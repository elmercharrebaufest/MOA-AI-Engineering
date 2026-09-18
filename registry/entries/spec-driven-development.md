# CAP-004 — spec-driven-development

| Campo | Valor | Evidencia / clasificación |
|---|---|---|
| **ID** | CAP-004 | — |
| **Name** | spec-driven-development | FACT |
| **Type** | Workflow | FACT — proceso multi-paso con estado, roles fijos, sin razonamiento dinámico (`capability-model.md`, criterio de desambiguación con Agent) |
| **Purpose** | Llevar un requerimiento desde ticket real hasta código verificado, con trazabilidad explícita y sin inventar contenido de requerimiento | FACT — 2 niveles de madurez, ver "Nota de clasificación" |
| **Owner** | REQUIRES VALIDATION | `BLOCKED-DECISIONS.md` #1 |
| **Maintainer** | REQUIRES VALIDATION | Ídem |
| **Origin** | Nivel Lite: DataAgro, `_sdd/docs/specs.md` (harness real de 3 roles) | FACT |
| **Originator** | REQUIRES VALIDATION (autoría no atribuida individualmente) | — |
| **Team** | DataAgro (nivel Lite, evidencia real de uso) | FACT |
| **Domain** | Transversal — el patrón (roles fijos, estado explícito, trazabilidad) es independiente del dominio de negocio | INFERENCE |
| **Repository** | `DataAgro/DataAgro` | FACT |
| **Branch** | `dev` | FACT |
| **Integration Status** | Integrado, en uso real (2 tickets procesados) | FACT |
| **Configuration Status** | **VERIFIED** (nivel Lite) — harness leído completo: `_sdd/docs/specs.md` | FACT |
| **Real Use Status** | **EXECUTED** (nivel Lite) — 2 tickets reales (`MOA-1765`, `MOA-1816`), ninguno con sign-off de QA manual. El **nivel Full** (6 roles, contratos JSON) queda **`PROPOSAL` conceptual** — sin evidencia de ejecución real de ningún equipo de MOA | Escala `NOT FOUND / CONFIGURED / EXECUTED / VERIFIED` |
| **Lifecycle State** | Pilot (nivel Lite). Proposal (nivel Full) | FACT |
| **Corporate Standard** | N | Sin evidencia de evaluación/medición formal en ningún nivel |
| **Version** | Sin versionado semántico en la fuente real. Esta entrada de Registry referencia la generalización en [`capabilities/workflows/spec-driven-development/WORKFLOW.md`](../../capabilities/workflows/spec-driven-development/WORKFLOW.md) | FACT |
| **Risk** | Bajo (nivel Lite, sin permisos especiales). Medio (nivel Full, el rol `security-reviewer` propuesto requeriría acceso de lectura a secretos/configuración) | FACT (diseño) + INFERENCE (riesgo agregado) |
| **Data** | Depende del dominio del ticket procesado — sin patrón fijo | INFERENCE |
| **Data Classification** | REQUIRES VALIDATION | `BLOCKED-DECISIONS.md` #3 |
| **Tools** | Nivel Lite: ninguna especial (lectura de ticket, lectura/escritura de spec y código). Nivel Full: acceso de lectura a secretos/configuración para `security-reviewer` (propuesto, sin evidencia de implementación real) | FACT |
| **Model** | No declarado — es un Workflow, no depende de un modelo específico por diseño | FACT |
| **Autonomy** | No aplica directo (Workflow, no Agent) — los roles son fijos, no hay selección dinámica de herramienta | FACT |
| **HITL** | **Explícito y verificado con evidencia real**: `qaManualPending` con `signOff: null` en ambos tickets reales — ningún requisito manual se marcó cubierto sin confirmación humana | FACT |
| **Evaluation** | NOT FOUND | Ningún nivel tiene evidencia de evaluación formal del proceso |
| **Observability** | PARTIAL (nivel Full) — el esquema de log de auditoría está definido (timestamp/rol/acción/evidencia/estado) como propuesta, sin ejemplo de ejecución real que lo confirme en uso. NOT FOUND (nivel Lite) | FACT |
| **Metrics** | NOT FOUND | — |
| **Adopters** | DataAgro (nivel Lite, real). Ninguno confirmado para el nivel Full | FACT |
| **Last Review** | 2026-09-18 | Corregido — ver nota de clasificación |
| **Reusable Asset** | [`capabilities/workflows/spec-driven-development/WORKFLOW.md`](../../capabilities/workflows/spec-driven-development/WORKFLOW.md) | Generalización del nivel Lite, con el nivel Full documentado como propuesta conceptual, no una copia de ningún harness real |
| **Evidence Reference** | Tickets reales `MOA-1816`/`MOA-1765` en `_sdd/` de DataAgro — instancias reales de este Workflow en su nivel Lite (las pruebas de CAP-002 que también usaron estos tickets como input fueron pruebas del mecanismo, ya purgadas, sin relación con esta evidencia) | Evidencia del Workflow en sí, independiente del estado de las pruebas de CAP-002 |

## Nota de clasificación (corregida 2026-09-18)

El nivel Lite (DataAgro) tiene evidencia real de uso, con código y tests reales en verde.
El nivel Full (6 roles, contratos JSON, gate formal de `security-reviewer`) es un patrón
conceptual, descrito en la literatura de spec-driven-development y contrastado contra
GitHub Spec Kit (External Practice) — **sin evidencia de ejecución real de ningún equipo
de MOA todavía**. Se registra como una sola entrada (CAP-004) con ambos niveles
explícitos, en vez de 2 entradas separadas, porque comparten el mismo origen conceptual y
la distinción de madurez es más útil visible en un solo lugar que fragmentada. Antes de
recomendar el nivel Full a un equipo real, corresponde pilotearlo primero — no adoptarlo
"porque está mejor especificado" (ver `capabilities/best-practices.md`).

## Nota de ampliación — `research.md` y `contracts/`

Decisión explícita del Solutions Architect, tras contrastar este Workflow contra GitHub
Spec Kit (External Practice): agregar `research.md` y `contracts/` como artefactos
**opcionales** del nivel Full. Ambos quedan `PROPOSAL` — sin ninguna instancia real de
uso en ningún repo de MOA relevado. `contracts/` responde a un gap real identificado
(endpoints reales sin contrato pre-implementación documentado), no a evidencia de uso.

Ninguno de los 2 es `Corporate Standard`, ninguno es obligatorio — mismo criterio que el
resto del Workflow.
