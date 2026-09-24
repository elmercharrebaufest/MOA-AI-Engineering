# CAP-024 — qa-analyst

**Nota de clasificación**: Agent nuevo del Common Core que empaqueta como rol de QA las
skills ya existentes (CAP-014, CAP-015) y la escritura en tickets (CAP-023). Tiene
precedente real en el `qa-tester` de DataAgro (clasificado TEAM-SPECIFIC en G5.1 por su
contenido, no por su función). Queda `PROPOSAL` hasta el primer piloto.

| Campo | Valor | Evidencia / clasificación |
|---|---|---|
| **ID** | CAP-024 | — |
| **Name** | qa-analyst | FACT (existe el archivo) |
| **Type** | Agent | FACT |
| **Purpose** | Rol de QA: casos de prueba por criterio, clasificación de qué automatizar, generación y ejecución de tests automatizados, publicación opcional de casos en el ticket | FACT |
| **Owner** | REQUIRES VALIDATION | `governance/BLOCKED-DECISIONS.md` #1 |
| **Maintainer** | REQUIRES VALIDATION | Ídem |
| **Origin** | Pedido explícito de MOA (agente de QA tester). Precedente: `qa-tester` de DataAgro (devuelve al PO si faltan criterios; publica en Jira tras confirmar). Evidencia externa: Camuzzi (`testrail-desde-jira`, `playwright-desde-testrail`) | FACT |
| **Originator** | No aplica al Agent nuevo | — |
| **Team** | Ninguno todavía | — |
| **Domain** | Transversal | FACT |
| **Repository** | No aplica | — |
| **Branch** | No aplica | — |
| **Integration Status** | No integrado a ningún repo de equipo todavía | FACT |
| **Configuration Status** | VERIFIED — contenido completo escrito | FACT |
| **Real Use Status** | **CONFIGURED** — cero ejecuciones reales | FACT |
| **Lifecycle State** | Proposal | — |
| **Corporate Standard** | N | — |
| **Version** | Sigue la versión del plugin | — |
| **Risk** | Medio | `edit` limitado a archivos de test; comentarios en el ticket con confirmación |
| **Data** | Criterios del ticket y código de test del repo | FACT |
| **Data Classification** | REQUIRES VALIDATION | `BLOCKED-DECISIONS.md` #3 |
| **Tools** | `[read, search, edit, execute]` + `getJiraIssue`, `listJiraIssueComments`, `addOrEditJiraIssueComment`. Traspasos a `test-validator` y `product-owner` | FACT |
| **Model** | No declarado | FACT |
| **Autonomy** | Plan de archivos de test aprobado antes de generar; nunca código de producción ni resultados esperados modificados para que pase | FACT (declarado en `AGENT.md`) |
| **HITL** | QA valida los casos; confirmación antes de generar tests y antes de comentar | FACT |
| **Evaluation** | NOT FOUND | — |
| **Observability** | NOT FOUND | — |
| **Metrics** | NOT FOUND | — |
| **Adopters** | Ninguno | — |
| **Last Review** | 2026-09-24 | — |
| **Evidence Reference** | Ninguna todavía | — |
| **Evaluation Reference** | Ninguna todavía | — |
| **Metric Reference** | Ninguna todavía | — |
| **Reusable Asset** | [`capabilities/agents/qa-analyst/AGENT.md`](../../capabilities/agents/qa-analyst/AGENT.md) | — |
| **Action Type** | ACT acotado (archivos de test; comentarios vía CAP-023) | — |
| **Context Requirements** | Criterios de aceptación de la historia; framework de test del repo | — |

## Nota de selección

Cubre las etapas "Testing funcional" y "Test de regresión" del KO como un rol dentro de
los traspasos guiados del SDLC, sin lógica nueva: reutiliza CAP-014 y CAP-015.
