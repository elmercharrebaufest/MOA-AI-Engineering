# CAP-022 — documentation-style

| Campo | Valor | Evidencia / clasificación |
|---|---|---|
| **ID** | CAP-022 | — |
| **Name** | documentation-style | FACT |
| **Type** | Instruction | FACT — regla que se aplica siempre que se escribe documentación, no cargada on-demand (Skill) |
| **Purpose** | Evitar voseo argentino y contenido extenso sin valor real en la documentación de este modelo (o de cualquier repositorio que lo adopte) — lenguaje natural, formal y acotado | FACT |
| **Owner** | REQUIRES VALIDATION | Mismo estado que CAP-006, `BLOCKED-DECISIONS.md` #1 |
| **Maintainer** | REQUIRES VALIDATION | Ídem |
| **Origin** | Corrección real y repetida durante la construcción de este mismo modelo (2026-09-22) — no generalización de un repo de equipo de MOA ni de un cliente externo | FACT — distinto del origen de CAP-006 (convergencia de 3 repos), este nace de una corrección real dentro de esta misma iniciativa |
| **Originator** | Esta misma iniciativa (Track 1, Baufest) | FACT |
| **Team** | Ninguno todavía — regla nueva, aplicada hacia atrás sobre este mismo repositorio | FACT |
| **Domain** | Transversal — aplica a cualquier documento de este modelo, independiente del dominio | FACT |
| **Repository** | `ai-engineering` | FACT |
| **Branch** | `main` | FACT |
| **Integration Status** | Aplicada de forma retroactiva a toda la documentación viva de este repositorio (2026-09-22) | FACT |
| **Configuration Status** | VERIFIED — barrido completo del repositorio confirmó cero instancias de voseo remanente tras la corrección | Verificación real por búsqueda de patrones, 2026-09-22 |
| **Real Use Status** | **CONFIGURED** — la regla ya se aplicó de forma retroactiva sobre este mismo repositorio (no es solo una plantilla vacía), pero no hay todavía evidencia de que un equipo externo a esta iniciativa la haya adoptado sobre su propia documentación | Escala unificada G4.5 |
| **Lifecycle State** | Pilot | Sin Evaluation/Measurement de ningún equipo todavía |
| **Corporate Standard** | N | Regla nueva, sin decisión de gobierno formal |
| **Version** | 1.0 | — |
| **Risk** | Bajo — es una convención de redacción, no código ejecutable | INFERENCE |
| **Data** | No aplica | — |
| **Data Classification** | No aplica | — |
| **Tools** | No aplica — documentación, no artefacto ejecutable | FACT |
| **Model** | No aplica | — |
| **Autonomy** | No aplica directo | — |
| **HITL** | La revisión humana de cualquier documentación significativa ya vigente en este modelo | FACT |
| **Evaluation** | NOT FOUND | Sin evaluación humana independiente todavía |
| **Observability** | NOT FOUND | — |
| **Metrics** | NOT FOUND | — |
| **Adopters** | Ninguno externo a esta iniciativa todavía | FACT |
| **Last Review** | 2026-09-22 | — |
| **Reusable Asset** | [`capabilities/instructions/documentation-style/INSTRUCTIONS.md`](../../capabilities/instructions/documentation-style/INSTRUCTIONS.md) | — |
| **Evidence Reference** | No aplica — regla transversal, no una ejecución puntual (mismo tratamiento que CAP-006) | — |

## Relación con CAP-006

Ambas son `Type: Instruction`, aplicadas siempre, no bajo demanda. CAP-006 gobierna qué
puede hacer un asistente de IA sobre código (autonomía). CAP-022 gobierna cómo se escribe
la documentación (lenguaje, extensión) — dos reglas transversales distintas, no una
extensión de la otra.
