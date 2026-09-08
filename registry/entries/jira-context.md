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
| **Real Use Status** | **NOT FOUND** | Sin ejecución real — el MCP real que lo origina también está `CONFIGURED`, sin invocación (`security-governance.md` §2) |
| **Lifecycle State** | Design | Recién definido |
| **Corporate Standard** | N | Requiere Assessment Gate |
| **Version** | `1.0-pattern` | — |
| **Risk** | Bajo-Medio — READ-only y scope acotado reducen el riesgo respecto al hallazgo wildcard original, pero MCP sigue sujeto al gobierno específico de `security-governance.md` §2 (identidad/auditoría `REQUIRES VALIDATION` para cualquier MCP real) | Ver `security-governance.md` §1.5 y §2 |
| **Data** | Contenido de issues de Jira — puede incluir información de negocio sensible | Ver "Data sensitivity" en el propio patrón |
| **Data Classification** | REQUIRES VALIDATION | Política no existe (`BLOCKED-DECISIONS.md` #3) |
| **Tools** | `com.atlassian/atlassian-mcp-server/getJiraIssue` — un único método, sin wildcard | FACT (nombre real del método, tal como aparece en la evidencia) |
| **Model** | No aplica | — |
| **Autonomy** | No aplica — no es Agent | — |
| **HITL** | No requerido para el READ acotado en sí; si el `Resolved Context` alimenta una decisión de alto impacto, el HITL aplica en la capability consumidora, no acá | PROPOSAL |
| **Evaluation** | NOT FOUND | — |
| **Observability** | NOT FOUND | `retrieval_status`/`provenance` preparados, no instrumentados |
| **Metrics** | NOT FOUND | — |
| **Adopters** | Ninguno | — |
| **Last Review** | Esta actividad | — |
| **Evidence Reference** | `NOT EXECUTED` | — |
| **Evaluation Reference** | `NOT EVALUATED` | — |
| **Metric Reference** | `NOT MEASURED` | — |
| **Reusable Asset** | [`integrations/jira-context-provider.md`](../../integrations/jira-context-provider.md) | Patrón completo, READ-only, sin wildcard, con consideraciones de prompt injection y data sensitivity documentadas |

## Nota de selección

Segunda capability nueva creada al implementar Context Acquisition & Resolution
(Prioridad 4). Deliberadamente **no** generaliza el patrón de mayor riesgo encontrado en
el benchmark (scope wildcard `product-owner`) — extrae y formaliza únicamente el patrón
de menor riesgo (scope acotado `architect`), como plantilla obligatoria para cualquier
integración de Jira futura.
