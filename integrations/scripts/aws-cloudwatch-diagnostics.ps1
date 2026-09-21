<#
.SYNOPSIS
    AWS CloudWatch Diagnostics -- implementacion real del patron
    ../production-diagnostics-provider.md, mitad AWS. Consulta CloudWatch Logs Insights,
    READ-only, para las 4 consultas de referencia que ya usa CAP-017
    (production-incident-investigation): excepciones recientes, requests fallidos,
    performance, timeline de una operacion puntual.

.DESCRIPTION
    Usa AWS CLI (`aws logs start-query` / `aws logs get-query-results`) -- el mecanismo
    real y oficial de CloudWatch Logs Insights, no una API inventada. Nunca escribe, nunca
    borra, nunca modifica ningun recurso -- solo `start-query`/`get-query-results` sobre el
    log group indicado.

    Credenciales NUNCA hardcoded -- se toman del entorno ya autenticado de AWS CLI
    ($env:AWS_ACCESS_KEY_ID / $env:AWS_SECRET_ACCESS_KEY / $env:AWS_REGION, o un profile
    real ya configurado). Si no hay sesion valida, el script falla explicitamente en vez de
    asumir una region o cuenta por defecto.

.PARAMETER LogGroupName
    Log group real de CloudWatch a consultar (ej. /ecs/portal-creditos-backend-prod).

.PARAMETER QueryType
    Una de las 4 consultas de referencia de CAP-017: 'recent-exceptions',
    'failed-requests', 'performance', 'operation-timeline'.

.PARAMETER StartTime
    Inicio de la ventana de tiempo, formato ISO 8601 (ej. 2026-09-21T00:00:00Z).

.PARAMETER EndTime
    Fin de la ventana de tiempo, formato ISO 8601. Si se omite, usa la hora actual.

.PARAMETER OperationId
    Requerido solo para 'operation-timeline' -- el request ID / trace ID puntual a rastrear.

.PARAMETER Region
    Region de AWS. Si se omite, usa $env:AWS_REGION.

.PARAMETER OutFile
    Path opcional donde guardar el resultado como JSON. Si se omite, solo se imprime a
    stdout.

.EXAMPLE
    ./aws-cloudwatch-diagnostics.ps1 -LogGroupName /ecs/portal-creditos-backend-prod -QueryType recent-exceptions -StartTime 2026-09-21T00:00:00Z

.EXAMPLE
    ./aws-cloudwatch-diagnostics.ps1 -LogGroupName /ecs/portal-creditos-backend-prod -QueryType operation-timeline -OperationId abc-123 -StartTime 2026-09-21T00:00:00Z
#>
param(
    [Parameter(Mandatory = $true)]
    [string]$LogGroupName,

    [Parameter(Mandatory = $true)]
    [ValidateSet('recent-exceptions', 'failed-requests', 'performance', 'operation-timeline')]
    [string]$QueryType,

    [Parameter(Mandatory = $true)]
    [string]$StartTime,

    [string]$EndTime,
    [string]$OperationId,
    [string]$Region = $env:AWS_REGION,
    [string]$OutFile
)

$ErrorActionPreference = 'Stop'
$retrievedAt = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")

function New-DiagnosticsResult {
    param(
        [string]$RetrievalStatus,
        [AllowNull()][object]$Results = $null,
        [AllowNull()][object]$ErrorMessage = $null
    )
    return [ordered]@{
        source          = "aws-cloudwatch"
        logGroup        = $LogGroupName
        queryType       = $QueryType
        retrievalStatus = $RetrievalStatus
        retrievedAt     = $retrievedAt
        results         = $Results
        provenance      = "aws-cloudwatch-diagnostics v1 (aws cli)"
        error           = $ErrorMessage
    }
}

function Write-Result {
    param($Result)
    $json = $Result | ConvertTo-Json -Depth 10
    if ($OutFile) {
        $json | Out-File -FilePath $OutFile -Encoding utf8
        Write-Host "Resultado escrito en: $OutFile"
    }
    Write-Output $json
}

if (-not $Region) {
    Write-Result (New-DiagnosticsResult -RetrievalStatus "SOURCE_UNAVAILABLE" `
        -ErrorMessage "Falta -Region o `$env:AWS_REGION. Este script no asume ninguna region por defecto.")
    exit 1
}

if ($QueryType -eq 'operation-timeline' -and -not $OperationId) {
    Write-Result (New-DiagnosticsResult -RetrievalStatus "INVALID_REQUEST" `
        -ErrorMessage "-OperationId es obligatorio para -QueryType operation-timeline.")
    exit 1
}

if (-not $EndTime) { $EndTime = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ") }
$startEpoch = [DateTimeOffset]::Parse($StartTime).ToUnixTimeSeconds()
$endEpoch = [DateTimeOffset]::Parse($EndTime).ToUnixTimeSeconds()

# Las 4 consultas de referencia de CAP-017, en sintaxis real de CloudWatch Logs Insights.
$insightsQuery = switch ($QueryType) {
    'recent-exceptions' {
        'fields @timestamp, @message | filter @message like /(?i)(exception|error)/ | sort @timestamp desc | limit 50'
    }
    'failed-requests' {
        'fields @timestamp, @message | filter @message like /(?i)(5\d\d|4\d\d|failed)/ | sort @timestamp desc | limit 50'
    }
    'performance' {
        'fields @timestamp, @duration | stats avg(@duration), pct(@duration, 50), pct(@duration, 95), pct(@duration, 99) by bin(5m)'
    }
    'operation-timeline' {
        "fields @timestamp, @message | filter @message like /$OperationId/ | sort @timestamp asc"
    }
}

$startResult = & aws logs start-query `
    --log-group-name $LogGroupName `
    --start-time $startEpoch `
    --end-time $endEpoch `
    --query-string $insightsQuery `
    --region $Region `
    --output json 2>&1
$exitCode = $LASTEXITCODE

if ($exitCode -ne 0) {
    $errText = ($startResult -join "`n")
    $status = switch -Regex ($errText) {
        'ResourceNotFoundException|does not exist' { 'NOT_FOUND'; break }
        'AccessDenied|not authorized' { 'FORBIDDEN'; break }
        'Unable to locate credentials|ExpiredToken|InvalidClientTokenId' { 'UNAUTHORIZED'; break }
        default { 'SOURCE_UNAVAILABLE' }
    }
    Write-Result (New-DiagnosticsResult -RetrievalStatus $status -ErrorMessage $errText)
    exit 1
}

$queryId = ($startResult | ConvertFrom-Json).queryId

# CloudWatch Logs Insights es async -- hay que sondear get-query-results hasta que termine.
$maxAttempts = 20
$attempt = 0
$queryStatus = "Running"
$results = $null

while ($attempt -lt $maxAttempts -and ($queryStatus -eq "Running" -or $queryStatus -eq "Scheduled")) {
    Start-Sleep -Seconds 2
    $pollResult = & aws logs get-query-results --query-id $queryId --region $Region --output json 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Result (New-DiagnosticsResult -RetrievalStatus "SOURCE_UNAVAILABLE" -ErrorMessage ($pollResult -join "`n"))
        exit 1
    }
    $parsed = $pollResult | ConvertFrom-Json
    $queryStatus = $parsed.status
    $results = $parsed.results
    $attempt++
}

if ($queryStatus -ne "Complete") {
    Write-Result (New-DiagnosticsResult -RetrievalStatus "PARTIAL" `
        -ErrorMessage "La consulta no termino tras $maxAttempts intentos (ultimo estado: $queryStatus). Los datos de CloudWatch Logs Insights pueden tardar mas en ventanas de tiempo grandes -- reintentar o acotar el rango.")
    exit 0
}

if (-not $results -or $results.Count -eq 0) {
    Write-Result (New-DiagnosticsResult -RetrievalStatus "PARTIAL" -Results @() `
        -ErrorMessage "La consulta corrio correctamente pero no encontro resultados en la ventana de tiempo indicada.")
    exit 0
}

Write-Result (New-DiagnosticsResult -RetrievalStatus "SUCCESS" -Results $results)
