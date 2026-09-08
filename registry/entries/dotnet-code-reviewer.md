# CAP-003 — .NET Code Reviewer

| Campo | Valor | Evidencia / clasificación |
|---|---|---|
| **ID** | CAP-003 | — |
| **Name** | `.NET Code Reviewer` (`dotnet-code-reviewer.agent.md`) | FACT |
| **Type** | Agent | FACT |
| **Purpose** | Code review de .NET acotado al diff (`git diff --staged`/`HEAD~1 HEAD`, no el repo completo), evaluando seguridad OWASP, manejo de errores, calidad de tests, SOLID, clean code y performance por versión de .NET, con salida estructurada por severidad (Critical/Major/Minor) | FACT — contenido completo leído (G3.2.5) |
| **Owner** | REQUIRES VALIDATION | `BLOCKED-DECISIONS.md` #1 |
| **Maintainer** | REQUIRES VALIDATION | Ídem |
| **Origin** | Orquestador, commit `872911c` (PR 5633, 2026-07-20). **Segunda instancia real encontrada en G5.1**: Scato Logística también tiene un agent `dotnet-code-reviewer` (`.github/agents/dotnet-code-reviewer.agent.md`, `model: claude-opus-5`, working tree — no en rama aislada) — no atribuido en el relevamiento original de G3.2.5/G4.2, que solo había inspeccionado Orquestador | FACT — corrección/ampliación explícita de G5.1 |
| **Originator** | Manuel Davila (Orquestador). Scato Logística: REQUIRES VALIDATION (no verificado individualmente en G5.1) | FACT (Orquestador) / REQUIRES VALIDATION (Scato Logística) |
| **Team** | Orquestador, Scato Logística | FACT — ampliado en G5.1 |
| **Domain** | Team-specific en su contenido de reglas (.NET Framework 4.7.2 específico) — el **patrón de diseño** (scope acotado al diff, sin `edit`, salida estructurada) es candidato a Common Pattern, ya señalado en `assessment-gate.md` | FACT (contenido) / PROPOSAL (patrón como candidato) |
| **Repository** | `Orquestador/Orquestador` | FACT |
| **Branch** | `master-logistica` | FACT — confirmado vía `git ls-tree`, ancestro de `feature/cardless4` |
| **Integration Status** | **Integrado a `master-logistica`** (rama de larga vida, último commit 2026-08-18) — **NO integrado a `master`** de Orquestador. **Corrección respecto a G3.2/G3.2.5**: se había caracterizado como viviendo únicamente en una rama feature (`feature/cardless4`) sin integrar — el relevamiento de G4.2 encontró que ya está en `master-logistica`, una rama distinta de `master` pero real y activamente mantenida. La relación exacta entre `master`, `master-logistica` y `master-merge` de Orquestador sigue **REQUIRES VALIDATION** (agregado como Blocked Decision nueva, ver reporte G4.2) | FACT, con corrección explícita |
| **Configuration Status** | **VERIFIED** | Contenido completo leído: frontmatter (`tools: [execute, read, search]`, sin `model`), misión, pilares de revisión, formato de salida, constraints — todo verificado directamente, no inferido |
| **Real Use Status** | **CONFIGURED** *(terminología unificada en G4.5 — escala `NOT FOUND / CONFIGURED / EXECUTED / VERIFIED`)* | Configuración VERIFIED, cero ejecuciones registradas — no se infiere de la calidad del diseño ni de Configuration Status |
| **Lifecycle State** | Pilot | Sin Evaluation/Measure documentados |
| **Corporate Standard** | N | — |
| **Version** | Sin versionado semántico. Proxy: commit `872911c` | FACT |
| **Risk** | **Bajo, por diseño estructural** — `tools` no incluye `edit`, por lo que el agent no puede escribir código, independientemente de cualquier regla declarada en prosa | FACT (verificado en el frontmatter real) |
| **Data** | Lee código fuente del propio repo únicamente — no accede a datos de negocio ni sistemas externos | INFERENCE (por `tools` declarados: `execute, read, search`, sin integraciones externas) |
| **Data Classification** | REQUIRES VALIDATION | Política no existe; riesgo intrínseco ya es bajo por el diseño sin escritura |
| **Tools** | `[execute, read, search]` — **explícitamente sin `edit`** | FACT |
| **Model** | No declarado — a diferencia del agent `afip-integration` de Scato Logística, que sí pinea `claude-opus-4.8` | FACT (ausencia confirmada). Si es deliberado o una omisión: REQUIRES VALIDATION |
| **Autonomy** | No se declara una matriz ALWAYS/ASK FIRST/NEVER explícita — el diseño mismo (ausencia de `tools: edit`) actúa como control estructural equivalente a "NEVER modificar código" | FACT + INFERENCE |
| **HITL** | **Explícito y fuerte, textual**: *"DO NOT edit or modify any files — this is a read-only review role"*; *"DO NOT run tests or build commands"* | FACT (cita textual) |
| **Evaluation** | NOT FOUND | Sin evidencia de que se haya verificado la precisión de sus hallazgos |
| **Observability** | NOT FOUND | — |
| **Metrics** | NOT FOUND | — |
| **Adopters** | Ninguno confirmado | — |
| **Last Review** | 2026-09-07 | — |
| **Evidence Reference** *(nuevo en G4.3)* | `NOT EXECUTED` | No consumida por el Golden Path de G4.2/G4.3 — ver `G4.3-Evidence-Evaluation-Measurement.md` §13 |
| **Evaluation Reference** *(nuevo en G4.3)* | `NOT EVALUATED` | Ídem |
| **Metric Reference** *(nuevo en G4.3)* | `NOT MEASURED` | Ídem |
| **Reusable Asset** *(nuevo en G5.1)* | [`capabilities/agents/read-only-code-reviewer/AGENT.md`](../../capabilities/agents/read-only-code-reviewer/AGENT.md) | Generaliza el patrón (scope al diff, sin `edit`, salida por severidad) de las 2 instancias reales (Scato Logística, Orquestador), sin copiar contenido de reglas |

## Nota de selección

Elegida como tercera entrada deliberadamente **a pesar de** su Integration Status más
complejo (no está en `master`) — precisamente porque demuestra que el Registry hace su
trabajo: expone con precisión que es el patrón de gobierno de Agent mejor diseñado de todo
el relevamiento (riesgo bajo por diseño, no por promesa), sin ocultar que vive en una
rama distinta de la principal. Es el ejemplo de referencia para cualquier futuro Golden
Path de "AI Code Review" — no seleccionado como Golden Path #1 de G4.2 por requerir más
infraestructura (acceso a diffs de PR) que `user-story`.
