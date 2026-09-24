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
| **Risk** | Medio cuando publica | Comenta, carga horas y pasa a Done vía CAP-023, una confirmación por escritura; nunca cierra con criterios sin evidencia ni duplica una transición nativa |
| **Data** | No toca datos sensibles directamente | INFERENCE |
| **Data Classification** | REQUIRES VALIDATION | Política no existe (`BLOCKED-DECISIONS.md` #3) |
| **Tools** | Ninguna declarada — contenido de referencia | FACT |
| **Model** | No declarado | FACT |
| **Autonomy** | No aplica directo (Skill) | — |
| **HITL** | Obligatoria: la persona confirma el comentario, las horas y el cambio de estado, cada uno antes de escribirse | FACT (declarado en `SKILL.md`) |
| **Evaluation** | NOT FOUND | — |
| **Observability** | NOT FOUND | — |
| **Metrics** | NOT FOUND | — |
| **Adopters** | Ninguno | — |
| **Last Review** | 2026-09-24 | — |
| **Evidence Reference** | Ninguna todavía | — |
| **Evaluation Reference** | Ninguna todavía | — |
| **Metric Reference** | Ninguna todavía | — |
| **Reusable Asset** | [`capabilities/skills/ticket-closure-assist/SKILL.md`](../../capabilities/skills/ticket-closure-assist/SKILL.md) | — |
| **Action Type** | ACT acotado vía CAP-023 (comentario de cierre, horas propias, transición a Done), con confirmación por escritura | Alineado con el KO (etapa 9), con las salvaguardas de `ticket-update` |
| **Context Requirements** | Criterios de aceptación de CAP-001 + evidencia real de cumplimiento (tests/PR/validación de QA) | Reutiliza mecanismos ya existentes |

## Nota de selección

Cubre la etapa "Cierre del ticket" del KO — que hasta este trabajo ni siquiera figuraba en
la tabla "Cobertura real hoy" de `architecture/ai-sdlc.md` (defecto de documentación
corregido en el mismo trabajo que generó esta entrada). Verifica y redacta, y desde
2026-09-24 también publica el cierre, carga las horas y cambia el estado como propone el
KO — siempre con una confirmación por escritura y sin cerrar con criterios sin evidencia.
