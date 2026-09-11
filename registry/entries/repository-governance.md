# CAP-005 — repository-governance

| Campo | Valor | Evidencia / clasificación |
|---|---|---|
| **ID** | CAP-005 | — |
| **Name** | repository-governance | FACT |
| **Type** | Instruction | FACT — regla estructural aplicada siempre, no cargada on-demand (Skill) ni con razonamiento dinámico (Agent) |
| **Purpose** | Declarar en un lugar predecible qué puede hacer un asistente de IA sin pedir permiso, qué debe confirmar antes, y qué nunca debe hacer — vía la convención de 4 capas (`copilot-instructions.md`/`AGENTS.md` + `instructions/` + `skills/` + `agents/`) | FACT |
| **Owner** | REQUIRES VALIDATION | `BLOCKED-DECISIONS.md` #1 |
| **Maintainer** | REQUIRES VALIDATION | Ídem |
| **Origin** | Convención encontrada de forma independiente en 4 repos: DataAgro, Scato Logística, Orquestador (rama `master-logistica`), `moa-sdlc` | FACT — ya evaluada como "ADOPT como convención" en `../../architecture/assessment-gate.md`, materializada posteriormente |
| **Originator** | Múltiples, sin un originador único identificable — la convención converge de forma independiente en 4 repos distintos, con distintos autores | FACT (multiplicidad) |
| **Team** | DataAgro, Scato Logística, Orquestador, `moa-sdlc` (herramienta de referencia, no equipo de MOA) | FACT |
| **Domain** | Transversal — la estructura es independiente del dominio; el contenido de cada capa es 100% específico por equipo | FACT |
| **Repository** | Los 4 anteriores | FACT |
| **Branch** | Ver cada repo — Orquestador solo en `master-logistica`/`feature/cardless4` | FACT |
| **Integration Status** | Integrada y en uso real en los 4 — con el matiz de que `moa-sdlc` documenta 2 elementos de esta convención (`.github/agents/`, `CODEOWNERS`) que **no existen** en su propio repo (ver CAP-004, misma brecha) | FACT, con hallazgo explícito de G5.1 |
| **Configuration Status** | VERIFIED en los 4 — contenido real leído en cada uno (`AGENTS.md`/`copilot-instructions.md` completos) | Inventario G5.1 |
| **Real Use Status** | **CONFIGURED** — existe, bien formada, en uso real por los asistentes de cada equipo. No se declara `EXECUTED`/`VERIFIED` porque la convención en sí no es "ejecutable" (no tiene una única ejecución que registrar como Evidence) — su "uso" es continuo y transversal, no puntual | Escala unificada G4.5, aplicada con matiz explícito por el tipo de capacidad |
| **Lifecycle State** | Pilot | Sin Evaluation/Measure documentados en ninguno de los 4 casos |
| **Corporate Standard** | N | Convención con fuerte evidencia de convergencia independiente, pero sin evaluación formal ni decisión de gobierno |
| **Version** | Sin versionado semántico en ninguna instancia real. Generalización: `1.0-generalized` (G5.1) | FACT |
| **Risk** | Bajo — es documentación de gobierno, no código ejecutable. El riesgo real que mitiga (o no) depende del contenido que cada equipo complete, no de la convención en sí | INFERENCE |
| **Data** | No aplica directamente | — |
| **Data Classification** | REQUIRES VALIDATION | `BLOCKED-DECISIONS.md` #3 |
| **Tools** | No aplica — documentación, no artefacto ejecutable | FACT |
| **Model** | No aplica | — |
| **Autonomy** | No aplica directo — es el mecanismo por el cual otras capacidades (Agents) declaran su propia autonomía | FACT |
| **HITL** | Es, en sí misma, donde se declara el HITL de cada equipo (columna ASK FIRST / NEVER) | FACT |
| **Evaluation** | NOT FOUND | Ninguna de las 4 instancias tiene evidencia de auditoría de si la matriz se respeta en la práctica |
| **Observability** | NOT FOUND | — |
| **Metrics** | NOT FOUND | — |
| **Adopters** | DataAgro, Scato Logística, Orquestador, `moa-sdlc` — 4 instancias independientes, sin evidencia de adopción cruzada explícita entre ellas (cada una llegó a la convención por su cuenta) | FACT |
| **Last Review** | 2026-09-08 | G5.1 |
| **Reusable Asset** *(nuevo en G5.1)* | [`capabilities/instructions/repository-governance/INSTRUCTIONS.md`](../../capabilities/instructions/repository-governance/INSTRUCTIONS.md) | Plantilla generalizada de la matriz ALWAYS/ASK FIRST/NEVER + la convención de 4 capas, sin contenido literal de ninguna instancia real |
| **Evidence Reference** | No aplica — esta capacidad no tiene un Evidence Record puntual (es transversal, no una ejecución única); su evidencia son las 4 instancias reales citadas en `Origin` | Distinción explícita, no una omisión |

## Clasificación — corregida en G5.2

`Last Review` (arriba) originalmente clasificaba esta capacidad como "COMMON CORE" en su
propia página de `capabilities/`, lo cual contradecía `Corporate Standard: N` en esta
misma tabla. **Corregido**: la clasificación correcta es **Reusable Governance Pattern /
Common Core Candidate** — evidencia fuerte de convergencia independiente (4 instancias)
no equivale a aprobación de gobierno. Progresión pendiente, sin atajos:

```text
Reusable Capability → Common Core Candidate (acá) → Assessment / Human Governance
(REQUIRES VALIDATION, Blocked #1) → Corporate Standard
```
