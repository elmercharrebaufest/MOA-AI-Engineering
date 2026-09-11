# CAP-008 — jira-context

| Campo | Valor | Evidencia / clasificación |
|---|---|---|
| **ID** | CAP-008 | — |
| **Name** | jira-context | FACT (nombre asignado en esta actividad) |
| **Type** | MCP | Patrón basado en descubrimiento gobernado de un método específico (`getJiraIssue`) sobre `com.atlassian/atlassian-mcp-server` — no un conector directo a medida |
| **Purpose** | Resolver una referencia a un issue de Jira hacia un `Resolved Context` consumible por cualquier capability, con scope de lectura estrictamente acotado | PROPOSAL — patrón nuevo, generalizado a partir de evidencia real |
| **Action Type** *(campo nuevo)* | READ | Declarado explícitamente — **sin `ACT`**, ver `security-governance.md` §1.5 y el propio patrón para la justificación |
| **Context Requirements** *(campo nuevo)* | N/A — este patrón **produce** Resolved Context, no lo consume | — |
| **Owner** | REQUIRES VALIDATION | `../../governance/BLOCKED-DECISIONS.md` #1 |
| **Maintainer** | REQUIRES VALIDATION | Ídem |
| **Origin** | Generalización del hallazgo real de `com.atlassian/atlassian-mcp-server`, scope acotado (`getJiraIssue`), visto en los agents `architect` de Orquestador y Scato Logística — **no** del scope wildcard (`product-owner`, Blocked Decision #4), descartado deliberadamente | FACT (evidencia origen) / PROPOSAL (el patrón en sí) |
| **Originator** | N/A — patrón derivado, no autoría de equipo | — |
| **Team** | Ninguno todavía — sin adopción real | — |
| **Domain** | Transversal | INFERENCE |
| **Repository** | `MOA-AI-Engineering` únicamente | FACT |
| **Branch** | `main` | FACT |
| **Integration Status** | No integrado a ningún repo de equipo — patrón de referencia | FACT |
| **Configuration Status** | **VERIFIED** para el patrón/documento en sí | Contrato completo y sin ambigüedad |
| **Real Use Status** | **EXECUTED** | 4 ejecuciones reales registradas. `EXEC-20260908-002`: Prioridad 2 (REST fallback), `retrievalStatus: SOURCE_UNAVAILABLE` (`BLOCKED` por falta de credenciales/MCP en ese entorno). `EXEC-20260908-004`: Prioridad 1 (MCP real, `com.atlassian/atlassian-mcp-server/getJiraIssue`), `retrievalStatus: SUCCESS` sobre issue real `ARMOA277-191` (tipo Error/Bug, tenant `baufest.atlassian.net`), con Resolved Context consumido realmente por CAP-002. `EXEC-20260908-005`: Prioridad 1 (MCP real), `retrievalStatus: SUCCESS` sobre issue real `ARMOA277-180` (tipo Tarea/Task, mismo tenant), segunda ejecución de punta a punta sobre un tipo de issue distinto. `EXEC-20260909-001`: Prioridad 1 (MCP real), `retrievalStatus: SUCCESS` sobre issue real `ARMOA277-45` (tipo Test/Xray, mismo tenant), tercera ejecución de punta a punta sobre un tercer tipo de issue distinto. **Sigue sin ser `VERIFIED`** — ninguna de las 4 ejecuciones tuvo evaluación humana independiente (autoevaluada `model-assisted` en los 3 casos donde hubo evaluación) |
| **Lifecycle State** | Pilot | 4 ejecuciones reales registradas (1 `BLOCKED`, 3 `SUCCESS` de punta a punta hasta CAP-002 sobre tipos de issue distintos), autoevaluación `model-assisted` en las 3 ejecuciones exitosas — sin HITL/evaluación humana independiente confirmada, no alcanza para graduar de `Pilot` |
| **Corporate Standard** | N | Requiere Assessment Gate |
| **Version** | `1.0-pattern` | — |
| **Risk** | Bajo-Medio — READ-only y scope acotado reducen el riesgo respecto al hallazgo wildcard original, pero MCP sigue sujeto al gobierno específico de `security-governance.md` §2 (identidad/auditoría `REQUIRES VALIDATION` para cualquier MCP real) | Ver `security-governance.md` §1.5 y §2 |
| **Data** | Contenido de issues de Jira — puede incluir información de negocio sensible | Ver "Data sensitivity" en el propio patrón |
| **Data Classification** | REQUIRES VALIDATION | Política no existe (`BLOCKED-DECISIONS.md` #3) |
| **Tools** | `com.atlassian/atlassian-mcp-server/getJiraIssue` — un único método, sin wildcard | FACT (nombre real del método, confirmado dos veces: en la evidencia de Orquestador/Scato Logística, y de forma independiente contra la documentación oficial de Atlassian Rovo MCP v2 — [Supported tools](https://support.atlassian.com/atlassian-rovo-mcp-server/docs/supported-tools/), verificado 2026-09-08) |
| **Model** | No aplica | — |
| **Autonomy** | No aplica — no es Agent | — |
| **HITL** | No requerido para el READ acotado en sí; si el `Resolved Context` alimenta una decisión de alto impacto, el HITL aplica en la capability consumidora, no acá | PROPOSAL |
| **Evaluation** | model-assisted (`EXEC-20260908-004`, `EXEC-20260908-005`, `EXEC-20260909-001`) — no humana | Ver `evaluation/EXEC-20260908-004.md`, `evaluation/EXEC-20260908-005.md` y `evaluation/EXEC-20260909-001.md` |
| **Observability** | NOT FOUND | `retrieval_status`/`provenance` preparados, no instrumentados |
| **Metrics** | NOT MEASURED | Ver `measurements/EXEC-20260908-004.md`, `measurements/EXEC-20260908-005.md` y `measurements/EXEC-20260909-001.md` |
| **Adopters** | Ninguno | — |
| **Last Review** | Esta actividad | — |
| **Evidence Reference** | [`EXEC-20260908-002`](../../records/jira-MOA-1234/EXEC-20260908-002/evidence.md) (`BLOCKED`, REST), [`EXEC-20260908-004`](../../records/jira-ARMOA277-191/EXEC-20260908-004/evidence.md) (`SUCCESS`, MCP, issue Error/Bug, hasta CAP-002), [`EXEC-20260908-005`](../../records/jira-ARMOA277-180/EXEC-20260908-005/evidence.md) (`SUCCESS`, MCP, issue Tarea/Task, hasta CAP-002), [`EXEC-20260909-001`](../../records/jira-ARMOA277-45/EXEC-20260909-001/evidence.md) (`SUCCESS`, MCP, issue Test/Xray, hasta CAP-002) | 4 ejecuciones reales, ninguna simulada |
| **Evaluation Reference** | [`EXEC-20260908-004`](../../records/jira-ARMOA277-191/EXEC-20260908-004/evaluation.md), [`EXEC-20260908-005`](../../records/jira-ARMOA277-180/EXEC-20260908-005/evaluation.md), [`EXEC-20260909-001`](../../records/jira-ARMOA277-45/EXEC-20260909-001/evaluation.md) — las 3 `PARTIAL`, `model-assisted` | Sin evaluación humana independiente todavía |
| **Metric Reference** | [`EXEC-20260908-004`](../../records/jira-ARMOA277-191/EXEC-20260908-004/measurement.md), [`EXEC-20260908-005`](../../records/jira-ARMOA277-180/EXEC-20260908-005/measurement.md), [`EXEC-20260909-001`](../../records/jira-ARMOA277-45/EXEC-20260909-001/measurement.md) — las 3 `NOT MEASURED` | Sin baseline |
| **Reusable Asset** | [`integrations/jira-context-provider.md`](../../integrations/jira-context-provider.md), implementación ejecutable en [`integrations/scripts/jira-context.ps1`](../../integrations/scripts/jira-context.ps1) | Patrón + código real, READ-only, sin wildcard, con consideraciones de prompt injection y data sensitivity documentadas |

## Nota de selección

Segunda capability nueva creada al implementar Context Acquisition & Resolution
(Prioridad 4). Deliberadamente **no** generaliza el patrón de mayor riesgo encontrado en
el benchmark (scope wildcard `product-owner`) — extrae y formaliza únicamente el patrón
de menor riesgo (scope acotado `architect`), como plantilla obligatoria para cualquier
integración de Jira futura.

## Qué falta para `VERIFIED` (actualizado tras `EXEC-20260908-005`)

Existe evidencia inicial de generalización a dos tipos de issue reales con diferente
nivel de completitud de información (`EXEC-20260908-004`, issue tipo Error/Bug con
descripción; `EXEC-20260908-005`, issue tipo Tarea/Task sin descripción). Esto **no
equivale a `VERIFIED`** — sigue faltando, sin excepción:

1. **Evaluación humana independiente** — las únicas evaluaciones existentes
   (`evaluation/EXEC-20260908-004.md`, `evaluation/EXEC-20260908-005.md`) son
   `model-assisted`, hechas por el mismo actor que ejecutó ambos vertical slices.
2. **Confirmación de un usuario real de MOA/Baufest** distinto del actor que diseñó/probó
   el patrón, ejecutándolo sobre su propio issue en su flujo de trabajo real.
3. **Resolución de `Owner`/`Maintainer`/`Data Classification`** — siguen `REQUIRES
   VALIDATION` (`../../governance/BLOCKED-DECISIONS.md` #1, #3), sin relación con esta
   ejecución técnica.
