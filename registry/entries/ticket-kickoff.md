# CAP-010 — ticket-kickoff

**Nota de clasificación**: propuesta directa con evidencia externa (Camuzzi/Baufest) — mismo
tratamiento que el resto de las propuestas nuevas del Registry. Queda `PROPOSAL` hasta que
un equipo real de MOA lo pilotee. **Es la propuesta de mayor riesgo/autonomía de todo el
Registry** — ver `Risk` abajo.

**Gap conocido**: el precedente real de Camuzzi actualiza la
documentación de specs impactada dentro del propio flujo, delegando a un agente `Spec
Writer`. El Registry de MOA no tiene ninguna capacidad equivalente — el plan que arma este
Agent solo *señala* qué documentación queda impactada (paso 3 del `AGENT.md`), sin que
nada la escriba. Queda documentado como brecha explícita, no como omisión silenciosa; se
evalúa si corresponde una capacidad nueva recién con evidencia real de que un equipo la
necesita (Golden Path #5, `Agent Creation`).

**Constraint agregado (2026-09-28)**: nunca ejecutar una migración de base de datos
destructiva sin mostrar el script real y esperar confirmación explícita puntual — evidencia
externa real del agent `database-migration` de Scato Logística
(`.github/agents/database-migration.agent.md`), con la misma regla textual.

**Corrección de UX agregada (2026-09-28, evidencia real de piloto)**: en una prueba real,
el developer vio los botones de traspaso "Revisar el código" y "Generar pruebas" (pensados
para el paso 8, cierre) ya visibles debajo del mensaje del paso 4, mientras el plan
todavía esperaba aprobación y no había código implementado. Verificado contra
documentación oficial de VS Code: los botones de `handoffs` se muestran después de cada
respuesta del agente, sin condicionarse al paso interno — es la única capacidad del
Registry con 2 traspasos pensados para 2 momentos distintos de la misma conversación. El
paso 4 ahora cierra siempre aclarando que esos botones no aplican todavía en ese punto.

**Constraint agregado (2026-09-28, persistencia del plan)**: el plan aprobado ahora se
persiste en `.ticket-kickoff-plan.md` dentro del worktree, nunca comiteado, para poder
retomar una sesión larga sin depender de que la persona la redescriba. Verificado contra
4 fuentes reales antes de decidir el diseño: `_sdd/progress/current/<TICKET>.md` de
moa-sdlc (efímero, `gitignored`, nunca comiteado — el mismo patrón elegido acá) y
`.specify/feature.json` de GitHub Spec Kit (estado de la feature activa, sin mandato de
comitearlo) coinciden en persistir localmente sin comitear; Camuzzi persiste specs
directo en el repo (más cerca de comitear). Se eligió el extremo más conservador (nunca
comitear) por ser el de mayor evidencia convergente y el de menor riesgo.

| Campo | Valor | Evidencia / clasificación |
|---|---|---|
| **ID** | CAP-010 | — |
| **Name** | ticket-kickoff | FACT (existe el archivo) |
| **Type** | Agent (orquestador) | FACT |
| **Purpose** | Orquestar investigación, plan técnico e implementación de un ticket, delegando a otras capacidades del Registry, con 2 checkpoints humanos obligatorios | FACT |
| **Owner** | REQUIRES VALIDATION | `governance/BLOCKED-DECISIONS.md` #1 |
| **Maintainer** | REQUIRES VALIDATION | Ídem |
| **Origin** | No hay instancia real de ningún equipo de MOA. Evidencia externa: agent real de Camuzzi/Baufest (`ticket-kickoff.agent.md`, el más maduro de su relevamiento, reunión 2026-09-18), generalizado y re-mapeado sobre las capacidades ya existentes del Registry de MOA | FACT (evidencia externa) |
| **Originator** | No aplica a la instancia de MOA | — |
| **Team** | Ninguno todavía | FACT |
| **Domain** | Transversal | FACT |
| **Repository** | No aplica | — |
| **Branch** | No aplica | — |
| **Integration Status** | No integrado a ningún repo de equipo todavía | FACT |
| **Configuration Status** | VERIFIED — contenido completo escrito y revisado en esta sesión | FACT |
| **Real Use Status** | **CONFIGURED** — mecanismo documentado, cero ejecuciones reales | FACT |
| **Lifecycle State** | Proposal | Sin ejecución real; requiere piloto muy acotado antes de cualquier extensión de alcance |
| **Corporate Standard** | N | Sin evidencia de uso real |
| **Version** | Sin versionado semántico | — |
| **Risk** | **Medio — la más alta del Registry**, por ser la primera capacidad con `edit` real sobre código de negocio (todas las anteriores son `READ` o `ACT` acotado a `git worktree`) | FACT (por `tools` declarado); mitigado por 2 checkpoints humanos obligatorios y el constraint de nunca escribir código antes de aprobación |
| **Data** | Código fuente del repo del equipo — no accede a datos de negocio en producción | INFERENCE (por `tools` y constraints declarados) |
| **Data Classification** | REQUIRES VALIDATION | `BLOCKED-DECISIONS.md` #3 |
| **Tools** | `[read, edit, execute, search, agent, todo]` + `listJiraIssueComments`, `addOrEditJiraIssueComment` (solo comentarios). Traspasos guiados (`handoffs`, `send: false`) a `read-only-code-reviewer` y `qa-analyst` | FACT |
| **Model** | No declarado | FACT |
| **Autonomy** | Explícitamente acotada por 13 constraints textuales (ver `AGENT.md`) — la más extensa del Registry, proporcional al riesgo | FACT |
| **HITL** | **2 checkpoints obligatorios, sin excepción**: aprobar el plan antes de implementar, revisar el código antes de publicar | FACT (declarado en `AGENT.md`) |
| **Evaluation** | NOT FOUND | — |
| **Observability** | NOT FOUND | — |
| **Metrics** | NOT FOUND | — |
| **Adopters** | Ninguno | — |
| **Last Review** | 2026-09-28 | — |
| **Evidence Reference** | Ninguna todavía | — |
| **Evaluation Reference** | Ninguna todavía | — |
| **Metric Reference** | Ninguna todavía | — |
| **Reusable Asset** | [`capabilities/agents/ticket-kickoff/AGENT.md`](../../capabilities/agents/ticket-kickoff/AGENT.md) | — |
| **Action Type** | ACT (edición real de código) — únicamente tras aprobación humana explícita del plan, siempre dentro de un worktree aislado (CAP-009). Nunca hace push; crea el PR solo después del push del developer y con su confirmación; comenta el plan y el vínculo al PR en el ticket vía CAP-023, con confirmación | Escalada deliberada y documentada respecto al resto del Registry — ver nota de clasificación arriba |
| **Context Requirements** | Resolved Context (CAP-002/CAP-003) + refinamiento (CAP-001/CAP-004) + consulta de specs (CAP-018) + worktree (CAP-009) | Orquesta, no duplica, la adquisición de contexto ya existente |

## Nota de selección

Es el candidato de mayor impacto identificado en el análisis de evidencia externa
(cliente de Baufest, sesión 2026-09-18) — fortalece directamente el Golden Path #2 (`AI-Assisted Development`), que hoy no tiene
ningún orquestador real, solo capacidades individuales. Se recomienda explícitamente **no
pilotear esta capacidad como parte de un lote junto a otras** — por su nivel de autonomía,
merece un piloto propio, acotado, con seguimiento humano estrecho antes de considerar
cualquier extensión de alcance (ej. delegar también la apertura de PR, hoy explícitamente
excluida).
