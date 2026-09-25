<#
.SYNOPSIS
  Instala, actualiza y verifica el MOA AI Engineering Core en la máquina del developer.

.DESCRIPTION
  Usa el mecanismo oficial de Copilot (marketplace + plugin). No clona repositorios ni copia
  capacidades a los proyectos. Mantiene una sola instalación del plugin por máquina.

  Qué se instala y cómo lo define core-manifest.json (componente, mecanismo y verificación).

  install  Registra el marketplace, instala el plugin (una sola vez; si ya está en una versión
           anterior, lo actualiza) y aplica cada componente del manifest con su mecanismo.
  update   Si hay una versión nueva, actualiza el plugin y vuelve a aplicar todos los componentes.
  status   Resumen del estado actual.
  doctor   Verificaciones detalladas: OK, WARNING, ERROR o NOT_VALIDATED.

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File .\moa-ai.ps1 install
#>
param(
    [Parameter(Position = 0)]
    [ValidateSet('install', 'update', 'status', 'doctor')]
    [string]$Command = 'status',
    [switch]$Yes
)

$ErrorActionPreference = 'Stop'
try { [Console]::OutputEncoding = [System.Text.Encoding]::UTF8 } catch {}

$MarketplaceName = 'ai-engineering'
$PluginName      = 'ai-engineering'
$PluginId        = "$PluginName@$MarketplaceName"
$RepoUrl         = 'https://dev.azure.com/molinosagro/ai-engineering/_git/ai-engineering'
$DefaultPluginDir = Join-Path $HOME ".copilot\installed-plugins\$MarketplaceName\$PluginName"
$MinCliFallback  = [version]'1.0.86'

# ---------------------------------------------------------------- utilidades

function Write-Line([string]$Text, [string]$Color = 'Gray') { Write-Host $Text -ForegroundColor $Color }

function Invoke-Copilot([string[]]$Arguments) {
    $prev = $ErrorActionPreference; $ErrorActionPreference = 'Continue'
    try {
        $out = & copilot @Arguments 2>&1 | ForEach-Object { "$_" }
        return [pscustomobject]@{ Code = $LASTEXITCODE; Out = ($out -join "`n") }
    } finally { $ErrorActionPreference = $prev }
}

function Get-Json([string[]]$Arguments) {
    $r = Invoke-Copilot $Arguments
    if ($r.Code -ne 0) { return $null }
    try { return ($r.Out | ConvertFrom-Json) } catch { return $null }
}

function Get-CliVersion {
    if (-not (Get-Command copilot -ErrorAction SilentlyContinue)) { return $null }
    $r = Invoke-Copilot @('--version')
    if ($r.Out -match '(\d+\.\d+\.\d+)') { return [version]$Matches[1] }
    return $null
}

function Get-MoaPlugins {
    $list = Get-Json @('plugin', 'list', '--json')
    if ($null -eq $list) { return @() }
    return @($list | ForEach-Object { $_ } | Where-Object { $_.name -eq $PluginName -and $_.source -eq 'installed' })
}

# Skills del plugin instalado. Copilot antepone "<plugin>:" al nombre solo cuando dos
# plugins tienen skills con el mismo nombre; se normaliza quitando el prefijo.
function Get-PluginSkills {
    $skills = Get-Json @('skill', 'list', '--json')
    if (-not $skills) { return @() }
    $pattern = "*\installed-plugins\$MarketplaceName\$PluginName\skills\*"
    return @($skills | ForEach-Object { $_ } | Where-Object { $_.source -eq 'plugin' -and $_.path -like $pattern } |
        ForEach-Object { [pscustomobject]@{ Name = ($_.name -replace "^$PluginName`:", ''); Path = $_.path } })
}

function Get-PluginDir {
    $s = @(Get-PluginSkills) | Select-Object -First 1
    if ($s) { return (Split-Path (Split-Path $s.Path -Parent) -Parent) }
    if (Test-Path $DefaultPluginDir) { return $DefaultPluginDir }
    return $null
}

function Get-AvailableVersion {
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) { return $null }
    $prev = $ErrorActionPreference; $ErrorActionPreference = 'Continue'
    try { $refs = & git ls-remote --tags --refs $RepoUrl 'refs/tags/v*' 2>$null } finally { $ErrorActionPreference = $prev }
    if ($LASTEXITCODE -ne 0 -or -not $refs) { return $null }
    $versions = @($refs | ForEach-Object { if ($_ -match 'refs/tags/v(\d+\.\d+\.\d+)$') { [version]$Matches[1] } })
    if ($versions.Count -eq 0) { return $null }
    return ($versions | Sort-Object -Descending | Select-Object -First 1)
}

function Get-Manifest([string]$PluginDir) {
    $scriptParent = if ($PSScriptRoot) { Split-Path $PSScriptRoot -Parent } else { $null }
    foreach ($dir in @($PluginDir, $scriptParent)) {
        if ($dir -and (Test-Path (Join-Path $dir 'core-manifest.json'))) {
            return (Get-Content (Join-Path $dir 'core-manifest.json') -Raw -Encoding UTF8 | ConvertFrom-Json)
        }
    }
    return $null
}

function Test-VSCodeRunning { return [bool](Get-Process -Name 'Code', 'Code - Insiders' -ErrorAction SilentlyContinue) }

function Confirm-Action([string]$Question) {
    if ($Yes) { return $true }
    $a = Read-Host "$Question (s/n)"
    return ($a -match '^(s|si|sí|y|yes)$')
}

# Instalar, actualizar o desinstalar reemplaza archivos que VS Code mantiene abiertos
# (Windows: "Access is denied (os error 5)"). Se exige VS Code cerrado antes de tocar el plugin.
function Assert-CanModifyPlugin {
    if ($env:TERM_PROGRAM -eq 'vscode') {
        Write-Line 'ERROR  Este paso modifica el plugin y no puede ejecutarse desde la terminal de VS Code.' Red
        Write-Line '       Cerrar VS Code y ejecutar el script desde PowerShell o Windows Terminal.' Red
        exit 2
    }
    while (Test-VSCodeRunning) {
        Write-Line 'VS Code está abierto. Cerrar todas sus ventanas para evitar "Access is denied (os error 5)".' Yellow
        if ($Yes) { Write-Line 'ERROR  VS Code sigue abierto.' Red; exit 2 }
        Read-Host 'Presionar Enter cuando VS Code esté cerrado' | Out-Null
    }
}

function Test-AccessDenied([string]$Out) { return ($Out -match 'os error 5' -or $Out -match 'Access is denied') }

function Expand-HomePath([string]$Path) { return ($Path -replace '^~', $HOME) -replace '/', '\' }

# Servidores MCP configurados a nivel de usuario en VS Code (perfil por defecto y perfiles).
function Get-VSCodeMcpServers {
    $files = @(Join-Path $env:APPDATA 'Code\User\mcp.json')
    $profiles = Join-Path $env:APPDATA 'Code\User\profiles'
    if (Test-Path $profiles) { $files += @(Get-ChildItem $profiles -Directory | ForEach-Object { Join-Path $_.FullName 'mcp.json' }) }
    $names = @()
    foreach ($f in $files) {
        if (-not (Test-Path $f)) { continue }
        $text = (Get-Content $f -Raw -Encoding UTF8) -replace '(?m)^\s*//.*$', ''
        try { $json = $text | ConvertFrom-Json } catch { continue }
        if ($json.servers) { $names += @($json.servers.PSObject.Properties | ForEach-Object { $_.Name }) }
    }
    return @($names | Select-Object -Unique)
}

function Write-VSCodeMcpHelp([string]$Server) {
    Write-Line "  Instalar el servidor de Atlassian en VS Code (una vez): vista Extensions -> buscar '@mcp atlassian' -> Install." Yellow
    Write-Line "  Debe quedar con el nombre $Server. El login de Atlassian se hace en VS Code al primer uso." Yellow
}

function Get-Components($Manifest) {
    return @($Manifest.components.PSObject.Properties | ForEach-Object {
        [pscustomobject]@{ Key = $_.Name; Def = $_.Value; Copilot = $_.Value.delivery.copilot }
    })
}

# Aplica lo que el plugin no entrega por sí mismo, según el mecanismo de cada componente.
# "plugin" y "plugin-agent" ya quedan instalados con el plugin; "none" no tiene mecanismo.
function Install-Components([string]$PluginDir) {
    $manifest = if ($PluginDir -and (Test-Path (Join-Path $PluginDir 'core-manifest.json'))) { Get-Manifest $PluginDir } else { $null }
    if (-not $manifest) {
        Write-Line 'WARNING  El plugin instalado es anterior a 0.5.0 (no trae core-manifest.json): solo se instalaron skills y agents. El resto llega al actualizar a 0.5.0 o superior.' Yellow
        return
    }
    foreach ($c in Get-Components $manifest) {
        switch ($c.Copilot.mechanism) {
            'user-instructions' {
                $src = Join-Path $PluginDir ($c.Copilot.source -replace '/', '\')
                $dst = Expand-HomePath $c.Copilot.target
                if (-not (Test-Path $src)) { Write-Line "WARNING  $($c.Key): falta $($c.Copilot.source) en el plugin." Yellow; continue }
                $dir = Split-Path $dst -Parent
                if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }
                $same = (Test-Path $dst) -and ((Get-FileHash $src).Hash -eq (Get-FileHash $dst).Hash)
                if (-not $same) { Copy-Item $src $dst -Force; Write-Line "$($c.Key): configurado en $dst" Green }
                else { Write-Line "$($c.Key): al día" Green }
            }
            'vscode-user-mcp' {
                $found = Get-VSCodeMcpServers
                $missing = @($c.Def.items | Where-Object { $found -notcontains $_ })
                if ($missing.Count -eq 0) { Write-Line "$($c.Key): $($c.Def.items -join ', ') configurado en VS Code" Green }
                else { Write-Line "WARNING  $($c.Key): falta $($missing -join ', ') en VS Code." Yellow; $missing | ForEach-Object { Write-VSCodeMcpHelp $_ } }
            }
            'none' { Write-Line "$($c.Key): NOT_SUPPORTED en Copilot. $($c.Copilot.notes)" DarkYellow }
            default { }
        }
    }
}

function Assert-Environment {
    $ok = $true
    if (-not (Get-Command copilot -ErrorAction SilentlyContinue)) {
        Write-Line 'ERROR  No se encontró Copilot CLI. Instalarla: https://docs.github.com/copilot/how-tos/copilot-cli' Red
        $ok = $false
    }
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        Write-Line 'ERROR  No se encontró Git. Copilot lo usa para descargar el plugin desde Azure DevOps.' Red
        $ok = $false
    }
    if (-not $ok) { exit 1 }
}

function Ensure-Marketplace {
    $mk = @((Get-Json @('plugin', 'marketplace', 'list', '--json')) | ForEach-Object { $_ } | Where-Object { $_.name -eq $MarketplaceName })
    if ($mk.Count -gt 0) {
        if ($mk[0].source -notlike "*$RepoUrl*") {
            Write-Line "WARNING  El marketplace '$MarketplaceName' apunta a otro origen: $($mk[0].source)" Yellow
        }
        return
    }
    Write-Line "Registrando el marketplace $MarketplaceName..."
    $r = Invoke-Copilot @('plugin', 'marketplace', 'add', $RepoUrl)
    if ($r.Code -ne 0) { Write-Line "ERROR  No se pudo registrar el marketplace:`n$($r.Out)" Red; exit 1 }
}

function Install-Plugin {
    $r = Invoke-Copilot @('plugin', 'install', $PluginId)
    if ($r.Code -ne 0) {
        if (Test-AccessDenied $r.Out) { Write-Line 'ERROR  Windows bloqueó archivos del plugin (os error 5). Cerrar VS Code y repetir.' Red }
        Write-Line $r.Out Red; exit 1
    }
}

function Remove-AllMoaPlugins([object[]]$Plugins) {
    foreach ($p in $Plugins) {
        $id = if ($p.marketplace) { "$($p.name)@$($p.marketplace)" } else { $p.name }
        Write-Line "Desinstalando $id..."
        $r = Invoke-Copilot @('plugin', 'uninstall', $id)
        if ($r.Code -ne 0) {
            if (Test-AccessDenied $r.Out) { Write-Line 'ERROR  Windows bloqueó archivos del plugin (os error 5). Cerrar VS Code y repetir.' Red }
            Write-Line $r.Out Red; exit 1
        }
    }
}

# ---------------------------------------------------------------- doctor

# Verifica un componente según el campo "check" del manifest. Devuelve estado y detalle.
function Test-Component($c, $Manifest, [string]$PluginDir) {
    $cp = $c.Copilot
    $items = if ($c.Def.itemsFrom) { @($Manifest.components.($c.Def.itemsFrom).items) } else { @($c.Def.items) }
    $hosts = "CLI: $($cp.status.cli) / VS Code: $($cp.status.vscode)"
    $fail = if ($c.Def.required) { 'ERROR' } else { 'WARNING' }
    $dir = if ($cp.path) { Join-Path $PluginDir ($cp.path -replace '/', '\') } else { $null }

    switch ($cp.check) {
        'skill-list' {
            $found = @(Get-PluginSkills | ForEach-Object { $_.Name })
            $missing = @($items | Where-Object { $found -notcontains $_ })
            if ($missing.Count -eq 0) { return 'OK', "$($items.Count) detectadas por Copilot. $hosts" }
            return $fail, "Faltan: $($missing -join ', ')"
        }
        'agent-files' {
            $missing = @($items | Where-Object { -not (Test-Path (Join-Path $dir "$_.agent.md")) })
            if ($missing.Count -eq 0) { return 'OK', "Presentes: $($items.Count). $hosts" }
            return $fail, "Faltan: $($missing -join ', ')"
        }
        'agent-flag' {
            $pattern = '^' + ([regex]::Escape($cp.flag) -replace '\\ ', '\s*')
            $without = @($items | Where-Object {
                $f = Join-Path $dir "$_.agent.md"
                -not ((Test-Path $f) -and (Select-String -Path $f -Pattern $pattern -Quiet))
            })
            if ($without.Count -eq 0) { return 'OK', "Leen el AGENTS.md del repo. $hosts" }
            return $fail, "Sin '$($cp.flag)': $($without -join ', ')"
        }
        'instruction-list' {
            $dst = Expand-HomePath $cp.target
            $found = @((Get-Json @('instruction', 'list', '--json')) | ForEach-Object { $_ } | Where-Object { $_.sourcePath -eq $dst })
            if ($found.Count -gt 0) { return 'OK', "Activas para todos los repos. $hosts" }
            return $fail, 'No detectadas (ejecutar install)'
        }
        'vscode-mcp' {
            $found = Get-VSCodeMcpServers
            $missing = @($items | Where-Object { $found -notcontains $_ })
            if ($missing.Count -eq 0) { return 'OK', "$($items -join ', ') configurado en VS Code; un sitio de Jira por vez. $hosts" }
            return $fail, "Falta en VS Code: $($missing -join ', ') (vista Extensions -> '@mcp atlassian' -> Install)"
        }
        'none' { return 'NOT_SUPPORTED', $cp.notes }
        default { return 'WARNING', "Verificación desconocida: $($cp.check)" }
    }
}

function Get-DoctorResults {
    $res = New-Object System.Collections.ArrayList
    function Add($area, $state, $detail, $required = $true) { [void]$res.Add([pscustomobject]@{ Area = $area; Estado = $state; Detalle = $detail; Required = $required }) }

    $cli = Get-CliVersion
    if (-not $cli) { Add 'Copilot CLI' 'ERROR' 'No instalada'; return , $res }

    $plugins = @(Get-MoaPlugins)
    $pluginDir = if ($plugins.Count -eq 1) { Get-PluginDir } else { $null }
    $manifest = Get-Manifest $pluginDir
    $minCli = if ($manifest) { [version]$manifest.providers.copilot.minCliVersion } else { $MinCliFallback }
    if ($cli -ge $minCli) { Add 'Copilot CLI' 'OK' "$cli" } else { Add 'Copilot CLI' 'WARNING' "$cli; se requiere $minCli o superior (copilot update)" }

    if (Get-Command git -ErrorAction SilentlyContinue) { Add 'Git' 'OK' 'Disponible' } else { Add 'Git' 'ERROR' 'No instalado' }

    $mk = @((Get-Json @('plugin', 'marketplace', 'list', '--json')) | ForEach-Object { $_ } | Where-Object { $_.name -eq $MarketplaceName })
    if ($mk.Count -eq 0) { Add 'Marketplace' 'ERROR' 'No registrado (ejecutar install)' }
    elseif ($mk[0].source -like "*$RepoUrl*") { Add 'Marketplace' 'OK' $RepoUrl }
    else { Add 'Marketplace' 'WARNING' "Origen distinto: $($mk[0].source)" }

    if ($plugins.Count -eq 0) { Add 'Plugin' 'ERROR' 'No instalado (ejecutar install)' }
    elseif ($plugins.Count -gt 1) { Add 'Plugin' 'ERROR' "$($plugins.Count) instalaciones; debe haber una sola (ejecutar install)" }
    elseif ($plugins[0].marketplace -ne $MarketplaceName) { Add 'Plugin' 'ERROR' 'Instalado fuera del marketplace de MOA (ejecutar install)' }
    elseif (-not $plugins[0].enabled) { Add 'Plugin' 'ERROR' "Deshabilitado (copilot plugin enable $PluginId)" }
    else {
        $installed = [version]($plugins[0].version -replace '[^\d\.].*$', '')
        $available = Get-AvailableVersion
        if (-not $available) { Add 'Plugin' 'WARNING' "$($plugins[0].version); no se pudo consultar la versión disponible" }
        elseif ($installed -lt $available) { Add 'Plugin' 'WARNING' "$installed instalada; $available disponible (ejecutar update)" }
        else { Add 'Plugin' 'OK' "$installed (última versión)" }
    }

    if (-not $pluginDir -or -not $manifest) {
        Add 'Manifest' 'ERROR' 'No se pudo leer el plugin instalado ni core-manifest.json'
        return , $res
    }
    if (-not (Test-Path (Join-Path $pluginDir 'core-manifest.json'))) {
        Add 'Manifest' 'WARNING' 'El plugin instalado no trae core-manifest.json (anterior a 0.5.0); se evalúa contra el del script'
    }
    foreach ($c in Get-Components $manifest) {
        $state, $detail = Test-Component $c $manifest $pluginDir
        $name = if ($c.Key -eq 'mcp') { 'MCP' } else { (Get-Culture).TextInfo.ToTitleCase($c.Key) }
        Add $name $state $detail ([bool]$c.Def.required)
    }
    return , $res
}

function Get-Overall($results) {
    if (@($results | Where-Object { $_.Estado -eq 'ERROR' -and $_.Required }).Count -gt 0) { return 'NOT READY' }
    if (@($results | Where-Object { @('OK', 'NOT_SUPPORTED') -notcontains $_.Estado }).Count -gt 0) { return 'READY (con advertencias)' }
    return 'READY'
}

function Show-Doctor {
    $results = Get-DoctorResults
    Write-Line ''
    Write-Line 'MOA AI Engineering Core - doctor' White
    Write-Line ''
    foreach ($r in $results) {
        $color = switch ($r.Estado) { 'OK' { 'Green' } 'WARNING' { 'Yellow' } 'ERROR' { 'Red' } default { 'DarkYellow' } }
        Write-Host ('{0,-14}' -f $r.Area) -NoNewline
        Write-Host ('{0,-15}' -f $r.Estado) -ForegroundColor $color -NoNewline
        Write-Host $r.Detalle
    }
    $overall = Get-Overall $results
    Write-Line ''
    Write-Line "Estado: $overall" $(if ($overall -eq 'NOT READY') { 'Red' } elseif ($overall -eq 'READY') { 'Green' } else { 'Yellow' })
    if ($overall -eq 'NOT READY') { exit 1 }
}

function Show-Status {
    $plugins = @(Get-MoaPlugins)
    $results = Get-DoctorResults
    $installed = if ($plugins.Count -ge 1) { $plugins[0].version } else { '-' }
    $available = Get-AvailableVersion
    $base = @('Copilot CLI', 'Git', 'Marketplace', 'Plugin', 'Manifest')
    Write-Line ''
    Write-Line 'MOA AI Engineering Core' White
    Write-Line ''
    Write-Line "Version:      $installed"
    Write-Line "Disponible:   $(if ($available) { $available } else { 'desconocida' })"
    Write-Line 'Provider:     Copilot'
    Write-Line "Marketplace:  $MarketplaceName ($RepoUrl)"
    Write-Line "Status:       $(Get-Overall $results)"
    Write-Line ''
    foreach ($r in @($results | Where-Object { $base -notcontains $_.Area })) { Write-Line ('{0,-14}{1}' -f "$($r.Area):", $r.Estado) }
    Write-Line ''
    Write-Line 'Detalle: moa-ai.ps1 doctor'
}

# ---------------------------------------------------------------- comandos

# Actualiza el plugin del marketplace de MOA y devuelve la versión resultante.
function Update-Plugin([string]$Before) {
    Assert-CanModifyPlugin
    [void](Invoke-Copilot @('plugin', 'marketplace', 'update'))
    $r = Invoke-Copilot @('plugin', 'update', $PluginId)
    if ($r.Code -ne 0) {
        if (Test-AccessDenied $r.Out) { Write-Line 'ERROR  Windows bloqueó archivos del plugin (os error 5). Cerrar VS Code y repetir.' Red }
        Write-Line $r.Out Red; exit 1
    }
    $after = @(Get-MoaPlugins)[0].version
    if ($after -eq $Before) { Write-Line "WARNING  La versión no cambió ($Before)." Yellow }
    else { Write-Line "Actualizado: $Before -> $after" Green }
}

function Get-InstalledVersion($Plugin) { return [version]($Plugin.version -replace '[^\d\.].*$', '') }

function Invoke-Install {
    Assert-Environment
    Set-Location $HOME
    $plugins = @(Get-MoaPlugins)
    $clean = ($plugins.Count -eq 1 -and $plugins[0].marketplace -eq $MarketplaceName)

    if ($clean) {
        Ensure-Marketplace
        $before = $plugins[0].version
        $available = Get-AvailableVersion
        if ($available -and (Get-InstalledVersion $plugins[0]) -lt $available) {
            Write-Line "El plugin ya está instalado, en una versión anterior: $before -> $available" Cyan
            Update-Plugin $before
        } elseif ($available) {
            Write-Line "El plugin ya está instalado y al día ($before). No se instala de nuevo." Green
        } else {
            Write-Line "El plugin ya está instalado ($before). No se pudo consultar la versión disponible; para forzar la actualización, ejecutar update." Yellow
        }
    } else {
        Assert-CanModifyPlugin
        Ensure-Marketplace
        if ($plugins.Count -gt 0) {
            Write-Line "Se encontraron $($plugins.Count) instalaciones de $PluginName que no cumplen la regla de una sola instalación desde el marketplace de MOA:" Yellow
            $plugins | ForEach-Object {
                $origin = if ($_.marketplace) { "marketplace $($_.marketplace)" } else { 'instalación directa, sin marketplace' }
                Write-Line "  - $($_.name) $($_.version) ($origin)" Yellow
            }
            if (-not (Confirm-Action 'Desinstalarlas e instalar una sola')) { Write-Line 'Cancelado.' Yellow; exit 1 }
            Remove-AllMoaPlugins $plugins
        }
        Write-Line "Instalando $PluginId..."
        Install-Plugin
        $plugins = @(Get-MoaPlugins)
        Write-Line "Instalado: versión $($plugins[0].version)" Green
    }

    $dir = Get-PluginDir
    Install-Components $dir

    Show-Doctor
    if ($dir) { Write-Line "`nPara actualizar más adelante:`n  powershell -ExecutionPolicy Bypass -File `"$dir\tools\moa-ai.ps1`" update" Cyan }
}

function Invoke-Update {
    Assert-Environment
    Set-Location $HOME
    $plugins = @(Get-MoaPlugins)
    if ($plugins.Count -ne 1 -or $plugins[0].marketplace -ne $MarketplaceName) {
        Write-Line 'La instalación no es única o no viene del marketplace de MOA. Ejecutar install.' Red; exit 1
    }
    $before = $plugins[0].version
    $available = Get-AvailableVersion

    if ($available -and (Get-InstalledVersion $plugins[0]) -ge $available) {
        Write-Line "Ya está en la última versión ($before)." Green
    } else {
        if (-not $available) { Write-Line 'No se pudo consultar la versión disponible; se intentará actualizar igual.' Yellow }
        else { Write-Line "Versión nueva disponible: $before -> $available" Cyan }
        Update-Plugin $before
    }

    Install-Components (Get-PluginDir)
    Show-Doctor
}

switch ($Command) {
    'install' { Invoke-Install }
    'update'  { Invoke-Update }
    'status'  { Show-Status }
    'doctor'  { Show-Doctor }
}
