# CAP-018 — spec-reader

**Nota de clasificación**: propuesta directa con evidencia externa (Camuzzi/Baufest) —
mismo tratamiento que el resto de las propuestas nuevas del Registry. Queda `PROPOSAL`
hasta que un equipo real de MOA lo pilotee.

**Nota de numeración**: por su función (consultar specs) correspondería agruparse junto a
CAP-005/CAP-007 en la secuencia de etapas del KO — se agrega como CAP-018 (siguiente
número disponible) en vez de renumerar otra vez todo el Registry para insertarlo en el
medio. El mapeo real por etapa del KO vive en `architecture/ai-sdlc.md`, no depende de que
los números sean adyacentes.

| Campo | Valor | Evidencia / clasificación |
|---|---|---|
| **ID** | CAP-018 | — |
| **Name** | spec-reader | FACT (existe el archivo) |
| **Type** | Agent | FACT |
| **Purpose** | Responder preguntas sobre specs ya documentadas por CAP-005, citando siempre archivo + ID exacto | FACT |
| **Owner** | REQUIRES VALIDATION | `governance/BLOCKED-DECISIONS.md` #1 |
| **Maintainer** | REQUIRES VALIDATION | Ídem |
| **Origin** | No hay instancia real de ningún equipo de MOA. Evidencia externa: agent real de Camuzzi/Baufest (`Spec Reader`, reunión 2026-09-18), identificado en la revisión de fidelidad del 2026-09-21 | FACT (evidencia externa) |
| **Originator** | No aplica a la instancia de MOA | — |
| **Team** | Ninguno todavía | FACT |
| **Domain** | Transversal — depende del formato de CAP-005, no de un dominio de negocio | FACT |
| **Repository** | No aplica | — |
| **Branch** | No aplica | — |
| **Integration Status** | No integrado a ningún repo de equipo todavía | FACT |
| **Configuration Status** | VERIFIED — contenido completo escrito y revisado en esta sesión | FACT |
| **Real Use Status** | **CONFIGURED** — mecanismo documentado, cero ejecuciones reales | FACT |
| **Lifecycle State** | Proposal | Sin ejecución real todavía |
| **Corporate Standard** | N | Sin evidencia de uso real |
| **Version** | Sin versionado semántico | — |
| **Risk** | Bajo | Solo lectura, sin `edit`; no accede a sistemas externos |
| **Data** | No toca datos sensibles | INFERENCE |
| **Data Classification** | REQUIRES VALIDATION | `BLOCKED-DECISIONS.md` #3 |
| **Tools** | `[read, search, todo]` — sin `edit` | FACT |
| **Model** | No declarado | FACT |
| **Autonomy** | No aplica directo — solo lectura por diseño estructural | FACT |
| **HITL** | Explícito: quien usa la respuesta para decidir debe confirmar que la spec citada sigue vigente antes de actuar | FACT (declarado en `AGENT.md`) |
| **Evaluation** | NOT FOUND | — |
| **Observability** | NOT FOUND | — |
| **Metrics** | NOT FOUND | — |
| **Adopters** | Ninguno | — |
| **Last Review** | 2026-09-21 | — |
| **Evidence Reference** | Ninguna todavía | — |
| **Evaluation Reference** | Ninguna todavía | — |
| **Metric Reference** | Ninguna todavía | — |
| **Reusable Asset** | [`capabilities/agents/spec-reader/AGENT.md`](../../capabilities/agents/spec-reader/AGENT.md) | — |
| **Action Type** | READ — nunca escribe ni edita ninguna spec | Mismo principio que el resto del Registry |
| **Context Requirements** | Artefactos reales ya generados por CAP-005 | Reutiliza el formato ya existente, no define uno propio |

## Nota de selección

No es una mejora de una capacidad existente — es un rol genuinamente distinto que faltaba
en la tríada de specs (escribir / auditar / responder preguntas). Se identificó recién en
la segunda revisión, fiel al contenido completo de Camuzzi, no en la primera pasada del
18-21 de septiembre — ejemplo concreto de por qué vale la pena una revisión de fidelidad
antes de dar por cerrada una adopción de evidencia externa.
