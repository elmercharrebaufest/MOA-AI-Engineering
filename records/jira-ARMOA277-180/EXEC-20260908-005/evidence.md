# Evidence Record — EXEC-20260908-005

Contrato canónico: [`../architecture/evidence-evaluation-measurement.md`](../../../architecture/evidence-evaluation-measurement.md#1-evidence).
**Segunda ejecución real de Connected Context vía MCP (Prioridad 1), para probar
generalización**: Jira (real, tenant `baufest.atlassian.net`) → Atlassian Rovo MCP →
`getJiraIssue` → Resolved Context → CAP-002 (real), sobre un issue **distinto** de
[`EXEC-20260908-004.md`](../../jira-ARMOA277-191/EXEC-20260908-004/evidence.md) (`ARMOA277-191`, tipo `Error`/Bug).

| Campo | Valor |
|---|---|
| `capability_id` | CAP-002 (`user-story`), habilitado por CAP-008 (`jira-context`) |
| `capability_version` | CAP-002 `1.0-generalized`; CAP-008 `1.0-pattern` (`jira-context-provider v1`) |
| `execution_id` | EXEC-20260908-005 |
| `executed_at` | 2026-09-08 |
| `actor` | Ejecutor técnico de esta actividad (human+AI assistant — GitHub Copilot Agent, VS Code) |
| `repository` | `MOA-AI-Engineering` |
| `branch` | `main` |
| `input_reference` | Issue real **ARMOA277-180**, proyecto `ARMOA277` ("GMK - MOLINOS - Portal de Créditos - MOA"), tenant `baufest.atlassian.net` — `https://baufest.atlassian.net/browse/ARMOA277-180` |
| `output_reference` | Historia de usuario + criterios + reglas + análisis de gaps (ver Paso 3 más abajo) |
| `evidence_reference` | Este mismo registro |
| `evaluation_reference` | [`EXEC-20260908-005`](evaluation.md) |
| `metric_reference` | [`EXEC-20260908-005`](measurement.md) — `NOT MEASURED` |
| `status` | **EXECUTED** — real, no simulado |

## Por qué se eligió `ARMOA277-180`

Objetivo explícito de esta ejecución: probar generalización sobre un **tipo de issue
distinto** al de `EXEC-20260908-004` (`Error`/Bug). Búsqueda real vía JQL
(`project = ARMOA277 AND issuetype != Error`, y por proyecto completo sin filtro) mostró
que el proyecto `ARMOA277` en este tenant está dominado casi en su totalidad por issues de
tipo `Error`/Bug — **no se encontró ningún issue de tipo `Historia`/Story** (`issuetype =
Historia` devolvió 0 resultados). Sí se encontró **1 issue de tipo `Tarea`/Task**:
`ARMOA277-180` ("Infraestructura/Despliegue Motor de Decisiones en QA"), distinto en tipo,
estado y completitud de campos respecto a `ARMOA277-191`. Se seleccionó por ser el único
tipo de issue realmente disponible y distinto en este proyecto — no se buscó fuera de
`ARMOA277` porque el encargo pedía explícitamente permanecer dentro de ese proyecto.

## Paso 0 — Localización del segundo issue (todo READ)

| Herramienta | Propósito | Resultado real |
|---|---|---|
| `mcp_atlassian-mcp_searchJiraIssuesUsingJql` (`project = ARMOA277 AND key != ARMOA277-191 ORDER BY created DESC`) | Confirmar candidatos reales distintos del primer issue | Lista real; primeros resultados (`ARMOA277-190`, `ARMOA277-189`) también tipo `Error` |
| `mcp_atlassian-mcp_searchJiraIssuesUsingJql` (`project = ARMOA277 AND issuetype != Error ORDER BY created DESC`) | Intentar filtrar directamente por tipo distinto | La API devolvió issues tipo `Error` igual — el nombre localizado `Error` no coincidió como se esperaba en el filtro JQL de este tenant |
| `mcp_atlassian-mcp_getJiraProjectIssueTypesMetadata` (`ARMOA277`) | Confirmar catálogo real de tipos de issue del proyecto | 17 tipos definidos (`Error`/Bug, `Epic`, `Historia`/Story, `Issue`, `Change Request`, `Tarea`/Task, entre otros) |
| `mcp_atlassian-mcp_searchJiraIssuesUsingJql` (`project = ARMOA277 AND issuetype = Historia`) | Verificar si existe algún issue tipo Story real | 0 resultados — no existe ningún issue `Historia` en este proyecto |
| `mcp_atlassian-mcp_searchJiraIssuesUsingJql` (`project = ARMOA277`, sin filtro de tipo, ordenado por creación) | Relevar la distribución real de tipos para elegir honestamente el más distinto disponible | Casi todos `Error`; se identificó `ARMOA277-180` como único `Tarea` visible en el rango relevado |

## Paso 1 — `getJiraIssue` real (Prioridad 1, MCP)

Herramienta invocada: `mcp_atlassian-mcp_getJiraIssue`, parámetros
`cloudId: 61607e2f-377a-4c9b-be69-4e95aa418683`, `issueIdOrKey: ARMOA277-180`. Ninguna
credencial, token ni variable de entorno fue leída, generada ni almacenada por esta
ejecución — misma sesión OAuth ya autorizada del cliente MCP, reutilizada sin volver a
autenticar.

Campos reales devueltos (resumen, sin inventar ninguno adicional):

| Campo Jira | Valor real |
|---|---|
| `summary` | "Infraestructura/Despliegue Motor de Decisiones en QA" |
| `issuetype` | `Tarea` (Task) — `id: 3`, "Un trabajo pequeño e independiente." |
| `description` | `null` — **el issue no tiene descripción cargada** |
| `status` | `Pendiente` (`statusCategory: Por hacer/new`) — **no resuelto**, a diferencia de `ARMOA277-191` |
| `resolution` | `null` |
| `priority` | "Poco importante" |
| `project` | `ARMOA277` — "GMK - MOLINOS - Portal de Créditos - MOA" |
| `reporter` | Jesús Gutiérrez (`jgutierrez@baufest.com`) |
| `assignee` | Elmer Elias Charre Salazar (`echarre@baufest.com`) |
| `created` | `2026-08-19T15:24:53.476-0300` |
| `updated` | `2026-08-19T15:25:29.913-0300` |
| `labels` / `components` | `[]` (vacíos) |

## Paso 2 — Transformación al contrato `Resolved Context` existente

**No se creó un contrato nuevo, ni se modificó el existente.** Se serializó la respuesta
real contra
[`../integrations/scripts/resolved-context.schema.json`](../integrations/scripts/resolved-context.schema.json)
tal cual — mismo schema que `EXEC-20260908-004`.

Resolved Context real, sin editar (`description` se deja `null` porque el campo real de
Jira es `null` — no se completó con contenido inventado):

```json
{
  "source": "jira",
  "sourceReference": "ARMOA277-180",
  "sourceType": "connected",
  "title": "Infraestructura/Despliegue Motor de Decisiones en QA",
  "description": null,
  "status": "Pendiente",
  "requirements": null,
  "acceptanceCriteria": null,
  "metadata": {
    "issueType": "Tarea",
    "priority": "Poco importante",
    "project": "ARMOA277 - GMK - MOLINOS - Portal de Créditos - MOA",
    "reporter": "Jesús Gutiérrez (jgutierrez@baufest.com)",
    "assignee": "Elmer Elias Charre Salazar (echarre@baufest.com)",
    "created": "2026-08-19T15:24:53.476-0300",
    "updated": "2026-08-19T15:25:29.913-0300"
  },
  "provenance": "jira-context-provider v1 (Atlassian Rovo MCP, getJiraIssue, invocado directamente por el Agent Runtime -- GitHub Copilot Agent en VS Code, sin script intermedio)",
  "retrievalStatus": "SUCCESS",
  "retrievedAt": "2026-09-08T00:00:00Z",
  "sourceUrl": "https://baufest.atlassian.net/browse/ARMOA277-180",
  "error": null
}
```

### Verificación explícita campo por campo (pedida en el encargo)

| Campo pedido en el encargo | Campo real del contrato | Valor | Nota |
|---|---|---|---|
| `source_type` | `sourceType` | `"connected"` | Mismo valor que `EXEC-20260908-004` — el contrato no tiene un campo llamado literalmente `source_type`, se usa el nombre real del schema |
| `source_system` | `source` | `"jira"` | Ídem |
| `source_identifier` | `sourceReference` | `"ARMOA277-180"` | Ídem |
| `resolved_at` | `retrievedAt` | `"2026-09-08T00:00:00Z"` | Misma limitación de precisión de hora que `EXEC-20260908-004` (sin script con `Get-Date`), declarada explícitamente, no inventada |
| `content_reference` | `sourceUrl` | `"https://baufest.atlassian.net/browse/ARMOA277-180"` | — |
| `content` | `title` + `description` | `title` real; `description: null` (real, no inventado) | A diferencia de `EXEC-20260908-004`, aquí no hay texto de descripción para preservar |
| `metadata` | `metadata` | Ver bloque de arriba | Mismos 6 subcampos que `EXEC-20260908-004`, con valores reales distintos |
| `provenance` | `provenance` | Idéntico texto de proveniencia que `EXEC-20260908-004` (mismo mecanismo real) | — |
| `retrieval_status` | `retrievalStatus` | `"SUCCESS"` | La llamada real tuvo éxito — la ausencia de `description` es del dato de origen, no un fallo de recuperación |

**No se inventó ningún campo que Jira no tenga** — `description`, `resolution`,
`requirements` y `acceptanceCriteria` quedan `null` porque así están en el issue real.

## Paso 3 — CAP-002 (`user-story`) ejecutado sobre el Resolved Context real

Aplicado el patrón de
[`../capabilities/skills/user-story/SKILL.md`](../../../capabilities/skills/user-story/SKILL.md)
tal cual, sin modificar la capability, usando como input:

```
Ticket:
ARMOA277-180

Requirement:
"Infraestructura/Despliegue Motor de Decisiones en QA"

Context:
"Fuente: jira (ARMOA277-180)
Estado en origen: Pendiente (no resuelto)
Tipo: Tarea (Task)
Referencia verificable: https://baufest.atlassian.net/browse/ARMOA277-180
Resuelto: 2026-09-08 via jira-context-provider v1 (Atlassian Rovo MCP, getJiraIssue)
Descripción: (ninguna — el campo description del issue real es null)"
```

### 1. Historia de usuario

```
Como [rol no especificado en el issue de origen — no hay descripción que identifique
quién solicita o se beneficia de este despliegue],
quiero [el Motor de Decisiones desplegado/operativo en el ambiente de QA — inferido
únicamente del título, sin más detalle disponible],
para [beneficio de negocio no especificado — el issue no explica por qué se necesita
este despliegue en QA].
```

**Nota de fidelidad**: a diferencia de `EXEC-20260908-004` (donde el "quiero" se derivó de
pasos de reproducción reales), acá el "quiero" es una paráfrasis mínima y literal del
`summary` — no se agregó ningún detalle técnico (ej. qué componente del Motor de
Decisiones, qué versión, qué configuración) que el issue no tenga.

### 2. Criterios de aceptación

```
Sin criterios de aceptación derivables de este issue.
```

**No se generó ningún criterio Given-When-Then.** El issue no tiene descripción, pasos de
reproducción, ni ningún comportamiento esperado documentado — solo un título. Inventar un
criterio (ej. "dado que se despliega en QA, cuando se accede al Motor de Decisiones,
entonces responde correctamente") sería fabricar contenido que el issue real no respalda.
Esto se registra como el gap más importante de esta ejecución, no como un criterio vacío
disimulado.

### 3. Reglas de negocio

**Ninguna regla de negocio identificable.** Sin descripción ni contexto técnico adicional,
no hay base real para inferir ninguna regla — no se completó con contenido inventado.

### 4. Análisis de gaps

```
❓ Sin descripción (campo `description` real es `null`).
   Contexto: el issue solo tiene un título — ningún detalle de qué debe desplegarse,
   configuración, ambiente exacto, ni criterio de "hecho".
   Impacto si no se resuelve: alto — imposible derivar criterios de aceptación reales sin
   esta información.

❓ Rol no especificado.
   Contexto: no hay información sobre quién solicita/necesita este despliegue.
   Impacto si no se resuelve: alto.

❓ Beneficio de negocio no especificado.
   Contexto: no se explica el impacto de negocio de tener (o no tener) el Motor de
   Decisiones desplegado en QA.
   Impacto si no se resuelve: medio.

❓ Sin criterios de aceptación de ningún tipo.
   Contexto: consecuencia directa de la ausencia de descripción — no hay comportamiento
   esperado documentado que verificar.
   Impacto si no se resuelve: alto — sin esto, la tarea no es actionable para un equipo de
   desarrollo/infraestructura sin conversación adicional.

❓ Sin reglas de negocio explícitas.
   Contexto: no hay contexto técnico (versión del Motor de Decisiones, dependencias,
   configuración de QA) documentado en el issue.
   Impacto si no se resuelve: medio.

❓ El issue está en estado "Pendiente" (no resuelto) — a diferencia de `ARMOA277-191`.
   Contexto: no hay evidencia de que el trabajo se haya completado o esté en curso más
   allá del estado declarado.
   Impacto si no se resuelve: bajo — no afecta la generación de la historia en sí, solo su
   vigencia temporal.
```

## Restricciones respetadas (verificado)

- **Solo lectura**: únicamente se invocaron `searchJiraIssuesUsingJql`,
  `getJiraProjectIssueTypesMetadata`, `getJiraIssue`. Ninguna herramienta `WRITE` fue
  invocada.
- **Sin API Token / REST como camino principal**: exclusivamente MCP (`getJiraIssue`), no
  `jira-context.ps1`.
- **Sin credenciales almacenadas**: ningún token, secreto ni variable de entorno fue
  escrito en ningún archivo de este repositorio.
- **Mismo contrato `Resolved Context`**: no se creó ni modificó ningún schema.
- **CAP-002 sin modificar**: se usó `capabilities/skills/user-story/SKILL.md` sin cambiar
  ninguna línea.
- **No se creó ninguna capability nueva** ni se cambió la arquitectura.
- **No se inventó información**: descripción ausente, rol, beneficio, reglas de negocio y
  criterios de aceptación quedaron explícitamente sin completar/como gaps, no como
  contenido plausible inventado.
