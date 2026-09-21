<#
.SYNOPSIS
    Capability Distribution -- implementacion real del patron descrito en
    ../capability-distribution.md. Compara capabilities/agents y capabilities/skills de
    MOA-AI-Engineering contra cada repo destino y abre un Pull Request si hay diferencias.

.DESCRIPTION
    Nunca hace push directo a la rama principal de un repo destino. Nunca mergea el PR que
    abre. Usa el mismo mecanismo ya real de CAP-008 (azure-devops-cli): `az repos pr
    create`. La lista de repos destino NUNCA queda hardcoded en este script -- se lee de
    -TargetsFile, y ese archivo (capability-distribution-targets.json) no debe contener
    repos reales de MOA sin que alguien de gobierno los haya agregado deliberadamente.

    Para `instructions/`, solo copia si el archivo NO existe ya en el repo destino -- es
    una plantilla de estructura, 100% Team Adaptation (ver capabilities/README.md), este
    script nunca sobreescribe contenido que un equipo ya completo.

.PARAMETER TargetsFile
    Path al JSON con la lista de repos destino. Ver capability-distribution-targets.json
    para el formato esperado.

.PARAMETER SourceRoot
    Carpeta capabilities/ de MOA-AI-Engineering. Por defecto, relativa a este script.

.PARAMETER WorkDir
    Carpeta temporal donde clonar cada repo destino. Por defecto, un subdirectorio nuevo
    bajo el temp del sistema -- nunca reutiliza un clon anterior sin limpiarlo.

.PARAMETER WhatIf
    Si se pasa, hace todo el proceso de comparacion pero nunca crea rama, commitea, ni
    abre PR -- solo reporta que hubiera cambiado. Modo recomendado para la primera
    ejecucion real contra cualquier repo nuevo en la lista.

.EXAMPLE
    ./sync-capability-distribution.ps1 -TargetsFile ./capability-distribution-targets.json -WhatIf

.EXAMPLE
    ./sync-capability-distribution.ps1 -TargetsFile ./capability-distribution-targets.json
#>
param(
    [Parameter(Mandatory = $true)]
    [string]$TargetsFile,

    [string]$SourceRoot = (Resolve-Path "$PSScriptRoot/../../capabilities"),
    [string]$WorkDir = (Join-Path $env:TEMP "capability-distribution-$(Get-Date -Format 'yyyyMMddHHmmss')"),
    [switch]$WhatIf
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path $TargetsFile)) {
    Write-Error "No existe -TargetsFile '$TargetsFile'. Este script no asume ninguna lista de repos por defecto."
    exit 1
}

$config = Get-Content $TargetsFile -Raw | ConvertFrom-Json
if (-not $config.targets -or $config.targets.Count -eq 0) {
    Write-Host "capability-distribution-targets.json no tiene repos configurados -- nada que hacer."
    exit 0
}

New-Item -ItemType Directory -Path $WorkDir -Force | Out-Null
$results = @()

function Copy-MappedContent {
    param([string]$SourceRoot, [string]$RepoRoot, [bool]$SyncAgents, [bool]$SyncSkills, [bool]$SyncInstructionsIfMissing)

    if ($SyncAgents) {
        $agentsSrc = Join-Path $SourceRoot 'agents'
        $agentsDst = Join-Path $RepoRoot '.github/agents'
        New-Item -ItemType Directory -Path $agentsDst -Force | Out-Null
        Get-ChildItem $agentsSrc -Directory | ForEach-Object {
            $srcFile = Join-Path $_.FullName 'AGENT.md'
            if (Test-Path $srcFile) {
                Copy-Item $srcFile (Join-Path $agentsDst "$($_.Name).agent.md") -Force
            }
        }
    }

    if ($SyncSkills) {
        $skillsSrc = Join-Path $SourceRoot 'skills'
        $skillsDst = Join-Path $RepoRoot '.github/skills'
        Get-ChildItem $skillsSrc -Directory | ForEach-Object {
            $dstFolder = Join-Path $skillsDst $_.Name
            New-Item -ItemType Directory -Path $dstFolder -Force | Out-Null
            Copy-Item (Join-Path $_.FullName 'SKILL.md') (Join-Path $dstFolder 'SKILL.md') -Force
        }
    }

    if ($SyncInstructionsIfMissing) {
        $instrSrc = Join-Path $SourceRoot 'instructions'
        if (Test-Path $instrSrc) {
            Get-ChildItem $instrSrc -Directory | ForEach-Object {
                $dstFolder = Join-Path $RepoRoot ".github/instructions/$($_.Name)"
                $dstFile = Join-Path $dstFolder 'INSTRUCTIONS.md'
                if (-not (Test-Path $dstFile)) {
                    New-Item -ItemType Directory -Path $dstFolder -Force | Out-Null
                    Copy-Item (Join-Path $_.FullName 'INSTRUCTIONS.md') $dstFile -Force
                }
            }
        }
    }
}

foreach ($target in $config.targets) {
    $repoWorkDir = Join-Path $WorkDir $target.repository
    Write-Host "--- $($target.project)/$($target.repository) ---"

    try {
        $cloneUrl = "$($config.organization)/$($target.project)/_git/$($target.repository)"
        git clone --branch $target.targetBranch --single-branch $cloneUrl $repoWorkDir 2>&1 | Out-Null
        if ($LASTEXITCODE -ne 0) { throw "git clone fallo para $($target.repository)" }

        Copy-MappedContent -SourceRoot $SourceRoot -RepoRoot $repoWorkDir `
            -SyncAgents:($target.syncAgents -eq $true) `
            -SyncSkills:($target.syncSkills -eq $true) `
            -SyncInstructionsIfMissing:($target.syncInstructionsIfMissing -eq $true)

        Push-Location $repoWorkDir
        git add -A
        $hasChanges = -not (git diff --cached --quiet; $?)
        if (-not $hasChanges) {
            Write-Host "Sin cambios -- se omite."
            Pop-Location
            $results += [pscustomobject]@{ repo = $target.repository; status = 'sin-cambios' }
            continue
        }

        if ($WhatIf) {
            Write-Host "WhatIf: hay cambios, no se crea rama ni PR."
            Pop-Location
            $results += [pscustomobject]@{ repo = $target.repository; status = 'whatif-hay-cambios' }
            continue
        }

        $branchName = "sync/capabilities-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
        git checkout -b $branchName
        git commit -m "sync: actualizar agents/skills desde MOA-AI-Engineering"
        git push origin $branchName
        Pop-Location

        az repos pr create `
            --repository $target.repository `
            --project $target.project `
            --org $config.organization `
            --source-branch $branchName `
            --target-branch $target.targetBranch `
            --title "Sync: actualizar capabilities desde MOA-AI-Engineering" `
            --description "PR automatico generado por integrations/scripts/sync-capability-distribution.ps1. Revisar y aprobar como cualquier otro cambio -- este proceso nunca mergea por su cuenta." `
            --output none

        $results += [pscustomobject]@{ repo = $target.repository; status = 'pr-abierto'; branch = $branchName }
    }
    catch {
        Write-Warning "Fallo en $($target.repository): $($_.Exception.Message)"
        $results += [pscustomobject]@{ repo = $target.repository; status = 'error'; detail = $_.Exception.Message }
    }
}

Write-Host "`n--- Resumen ---"
$results | Format-Table -AutoSize
