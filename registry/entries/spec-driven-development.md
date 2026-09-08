# CAP-004 — spec-driven-development

| Campo | Valor | Evidencia / clasificación |
|---|---|---|
| **ID** | CAP-004 | — |
| **Name** | spec-driven-development | FACT |
| **Type** | Workflow | FACT — proceso multi-paso con estado, roles fijos, sin razonamiento dinámico (`capability-model.md`, criterio de desambiguación con Agent) |
| **Purpose** | Llevar un requerimiento desde ticket real hasta código verificado, con trazabilidad explícita y sin inventar contenido de requerimiento | FACT — 2 niveles de madurez, ver "Nota de clasificación" |
| **Owner** | REQUIRES VALIDATION | `BLOCKED-DECISIONS.md` #1 |
| **Maintainer** | REQUIRES VALIDATION | Ídem |
| **Origin** | Nivel Lite: DataAgro, `_sdd/docs/specs.md` (harness real de 3 roles). Nivel Full: `moa-sdlc`, `.github/AGENTS-CONTRACTS.md` + `.github/AGENTS-HARNESS.md` (461 + 159 líneas) | FACT — inventario completo G5.1 |
| **Originator** | REQUIRES VALIDATION (autoría no atribuida individualmente en ninguno de los 2 repos, a diferencia de CAP-001/002/003) | — |
| **Team** | DataAgro (nivel Lite, evidencia real de uso). `moa-sdlc` es herramienta de referencia de Baufest, no un equipo de MOA (nivel Full) | FACT |
| **Domain** | Transversal — el patrón (roles fijos, estado explícito, trazabilidad) es independiente del dominio de negocio | INFERENCE |
| **Repository** | `DataAgro/DataAgro`; `moa-sdlc` | FACT |
| **Branch** | DataAgro: `dev`. `moa-sdlc`: rama principal (repo de referencia, no de un equipo de MOA) | FACT |
| **Integration Status** | DataAgro: integrado, en uso real (2 tickets procesados). `moa-sdlc`: es el repo completo, no una rama — pero con una brecha real encontrada: su propio `README.md` menciona `.github/agents/` y `CODEOWNERS` que **no existen** en el repo | FACT, con hallazgo explícito de G5.1 |
| **Configuration Status** | **VERIFIED** (nivel Lite y nivel Full) — ambos harnesses fueron leídos completos: `_sdd/docs/specs.md` (DataAgro), `AGENTS-CONTRACTS.md`/`AGENTS-HARNESS.md` (`moa-sdlc`) | Inventario G5.1 |
| **Real Use Status** | **EXECUTED** (nivel Lite únicamente) — 2 tickets reales procesados por el ciclo de 3 roles (`MOA-1765`, `MOA-1816`), ninguno con sign-off de QA manual. **NOT FOUND** el uso real del nivel Full de 6 roles/contratos JSON — sin evidencia de ejecución end-to-end | Escala `NOT FOUND / CONFIGURED / EXECUTED / VERIFIED` (unificada G4.5). No confundir "bien especificado" (nivel Full) con "ejecutado" |
| **Lifecycle State** | Pilot (nivel Lite). El nivel Full no alcanza ni `Pilot` bajo `lifecycle.md` — sin evidencia de ejecución real, no solo configuración | FACT |
| **Corporate Standard** | N | Sin evidencia de evaluación/medición formal en ningún nivel |
| **Version** | Sin versionado semántico en las fuentes reales. Esta entrada de Registry referencia la generalización `1.0-generalized` (G5.1) en `capabilities/workflows/spec-driven-development/WORKFLOW.md` | FACT |
| **Risk** | Bajo (nivel Lite, sin permisos especiales). Medio (nivel Full, el rol `security-reviewer` propuesto requiere acceso de lectura a secretos/configuración — sin evidencia de que ese acceso esté gobernado en la práctica) | FACT (diseño) + INFERENCE (riesgo agregado) |
| **Data** | Depende del dominio del ticket procesado — sin patrón fijo | INFERENCE |
| **Data Classification** | REQUIRES VALIDATION | `BLOCKED-DECISIONS.md` #3 |
| **Tools** | Nivel Lite: ninguna especial (lectura de ticket, lectura/escritura de spec y código). Nivel Full: acceso de lectura a secretos/configuración para `security-reviewer` (propuesto, sin evidencia de implementación real) | FACT |
| **Model** | No declarado en ninguno de los 2 harnesses — es un Workflow, no depende de un modelo específico por diseño | FACT |
| **Autonomy** | No aplica directo (Workflow, no Agent) — los roles son fijos, no hay selección dinámica de herramienta | FACT |
| **HITL** | **Explícito y verificado con evidencia real**: `qaManualPending` con `signOff: null` en ambos tickets reales — ningún requisito manual se marcó cubierto sin confirmación humana | FACT |
| **Evaluation** | NOT FOUND | Ningún nivel tiene evidencia de evaluación formal del proceso |
| **Observability** | PARTIAL (nivel Full) — el esquema de log de auditoría está definido (timestamp/rol/acción/evidencia/estado) pero sin ejemplo de ejecución real que lo confirme en uso. NOT FOUND (nivel Lite) | FACT |
| **Metrics** | NOT FOUND | — |
| **Adopters** | DataAgro (nivel Lite, real). Ninguno confirmado para el nivel Full | FACT |
| **Last Review** | 2026-09-08 | G5.1 |
| **Reusable Asset** *(nuevo en G5.1)* | [`capabilities/workflows/spec-driven-development/WORKFLOW.md`](../../capabilities/workflows/spec-driven-development/WORKFLOW.md) | Generalización de ambos niveles, con la distinción de madurez explícita — no una copia de ninguno de los 2 harnesses reales |
| **Evidence Reference** | `evidence/EXEC-20260907-001.md`, `evidence/EXEC-20260908-001.md` — ambas ejecuciones de CAP-002 usaron tickets reales (`MOA-1816`, `MOA-1765`) que son, a su vez, instancias reales de este Workflow en su nivel Lite | Cruce de evidencia entre CAP-002 y CAP-004, verificado, no coincidencia forzada |

## Nota de clasificación (G5.1)

Ver `capabilities/workflows/spec-driven-development/WORKFLOW.md`, sección "Dos niveles de
madurez — no confundir": el nivel Lite (DataAgro) tiene evidencia real de uso; el nivel
Full (`moa-sdlc`) está mejor especificado (contratos JSON, máquina de estados) pero **sin
evidencia de ejecución real**, agravado por una brecha encontrada entre lo que el propio
`README.md` de `moa-sdlc` describe (`.github/agents/`, `CODEOWNERS`) y lo que realmente
existe en el repo. Se registra como una sola entrada (CAP-004) con ambos niveles
explícitos, en vez de 2 entradas separadas, porque comparten el mismo Origin conceptual y
la distinción de madurez es más útil visible en un solo lugar que fragmentada.
