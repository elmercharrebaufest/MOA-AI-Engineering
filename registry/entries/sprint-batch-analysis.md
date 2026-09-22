# CAP-021 — sprint-batch-analysis

| Campo | Valor | Evidencia / clasificación |
|---|---|---|
| **ID** | CAP-021 | — |
| **Name** | sprint-batch-analysis | FACT |
| **Type** | Skill | FACT |
| **Purpose** | Analizar en batch todos los tickets asignados a una persona en el sprint activo, antes de planning — nunca escribe en el sistema origen | FACT |
| **Owner** | REQUIRES VALIDATION | `governance/BLOCKED-DECISIONS.md` #1 |
| **Maintainer** | REQUIRES VALIDATION | Ídem |
| **Origin** | Evidencia externa — skill `post-planning` de un cliente de Baufest (Camuzzi), generalizada sin copiar el proyecto Jira hardcodeado ni nombres reales de herramientas MCP de ese cliente | FACT (evidencia origen) / PROPOSAL (el patrón generalizado) |
| **Originator** | No aplica a la instancia de MOA | — |
| **Team** | Ninguno todavía | — |
| **Domain** | Transversal | FACT |
| **Repository** | No aplica | — |
| **Branch** | No aplica | — |
| **Integration Status** | No integrado a ningún repo de equipo todavía | FACT |
| **Configuration Status** | VERIFIED — contenido completo escrito y revisado en esta sesión | FACT |
| **Real Use Status** | CONFIGURED — documentada, cero ejecuciones reales | FACT |
| **Lifecycle State** | Proposal | Sin ejecución real todavía |
| **Corporate Standard** | N | Sin evidencia de uso real |
| **Version** | Sin versionado semántico | — |
| **Risk** | Bajo | Sin herramientas de escritura — produce texto estructurado, nunca publica en el sistema origen (corrección deliberada respecto al patrón de origen, que sí escribía directo) |
| **Data** | Contenido de tickets del sprint — puede incluir información de negocio | INFERENCE |
| **Data Classification** | REQUIRES VALIDATION | `BLOCKED-DECISIONS.md` #3 |
| **Tools** | Ninguna de escritura propia; hereda el alcance de solo lectura de CAP-002/CAP-003 si los consume | FACT |
| **Model** | No declarado | FACT |
| **Autonomy** | No aplica directo (Skill) | — |
| **HITL** | Obligatoria — el análisis es insumo para planning, nunca publicado ni aplicado automáticamente | FACT |
| **Evaluation** | NOT FOUND | — |
| **Observability** | NOT FOUND | — |
| **Metrics** | NOT FOUND | — |
| **Adopters** | Ninguno | — |
| **Last Review** | 2026-09-22 | — |
| **Evidence Reference** | Ninguna todavía | — |
| **Evaluation Reference** | Ninguna todavía | — |
| **Metric Reference** | Ninguna todavía | — |
| **Reusable Asset** | [`capabilities/skills/sprint-batch-analysis/SKILL.md`](../../capabilities/skills/sprint-batch-analysis/SKILL.md) | — |
| **Action Type** | READ — nunca escribe en el sistema origen | Corrección deliberada respecto al patrón de origen |
| **Context Requirements** | Lista real de tickets del sprint, vía CAP-002/CAP-003 o pegados a mano | Reutiliza mecanismos ya existentes |

## Nota de selección

Refuerza la etapa "Planning" del KO (mismo grupo que CAP-001/CAP-004), con un ángulo
complementario: analizar todo el lote antes de la reunión, no ticket por ticket. Ejemplo
concreto de cómo este modelo adopta un patrón externo corrigiendo su comportamiento de
escritura para alinearlo con la disciplina de revisión humana ya vigente — ver
[[moa_capability_design_principles]].
