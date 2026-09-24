# CAP-023 — ticket-update

**Nota de clasificación**: primera capacidad del Registry que escribe en un sistema
externo (`ACT`). Concentra en una sola skill toda la escritura en Jira y Azure DevOps que
usan los agentes de PO, desarrollo, QA y cierre. Queda `PROPOSAL` hasta el primer piloto
real.

| Campo | Valor | Evidencia / clasificación |
|---|---|---|
| **ID** | CAP-023 | — |
| **Name** | ticket-update | FACT (existe el archivo) |
| **Type** | Skill | FACT |
| **Purpose** | Escribir en un ticket de forma segura: leer, mostrar el cambio, confirmar, escribir, verificar y marcar lo escrito | FACT |
| **Owner** | REQUIRES VALIDATION | `governance/BLOCKED-DECISIONS.md` #1 |
| **Maintainer** | REQUIRES VALIDATION | Ídem |
| **Origin** | KO Interno (etapas 1-2, 5, 7 y 9: la IA comenta, vincula el PR, publica casos de prueba, carga horas y actualiza el estado). Patrones de confirmación y relectura de Camuzzi (`log-work`, `testrail-desde-jira`, `atlassian-twg`) | FACT (KO) + evidencia externa |
| **Originator** | No aplica | — |
| **Team** | Ninguno todavía | — |
| **Domain** | Transversal | FACT |
| **Repository** | No aplica | — |
| **Branch** | No aplica | — |
| **Integration Status** | No integrada a ningún repo de equipo todavía | FACT |
| **Configuration Status** | VERIFIED — contenido completo escrito; nombres de herramientas verificados contra la documentación oficial de Atlassian Rovo MCP | FACT |
| **Real Use Status** | **CONFIGURED** — cero ejecuciones reales | FACT |
| **Lifecycle State** | Proposal | — |
| **Corporate Standard** | N | — |
| **Version** | Sin versionado semántico propio (sigue la versión del plugin) | — |
| **Risk** | Medio | Escribe en un sistema que leen otras personas |
| **Data** | Contenido de tickets (descripción, comentarios, horas, estado) | FACT |
| **Data Classification** | REQUIRES VALIDATION | `BLOCKED-DECISIONS.md` #3 |
| **Tools** | Jira vía Rovo MCP: `getJiraIssue`, `listJiraIssueComments`, `listJiraIssueWorklogs`, `listJiraIssueTransitions`, `getJiraIssueTypeMetaWithFields`, `editJiraIssue`, `addOrEditJiraIssueComment`, `addOrEditJiraIssueWorklog`, `createJiraIssue`, `createJiraIssueLink`, `transitionJiraIssue` (solo estado). Azure DevOps vía `az boards work-item show/update`. Cada agente declara solo las de su rol | FACT |
| **Model** | No aplica (Skill) | — |
| **Autonomy** | Ninguna escritura sin confirmación explícita; tabla cerrada de operaciones por rol | FACT (declarado en `SKILL.md`) |
| **HITL** | Obligatoria en cada escritura | FACT |
| **Evaluation** | NOT FOUND | — |
| **Observability** | Historial nativo del ticket + marca visible en lo escrito | FACT (diseño) |
| **Metrics** | NOT FOUND | — |
| **Adopters** | Ninguno | — |
| **Last Review** | 2026-09-24 | — |
| **Evidence Reference** | Ninguna todavía | — |
| **Evaluation Reference** | Ninguna todavía | — |
| **Metric Reference** | Ninguna todavía | — |
| **Reusable Asset** | [`capabilities/skills/ticket-update/SKILL.md`](../../capabilities/skills/ticket-update/SKILL.md) | — |
| **Action Type** | ACT — con confirmación por escritura; sin borrado ni administración | Condiciones en `security/security-governance.md`, "Escritura en tickets" |
| **Context Requirements** | Atlassian Rovo MCP autenticado por la persona (Jira) o Azure CLI con `azure-devops` (Azure Boards) | Mecanismos ya documentados en `adoption/context-providers-quickstart.md` |

## Nota de selección

Hasta esta capacidad, el modelo no escribía en ningún sistema externo. MOA pidió que el
SDLC actualice el ticket a medida que avanza; en lugar de dar permisos de escritura a
cada agente con reglas propias, se concentra en una skill con un único protocolo seguro.
