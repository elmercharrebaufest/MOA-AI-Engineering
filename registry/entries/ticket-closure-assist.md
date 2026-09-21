# CAP-016 — ticket-closure-assist

**Nota de clasificación**: misma categoría que CAP-011/CAP-014 — propuesta directa, no
generalización de una instancia real. Ver CAP-011 para el criterio completo. Queda
`PROPOSAL` hasta que un equipo real la pilotee.

| Campo | Valor | Evidencia / clasificación |
|---|---|---|
| **ID** | CAP-016 | — |
| **Name** | ticket-closure-assist | FACT (existe el archivo) |
| **Type** | Skill | FACT |
| **Purpose** | Verificar cumplimiento de criterios de aceptación y redactar un borrador de comentario de cierre de ticket | FACT |
| **Owner** | REQUIRES VALIDATION | `governance/BLOCKED-DECISIONS.md` #1 |
| **Maintainer** | REQUIRES VALIDATION | Ídem |
| **Origin** | No aplica — no hay instancia real de ningún equipo. KO Interno pág. 26 (*"Copilot + Skills + MCP Jira sugiere registro de horas y actualiza estado automáticamente"*) | FACT (cita del KO) |
| **Originator** | No aplica | — |
| **Team** | Ninguno todavía | — |
| **Domain** | Transversal — sin contenido específico de dominio que adaptar | FACT |
| **Repository** | No aplica | — |
| **Branch** | No aplica | — |
| **Integration Status** | No integrada a ningún repo de equipo todavía | FACT |
| **Configuration Status** | VERIFIED — contenido completo escrito y revisado en esta sesión | FACT |
| **Real Use Status** | **CONFIGURED** — mecanismo documentado, cero ejecuciones reales, sin evidencia de equipo real todavía | FACT |
| **Lifecycle State** | Proposal | Sin ejecución real todavía |
| **Corporate Standard** | N | Sin evidencia de uso real |
| **Version** | Sin versionado semántico | — |
| **Risk** | Bajo | No cambia el estado del ticket ni publica el comentario por sí misma |
| **Data** | No toca datos sensibles directamente | INFERENCE |
| **Data Classification** | REQUIRES VALIDATION | Política no existe (`BLOCKED-DECISIONS.md` #3) |
| **Tools** | Ninguna declarada — contenido de referencia | FACT |
| **Model** | No declarado | FACT |
| **Autonomy** | No aplica directo (Skill) | — |
| **HITL** | Obligatoria: la persona que cierra el ticket debe confirmar el borrador y cambiar el estado — la skill nunca actúa sobre Jira/Azure DevOps | FACT (declarado en `SKILL.md`) |
| **Evaluation** | NOT FOUND | — |
| **Observability** | NOT FOUND | — |
| **Metrics** | NOT FOUND | — |
| **Adopters** | Ninguno | — |
| **Last Review** | 2026-09-18 | — |
| **Evidence Reference** | Ninguna todavía | — |
| **Evaluation Reference** | Ninguna todavía | — |
| **Metric Reference** | Ninguna todavía | — |
| **Reusable Asset** | [`capabilities/skills/ticket-closure-assist/SKILL.md`](../../capabilities/skills/ticket-closure-assist/SKILL.md) | — |
| **Action Type** | READ (redacta un borrador; nunca cambia el estado del ticket ni publica el comentario por sí misma) | Deliberadamente más conservador que el propio KO, que propone `ACT` para esta etapa — mismo principio `READ` de CAP-001/002/003/011/014 |
| **Context Requirements** | Criterios de aceptación de CAP-001 + evidencia real de cumplimiento (tests/PR/validación de QA) | Reutiliza mecanismos ya existentes |

## Nota de selección

Cubre la etapa "Cierre del ticket" del KO — que hasta este trabajo ni siquiera figuraba en
la tabla "Cobertura real hoy" de `architecture/ai-sdlc.md` (defecto de documentación
corregido en el mismo trabajo que generó esta entrada). Capacidad mínima y de bajo riesgo:
solo verifica y redacta, nunca actúa sobre el ticket — más conservadora que la propuesta
original del KO, que sí contempla actualización automática de estado.
