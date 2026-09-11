# ARMOA277-45 — Consulta de Datos Sociedad (Integración SAP)

## Historia de usuario

```
Como usuario del Portal de Créditos (rol específico sin confirmar — no está declarado en
el issue),
quiero consultar los Datos de Sociedad ingresando CUIT y Cosecha,
para obtener la información de la sociedad sincronizada desde SAP sin consultarla
manualmente en el sistema origen.
```

## Criterios de aceptación

```
Dado que el usuario ingresa un CUIT y una Cosecha válidos y existentes en SAP,
cuando ejecuta la búsqueda de Datos Sociedad,
entonces el sistema recupera la información desde SAP y la muestra correctamente en la
pantalla de Datos Sociedad.

Dado que el usuario ingresa un CUIT válido pero sin datos asociados en SAP para la
Cosecha indicada,
cuando ejecuta la búsqueda,
entonces el sistema debe informar la ausencia de datos de forma explícita (este
comportamiento no está documentado en el issue — queda como pregunta abierta).

Dado que el CUIT o la Cosecha ingresados tienen formato inválido,
cuando el usuario ejecuta la búsqueda,
entonces el sistema debe rechazar la búsqueda y mostrar un mensaje de validación (ídem,
no documentado, queda como pregunta abierta).
```

Solo el primer criterio está respaldado directamente por lo que dice el issue. Los otros
2 son deducciones razonables de lo mínimo que cualquier búsqueda debería cubrir — no están
confirmados, hay que validarlos con el equipo.

## Reglas de negocio

```
RN-01: La búsqueda de Datos Sociedad requiere CUIT y Cosecha como criterios de búsqueda.
RN-02: Los datos mostrados en Datos Sociedad provienen de una integración con SAP (no de
       una fuente propia del Portal de Créditos).
```

Ilustrativas del formato esperado — hay que validarlas contra la integración real con SAP
antes de dar la historia por cerrada.

## Preguntas abiertas

```
❓ ¿Qué debe mostrar el sistema si el CUIT/Cosecha son válidos pero SAP no tiene datos
   para esa combinación?
   El issue solo describe el caso exitoso. Impacto si no se resuelve: medio.

❓ ¿Qué pasa si la integración con SAP no responde o da timeout?
   No hay nada documentado sobre cómo manejar una falla de la integración externa.
   Impacto si no se resuelve: alto — es un punto de falla real.

❓ ¿Cuál es el rol real que hace esta búsqueda?
   El issue no dice quién ejecuta esta acción. Impacto si no se resuelve: medio.

❓ ¿Qué formato válido deben tener el CUIT y la Cosecha?
   No está especificado ni en el issue ni en la descripción del caso de prueba. Impacto
   si no se resuelve: medio — afecta directamente el criterio de validación.
```

## ¿Y ahora qué?

Esto todavía no está validado por una persona — antes de pasar a Planning o desarrollo,
alguien con criterio de negocio real tiene que revisar si esta historia está bien y
responder las preguntas abiertas. Ver [`evaluation.md`](evaluation.md) para cómo dejar
constancia de esa revisión.

---

## De dónde salió esto (para trazabilidad — no hace falta leer esto para usar la historia de arriba)

Se tomó el ticket real `ARMOA277-45` directamente de Jira, un caso de prueba (tipo
`Test`/Xray) llamado "Consulta de Datos Sociedad exitosa (Integración SAP)", con esta
descripción original: *"Validar que al realizar una Búsqueda con CUIT y Cosecha válidos,
el sistema recupere y muestre la información de SAP de forma correcta en Datos
Sociedad."* Reportado y asignado a Ricardo García Meza, estado Pendiente, prioridad
Medium.

El issue se trajo con la herramienta `getJiraIssue` (vía el conector MCP de Atlassian), no
copiado a mano. La historia, los criterios, las reglas y las preguntas de arriba se
generaron con la capability `user-story` (CAP-002) sobre ese contenido real, sin
inventar nada que Jira no tuviera.

<details>
<summary>Detalle técnico completo (contrato de evidencia, JSON del contexto, restricciones respetadas)</summary>

Contrato canónico: [`evidence-evaluation-measurement.md`](../../../architecture/evidence-evaluation-measurement.md#1-evidence).

| Campo | Valor |
|---|---|
| `capability_id` | CAP-002 (`user-story`), con el contexto traído por CAP-008 (`jira-context`) |
| `capability_version` | CAP-002 `1.0-generalized`; CAP-008 `1.0-pattern` |
| `execution_id` | EXEC-20260909-001 |
| `executed_at` | 2026-09-09 |
| `actor` | Un developer real de MOA, en una sesión con GitHub Copilot Agent (VS Code) |
| `repository` | `MOA-AI-Engineering` |
| `branch` | `main` |
| `input_reference` | `https://baufest.atlassian.net/browse/ARMOA277-45` |
| `output_reference` | La historia de usuario de arriba |
| `evidence_reference` | Este mismo registro |
| `evaluation_reference` | [`evaluation.md`](evaluation.md) |
| `metric_reference` | [`measurement.md`](measurement.md) — todavía no hay nada medido |
| `status` | Ejecutado, real, no simulado |

Campos que Jira devolvió, tal cual (sin agregar ni resumir):

| Campo Jira | Valor real |
|---|---|
| `summary` | "Consulta de Datos Sociedad exitosa (Integración SAP)" |
| `issuetype` | `Test` (caso de prueba de Xray) |
| `status` | Pendiente |
| `priority` | Medium |
| `project` | ARMOA277 — "GMK - MOLINOS - Portal de Créditos - MOA" |
| `reporter` / `assignee` | Ricardo García Meza, en ambos campos |
| `created` | 2026-06-22 |
| `updated` | 2026-06-23 |
| `labels` / `components` | vacíos |

Contexto armado a partir de esos datos, en el formato estándar que usa esta capability:

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

Restricciones respetadas: solo se leyó información de Jira (nunca se escribió nada), se
usó únicamente el camino MCP, no se guardó ninguna credencial, y no se modificó el
formato de contexto ni la capability `user-story`.

</details>
