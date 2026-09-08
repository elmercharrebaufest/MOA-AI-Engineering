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
| **Real Use Status** | **EXECUTED** *(2 ejecuciones registradas — G4.4 y G4.6)*. Escala usada: `NOT FOUND / CONFIGURED / EXECUTED / VERIFIED`. **No es `VERIFIED`**: ambas ejecuciones (`EXEC-20260907-001` sobre MOA-1816, `EXEC-20260908-001` sobre MOA-1765) fueron CONTROLLED DRY-RUN realizados por el mismo agente que diseñó la capability, no por un miembro independiente de un equipo de MOA — sigue sin haber confirmación humana independiente. G4.6 sumó una segunda ejecución sobre un ticket real distinto específicamente para probar generalización, no para repetir la primera | Configuration Status sigue sin usarse para inferir esto — es evidencia directa de 2 ejecuciones reales registradas, distintas de la configuración |
| **Lifecycle State** | Pilot | 2 ejecuciones + 2 autoevaluaciones `PARTIAL`, sin Measurement logrado ni HITL humano confirmado — no alcanza para `Measure`/`Human Validation` (`lifecycle.md`) |
| **Corporate Standard** | N | Sin decisión de gobierno — 2 ejecuciones no independientes no son base suficiente, independientemente de que ambas dieran `PARTIAL` |
| **Version** | Sin versionado semántico. Proxy: DataAgro = `20b6363a3`; Scato Logística = `8bff906e`; Orquestador = `872911c` | FACT (hashes) |
| **Risk** | Bajo | No ejecuta código, no accede a sistemas externos — produce texto estructurado |
| **Data** | No toca datos sensibles | INFERENCE |
| **Data Classification** | REQUIRES VALIDATION | Política no existe (`BLOCKED-DECISIONS.md` #3) |
| **Tools** | Ninguna declarada — es contenido de referencia, no requiere `tools` | FACT |
| **Model** | No declarado en ningún caso donde se invoca (el agent `product-owner` de Orquestador que la carga tampoco declara `model`) | FACT |
| **Autonomy** | No aplica directo (Skill) | — |
| **HITL** | No se encontró un punto de validación humana declarado explícitamente dentro de la skill misma; el agent `product-owner` de Orquestador tiene la constraint "Never discuss implementation" pero no un HITL específico sobre la historia generada | REQUIRES VALIDATION |
| **Evaluation** | NOT FOUND | — |
| **Observability** | NOT FOUND | — |
| **Metrics** | NOT FOUND | — |
| **Adopters** | Ninguno confirmado | Los 3 orígenes son independientes, no hay evidencia de adopción cruzada entre los 3 repos |
| **Last Review** | 2026-09-08 | — |
| **Evidence Reference** *(actualizado en G4.6)* | [`evidence/EXEC-20260907-001.md`](../../evidence/EXEC-20260907-001.md) (MOA-1816, G4.4), [`evidence/EXEC-20260908-001.md`](../../evidence/EXEC-20260908-001.md) (MOA-1765, G4.6) | 2 ejecuciones reales (CONTROLLED DRY-RUN), sobre 2 tickets reales distintos de DataAgro |
| **Evaluation Reference** *(actualizado en G4.6)* | [`evaluation/EXEC-20260907-001.md`](../../evaluation/EXEC-20260907-001.md), [`evaluation/EXEC-20260908-001.md`](../../evaluation/EXEC-20260908-001.md) | Resultado en ambas: `PARTIAL`, autoevaluación (`method: model-assisted`), HITL real pendiente en ambas |
| **Metric Reference** *(actualizado en G4.6)* | [`measurements/EXEC-20260907-001.md`](../../measurements/EXEC-20260907-001.md), [`measurements/EXEC-20260908-001.md`](../../measurements/EXEC-20260908-001.md) | `NOT MEASURED` en ambas — sin baseline, y 2 puntos del mismo actor no son una serie comparable (explicado en el segundo archivo) |
| **Reusable Asset** *(nuevo en G5.1)* | [`capabilities/skills/user-story/SKILL.md`](../../capabilities/skills/user-story/SKILL.md) | Generalización de las 3 instancias reales — **sin catálogo de roles fijo**, corrigiendo la brecha encontrada en `EXEC-20260908-001` (rol "operador de planta" ausente del catálogo original de DataAgro) |

## Nota de selección

Elegida como segunda entrada por ser la capacidad de este relevamiento con **más repos
independientes coincidiendo** (3, con 2 originadores distintos) y por ser la base directa
del primer Golden Path (ver sección 9 del reporte G4.2) — bajo riesgo, evaluación simple
(revisión humana de que la historia cumple el formato), sin dependencia de infraestructura
no disponible.
