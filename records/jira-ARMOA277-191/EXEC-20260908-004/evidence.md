# Evidence Record — EXEC-20260908-004

Contrato canónico: [`../architecture/evidence-evaluation-measurement.md`](../../../architecture/evidence-evaluation-measurement.md#1-evidence).
**Primer vertical slice real de Connected Context vía MCP (Prioridad 1)**: Jira (real,
tenant `baufest.atlassian.net`) → Atlassian Rovo MCP → `getJiraIssue` → Resolved Context →
CAP-002 (real). Distinto de [`EXEC-20260908-002.md`](../../jira-MOA-1234/EXEC-20260908-002/evidence.md) (REST fallback,
Prioridad 2, `BLOCKED`) — esta ejecución usa el runtime principal documentado en
[`../integrations/jira-context-provider.md`](../../../integrations/jira-context-provider.md#arquitectura-runtime--runtime-adapter).

| Campo | Valor |
|---|---|
| `capability_id` | CAP-002 (`user-story`), habilitado por CAP-008 (`jira-context`) |
| `capability_version` | CAP-002 `1.0-generalized`; CAP-008 `1.0-pattern` (`jira-context-provider v1`) |
| `execution_id` | EXEC-20260908-004 |
| `executed_at` | 2026-09-08 |
| `actor` | Ejecutor técnico de esta actividad (human+AI assistant — GitHub Copilot Agent, VS Code) |
| `repository` | `MOA-AI-Engineering` |
| `branch` | `main` |
| `input_reference` | Issue real **ARMOA277-191**, proyecto `ARMOA277` ("GMK - MOLINOS - Portal de Créditos - MOA"), tenant `baufest.atlassian.net` — `https://baufest.atlassian.net/browse/ARMOA277-191` |
| `output_reference` | Historia de usuario + criterios + reglas + análisis de gaps (ver Paso 3 más abajo) |
| `evidence_reference` | Este mismo registro |
| `evaluation_reference` | [`EXEC-20260908-004`](evaluation.md) |
| `metric_reference` | [`EXEC-20260908-004`](measurement.md) — `NOT MEASURED` |
| `status` | **EXECUTED** — real, no simulado |

## Por qué esta ejecución es distinta de `EXEC-20260908-002`

`EXEC-20260908-002` documentó honestamente un `BLOCKED` real: esa sesión (Claude Code, sin
cliente MCP interactivo) no tenía ningún servidor MCP de Atlassian invocable, y probó
únicamente la Prioridad 2 (REST), que falló por falta de credenciales. **Esta ejecución
corre en un runtime distinto** (GitHub Copilot Agent, con el servidor `Atlassian Rovo MCP`
ya cargado como herramienta del propio agente) — es la primera vez que la Prioridad 1
(`getJiraIssue` vía MCP) se invoca realmente, tal como predice
[`jira-context-provider.md`](../../../integrations/jira-context-provider.md#arquitectura-runtime--runtime-adapter).

## Paso 0 — Validación de conexión MCP (antes de cualquier lectura de issue)

Herramientas realmente invocadas (todas **READ**, ninguna `WRITE`):

| Herramienta | Propósito | Resultado real |
|---|---|---|
| `mcp_atlassian-mcp_getAccessibleAtlassianResources` | Confirmar servidor/tenant conectado | 1 recurso: `baufest` (`https://baufest.atlassian.net`), `cloudId: 61607e2f-377a-4c9b-be69-4e95aa418683`, scopes incluyen `read:jira-work` |
| `mcp_atlassian-mcp_atlassianUserInfo` | Confirmar autenticación OAuth real | Identidad real devuelta (cuenta activa, `account_type: atlassian`) — confirma OAuth 2.1 ya completado, no simulable |
| `mcp_atlassian-mcp_getVisibleJiraProjects` (`searchString: "MOA"`) | Localizar un issue real sin inventar una key (el usuario no proveyó una) | 1 proyecto real: `ARMOA277` ("GMK - MOLINOS - Portal de Créditos - MOA") |
| `mcp_atlassian-mcp_searchJiraIssuesUsingJql` (`project = ARMOA277 ORDER BY created DESC`) | Encontrar un issue real y verificable dentro del proyecto | Lista real de issues; se tomó `ARMOA277-191` |

**Nota de identificador de tenant**: el sitio real es `baufest.atlassian.net` (tenant de
Baufest, la consultora que ejecuta el proyecto para Molinos), no un tenant propio de
"MOA"/Molinos. Esto corrige la asunción implícita de `EXEC-20260908-002` (que probó con
`MOA-1234` asumiendo un proyecto `MOA`) — el proyecto real de este cliente en este tenant
es `ARMOA277`, no `MOA`.

## Paso 1 — `getJiraIssue` real (Prioridad 1, MCP)

Herramienta invocada: `mcp_atlassian-mcp_getJiraIssue`, parámetros
`cloudId: 61607e2f-377a-4c9b-be69-4e95aa418683`, `issueIdOrKey: ARMOA277-191`. Ninguna
credencial, token ni variable de entorno fue leída, generada ni almacenada por esta
ejecución — la sesión OAuth ya existente del cliente MCP fue la que autorizó la llamada.

## Paso 2 — Transformación al contrato `Resolved Context` existente

**No se creó un contrato nuevo.** Se serializó la respuesta real de `getJiraIssue` contra
[`../integrations/scripts/resolved-context.schema.json`](../../../integrations/scripts/resolved-context.schema.json)
tal cual — mismo schema que ya usa `azure-devops-context.ps1`/`jira-context.ps1`. La
transformación la hizo el Agent Runtime directamente (no un script PowerShell — `getJiraIssue`
solo puede invocarlo el cliente MCP, no un proceso standalone, tal como ya documenta
`jira-context.ps1` en su propia cabecera).

Resolved Context real, sin editar (recorte explícito: las 2 URLs de imágenes adjuntas del
`description` original se omitieron por ruido/no accesibles fuera del tenant — no se alteró
ningún texto):

```json
{
  "source": "jira",
  "sourceReference": "ARMOA277-191",
  "sourceType": "connected",
  "title": "Los créditos con cosecha con correlativo no se listan en la grilla de Aprobación de Créditos",
  "description": "Descripción:\n\nLos créditos con cosechas con correlativo se encuentran invisibles en la grilla principal.\n\nPasos para reproducir:\n1. Navegar hacia el módulo Aprobación de Créditos.\n2. Ingresar filtro con cosecha correlativo.\n3. Visualizar resultados.\n\n(2 imágenes de evidencia adjuntas en el issue original -- omitidas aquí, ver sourceUrl para el issue completo)",
  "status": "Resuelto",
  "requirements": null,
  "acceptanceCriteria": null,
  "metadata": {
    "issueType": "Error",
    "priority": "Poco importante",
    "project": "ARMOA277 - GMK - MOLINOS - Portal de Créditos - MOA",
    "reporter": "Ricardo García Meza (rgarcia@baufest.com)",
    "assignee": "Samoel Sarmiento Tello (ssarmiento@baufest.com)",
    "created": "2026-08-21T12:08:49.963-0300",
    "updated": "2026-08-21T19:01:41.464-0300"
  },
  "provenance": "jira-context-provider v1 (Atlassian Rovo MCP, getJiraIssue, invocado directamente por el Agent Runtime -- GitHub Copilot Agent en VS Code, sin script intermedio)",
  "retrievalStatus": "SUCCESS",
  "retrievedAt": "2026-09-08T00:00:00Z",
  "sourceUrl": "https://baufest.atlassian.net/browse/ARMOA277-191",
  "error": null
}
```

**Nota sobre `retrievedAt`**: se registra con precisión de fecha (`2026-09-08`); la hora
exacta se deja en `00:00:00Z` porque esta ejecución no pasó por un script que
autogenerara el timestamp (a diferencia de `jira-context.ps1`/`azure-devops-context.ps1`,
que sí usan `Get-Date`) — el Agent Runtime que invocó `getJiraIssue` directamente no expone
un reloj de sistema verificable en este contexto. Se prefiere declarar esta limitación de
precisión explícitamente antes que inventar una hora exacta.

`acceptanceCriteria` y `requirements` quedan `null` **porque el issue real es de tipo
`Error` (bug) y no contiene esos campos** — ausencia real preservada, no completada.

## Paso 3 — CAP-002 (`user-story`) ejecutado sobre el Resolved Context real

Aplicado el patrón de
[`../capabilities/skills/user-story/SKILL.md`](../../../capabilities/skills/user-story/SKILL.md)
tal cual, sin modificar la capability, usando como input:

```
Ticket:
ARMOA277-191

Requirement:
"Los créditos con cosecha con correlativo no se listan en la grilla de Aprobación de Créditos"

Context:
"Fuente: jira (ARMOA277-191)
Estado en origen: Resuelto
Tipo: Error (bug)
Referencia verificable: https://baufest.atlassian.net/browse/ARMOA277-191
Resuelto: 2026-09-08 via jira-context-provider v1 (Atlassian Rovo MCP, getJiraIssue)
Descripción: Los créditos con cosechas con correlativo se encuentran invisibles en la
grilla principal. Pasos para reproducir: 1) Navegar hacia el módulo Aprobación de
Créditos. 2) Ingresar filtro con cosecha correlativo. 3) Visualizar resultados."
```

### 1. Historia de usuario

```
Como [rol no especificado en el issue de origen — el issue no identifica quién opera el
módulo de Aprobación de Créditos],
quiero que los créditos con cosecha con correlativo se listen correctamente en la grilla
de Aprobación de Créditos,
para [beneficio de negocio no especificado explícitamente en el issue].
```

### 2. Criterios de aceptación

```
1. Dado un crédito válido con cosecha con correlativo,
   cuando se ingresa el filtro correspondiente en el módulo de Aprobación de Créditos,
   entonces el crédito debe listarse en la grilla principal
   (comportamiento esperado tras la resolución del bug, derivado directamente de los
   pasos de reproducción del issue real).
```

**No se agregaron más criterios** (validación/error, casos borde) — el issue real no
describe ningún comportamiento esperado para esos casos (ej. qué debe pasar si no hay
créditos con ese filtro, o si el correlativo es inválido). Se documentan como gap en vez
de inventarse.

### 3. Reglas de negocio

**Ninguna regla de negocio identificable en el issue de origen.** No se completó este
campo con contenido inventado.

### 4. Análisis de gaps

```
❓ Rol no especificado.
   Contexto: el issue no indica qué actor (ej. analista de créditos, operador) utiliza el
   módulo de Aprobación de Créditos.
   Impacto si no se resuelve: alto — sin rol, la historia no queda completa para Planning.

❓ Beneficio de negocio no especificado.
   Contexto: el issue describe el síntoma (créditos invisibles en la grilla) pero no el
   impacto de negocio de no verlos (ej. demoras en aprobación, riesgo de duplicar carga).
   Impacto si no se resuelve: medio.

❓ Sin criterios de aceptación para casos de error/borde.
   Contexto: no hay información sobre el comportamiento esperado cuando no existen
   créditos con el filtro aplicado, o cuando el valor de "correlativo" es inválido.
   Impacto si no se resuelve: medio — no bloquea el fix puntual, pero deja sin cubrir
   casos que un tester real probablemente encuentre.

❓ Sin reglas de negocio explícitas sobre qué hace a un crédito "con cosecha con
   correlativo" un caso especial frente a otros créditos.
   Contexto: el issue asume ese concepto de dominio sin explicarlo.
   Impacto si no se resuelve: medio — afecta la trazabilidad de la regla, no la
   funcionalidad puntual reportada.

❓ El issue está en estado "Resuelto" pero no enlaza el fix/commit que lo resolvió.
   Contexto: no fue posible verificar contra la implementación real qué cambio corrigió
   el bug (mismo principio de `user-story/SKILL.md`: "verificar contra documentación
   técnica existente antes de reportar un gap" — no hay esa documentación disponible acá).
   Impacto si no se resuelve: bajo — no afecta la historia derivada, sí la trazabilidad.
```

## Restricciones respetadas (verificado)

- **Solo lectura**: únicamente se invocaron `getAccessibleAtlassianResources`,
  `atlassianUserInfo`, `getVisibleJiraProjects`, `searchJiraIssuesUsingJql`,
  `getJiraIssue`. Ninguna herramienta `WRITE` (`createJiraIssue`, `editJiraIssue`,
  `addCommentToJiraIssue`, `transitionJiraIssue`, `addWorklogToJiraIssue`,
  `createIssueLink`) fue invocada.
- **Sin API Token / REST como camino principal**: el camino usado fue exclusivamente MCP
  (`getJiraIssue`), no `jira-context.ps1`.
- **Sin credenciales almacenadas**: ningún token, secreto ni variable de entorno fue
  escrito en ningún archivo de este repositorio.
- **Mismo contrato `Resolved Context`**: no se creó un segundo schema — se usó
  `resolved-context.schema.json` tal cual.
- **CAP-002 sin modificar**: se usó `capabilities/skills/user-story/SKILL.md` sin
  cambiarla — misma capability que consumió `EXEC-20260908-003` (Azure DevOps).
- **No se inventó información**: rol, beneficio, reglas de negocio y criterios
  adicionales quedaron explícitamente como gaps, no como contenido plausible inventado.
