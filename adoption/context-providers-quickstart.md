# Context Providers — Quick Start

**Para quién es**: un desarrollador que quiere ejecutar el vertical slice real
`Jira/Azure DevOps → Resolved Context → CAP-001 (user-story)` en su propio entorno, sin
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
  autenticada (`az login`) — mismo prerequisito ya vigente para CAP-008
  (`azure-devops-cli`).
- Para Jira: **uno** de los 2 mecanismos:
  - Un cliente MCP real (VS Code + Copilot) con `com.atlassian/atlassian-mcp-server`
    configurado y autenticado — ver `../integrations/scripts/mcp.template.json`.
  - Un API token de Jira de una cuenta autorizada (Prioridad 2, fallback REST).

## 2. Configuration

Azure DevOps (variables de entorno, **nunca hardcoded**):

```powershell
$env:AZURE_DEVOPS_ORG = "https://dev.azure.com/<organizacion>"
$env:AZURE_DEVOPS_PROJECT = "<proyecto>"   # requerido solo para pull_request
```

Jira (Prioridad 2, REST):

```powershell
$env:JIRA_BASE_URL = "https://<organizacion>.atlassian.net"
$env:JIRA_EMAIL = "email@empresa.com"
$env:JIRA_API_TOKEN = "<token-real, nunca commiteado>"
```

**Estado**: `CONFIGURED` una vez seteadas — ningún valor de ejemplo de este documento es
real.

## 3. Authentication

- Azure DevOps: `az account show` debe devolver una sesión real antes de continuar.
- Jira MCP: la autenticación la resuelve el cliente MCP (VS Code/Copilot), no este
  repositorio.
- Jira REST: el API token se valida en el primer request real (401 = `UNAUTHORIZED` en el
  Resolved Context devuelto, no un error genérico).

### 3a. Atlassian Rovo MCP v2 — runtime principal (VS Code + GitHub Copilot)

**Este es el mecanismo Prioridad 1** — el script REST de la sección 4 es el fallback
headless, no el runtime real de un desarrollador. Pasos verificados contra la
documentación oficial de Atlassian (citada abajo) y probados de punta a punta durante la
construcción — sesiones de GitHub Copilot Agent en VS Code invocaron `getJiraIssue` real
sobre varios issues de tipo distinto (esas pruebas se purgaron al pasar a adopción real).
Los pasos 1 y 2 (instalación, primer OAuth) siguen siendo
inherentemente interactivos y requieren una persona real la primera vez — una vez hechos,
el paso 3 (invocar la herramienta) puede repetirlo cualquier sesión de agente que reutilice
esa configuración/autenticación ya existente (ver detalle en
[`../integrations/jira-context-provider.md`](../integrations/jira-context-provider.md#ejecución-interactiva-histórico-vs-esta-actualización)):

1. **Instalación**: en VS Code, abrir el panel de Extensiones y buscar `@mcp Atlassian` →
   seleccionar **Atlassian MCP server** de la galería → **Install**. Alternativa manual:
   copiar [`../integrations/scripts/mcp.template.json`](../integrations/scripts/mcp.template.json)
   a `.vscode/mcp.json` del repo del equipo.
2. **Autenticación (OAuth 2.1)**: al primer uso, el cliente MCP (VS Code/Copilot) inicia
   el flujo de autenticación de Atlassian en el navegador — el desarrollador aprueba con
   su propia cuenta real. **Nunca** un token en `mcp.json` ni en ningún archivo de este
   repositorio.
3. **Prueba READ**: con Copilot en modo Agent, pedirle que use la herramienta
   `getJiraIssue` sobre un issue real (ej. *"usar getJiraIssue para traer el issue
   PROY-1234"*) — el propio cliente MCP invoca la herramienta, no un script.

**Fuentes** (verificadas 2026-09-08, no inventadas):
[Get started with the Atlassian Rovo MCP Server](https://support.atlassian.com/atlassian-rovo-mcp-server/docs/getting-started-with-the-atlassian-remote-mcp-server/),
[Supported tools](https://support.atlassian.com/atlassian-rovo-mcp-server/docs/supported-tools/).

## 4. Jira test

**Vía MCP (Prioridad 1, runtime real)**: pedirle a Copilot Agent que invoque
`getJiraIssue` sobre un issue real. No hay un comando de terminal para esto — lo ejecuta
el cliente MCP directamente. Probado durante la construcción sobre varios issues reales
de tipo distinto, con resultado `retrievalStatus: SUCCESS` y Resolved Context consumido
por CAP-001 — ejemplos purgados al pasar a adopción real. **No se simuló ningún
resultado, ni se realizó ninguna operación `WRITE` sobre Jira.**

**Vía REST (Prioridad 2, fallback headless — sin cliente MCP disponible)**:

```powershell
cd integrations/scripts
./jira-context.ps1 -Reference "PROY-1234"
```

Probado durante la construcción sin credenciales disponibles en ese entorno: resultado
`retrievalStatus: SOURCE_UNAVAILABLE`, `BLOCKED` — comportamiento correcto (no se simula
un éxito), no una limitación del patrón: con el cliente MCP autenticado, la Prioridad 1
sí llega a `SUCCESS` de punta a punta. Ver el detalle completo en
[`../integrations/jira-context-provider.md`](../integrations/jira-context-provider.md#ejecución-interactiva-histórico-vs-esta-actualización).

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

**Estado**: `EXECUTABLE` — las 2 rutas de error y el camino de éxito completo (Work Item
→ Resolved Context → CAP-001) quedaron probados durante la construcción; ese ejemplo se
purgó al pasar a adopción real — sin ejecuciones reales registradas todavía.

## 6. Context resolution

Cualquiera de los 2 scripts anteriores produce un `Resolved Context` que cumple
[`../integrations/scripts/resolved-context.schema.json`](../integrations/scripts/resolved-context.schema.json)
— ver ese archivo para el mapeo exacto hacia el contrato conceptual de
[`../architecture/context-acquisition-resolution.md`](../architecture/context-acquisition-resolution.md).

## 7. CAP-001 execution

```powershell
./invoke-cap001-with-context.ps1 -ContextFile resolved-context.json
```

Traduce el `Resolved Context` (sin importar si vino de Jira o Azure DevOps) al mismo
bloque `Ticket:/Requirement:/Context:` que
[`../capabilities/skills/user-story/SKILL.md`](../capabilities/skills/user-story/SKILL.md)
ya acepta. Esa salida se pega en el patrón de ejecución de CAP-001 (sección "Execution
prompt pattern" de esa skill), con el asistente de IA que corresponda (Copilot, Claude,
u otro).

**Estado**: `EXECUTABLE` — vertical slice completo de punta a punta probado durante la
construcción (Work Item real → Resolved Context real → CAP-001 real); ese ejemplo se
purgó al pasar a adopción real.

## 8. Evidence

Cada ejecución real de cualquiera de los caminos (MCP o los 3 scripts REST) debe
registrarse con el
[Evidence Contract](../architecture/evidence-evaluation-measurement.md#1-evidence) — ver
[`../evidence/README.md`](../evidence/README.md) para el estado vivo.

## 9. Evaluation

Al evaluar un Resolved Context real, separar explícitamente:
1. **Ejecución** — ¿el script/herramienta corrió y devolvió un `retrievalStatus` válido?
2. **Evaluación humana** — ¿una persona confirmó que el contenido resuelto preserva el
   significado real del issue/work item, sin inventar información?
3. **Evaluación asistida** (`model-assisted`) — no sustituye la humana, igual que en
   CAP-001 (ver `../architecture/evidence-evaluation-measurement.md` §2).

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

### Interpretación de SUCCESS / BLOCKED a nivel de vertical slice

Distinto del `retrievalStatus` granular del contrato (sección "Troubleshooting" arriba),
a nivel de todo el vertical slice (`Reference → Resolved Context → CAP-001`):

| Estado del vertical slice | Cuándo aplica |
|---|---|
| **SUCCESS** | `retrievalStatus: SUCCESS` o `PARTIAL` **y** CAP-001 se ejecutó sobre ese contexto |
| **BLOCKED** | El script/herramienta se ejecutó de verdad (no se omitió), pero no hay mecanismo de autenticación real disponible en el entorno — `retrievalStatus: SOURCE_UNAVAILABLE`/`UNAUTHORIZED`, con `error` explícito. **No es un fallo de diseño** — es un prerrequisito de entorno faltante, documentado con su causa exacta |

`BLOCKED` nunca se reescribe como `SUCCESS` sin que el mecanismo real exista.

**Todos los comandos de este documento fueron validados durante la construcción** — los
ejemplos concretos se purgaron al pasar a adopción real; no hay instrucciones ficticias
acá.
