# CAP-007 — spec-review

**Nota de clasificación**: propuesta directa con evidencia externa (Camuzzi/Baufest) — mismo
tratamiento que el resto de las propuestas nuevas del Registry. Queda `PROPOSAL` hasta que
un equipo real de MOA lo pilotee.

| Campo | Valor | Evidencia / clasificación |
|---|---|---|
| **ID** | CAP-007 | — |
| **Name** | spec-review | FACT (existe el archivo) |
| **Type** | Skill | FACT |
| **Purpose** | Auditar `requirements.md`/`design.md`/`tasks.md`/`feature.json` generados por CAP-005 contra su formato y consistencia | FACT |
| **Owner** | REQUIRES VALIDATION | `governance/BLOCKED-DECISIONS.md` #1 |
| **Maintainer** | REQUIRES VALIDATION | Ídem |
| **Origin** | No hay instancia real de ningún equipo de MOA. Evidencia externa: skill real de Camuzzi/Baufest (`spec-review`, reunión 2026-09-18), adaptada al formato real de CAP-005 (distinto del de Camuzzi) | FACT (evidencia externa) |
| **Originator** | No aplica a la instancia de MOA | — |
| **Team** | Ninguno todavía | FACT |
| **Domain** | Transversal — depende del formato de CAP-005, no de un dominio de negocio | FACT |
| **Repository** | No aplica | — |
| **Branch** | No aplica | — |
| **Integration Status** | No integrada a ningún repo de equipo todavía | FACT |
| **Configuration Status** | VERIFIED — contenido completo escrito y revisado en esta sesión | FACT |
| **Real Use Status** | **CONFIGURED** — mecanismo documentado, cero ejecuciones reales | FACT |
| **Lifecycle State** | Proposal | Sin ejecución real todavía |
| **Corporate Standard** | N | Sin evidencia de uso real |
| **Version** | Sin versionado semántico | — |
| **Risk** | Bajo | Solo lectura, no edita artefactos salvo pedido explícito |
| **Data** | No toca datos sensibles | INFERENCE |
| **Data Classification** | REQUIRES VALIDATION | `BLOCKED-DECISIONS.md` #3 |
| **Tools** | Ninguna declarada — contenido de referencia | FACT |
| **Model** | No declarado | FACT |
| **Autonomy** | No aplica directo (Skill) | — |
| **HITL** | Explícito: la decisión de si una spec está lista para avanzar de rol sigue siendo de una persona; nunca resuelve `[NEEDS CLARIFICATION]` por su cuenta | FACT (declarado en `SKILL.md`) |
| **Evaluation** | NOT FOUND | — |
| **Observability** | NOT FOUND | — |
| **Metrics** | NOT FOUND | — |
| **Adopters** | Ninguno | — |
| **Last Review** | 2026-09-28 (revisión de fidelidad — ver nota abajo) | — |
| **Evidence Reference** | Ninguna todavía | — |
| **Evaluation Reference** | Ninguna todavía | — |
| **Metric Reference** | Ninguna todavía | — |
| **Reusable Asset** | [`capabilities/skills/spec-review/SKILL.md`](../../capabilities/skills/spec-review/SKILL.md) | — |
| **Action Type** | READ (audita; no edita salvo pedido explícito, y nunca resuelve ambigüedades por su cuenta) | Mismo principio que el resto del Registry |
| **Context Requirements** | Artefactos reales ya generados por CAP-005 | Reutiliza el formato ya existente, no define uno propio |

## Nota de selección

Complementa a CAP-005 (`spec-driven-development`) — hoy esa capability define cómo generar
los artefactos, pero nada audita su calidad después. Bajo riesgo, alto valor de detección
temprana (sign-offs marcados sin evidencia real, cobertura incompleta requisito→tarea).

## Revisión de fidelidad (2026-09-28)

Primera lectura completa y directa del archivo real de Camuzzi
(`TRACK-1/github-main/.github-main/skills/spec-review/SKILL.md`, 9 checks sobre `spec.md` +
6 sobre `tasks.md`) — hasta ahora solo se conocía por su nombre y su propósito general. Se
agregaron 2 checks reales que faltaban y sí aplican a nuestro formato: contexto de negocio
insuficiente (equivalente a su C5) y dependencia entre tareas que referencia una tarea
inexistente (equivalente a su T6). No se copiaron los checks atados a la estructura fija de
Camuzzi (`Out of Scope`, `User Story`, encabezado `Ticket`/`Repo`) porque nuestro
`requirements.md`, generalizado del EARS real de DataAgro, no exige esas secciones.
