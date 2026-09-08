<#
.SYNOPSIS
    Jira Context Provider -- implementacion real de CAP-008.
    Reference -> Jira (READ-only, scope acotado) -> Resolved Context (JSON).

.DESCRIPTION
    Patron: integrations/jira-context-provider.md.

    Mecanismo Prioridad 1 (preferido, consistente con la evidencia real encontrada en
    Orquestador/Scato Logistica): Atlassian MCP, metodo unico `getJiraIssue`, scope acotado
    -- ver mcp.template.json. Un cliente MCP (VS Code + Copilot) invoca ese metodo
    directamente; este script de PowerShell NO puede invocar un servidor MCP el mismo
    (los MCP los invoca el cliente/agent, no un script standalone) -- por eso no hay una
    rama de codigo "MCP" aca, solo el template de configuracion.

    Mecanismo Prioridad 2 (fallback ejecutable real, documentado explicitamente como tal,
    NO un mecanismo nuevo no evidenciado -- es la API REST estandar de Atlassian, el mismo
    protocolo que el propio servidor MCP termina llamando): Jira REST API v3,
    GET /rest/api/3/issue/{key}, solo lectura.

    Ningun token/URL de Jira queda hardcoded -- se piden por variable de entorno:
    JIRA_BASE_URL, JIRA_EMAIL, JIRA_API_TOKEN. Sin las 3, el resultado es SOURCE_UNAVAILABLE
    explicito, nunca una simulacion.

.PARAMETER Reference
    Clave del issue, ej. PROY-1234.

.PARAMETER OutFile
    Path opcional donde guardar el Resolved Context como JSON.

.EXAMPLE
    $env:JIRA_BASE_URL = "https://<org>.atlassian.net"
    $env:JIRA_EMAIL = "persona@empresa.com"
    $env:JIRA_API_TOKEN = "<token real, nunca commiteado>"
    ./jira-context.ps1 -Reference PROY-1234
#>
param(
    [Parameter(Mandatory = $true)]
    [string]$Reference,

    [string]$OutFile
)

$ErrorActionPreference = 'Stop'
$retrievedAt = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")

function New-ResolvedContext {
    param(
        [string]$RetrievalStatus,
        [AllowNull()][object]$Title = $null,
        [AllowNull()][object]$Description = $null,
        [AllowNull()][object]$Status = $null,
        [hashtable]$Metadata = @{},
        [AllowNull()][object]$SourceUrl = $null,
        [AllowNull()][object]$ErrorMessage = $null
    )
    if ([string]::IsNullOrEmpty($Title)) { $Title = $null }
    if ([string]::IsNullOrEmpty($Description)) { $Description = $null }
    if ([string]::IsNullOrEmpty($Status)) { $Status = $null }
    if ([string]::IsNullOrEmpty($SourceUrl)) { $SourceUrl = $null }
    if ([string]::IsNullOrEmpty($ErrorMessage)) { $ErrorMessage = $null }
    return [ordered]@{
        source           = "jira"
        sourceReference  = $Reference
        sourceType       = "connected"
        title            = $Title
        description      = $Description
        status           = $Status
        requirements     = $null
        acceptanceCriteria = $null
        metadata         = $Metadata
        provenance       = "jira-context-provider v1 (REST fallback -- MCP getJiraIssue es Prioridad 1, ver mcp.template.json)"
        retrievalStatus  = $RetrievalStatus
        retrievedAt      = $retrievedAt
        sourceUrl        = $SourceUrl
        error            = $ErrorMessage
    }
}

function Write-Result {
    param($Context)
    $json = $Context | ConvertTo-Json -Depth 10
    if ($OutFile) {
        $json | Out-File -FilePath $OutFile -Encoding utf8
        Write-Host "Resolved Context escrito en: $OutFile"
    }
    Write-Output $json
}

# 1. INVALID_REFERENCE -- formato de clave de Jira: PROYECTO-NUMERO
if ($Reference -notmatch '^[A-Z][A-Z0-9]*-\d+$') {
    Write-Result (New-ResolvedContext -RetrievalStatus "INVALID_REFERENCE" `
        -ErrorMessage "La referencia '$Reference' no tiene el formato PROYECTO-NUMERO esperado de una clave de Jira.")
    exit 1
}

# 2. Credenciales explicitas obligatorias -- sin fallback silencioso, sin simulacion
$baseUrl = $env:JIRA_BASE_URL
$email = $env:JIRA_EMAIL
$token = $env:JIRA_API_TOKEN

if (-not $baseUrl -or -not $email -or -not $token) {
    $missing = @()
    if (-not $baseUrl) { $missing += 'JIRA_BASE_URL' }
    if (-not $email) { $missing += 'JIRA_EMAIL' }
    if (-not $token) { $missing += 'JIRA_API_TOKEN' }
    Write-Result (New-ResolvedContext -RetrievalStatus "SOURCE_UNAVAILABLE" `
        -ErrorMessage "BLOCKED: faltan variables de entorno requeridas ($($missing -join ', ')). Este script no simula un resultado -- requiere autenticacion real (MCP Atlassian o REST) que no esta disponible en este entorno de ejecucion.")
    exit 1
}

# 3. Llamada real, READ-only, scope acotado a GET de un unico issue
$uri = "$($baseUrl.TrimEnd('/'))/rest/api/3/issue/$Reference"
$pair = "$($email):$($token)"
$b64 = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($pair))
$headers = @{ Authorization = "Basic $b64"; Accept = "application/json" }

try {
    $response = Invoke-RestMethod -Uri $uri -Headers $headers -Method Get -ErrorAction Stop
} catch {
    $ex = $_.Exception
    $statusCode = $null
    if ($ex.Response) { $statusCode = [int]$ex.Response.StatusCode }
    $status = switch ($statusCode) {
        404 { 'NOT_FOUND' }
        401 { 'UNAUTHORIZED' }
        403 { 'FORBIDDEN' }
        default { 'SOURCE_UNAVAILABLE' }
    }
    Write-Result (New-ResolvedContext -RetrievalStatus $status -ErrorMessage $ex.Message)
    exit 1
}

$title = $response.fields.summary
$descAdf = $response.fields.description
$descText = if ($descAdf) { ($descAdf | ConvertTo-Json -Depth 20 -Compress) } else { $null }
$status = $response.fields.status.name
$issueType = $response.fields.issuetype.name
$url = "$($baseUrl.TrimEnd('/'))/browse/$Reference"

if (-not $title) {
    Write-Result (New-ResolvedContext -RetrievalStatus "PARTIAL" -Status $status `
        -Metadata @{ issueType = $issueType } -SourceUrl $url `
        -ErrorMessage "Issue recuperado pero sin summary -- no se completa con contenido inventado.")
    exit 0
}

Write-Result (New-ResolvedContext -RetrievalStatus "SUCCESS" -Title $title -Description $descText `
    -Status $status -Metadata @{ issueType = $issueType } -SourceUrl $url)
