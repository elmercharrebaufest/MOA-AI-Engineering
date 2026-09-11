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
| **Real Use Status** | **EXECUTED** *(6 ejecuciones registradas — 2 Direct Context: G4.4 y G4.6; 4 Connected Context: `EXEC-20260908-003/004/005`, `EXEC-20260909-001`)*. Escala usada: `NOT FOUND / CONFIGURED / EXECUTED / VERIFIED`. **No es `VERIFIED`**: las 2 primeras ejecuciones (`EXEC-20260907-001` sobre MOA-1816, `EXEC-20260908-001` sobre MOA-1765) fueron CONTROLLED DRY-RUN con Direct Context; las 4 adicionales (`EXEC-20260908-003` Azure DevOps, `EXEC-20260908-004`/`EXEC-20260908-005`/`EXEC-20260909-001` Jira/MCP) fueron con Connected Context vía Context Provider — las 6 fueron realizadas por el mismo agente que diseñó la capability (el campo `actor` de cada Evidence Record es genérico y no declara un desarrollador independiente de un equipo de MOA) — sigue sin haber confirmación humana independiente. G4.6 sumó una segunda ejecución Direct Context sobre un ticket real distinto específicamente para probar generalización; el vertical slice de Context Acquisition & Resolution sumó las 4 restantes para probar el modo Connected Context, cada una sobre un tipo de issue Jira distinto (`Error`/Bug, `Tarea`/Task, `Test`/Xray) | Configuration Status sigue sin usarse para inferir esto — es evidencia directa de 6 ejecuciones reales registradas, distintas de la configuración |
| **Lifecycle State** | Pilot | 6 ejecuciones + 6 autoevaluaciones `PARTIAL`, sin Measurement logrado ni HITL humano confirmado — no alcanza para `Measure`/`Human Validation` (`lifecycle.md`) |
| **Corporate Standard** | N | Sin decisión de gobierno — 6 ejecuciones no independientes no son base suficiente, independientemente de que todas dieran `PARTIAL` |
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
| **Evidence Reference** *(actualizado tras la tercera ejecución MCP)* | [`evidence/EXEC-20260907-001.md`](../../evidence/EXEC-20260907-001.md) (MOA-1816, G4.4), [`evidence/EXEC-20260908-001.md`](../../evidence/EXEC-20260908-001.md) (MOA-1765, G4.6), [`evidence/EXEC-20260908-003.md`](../../evidence/EXEC-20260908-003.md) (Azure DevOps #7, Resolved Context vía CAP-007), [`evidence/EXEC-20260908-004.md`](../../evidence/EXEC-20260908-004.md) (Jira `ARMOA277-191`, Resolved Context vía CAP-008/MCP), [`evidence/EXEC-20260908-005.md`](../../evidence/EXEC-20260908-005.md) (Jira `ARMOA277-180`, Resolved Context vía CAP-008/MCP, segundo tipo de issue), [`evidence/EXEC-20260909-001.md`](../../evidence/EXEC-20260909-001.md) (Jira `ARMOA277-45`, Resolved Context vía CAP-008/MCP, tercer tipo de issue) | 6 ejecuciones reales — 2 Direct Context (DataAgro), 4 Connected Context (Azure DevOps, Jira x3) |
| **Evaluation Reference** *(actualizado)* | [`evaluation/EXEC-20260907-001.md`](../../evaluation/EXEC-20260907-001.md), [`evaluation/EXEC-20260908-001.md`](../../evaluation/EXEC-20260908-001.md), [`evaluation/EXEC-20260908-003.md`](../../evaluation/EXEC-20260908-003.md), [`evaluation/EXEC-20260908-004.md`](../../evaluation/EXEC-20260908-004.md), [`evaluation/EXEC-20260908-005.md`](../../evaluation/EXEC-20260908-005.md), [`evaluation/EXEC-20260909-001.md`](../../evaluation/EXEC-20260909-001.md) | Resultado en las 6: `PARTIAL`, autoevaluación (`method: model-assisted`), HITL real pendiente en todas |
| **Metric Reference** *(actualizado)* | [`measurements/EXEC-20260907-001.md`](../../measurements/EXEC-20260907-001.md), [`measurements/EXEC-20260908-001.md`](../../measurements/EXEC-20260908-001.md), [`measurements/EXEC-20260908-003.md`](../../measurements/EXEC-20260908-003.md), [`measurements/EXEC-20260908-004.md`](../../measurements/EXEC-20260908-004.md), [`measurements/EXEC-20260908-005.md`](../../measurements/EXEC-20260908-005.md), [`measurements/EXEC-20260909-001.md`](../../measurements/EXEC-20260909-001.md) | `NOT MEASURED` en las 6 — sin baseline, y ejecuciones puntuales del mismo actor no forman una serie comparable |
| **Reusable Asset** *(nuevo en G5.1)* | [`capabilities/skills/user-story/SKILL.md`](../../capabilities/skills/user-story/SKILL.md) | Generalización de las 3 instancias reales — **sin catálogo de roles fijo**, corrigiendo la brecha encontrada en `EXEC-20260908-001` (rol "operador de planta" ausente del catálogo original de DataAgro) |
| **Action Type** *(nuevo, campo agregado al implementar Context Acquisition & Resolution)* | READ (no accede a sistemas externos; produce texto, no actúa sobre ningún sistema) | Sin cambios respecto a la evidencia ya existente — CAP-002 nunca declaró `ACT` |
| **Context Requirements** *(actualizado tras el vertical slice de Context Acquisition & Resolution)* | `Direct Context o Resolved Context, indistintamente` — ver [`SKILL.md`](../../capabilities/skills/user-story/SKILL.md#context-input) | Ambos modos tienen ahora evidencia real de ejecución: Direct Context (`EXEC-20260907-001`, `EXEC-20260908-001`) y Resolved Context/Connected Context (`EXEC-20260908-003` vía Azure DevOps, `EXEC-20260908-004`/`EXEC-20260908-005` vía Jira/MCP sobre dos tipos de issue distintos) — ninguno de los 2 modos alcanza `VERIFIED` todavía |

## Nota de selección

Elegida como segunda entrada por ser la capacidad de este relevamiento con **más repos
independientes coincidiendo** (3, con 2 originadores distintos) y por ser la base directa
del primer Golden Path (ver sección 9 del reporte G4.2) — bajo riesgo, evaluación simple
(revisión humana de que la historia cumple el formato), sin dependencia de infraestructura
no disponible.
