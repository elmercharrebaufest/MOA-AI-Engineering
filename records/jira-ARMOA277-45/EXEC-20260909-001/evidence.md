# Evidence Record — EXEC-20260909-001

Esta es la ejecución más importante de las 6 que tiene `user-story` (CAP-002) hasta ahora:
fue la primera vez que alguien de MOA la usó por su cuenta, sin relación con quien armó
este repositorio. Las 5 anteriores las hizo la misma persona que diseñó el modelo, a modo
de prueba. El detalle de cómo pasó está en
[PILOT-003](../../../docs/history/track-1/pilots/PILOT-003-armoa277-45-cold-start-independiente/README.md).

Una aclaración importante: que la haya ejecutado una persona independiente **no significa
que el resultado ya esté evaluado por un humano** — eso todavía no pasó (lo ves en el
archivo `evaluation.md` de esta misma carpeta). Son 2 cosas distintas: quién ejecutó, y
quién revisó que el resultado esté bien.

Lo que se hizo, en simple: se trajo el ticket real `ARMOA277-45` directamente desde Jira
(usando el servidor MCP de Atlassian, no copiando y pegando a mano), y con ese contenido
se generó la historia de usuario, los criterios de aceptación, las reglas de negocio y las
preguntas abiertas. Es la tercera vez que se prueba este camino de punta a punta, y la
primera sobre un caso de prueba (tipo `Test` en Jira) en vez de un bug o una tarea — así
que además sirve para confirmar que la capability funciona también con este tipo de
contenido.

Contrato canónico: [`evidence-evaluation-measurement.md`](../../../architecture/evidence-evaluation-measurement.md#1-evidence).

| Campo | Valor |
|---|---|
| `capability_id` | CAP-002 (`user-story`), con el contexto traído por CAP-008 (`jira-context`) |
| `capability_version` | CAP-002 `1.0-generalized`; CAP-008 `1.0-pattern` |
| `execution_id` | EXEC-20260909-001 |
| `executed_at` | 2026-09-09 |
| `actor` | Un developer real de MOA, sin relación con quien armó este repositorio, trabajando en una sesión de chat aparte (GitHub Copilot Agent, VS Code) — ver `PILOT-003` |
| `repository` | `MOA-AI-Engineering` |
| `branch` | `main` |
| `input_reference` | Issue real **ARMOA277-45**, del proyecto "GMK - MOLINOS - Portal de Créditos - MOA" — `https://baufest.atlassian.net/browse/ARMOA277-45` |
| `output_reference` | La historia de usuario, criterios, reglas y preguntas abiertas (ver más abajo) |
| `evidence_reference` | Este mismo registro |
| `evaluation_reference` | [`evaluation.md`](evaluation.md) |
| `metric_reference` | [`measurement.md`](measurement.md) — todavía no hay nada medido |
| `status` | Ejecutado, real, no simulado |

## Por qué este ticket

El developer dio directamente la referencia `ARMOA277-45`, sin buscarla antes en Jira. El
issue resultó ser un caso de prueba (tipo `Test`, de Xray) — un tipo distinto a los 2 que
ya se habían probado antes (un bug y una tarea de infraestructura), así que de paso suma
evidencia de que la capability también funciona bien sobre este tipo de contenido, no solo
sobre requerimientos o tareas.

## Paso 1 — Traer el issue real desde Jira

Se usó la herramienta `getJiraIssue` (vía MCP de Atlassian) para pedir el issue
`ARMOA277-45` directamente. No se leyó, generó ni guardó ninguna credencial en este
paso — se reutilizó la sesión ya autorizada del cliente MCP.

Esto es lo que Jira devolvió (sin agregar ni resumir nada):

| Campo Jira | Valor real |
|---|---|
| `summary` | "Consulta de Datos Sociedad exitosa (Integración SAP)" |
| `issuetype` | `Test` (caso de prueba de Xray) |
| `description` | "Validar que al realizar una Búsqueda con CUIT y Cosecha válidos, el sistema recupere y muestre la información de SAP de forma correcta en Datos Sociedad." |
| `status` | Pendiente |
| `priority` | Medium |
| `project` | ARMOA277 — "GMK - MOLINOS - Portal de Créditos - MOA" |
| `reporter` / `assignee` | Ricardo García Meza, en ambos campos |
| `created` | 2026-06-22 |
| `updated` | 2026-06-23 |
| `labels` / `components` | vacíos |

## Paso 2 — Armar el contexto que recibe la capability

Con esos datos se arma un paquete de contexto (`Resolved Context`) en el mismo formato que
ya usan las otras ejecuciones — no se inventó ni se cambió nada del formato para esta.
`requirements` y `acceptanceCriteria` quedan vacíos porque Jira no tenía cargados esos
campos específicos para este issue, no porque se haya omitido algo a propósito:

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

## Paso 3 — Generar la historia de usuario

Con ese contexto, se aplicó la capability `user-story` tal cual está definida, sin
modificarla. Esto fue lo que se generó:

### Historia de usuario

```
Como usuario del Portal de Créditos (el rol específico no está definido en el issue —
falta confirmarlo),
quiero consultar los Datos de Sociedad ingresando CUIT y Cosecha,
para obtener la información de la sociedad sincronizada desde SAP sin consultarla
manualmente en el sistema origen.
```

El issue de origen es un caso de prueba, no una historia de usuario ni un pedido de
negocio explícito — la historia se reconstruyó hacia atrás desde lo que el caso de prueba
describe. Se aclara esto como una limitación real, no se disimula.

### Criterios de aceptación

```
Dado que el usuario ingresa un CUIT y una Cosecha válidos y existentes en SAP,
cuando ejecuta la búsqueda de Datos Sociedad,
entonces el sistema recupera la información desde SAP y la muestra correctamente en la
pantalla de Datos Sociedad.

Dado que el usuario ingresa un CUIT válido pero sin datos asociados en SAP para la
Cosecha indicada,
cuando ejecuta la búsqueda,
entonces el sistema debe informar la ausencia de datos de forma explícita (este
comportamiento no está documentado en el issue — queda como pregunta abierta, no se
inventó).

Dado que el CUIT o la Cosecha ingresados tienen formato inválido,
cuando el usuario ejecuta la búsqueda,
entonces el sistema debe rechazar la búsqueda y mostrar un mensaje de validación (ídem,
no documentado, queda como pregunta abierta).
```

Solo el primer criterio (el camino esperado) está respaldado directamente por lo que dice
el issue. Los otros 2 son deducciones razonables de lo mínimo que cualquier búsqueda
debería cubrir — se marcan como tal, no se presentan con la misma certeza que el primero.

### Reglas de negocio

```
RN-01: La búsqueda de Datos Sociedad requiere CUIT y Cosecha como criterios de búsqueda.
RN-02: Los datos mostrados en Datos Sociedad provienen de una integración con SAP (no de
       una fuente propia del Portal de Créditos).
```

Son ilustrativas del formato esperado, no están certificadas contra la implementación
real — hay que validar cada una contra la integración con SAP antes de dar la historia
por cerrada.

### Preguntas abiertas

```
❓ ¿Qué debe mostrar el sistema si el CUIT/Cosecha son válidos pero SAP no tiene datos
   para esa combinación?
   El issue solo describe el caso exitoso; no hay un caso de prueba para cuando no hay
   datos. Impacto si no se resuelve: medio.

❓ ¿Qué pasa si la integración con SAP no responde o da timeout?
   No hay nada documentado sobre cómo manejar una falla de la integración externa.
   Impacto si no se resuelve: alto — es un punto de falla real.

❓ ¿Cuál es el rol real que hace esta búsqueda?
   El issue no dice quién ejecuta esta acción; "usuario del Portal de Créditos" es un
   placeholder, no un rol confirmado del negocio. Impacto si no se resuelve: medio.

❓ ¿Qué formato válido deben tener el CUIT y la Cosecha?
   No está especificado ni en el issue ni en la descripción del caso de prueba. Impacto
   si no se resuelve: medio — afecta directamente el criterio de validación.
```

## Qué se respetó durante esta ejecución

- Solo se leyó información de Jira — no se escribió ni modificó nada.
- Se usó únicamente el camino MCP (no hubo que caer al método alternativo por API/token).
- No se guardó ninguna credencial en ningún archivo de este repositorio.
- No se cambió el formato de contexto ni la capability `user-story` — se usaron tal cual
  ya estaban definidos.
- No se inventó ningún dato: el rol, los criterios de error/borde y las reglas de negocio
  quedan marcados explícitamente como suposición o pregunta abierta, nunca como hecho
  confirmado por el issue.
