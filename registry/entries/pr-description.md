# CAP-009 — pr-description

**Nota de clasificación**: primera entrada del Registry cuyo origen no es la
generalización de una instancia real de un equipo de MOA (a diferencia de CAP-001 a
CAP-006), ni un patrón nuevo extraído de evidencia real (a diferencia de CAP-007/CAP-008)
— es una propuesta directa, justificada por el KO Interno + práctica externa +
reutilización de infraestructura ya construida (Context Acquisition & Resolution). Queda
`PROPOSAL` hasta que un equipo real la pilotee, exactamente con el mismo criterio que ya
aplica `assessment/README.md` a cualquier capacidad sin evidencia de uso.

| Campo | Valor | Evidencia / clasificación |
|---|---|---|
| **ID** | CAP-009 | — |
| **Name** | pr-description | FACT (existe el archivo) |
| **Type** | Skill | FACT |
| **Purpose** | Generar título, descripción y sugerencia de revisores de un PR a partir del ticket de origen y el diff real | FACT |
| **Owner** | REQUIRES VALIDATION | `governance/BLOCKED-DECISIONS.md` #1 |
| **Maintainer** | REQUIRES VALIDATION | Ídem |
| **Origin** | No aplica — no hay instancia real de ningún equipo. KO Interno pág. 24 (*"Copilot + Skills + MCP Jira + MCP Azure DevOps crea el PR automáticamente tras el push"*) | FACT (cita del KO) |
| **Originator** | No aplica | — |
| **Team** | Ninguno todavía | — |
| **Domain** | Transversal — sin contenido específico de dominio que adaptar | FACT |
| **Repository** | No aplica | — |
| **Branch** | No aplica | — |
| **Integration Status** | No integrada a ningún repo de equipo todavía | FACT |
| **Configuration Status** | VERIFIED — contenido completo escrito y revisado en esta sesión | FACT |
| **Real Use Status** | **CONFIGURED** — mecanismo documentado, cero ejecuciones reales, sin evidencia de equipo real todavía | FACT |
| **Lifecycle State** | Proposal | Ni siquiera en Pilot — no hay ejecución real todavía, a diferencia de CAP-002/007/008 |
| **Corporate Standard** | N | Sin evidencia de uso real |
| **Version** | Sin versionado semántico | — |
| **Risk** | Bajo | Solo lectura de diff y de ticket ya resuelto; no ejecuta ninguna acción sobre Azure DevOps/Jira |
| **Data** | No toca datos sensibles directamente | INFERENCE |
| **Data Classification** | REQUIRES VALIDATION | Política no existe (`BLOCKED-DECISIONS.md` #3) |
| **Tools** | Ninguna declarada — contenido de referencia | FACT |
| **Model** | No declarado | FACT |
| **Autonomy** | No aplica directo (Skill) | — |
| **HITL** | Obligatoria: quien abre el PR debe revisar que la descripción generada corresponda al diff real antes de publicarla | FACT (declarado en `SKILL.md`) |
| **Evaluation** | NOT FOUND | — |
| **Observability** | NOT FOUND | — |
| **Metrics** | NOT FOUND | — |
| **Adopters** | Ninguno | — |
| **Last Review** | 2026-09-18 | — |
| **Evidence Reference** | Ninguna todavía | — |
| **Evaluation Reference** | Ninguna todavía | — |
| **Metric Reference** | Ninguna todavía | — |
| **Reusable Asset** | [`capabilities/skills/pr-description/SKILL.md`](../../capabilities/skills/pr-description/SKILL.md) | — |
| **Action Type** | READ (no abre el PR por sí misma; produce texto para que un humano lo publique) | Mismo principio que CAP-002/007/008 — ver `security/security-governance.md` §1.5 |
| **Context Requirements** | Resolved Context (CAP-007/CAP-008) + diff real de `git diff` | Reutiliza el mecanismo ya existente, no define uno propio |

## Nota de selección

Cierra la etapa "Apertura del PR" del KO, la única de las 11 etapas que hasta ahora no
tenía ni capacidad real ni propuesta (`architecture/ai-sdlc.md`, `NOT FOUND`). Bajo riesgo
por diseño: solo lectura, sin acceso a sistemas externos propio, reutiliza el mecanismo de
Context Acquisition & Resolution ya construido y probado.
