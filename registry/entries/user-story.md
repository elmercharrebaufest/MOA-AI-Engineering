# CAP-002 — user-story

| Campo | Valor | Evidencia / clasificación |
|---|---|---|
| **ID** | CAP-002 | — |
| **Name** | user-story | FACT |
| **Type** | Skill | FACT |
| **Purpose** | Estructura y plantillas para historias de usuario (Como/quiero/para), criterios de aceptación (Given/When/Then), reglas de negocio (formato RN-XX) y análisis de gaps | FACT |
| **Owner** | REQUIRES VALIDATION | `BLOCKED-DECISIONS.md` #1 |
| **Maintainer** | REQUIRES VALIDATION | Ídem |
| **Origin** | 3 orígenes independientes: DataAgro (commit `20b6363a3`, ticket DAT-1274, 2026-08-31), Scato Logística (commit `8bff906e`, PR 5629, 2026-07-20), Orquestador (commit `872911c`, PR 5633, 2026-07-20) | FACT |
| **Originator** | Gonzalo Sian (`gsian@baufest.com`) en DataAgro. Manuel Davila en Scato Logística y Orquestador. **2 originadores distintos** — no es autoría única concentrada como en `azure-devops-cli` | FACT |
| **Team** | DataAgro, Scato Logística, Orquestador | FACT |
| **Domain** | Transversal en estructura; contenido/ejemplos 100% adaptados por dominio de cada repo (logística de granos vs. IoT industrial) | FACT (G3.2.5, comparación de contenido) |
| **Repository** | `DataAgro/DataAgro`; `Scato Logistica/Scato%20Logistica`; `Orquestador/Orquestador` | FACT |
| **Branch** | DataAgro: `dev` (confirmado rama principal real vía `origin/HEAD`, no `master`). Scato Logística: `master`. Orquestador: `master-logistica` | FACT |
| **Integration Status** | DataAgro: integrado a `dev`. Scato Logística: integrado a `master`. Orquestador: integrado a `master-logistica`, **NO** a `master` (misma corrección de contexto que en CAP-001) | FACT |
| **Configuration Status** | **VERIFIED** para Scato Logística y Orquestador (contenido completo leído y comparado en G3.2.5). **PARTIAL** para DataAgro — la existencia del archivo está confirmada (listado de directorio), pero **su contenido específico no fue leído completo en ninguna sesión hasta ahora** — no se sobreestima esta entrada | Mixto, declarado explícitamente por repo |
| **Real Use Status** | **CONFIGURED** — el mecanismo (Direct Context y Connected Context vía Context Provider) quedó probado de punta a punta durante la construcción, pero esas ejecuciones fueron pruebas del mecanismo por quien diseñó la capability, purgadas deliberadamente al pasar a adopción real (no cuentan como evidencia de uso). **Sin ejecuciones reales registradas todavía** — la evidencia real empieza con la prueba en curso de un developer real de MOA sobre `ARMOA277-194` (Jira/MCP) | Ver `Evidence Reference` abajo para el estado vivo |
| **Lifecycle State** | Pilot | Mecanismo probado, sin evidencia de uso real registrada todavía — no alcanza para `Measure`/`Human Validation` (`lifecycle.md`) |
| **Corporate Standard** | N | Sin decisión de gobierno — sin evidencia de uso real todavía |
| **Version** | Sin versionado semántico. Proxy: DataAgro = `20b6363a3`; Scato Logística = `8bff906e`; Orquestador = `872911c` | FACT (hashes) |
| **Risk** | Bajo | No ejecuta código, no accede a sistemas externos — produce texto estructurado |
| **Data** | No toca datos sensibles | INFERENCE |
| **Data Classification** | REQUIRES VALIDATION | Política no existe (`../governance/BLOCKED-DECISIONS.md` #3) |
| **Tools** | Ninguna declarada — es contenido de referencia, no requiere `tools` | FACT |
| **Model** | No declarado en ningún caso donde se invoca (el agent `product-owner` de Orquestador que la carga tampoco declara `model`) | FACT |
| **Autonomy** | No aplica directo (Skill) | — |
| **HITL** | No se encontró un punto de validación humana declarado explícitamente dentro de la skill misma; el agent `product-owner` de Orquestador tiene la constraint "Never discuss implementation" pero no un HITL específico sobre la historia generada | REQUIRES VALIDATION |
| **Evaluation** | NOT FOUND | — |
| **Observability** | NOT FOUND | — |
| **Metrics** | NOT FOUND | — |
| **Adopters** | Ninguno confirmado | Los 3 orígenes son independientes, no hay evidencia de adopción cruzada entre los 3 repos |
| **Last Review** | 2026-09-08 | — |
| **Evidence Reference** | Ninguna todavía — ver [`../../evidence/README.md`](../../evidence/README.md) para el estado vivo | Sin registros reales de uso |
| **Evaluation Reference** | Ninguna todavía | — |
| **Metric Reference** | Ninguna todavía | — |
| **Reusable Asset** *(nuevo en G5.1)* | [`capabilities/skills/user-story/SKILL.md`](../../capabilities/skills/user-story/SKILL.md) | Generalización de las 3 instancias reales — **sin catálogo de roles fijo**, corrigiendo una brecha encontrada durante la construcción (rol "operador de planta" ausente del catálogo original de DataAgro) |
| **Action Type** *(nuevo, campo agregado al implementar Context Acquisition & Resolution)* | READ (no accede a sistemas externos; produce texto, no actúa sobre ningún sistema) | Sin cambios respecto a la evidencia ya existente — CAP-002 nunca declaró `ACT` |
| **Context Requirements** | `Direct Context o Resolved Context, indistintamente` — ver [`SKILL.md`](../../capabilities/skills/user-story/SKILL.md#entrada) | Ambos modos quedaron probados de punta a punta durante la construcción — ninguno tiene evidencia de uso real todavía |

## Nota de selección

Elegida como segunda entrada por ser la capacidad de este relevamiento con **más repos
independientes coincidiendo** (3, con 2 originadores distintos) y por ser la base directa
del primer Golden Path (ver sección 9 del reporte G4.2) — bajo riesgo, evaluación simple
(revisión humana de que la historia cumple el formato), sin dependencia de infraestructura
no disponible.
