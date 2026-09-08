<#
.SYNOPSIS
    Azure DevOps Context Provider -- implementacion real de CAP-007.
    Reference -> Azure DevOps (az CLI, READ-only) -> Resolved Context (JSON, ver resolved-context.schema.json).

.DESCRIPTION
    Patron: integrations/azure-devops-context-provider.md. Este script es la implementacion
    ejecutable de ese patron -- no introduce un mecanismo nuevo, usa az CLI (el mismo mecanismo
    ya real de CAP-001 azure-devops-cli). READ-only, sin excepcion: solo `work-item show` y
    `pr show`, nunca create/update.

    La organizacion/proyecto NUNCA quedan hardcoded -- se piden por parametro o por variable
    de entorno (AZURE_DEVOPS_ORG, AZURE_DEVOPS_PROJECT). Sin ninguno de los dos, el script
    falla explicitamente en vez de asumir un valor por defecto.

.PARAMETER Reference
    ID numerico del Work Item, o numero de Pull Request.

.PARAMETER ResourceType
    'work_item' o 'pull_request'.

.PARAMETER Organization
    URL de la organizacion de Azure DevOps (ej. https://dev.azure.com/<org>). Si se omite, usa
    $env:AZURE_DEVOPS_ORG.

.PARAMETER Project
    Proyecto de Azure DevOps. Requerido para 'pull_request'. Si se omite, usa
    $env:AZURE_DEVOPS_PROJECT.

.PARAMETER OutFile
    Path opcional donde guardar el Resolved Context como JSON. Si se omite, solo se imprime a
    stdout -- no se persiste nada por defecto.

.EXAMPLE
    ./azure-devops-context.ps1 -Reference 12345 -ResourceType work_item -Organization https://dev.azure.com/molinosagro -Project Orquestador

.EXAMPLE
    $env:AZURE_DEVOPS_ORG = "https://dev.azure.com/molinosagro"
    ./azure-devops-context.ps1 -Reference 12345 -ResourceType work_item
#>
param(
    [Parameter(Mandatory = $true)]
    [string]$Reference,

    [Parameter(Mandatory = $true)]
    [ValidateSet('work_item', 'pull_request')]
    [string]$ResourceType,

    [string]$Organization = $env:AZURE_DEVOPS_ORG,
    [string]$Project = $env:AZURE_DEVOPS_PROJECT,
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
        source           = "azure-devops"
        sourceReference  = $Reference
        sourceType       = "connected"
        title            = $Title
        description      = $Description
        status           = $Status
        requirements     = $null
        acceptanceCriteria = $null
        metadata         = $Metadata
        provenance       = "azure-devops-context-provider v1 (az cli)"
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

# 1. INVALID_REFERENCE -- validar formato antes de llamar a nada
if ($Reference -notmatch '^\d+$') {
    Write-Result (New-ResolvedContext -RetrievalStatus "INVALID_REFERENCE" `
        -ErrorMessage "La referencia '$Reference' no es un ID numerico valido de Work Item/PR.")
    exit 1
}

# 2. Configuracion explicita obligatoria -- nunca un default hardcoded
if (-not $Organization) {
    Write-Result (New-ResolvedContext -RetrievalStatus "SOURCE_UNAVAILABLE" `
        -ErrorMessage "Falta -Organization o `$env:AZURE_DEVOPS_ORG. Este script no asume ninguna organizacion por defecto.")
    exit 1
}
if ($ResourceType -eq 'pull_request' -and -not $Project) {
    Write-Result (New-ResolvedContext -RetrievalStatus "SOURCE_UNAVAILABLE" `
        -ErrorMessage "Falta -Project o `$env:AZURE_DEVOPS_PROJECT, requerido para pull_request.")
    exit 1
}

# 3. Llamada real, READ-only
if ($ResourceType -eq 'work_item') {
    $azArgs = @('boards', 'work-item', 'show', '--id', $Reference, '--org', $Organization, '-o', 'json')
} else {
    $azArgs = @('repos', 'pr', 'show', '--id', $Reference, '--org', $Organization, '--project', $Project, '-o', 'json')
}

$rawOutput = & az @azArgs 2>&1
$exitCode = $LASTEXITCODE

if ($exitCode -ne 0) {
    $errText = ($rawOutput -join "`n")
    $status = switch -Regex ($errText) {
        'TF401232|does not exist|could not be found|VS402337' { 'NOT_FOUND'; break }
        'TF400813|does not have permission|Access Denied|Forbidden' { 'FORBIDDEN'; break }
        'az login|Please run|AADSTS|not logged in|authenticat' { 'UNAUTHORIZED'; break }
        default { 'SOURCE_UNAVAILABLE' }
    }
    Write-Result (New-ResolvedContext -RetrievalStatus $status -ErrorMessage $errText)
    exit 1
}

try {
    $data = $rawOutput -join "`n" | ConvertFrom-Json
} catch {
    Write-Result (New-ResolvedContext -RetrievalStatus "PARTIAL" `
        -ErrorMessage "La respuesta de az no pudo parsearse como JSON: $($_.Exception.Message)")
    exit 1
}

if ($ResourceType -eq 'work_item') {
    $title = $data.fields.'System.Title'
    $descRaw = $data.fields.'System.Description'
    $status = $data.fields.'System.State'
    $workItemType = $data.fields.'System.WorkItemType'
    # `_links.html.href` no viene presente en la respuesta real de `az boards work-item
    # show` para esta forma de consulta (se confirmo contra Work Item real, 2026-09-08) --
    # se usa el patron de URL publico y estable de Azure DevOps en su lugar, no contenido
    # inventado.
    $url = "$Organization/_workitems/edit/$Reference"
    if (-not $title -and -not $descRaw) {
        Write-Result (New-ResolvedContext -RetrievalStatus "PARTIAL" -Title $title -Status $status `
            -Metadata @{ workItemType = $workItemType } -SourceUrl $url `
            -ErrorMessage "Work item recuperado pero sin titulo ni descripcion -- no se completa con contenido inventado.")
        exit 0
    }
    Write-Result (New-ResolvedContext -RetrievalStatus "SUCCESS" -Title $title -Description $descRaw `
        -Status $status -Metadata @{ workItemType = $workItemType; assignedTo = $data.fields.'System.AssignedTo'.displayName } `
        -SourceUrl $url)
} else {
    $title = $data.title
    $descRaw = $data.description
    $status = $data.status
    $url = "$Organization/$Project/_git/$($data.repository.name)/pullrequest/$Reference"
    Write-Result (New-ResolvedContext -RetrievalStatus "SUCCESS" -Title $title -Description $descRaw `
        -Status $status -Metadata @{ sourceBranch = $data.sourceRefName; targetBranch = $data.targetRefName } `
        -SourceUrl $url)
}
