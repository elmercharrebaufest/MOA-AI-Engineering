<#
.SYNOPSIS
    Adaptador: Resolved Context (JSON) -> input real de CAP-002 (user-story).

.DESCRIPTION
    Esto es lo que preserva "CAP-002 debe permanecer independiente del sistema origen":
    CAP-002 (capabilities/skills/user-story/SKILL.md) no cambia -- este script vive
    afuera, en integrations/, y solo traduce un Resolved Context (sin importar si vino de
    Jira o de Azure DevOps) al mismo bloque Ticket/Requirement/Context que CAP-002 ya
    acepta desde su version original. No existe, ni existira, un "cap-002-jira.ps1"
    separado de un "cap-002-azuredevops.ps1" -- es el mismo adaptador para cualquier
    Resolved Context.

.PARAMETER ContextFile
    Path a un archivo JSON que cumple resolved-context.schema.json (salida de
    azure-devops-context.ps1 o jira-context.ps1).

.PARAMETER Ticket
    Identificador de ticket a mostrar en el bloque de input (por defecto, sourceReference
    del propio Resolved Context).

.EXAMPLE
    ./azure-devops-context.ps1 -Reference 12345 -ResourceType work_item -OutFile ctx.json
    ./invoke-cap002-with-context.ps1 -ContextFile ctx.json
#>
param(
    [Parameter(Mandatory = $true)]
    [string]$ContextFile,

    [string]$Ticket
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path $ContextFile)) {
    Write-Error "No existe el archivo de Resolved Context: $ContextFile"
    exit 1
}

$ctx = Get-Content $ContextFile -Raw | ConvertFrom-Json

if ($ctx.retrievalStatus -ne 'SUCCESS' -and $ctx.retrievalStatus -ne 'PARTIAL') {
    Write-Host "No se genera input para CAP-002: retrievalStatus = $($ctx.retrievalStatus)." -ForegroundColor Yellow
    Write-Host "CAP-002 no debe ejecutarse sobre un contexto que no se resolvio -- no se completa con contenido inventado."
    exit 1
}

if (-not $Ticket) { $Ticket = $ctx.sourceReference }

$requirementText = if ($ctx.description) { $ctx.description } elseif ($ctx.title) { $ctx.title } else { "" }
$contextText = @"
Fuente: $($ctx.source) ($($ctx.sourceReference))
Estado en origen: $($ctx.status)
Referencia verificable: $($ctx.sourceUrl)
Resuelto: $($ctx.retrievedAt) via $($ctx.provenance)
"@

$block = @"
Ticket:
$Ticket

Requirement:
"$requirementText"

Context:
"$contextText"
"@

Write-Output $block

if ($ctx.retrievalStatus -eq 'PARTIAL') {
    Write-Host ""
    Write-Host "AVISO: retrievalStatus = PARTIAL -- el Resolved Context esta incompleto. Revisar antes de ejecutar CAP-002." -ForegroundColor Yellow
}
