# Evidence Record — EXEC-20260909-001

**La más significativa de las 6 ejecuciones de CAP-002 hasta hoy**: es la **primera con un
actor real independiente** de quien diseñó `MOA-AI-Engineering` — ver
[`PILOT-003`](../../../docs/history/track-1/pilots/PILOT-003-armoa277-45-cold-start-independiente/README.md).
Todas las anteriores (`EXEC-20260907-001` a `EXEC-20260908-005`) fueron CONTROLLED
DRY-RUN del mismo agente que construyó el modelo. La `Evaluation` sigue siendo
`model-assisted` (sección de abajo) — la independencia del actor y la independencia de la
evaluación son 2 ejes distintos, y solo el primero se resuelve acá.

Contrato canónico: [`../architecture/evidence-evaluation-measurement.md`](../../../architecture/evidence-evaluation-measurement.md#1-evidence).
**Tercera ejecución real de Connected Context vía MCP (Prioridad 1)**: Jira (real, tenant
`baufest.atlassian.net`) → Atlassian Rovo MCP → `getJiraIssue` → Resolved Context →
CAP-002 (real), sobre un issue de tipo `Test` (Xray) — un tercer tipo de issue distinto de
[`EXEC-20260908-004.md`](../../jira-ARMOA277-191/EXEC-20260908-004/evidence.md) (`Error`/Bug) y
[`EXEC-20260908-005.md`](../../jira-ARMOA277-180/EXEC-20260908-005/evidence.md) (`Tarea`/Task).

| Campo | Valor |
|---|---|
| `capability_id` | CAP-002 (`user-story`), habilitado por CAP-008 (`jira-context`) |
| `capability_version` | CAP-002 `1.0-generalized`; CAP-008 `1.0-pattern` (`jira-context-provider v1`) |
| `execution_id` | EXEC-20260909-001 |
| `executed_at` | 2026-09-09 |
| `actor` | Developer real de MOA, **independiente de quien diseñó `MOA-AI-Engineering`** (human+AI assistant — GitHub Copilot Agent, VS Code), en una sesión de chat separada sin el historial de diseño de este repositorio — ver `docs/history/track-1/pilots/PILOT-003-armoa277-45-cold-start-independiente/README.md` |
| `repository` | `MOA-AI-Engineering` |
| `branch` | `main` |
| `input_reference` | Issue real **ARMOA277-45**, proyecto `ARMOA277` ("GMK - MOLINOS - Portal de Créditos - MOA"), tenant `baufest.atlassian.net` — `https://baufest.atlassian.net/browse/ARMOA277-45` |
| `output_reference` | Historia de usuario + criterios + reglas + análisis de gaps (ver Paso 3 más abajo) |
| `evidence_reference` | Este mismo registro |
| `evaluation_reference` | [`EXEC-20260909-001`](evaluation.md) |
| `metric_reference` | [`EXEC-20260909-001`](measurement.md) — `NOT MEASURED` |
| `status` | **EXECUTED** — real, no simulado |

## Por qué se eligió `ARMOA277-45`

El usuario aportó directamente la referencia `ARMOA277-45` (sin búsqueda JQL previa, a
diferencia de `EXEC-20260908-005`). El issue real resultó ser de tipo `Test` (Xray Test
Issue Type) — un tercer tipo distinto de los dos ya probados en este proyecto (`Error`/Bug
en `EXEC-20260908-004`, `Tarea`/Task en `EXEC-20260908-005`), lo que suma evidencia real de
generalización de CAP-002 sobre un tipo de contenido adicional: un caso de prueba, no un
requerimiento ni una tarea de infraestructura.

## Paso 1 — `getJiraIssue` real (Prioridad 1, MCP)

Herramienta invocada: `mcp_atlassian-mcp_getJiraIssue`, parámetros
`cloudId: 61607e2f-377a-4c9b-be69-4e95aa418683`, `issueIdOrKey: ARMOA277-45`. Ninguna
credencial, token ni variable de entorno fue leída, generada ni almacenada por esta
ejecución — misma sesión OAuth ya autorizada del cliente MCP, reutilizada sin volver a
autenticar.

Campos reales devueltos (resumen, sin inventar ninguno adicional):

| Campo Jira | Valor real |
|---|---|
| `summary` | "Consulta de Datos Sociedad exitosa (Integración SAP)" |
| `issuetype` | `Test` — `id: 11936`, "This is the Xray Test Issue Type. Used to define test cases of different types that can be executed multiple times using Test Execution issues." |
| `description` | "Validar que al realizar una Búsqueda con CUIT y Cosecha válidos, el sistema recupere y muestre la información de SAP de forma correcta en Datos Sociedad." |
| `status` | `Pendiente` (`statusCategory: Por hacer/new`) |
| `resolution` | `null` |
| `priority` | "Medium" |
| `project` | `ARMOA277` — "GMK - MOLINOS - Portal de Créditos - MOA" |
| `reporter` / `assignee` | Ricardo García Meza (`rgarcia@baufest.com`), mismo usuario en ambos campos |
| `created` | `2026-06-22T18:32:20.953-0300` |
| `updated` | `2026-06-23T11:47:47.412-0300` |
| `labels` / `components` | `[]` (vacíos) |

## Paso 2 — Transformación al contrato `Resolved Context` existente

**No se creó un contrato nuevo, ni se modificó el existente.** Se serializó la respuesta
real contra
[`../integrations/scripts/resolved-context.schema.json`](../integrations/scripts/resolved-context.schema.json)
tal cual — mismo schema que `EXEC-20260908-004`/`EXEC-20260908-005`.

Resolved Context real, sin editar:

```json
{
  "source": "jira",
  "sourceReference": "ARMOA277-45",
  "sourceType": "connected",
  "title": "Consulta de Datos Sociedad exitosa (Integración SAP)",
  "description": "Validar que al realizar una Búsqueda con CUIT y Cosecha válidos, el sistema recupere y muestre la información de SAP de forma correcta en Datos Sociedad.",
  "status": "Pendiente",
  "requirements": null,
  "acceptanceCriteria": null,
  "metadata": {
    "issueType": "Test",
    "priority": "Medium",
    "project": "ARMOA277 - GMK - MOLINOS - Portal de Créditos - MOA",
    "reporter": "Ricardo García Meza (rgarcia@baufest.com)",
    "assignee": "Ricardo García Meza (rgarcia@baufest.com)",
    "created": "2026-06-22T18:32:20.953-0300",
    "updated": "2026-06-23T11:47:47.412-0300"
  },
  "provenance": "jira-context-provider v1 (Atlassian Rovo MCP, getJiraIssue, invocado directamente por el Agent Runtime -- GitHub Copilot Agent en VS Code, sin script intermedio)",
  "retrievalStatus": "SUCCESS",
  "retrievedAt": "2026-09-09T00:00:00Z",
  "sourceUrl": "https://baufest.atlassian.net/browse/ARMOA277-45",
  "error": null
}
```

**No se inventó ningún campo que Jira no tenga** — `requirements` y `acceptanceCriteria`
quedan `null` porque el issue real no tiene campos Xray de criterios estructurados
recuperados en esta llamada (`fields` por defecto, sin `expand` de campos Xray custom).

## Paso 3 — CAP-002 (`user-story`) ejecutado sobre el Resolved Context real

Aplicado el patrón de
[`../capabilities/skills/user-story/SKILL.md`](../../../capabilities/skills/user-story/SKILL.md)
tal cual, sin modificar la capability, usando como input:

```
Ticket:
ARMOA277-45

Requirement:
"Validar que al realizar una Búsqueda con CUIT y Cosecha válidos, el sistema recupere y
muestre la información de SAP de forma correcta en Datos Sociedad."

Context:
"Fuente: jira (ARMOA277-45)
Estado en origen: Pendiente (no resuelto)
Tipo: Test (Xray Test Issue Type)
Referencia verificable: https://baufest.atlassian.net/browse/ARMOA277-45
Resuelto: 2026-09-09 via jira-context-provider v1 (Atlassian Rovo MCP, getJiraIssue)"
```

### 1. Historia de usuario

```
Como usuario del Portal de Créditos (rol específico REQUIERE VALIDACIÓN — no declarado en
el issue),
quiero consultar los Datos de Sociedad ingresando CUIT y Cosecha,
para obtener la información de la sociedad sincronizada desde SAP sin consultarla
manualmente en el sistema origen.
```

**Nota de fidelidad**: el issue de origen es un caso de prueba (Xray `Test`), no una
historia de usuario ni un requerimiento crudo — la historia fue reconstruida hacia atrás
desde el comportamiento esperado que el caso de prueba describe, no desde un pedido de
negocio explícito. Esto se declara como limitación, no se disimula.

### 2. Criterios de aceptación

```
Dado que el usuario ingresa un CUIT y una Cosecha válidos y existentes en SAP,
cuando ejecuta la búsqueda de Datos Sociedad,
entonces el sistema recupera la información desde SAP y la muestra correctamente en la
pantalla de Datos Sociedad.

Dado que el usuario ingresa un CUIT válido pero sin datos asociados en SAP para la
Cosecha indicada,
cuando ejecuta la búsqueda,
entonces el sistema debe informar la ausencia de datos de forma explícita (comportamiento
exacto NO documentado en el issue real — registrado como gap, no inventado).

Dado que el CUIT o la Cosecha ingresados tienen formato inválido,
cuando el usuario ejecuta la búsqueda,
entonces el sistema debe rechazar la búsqueda y mostrar un mensaje de validación
(comportamiento exacto NO documentado en el issue real — registrado como gap, no
inventado).
```

**Nota de fidelidad**: solo el primer criterio (camino feliz) está respaldado
directamente por el texto real del issue ("exitosa" en el summary, y la descripción
completa). Los otros dos (error/borde) son inferencias razonables de cobertura mínima
exigidas por la skill, no comportamiento confirmado — se marcan explícitamente como tal,
no se presentan con el mismo nivel de certeza que el primero.

### 3. Reglas de negocio

```
RN-01: La búsqueda de Datos Sociedad requiere CUIT y Cosecha como criterios de búsqueda.
RN-02: Los datos mostrados en Datos Sociedad provienen de una integración con SAP (no de
       una fuente propia del Portal de Créditos).
```

Ilustrativas del formato — no certificadas contra la implementación real; validar cada
regla contra la integración SAP antes de dar la historia por cerrada.

### 4. Análisis de gaps

```
❓ ¿Qué debe mostrar el sistema si el CUIT/Cosecha son válidos pero SAP no tiene datos
   para esa combinación?
   Contexto: el issue solo describe el camino feliz ("exitosa"); no hay un caso de
   prueba hermano visible para el camino sin datos.
   Impacto si no se resuelve: medio.

❓ ¿Qué pasa si la integración con SAP no responde o responde con error/timeout?
   Contexto: no se documenta manejo de fallas de la integración externa.
   Impacto si no se resuelve: alto — integración externa es un punto de falla real.

❓ ¿Cuál es el rol real que ejecuta esta búsqueda?
   Contexto: el issue no declara un actor/rol; "usuario del Portal de Créditos" es un
   placeholder, no un rol validado del dominio.
   Impacto si no se resuelve: medio.

❓ ¿Qué formato válido debe tener el CUIT y la Cosecha (rango, longitud, tipo)?
   Contexto: no está especificado en el issue ni en la descripción del test.
   Impacto si no se resuelve: medio — afecta el criterio de validación/error.
```

## Restricciones respetadas (verificado)

- **Solo lectura**: únicamente se invocó `getJiraIssue`. Ninguna herramienta `WRITE` fue
  invocada.
- **Sin API Token / REST como camino principal**: exclusivamente MCP (`getJiraIssue`), no
  `jira-context.ps1`.
- **Sin credenciales almacenadas**: ningún token, secreto ni variable de entorno fue
  escrito en ningún archivo de este repositorio.
- **Mismo contrato `Resolved Context`**: no se creó ni modificó ningún schema.
- **CAP-002 sin modificar**: se usó `capabilities/skills/user-story/SKILL.md` sin cambiar
  ninguna línea.
- **No se creó ninguna capability nueva** ni se cambió la arquitectura.
- **No se inventó información**: rol, criterios de borde/error y reglas de negocio se
  declaran explícitamente como inferencia o gap, no como contenido confirmado por el
  issue.
