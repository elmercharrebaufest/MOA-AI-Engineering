# CAP-026 — test-pipeline-setup

**Nota de clasificación**: guía accionable basada en documentación oficial de Azure
Pipelines y Azure Repos, no en una herramienta propia. Queda `PROPOSAL` hasta el primer
piloto.

| Campo | Valor | Evidencia / clasificación |
|---|---|---|
| **ID** | CAP-026 | — |
| **Name** | test-pipeline-setup | FACT (existe el archivo) |
| **Type** | Skill | FACT |
| **Purpose** | Configurar CI para que los tests corran en cada cambio y en cada PR: pipeline por stack (.NET moderno, .NET Framework, Angular), resultados y cobertura publicados, cobertura del código modificado y política de rama | FACT |
| **Owner** | REQUIRES VALIDATION | `governance/BLOCKED-DECISIONS.md` #1 |
| **Maintainer** | REQUIRES VALIDATION | Ídem |
| **Origin** | Relevamiento de los repos de MOA (2026-09-24): suites reales en DataAgro, MoaOperaciones, Orquestador, Scato Logística, ScatoPuerto y Portal de Créditos; solo Portal de Créditos backend corre tests en un pipeline, dentro de un despliegue manual (`trigger: none`, `pr: none`) y sin publicar resultados | FACT (leído en los repos) |
| **Originator** | No aplica | — |
| **Team** | Ninguno todavía | — |
| **Domain** | Transversal (Azure DevOps) | FACT |
| **Repository** | No aplica | — |
| **Branch** | No aplica | — |
| **Integration Status** | No integrada a ningún repo de equipo todavía | FACT |
| **Configuration Status** | VERIFIED — sintaxis verificada contra la documentación oficial de Microsoft y Angular | FACT |
| **Real Use Status** | **CONFIGURED** — cero ejecuciones reales | FACT |
| **Lifecycle State** | Proposal | — |
| **Corporate Standard** | N | — |
| **Version** | Sigue la versión del plugin | — |
| **Risk** | Bajo | Propone configuración; los cambios reales pasan por PR y por un administrador del proyecto |
| **Data** | Configuración de pipelines del repo | FACT |
| **Data Classification** | No aplica | — |
| **Tools** | Ninguna propia; escribe archivos de pipeline solo con confirmación | FACT |
| **Model** | No aplica (Skill) | — |
| **Autonomy** | Nunca commit, push ni cambios de política sin confirmación; nunca excluir tests ni bajar umbrales | FACT (declarado en `SKILL.md`) |
| **HITL** | Revisión del PR con la configuración; la política de rama la aplica un administrador del proyecto | FACT |
| **Evaluation** | NOT FOUND | — |
| **Observability** | Resultados de tests y cobertura publicados en Azure DevOps (objetivo de la skill) | — |
| **Metrics** | NOT FOUND | — |
| **Adopters** | Ninguno | — |
| **Last Review** | 2026-09-24 | — |
| **Evidence Reference** | Ninguna todavía | — |
| **Evaluation Reference** | Ninguna todavía | — |
| **Metric Reference** | Ninguna todavía | — |
| **Reusable Asset** | [`capabilities/skills/test-pipeline-setup/SKILL.md`](../../capabilities/skills/test-pipeline-setup/SKILL.md) | — |
| **Action Type** | READ (propone); la aplicación es del equipo | — |
| **Context Requirements** | Repo en Azure Repos; permisos de administrador del proyecto para la política de rama | — |

## Nota de selección

Es la condición para que la validación de pruebas (CAP-025) tenga evidencia de CI en
lugar de depender de una corrida local. El candidato natural para el primer piloto es
Portal de Créditos backend (.NET 8, tests reales, pipeline ya existente).
