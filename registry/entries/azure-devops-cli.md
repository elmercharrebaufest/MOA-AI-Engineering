# CAP-001 — azure-devops-cli

| Campo | Valor | Evidencia / clasificación |
|---|---|---|
| **ID** | CAP-001 | — |
| **Name** | azure-devops-cli | FACT |
| **Type** | Skill | FACT — sigue la convención `.github/skills/*/SKILL.md` |
| **Purpose** | Ejecutar operaciones de Azure DevOps (pipelines, builds, PRs, variable groups) vía CLI, con verificación de entorno obligatoria antes de cualquier tarea, sin que el asistente invente sintaxis de memoria | FACT — leído completo en ambos repos |
| **Owner** | REQUIRES VALIDATION | Bloqueado por `BLOCKED-DECISIONS.md` #1 |
| **Maintainer** | REQUIRES VALIDATION | Ídem |
| **Origin** | Introducida el mismo día (2026-07-20) en Scato Logística (PR 5629 → `master`) y en Orquestador (PR 5633 → `master-logistica`) | FACT — confirmado por `git log --follow` en ambos repos |
| **Originator** | Manuel Davila (`Manuel.Davila@Molinosagro.com.ar` / `mdavila@baufest.com`) | FACT (autoría por `git log`) — que ambas direcciones de email sean la misma persona es INFERENCE razonable, no confirmado formalmente |
| **Team** | Scato Logística, Orquestador | FACT |
| **Domain** | Transversal — Azure DevOps es infraestructura común, no depende del dominio de negocio | INFERENCE |
| **Repository** | `Scato Logistica/Scato%20Logistica`; `Orquestador/Orquestador` | FACT |
| **Branch** | Scato Logística: `master`. Orquestador: `master-logistica` | FACT — verificado con `git ls-tree`/`git merge-base` |
| **Integration Status** | Scato Logística: **integrado** a `master`. Orquestador: **integrado a `master-logistica`** (rama de larga vida, último commit 2026-08-18, confirmada ancestro de `feature/cardless4`) — **NO integrado a `master`** de Orquestador. **Corrección respecto a G3.2/G3.2.5**: esas fases habían caracterizado la evidencia de Orquestador como viviendo solo en una rama feature no integrada; el relevamiento de G4.2 encontró que en realidad está integrada en `master-logistica`, una rama distinta y activamente mantenida — no es el mismo hallazgo de riesgo que se había reportado antes | FACT, con corrección explícita |
| **Configuration Status** | **VERIFIED** | Contenido completo leído en ambos repos (G3.2.5): mismos 4 pre-checks (`az --version`, extensión, `az account show`, `az devops configure --list`), mismos 2 archivos de referencia (`pipelines-and-builds.md`, `variables-and-agents.md`) — evidencia fuerte de origen común |
| **Real Use Status** | **CONFIGURED** *(terminología unificada en G4.5 — escala `NOT FOUND / CONFIGURED / EXECUTED / VERIFIED`, la misma que CAP-002)* | Configuración VERIFIED, pero cero ejecuciones registradas (a diferencia de CAP-002, que sí tiene `EXEC-20260907-001`) — **no se infiere de Configuration Status**, es la ausencia real de un Evidence Record lo que fija este valor |
| **Lifecycle State** | Pilot | Configuración madura, sin Evaluation/Measure documentados (`lifecycle.md`, Capability Lifecycle) |
| **Corporate Standard** | N | Ninguna capacidad relevada completó el Assessment Gate |
| **Version** | Sin versionado semántico formal. Proxy de Configuration version: Scato Logística = commit `8bff906e` (introducción), posible actualización en `be9ae170` (2026-08-24, diff exacto no verificado — REQUIRES VALIDATION). Orquestador = commit `872911c` | FACT (hashes) / REQUIRES VALIDATION (diff exacto de la actualización) |
| **Risk** | Bajo | Solo lectura en los pre-checks obligatorios; no se declaran operaciones destructivas por defecto en la skill misma |
| **Data** | No toca datos de negocio — opera sobre metadata de Azure DevOps (pipelines, PRs, builds) | INFERENCE (por contenido leído) |
| **Data Classification** | REQUIRES VALIDATION | Política de clasificación de datos no existe (`../governance/BLOCKED-DECISIONS.md` #3) |
| **Tools** | `az cli` + extensión `azure-devops` | FACT |
| **Model** | No declarado en el agent `devops` de Orquestador que la invoca | FACT (ausencia confirmada) |
| **Autonomy** | No aplica directo (es Skill). El agent `devops` que la carga declara reglas duras: secretos nunca en YAML, sin tareas deprecadas, sin push directo a main | FACT (del agent, no de la skill en sí) |
| **HITL** | Implícito vía las reglas duras del agent `devops` — no declarado explícitamente dentro de la skill | PARTIAL |
| **Evaluation** | NOT FOUND | Brecha fundacional, sin cambios desde G3.1 |
| **Observability** | NOT FOUND | Ídem |
| **Metrics** | NOT FOUND | Ídem |
| **Adopters** | Ninguno confirmado | No hay evidencia de que un equipo haya "adoptado desde otro origen" — ambas instancias surgen del mismo originador el mismo día, no de un flujo de adopción documentado |
| **Last Review** | 2026-09-07 | Esta sesión (G4.2) |
| **Evidence Reference** *(nuevo en G4.3)* | `NOT EXECUTED` | Sin ejecución real todavía — ver `G4.3-Evidence-Evaluation-Measurement.md` §13 |
| **Evaluation Reference** *(nuevo en G4.3)* | `NOT EVALUATED` | Ídem |
| **Metric Reference** *(nuevo en G4.3)* | `NOT MEASURED` | Ídem |
| **Reusable Asset** *(nuevo en G5.1)* | [`capabilities/skills/azure-devops-cli/SKILL.md`](../../capabilities/skills/azure-devops-cli/SKILL.md) | Generalización de las 2 instancias reales — no una copia literal de ninguna |

## Nota de selección

Elegida como primera entrada del Registry MVP por: evidencia de configuración más sólida
de todo el relevamiento (comparación de contenido real entre 2 repos independientes, no
solo coincidencia de nombre), riesgo bajo, y clasificación preliminar ya existente en
`assessment-gate.md` ("ADOPT, tras reconciliar versiones").
