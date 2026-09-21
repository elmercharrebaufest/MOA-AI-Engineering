<#
.SYNOPSIS
    Azure Application Insights Diagnostics -- implementacion real del patron
    ../production-diagnostics-provider.md, mitad Azure. Consulta Application Insights via
    KQL, READ-only, para las mismas 4 consultas de referencia que ya usa CAP-017
    (production-incident-investigation): excepciones recientes, requests fallidos,
    performance, timeline de una operacion puntual.

.DESCRIPTION
    Usa Azure CLI (`az monitor app-insights query`) -- el mecanismo real y oficial de
    consulta de Application Insights, mismo principio que azure-devops-context.ps1 (CAP-002):
    az cli, sin API inventada. Nunca escribe, nunca modifica ningun recurso -- solo
    consultas KQL de lectura.

    Credenciales NUNCA hardcoded -- depende de una sesion real ya autenticada (`az login`).
    El nombre/ID de la aplicacion de Application Insights se pide siempre por parametro o
    variable de entorno -- nunca asumido.

.PARAMETER AppId
    ID o nombre de la aplicacion de Application Insights a consultar. Si se omite, usa
    $env:APPINSIGHTS_APP_ID.

.PARAMETER QueryType
    Una de las 4 consultas de referencia de CAP-017: 'recent-exceptions',
    'failed-requests', 'performance', 'operation-timeline'.

.PARAMETER TimespanHours
    Ventana de tiempo hacia atras, en horas (ej. 24). Default: 24.

.PARAMETER OperationId
    Requerido solo para 'operation-timeline' -- el operation_Id puntual a rastrear.

.PARAMETER OutFile
    Path opcional donde guardar el resultado como JSON. Si se omite, solo se imprime a
    stdout.

.EXAMPLE
    ./azure-appinsights-diagnostics.ps1 -AppId <app-id-real> -QueryType recent-exceptions -TimespanHours 6

.EXAMPLE
    ./azure-appinsights-diagnostics.ps1 -AppId <app-id-real> -QueryType operation-timeline -OperationId <operation-id-real>
#>
param(
    [string]$AppId = $env:APPINSIGHTS_APP_ID,

    [Parameter(Mandatory = $true)]
    [ValidateSet('recent-exceptions', 'failed-requests', 'performance', 'operation-timeline')]
    [string]$QueryType,

    [int]$TimespanHours = 24,
    [string]$OperationId,
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
        source          = "azure-application-insights"
        appId           = $AppId
        queryType       = $QueryType
        retrievalStatus = $RetrievalStatus
        retrievedAt     = $retrievedAt
        results         = $Results
        provenance      = "azure-appinsights-diagnostics v1 (az cli)"
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

if (-not $AppId) {
    Write-Result (New-DiagnosticsResult -RetrievalStatus "SOURCE_UNAVAILABLE" `
        -ErrorMessage "Falta -AppId o `$env:APPINSIGHTS_APP_ID. Este script no asume ninguna aplicacion por defecto.")
    exit 1
}

if ($QueryType -eq 'operation-timeline' -and -not $OperationId) {
    Write-Result (New-DiagnosticsResult -RetrievalStatus "INVALID_REQUEST" `
        -ErrorMessage "-OperationId es obligatorio para -QueryType operation-timeline.")
    exit 1
}

# Las 4 consultas de referencia de CAP-017, en sintaxis real de KQL sobre Application Insights.
$kqlQuery = switch ($QueryType) {
    'recent-exceptions' {
        'exceptions | order by timestamp desc | project timestamp, type, outerMessage, operation_Id | take 50'
    }
    'failed-requests' {
        'requests | where success == false | order by timestamp desc | project timestamp, name, resultCode, duration, operation_Id | take 50'
    }
    'performance' {
        'requests | summarize avgDuration=avg(duration), p50=percentile(duration,50), p95=percentile(duration,95), p99=percentile(duration,99) by bin(timestamp, 5m), name'
    }
    'operation-timeline' {
        "union requests, dependencies, exceptions | where operation_Id == `"$OperationId`" | order by timestamp asc"
    }
}

$rawOutput = & az monitor app-insights query `
    --app $AppId `
    --analytics-query $kqlQuery `
    --offset "${TimespanHours}h" `
    -o json 2>&1
$exitCode = $LASTEXITCODE

if ($exitCode -ne 0) {
    $errText = ($rawOutput -join "`n")
    $status = switch -Regex ($errText) {
        'ResourceNotFound|could not be found' { 'NOT_FOUND'; break }
        'AuthorizationFailed|does not have permission|Forbidden' { 'FORBIDDEN'; break }
        'az login|Please run|AADSTS|not logged in|authenticat' { 'UNAUTHORIZED'; break }
        default { 'SOURCE_UNAVAILABLE' }
    }
    Write-Result (New-DiagnosticsResult -RetrievalStatus $status -ErrorMessage $errText)
    exit 1
}

try {
    $parsed = ($rawOutput -join "`n") | ConvertFrom-Json
    $rows = $parsed.tables[0].rows
} catch {
    Write-Result (New-DiagnosticsResult -RetrievalStatus "PARTIAL" `
        -ErrorMessage "La respuesta de az no pudo parsearse como JSON: $($_.Exception.Message)")
    exit 1
}

if (-not $rows -or $rows.Count -eq 0) {
    Write-Result (New-DiagnosticsResult -RetrievalStatus "PARTIAL" -Results @() `
        -ErrorMessage "La consulta corrio correctamente pero no encontro resultados en la ventana de tiempo indicada.")
    exit 0
}

Write-Result (New-DiagnosticsResult -RetrievalStatus "SUCCESS" -Results $rows)
