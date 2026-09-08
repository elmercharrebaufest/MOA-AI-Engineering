# Context Providers — Quick Start

**Para quién es**: un desarrollador que quiere ejecutar el vertical slice real
`Jira/Azure DevOps → Resolved Context → CAP-002 (user-story)` en su propio entorno, sin
depender del arquitecto.

**Estado de cada paso, distinguido sin excepción** (Principio central del modelo,
`CONFIGURED ≠ USED ≠ MATURE ≠ MEASURED ≠ PROVEN`):

| Estado | Qué significa |
|---|---|
| `CONFIGURED` | El código/config existe y está bien formado |
| `EXECUTABLE` | El código corre — probado en sus rutas de error, no en un caso de éxito completo todavía |
| `EXECUTED` | Corrió de verdad, con un resultado real (éxito o `BLOCKED`, ambos son "real") |
| `EVALUATED` | Un humano revisó el resultado contra criterios |
| `MEASURED` | Existe una medición real contra un baseline |

## 1. Prerequisites

- PowerShell (Windows) o PowerShell Core (`pwsh`, cualquier plataforma).
- Para Azure DevOps: Azure CLI (`az`) con la extensión `azure-devops` instalada, sesión
  autenticada (`az login`) — mismo prerequisito ya vigente para CAP-001
  (`azure-devops-cli`).
- Para Jira: **uno** de los 2 mecanismos:
  - Un cliente MCP real (VS Code + Copilot) con `com.atlassian/atlassian-mcp-server`
    configurado y autenticado — ver `../integrations/scripts/mcp.template.json`.
  - Un API token de Jira de una cuenta autorizada (Prioridad 2, fallback REST).

## 2. Configuration

Azure DevOps (variables de entorno, **nunca hardcoded**):

```powershell
$env:AZURE_DEVOPS_ORG = "https://dev.azure.com/<tu-organizacion>"
$env:AZURE_DEVOPS_PROJECT = "<tu-proyecto>"   # requerido solo para pull_request
```

Jira (Prioridad 2, REST):

```powershell
$env:JIRA_BASE_URL = "https://<tu-org>.atlassian.net"
$env:JIRA_EMAIL = "tu-email@empresa.com"
$env:JIRA_API_TOKEN = "<tu-token-real, nunca commiteado>"
```

**Estado**: `CONFIGURED` una vez seteadas — ningún valor de ejemplo de este documento es
real.

## 3. Authentication

- Azure DevOps: `az account show` debe devolver una sesión real antes de continuar.
- Jira MCP: la autenticación la resuelve el cliente MCP (VS Code/Copilot), no este
  repositorio.
- Jira REST: el API token se valida en el primer request real (401 = `UNAUTHORIZED` en el
  Resolved Context devuelto, no un error genérico).

## 4. Jira test

```powershell
cd integrations/scripts
./jira-context.ps1 -Reference "PROY-1234"
```

**Estado real, EXECUTED en esta sesión** (con `Reference: MOA-1234`, sin credenciales
disponibles en este entorno): resultado `retrievalStatus: SOURCE_UNAVAILABLE`, `BLOCKED`
— ver [`../evidence/EXEC-20260908-002.md`](../evidence/EXEC-20260908-002.md) para el JSON
completo, real, sin editar. **No se simuló un resultado exitoso.**

## 5. Azure DevOps test

```powershell
cd integrations/scripts
./azure-devops-context.ps1 -Reference "abc" -ResourceType work_item
# → retrievalStatus: INVALID_REFERENCE (validado en esta sesión, EXECUTED)

./azure-devops-context.ps1 -Reference "12345" -ResourceType work_item
# sin $env:AZURE_DEVOPS_ORG seteado
# → retrievalStatus: SOURCE_UNAVAILABLE (validado en esta sesión, EXECUTED)

# Con AZURE_DEVOPS_ORG real seteado y un ID real de Work Item:
$env:AZURE_DEVOPS_ORG = "https://dev.azure.com/<org>"
./azure-devops-context.ps1 -Reference "<ID real>" -ResourceType work_item -OutFile resolved-context.json
```

**Estado**: `EXECUTED` — las 2 rutas de error y el camino de éxito completo se validaron
en esta sesión, incluyendo un vertical slice real de punta a punta (Work Item #7 real →
Resolved Context → CAP-002) — ver
[`../evidence/EXEC-20260908-003.md`](../evidence/EXEC-20260908-003.md) para el detalle
completo, comandos y salidas reales, sin editar.

## 6. Context resolution

Cualquiera de los 2 scripts anteriores produce un `Resolved Context` que cumple
[`../integrations/scripts/resolved-context.schema.json`](../integrations/scripts/resolved-context.schema.json)
— ver ese archivo para el mapeo exacto hacia el contrato conceptual de
[`../architecture/context-acquisition-resolution.md`](../architecture/context-acquisition-resolution.md).

## 7. CAP-002 execution

```powershell
./invoke-cap002-with-context.ps1 -ContextFile resolved-context.json
```

Traduce el `Resolved Context` (sin importar si vino de Jira o Azure DevOps) al mismo
bloque `Ticket:/Requirement:/Context:` que
[`../capabilities/skills/user-story/SKILL.md`](../capabilities/skills/user-story/SKILL.md)
ya acepta. Pegá esa salida en el patrón de ejecución de CAP-002 (sección "Execution
prompt pattern" de esa skill) con tu asistente de IA (Copilot, Claude, u otro).

**Estado**: `EXECUTED` — vertical slice completo de punta a punta corrido en esta sesión
(Work Item real → Resolved Context real → CAP-002 real) — ver
[`../evidence/EXEC-20260908-003.md`](../evidence/EXEC-20260908-003.md).

## 8. Evidence

Cada ejecución real de cualquiera de los 3 scripts debe registrarse con el
[Evidence Contract](../architecture/evidence-evaluation-measurement.md#1-evidence) — ver
[`../evidence/EXEC-20260908-002.md`](../evidence/EXEC-20260908-002.md) como ejemplo real
(un `BLOCKED`, no un éxito, y así se registró).

## 9. Evaluation

Al evaluar un Resolved Context real, separar explícitamente:
1. **Ejecución** — ¿el script corrió y devolvió un `retrievalStatus` válido?
2. **Evaluación humana** — ¿una persona confirmó que el contenido resuelto preserva el
   significado real del issue/work item, sin inventar información?
3. **Evaluación asistida** (`model-assisted`) — no sustituye la humana, igual que en
   CAP-002 (ver `../architecture/evidence-evaluation-measurement.md` §2).

**No declarar una evaluación independiente si no existe** — mismo principio ya vigente en
todo el repositorio.

## 10. Troubleshooting

| Síntoma | `retrievalStatus` | Causa probable |
|---|---|---|
| El script falla antes de cualquier llamada real | `INVALID_REFERENCE` | Formato de referencia incorrecto |
| Falta configuración | `SOURCE_UNAVAILABLE` | Variables de entorno/organización no configuradas |
| `az`/REST devuelve 401 | `UNAUTHORIZED` | Sesión no autenticada o token inválido/expirado |
| `az`/REST devuelve 403 | `FORBIDDEN` | Sin permisos sobre el proyecto/recurso |
| `az`/REST devuelve 404 | `NOT_FOUND` | La referencia no existe en el proyecto configurado |
| Recurso existe pero sin campos relevantes | `PARTIAL` | El script no completa con contenido inventado — revisar manualmente |

**Cada comando de este documento fue validado en esta sesión, salvo donde se marca
explícitamente `EXECUTABLE` (no `EXECUTED`)** — no hay instrucciones ficticias acá.
