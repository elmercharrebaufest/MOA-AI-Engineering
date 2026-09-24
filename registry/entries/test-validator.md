# CAP-025 — test-validator

**Nota de clasificación**: Agent nuevo, de solo lectura, pedido explícitamente por MOA
("un agente que valide que todo esté probado antes del OK humano final"). Queda
`PROPOSAL` hasta el primer piloto.

| Campo | Valor | Evidencia / clasificación |
|---|---|---|
| **ID** | CAP-025 | — |
| **Name** | test-validator | FACT (existe el archivo) |
| **Type** | Agent | FACT |
| **Purpose** | Verificar con evidencia real que un cambio está probado: resultado de CI o ejecución local, trazabilidad criterio → test o caso manual, tests para el código modificado, detección de tests desactivados o debilitados, fallas previas | FACT |
| **Owner** | REQUIRES VALIDATION | `governance/BLOCKED-DECISIONS.md` #1 |
| **Maintainer** | REQUIRES VALIDATION | Ídem |
| **Origin** | Pedido de MOA. Relevamiento de los repos de MOA: suites grandes y reales, casi ningún pipeline que las corra en cada cambio. Evidencia externa: el agente de ejecución de tests de Camuzzi reporta fallas previas sin arreglarlas | FACT |
| **Originator** | No aplica | — |
| **Team** | Ninguno todavía | — |
| **Domain** | Transversal | FACT |
| **Repository** | No aplica | — |
| **Branch** | No aplica | — |
| **Integration Status** | No integrado a ningún repo de equipo todavía | FACT |
| **Configuration Status** | VERIFIED — contenido completo escrito | FACT |
| **Real Use Status** | **CONFIGURED** — cero ejecuciones reales | FACT |
| **Lifecycle State** | Proposal | — |
| **Corporate Standard** | N | — |
| **Version** | Sigue la versión del plugin | — |
| **Risk** | Bajo por diseño | Sin `edit` y sin escritura en tickets |
| **Data** | Código, diff, resultados de tests y de pipelines | FACT |
| **Data Classification** | REQUIRES VALIDATION | `BLOCKED-DECISIONS.md` #3 |
| **Tools** | `[read, search, execute]` — `execute` solo para git de lectura, `az pipelines` / `az repos pr` de lectura y el comando de test del repo. Traspaso "Preparar cierre" al asistente general | FACT |
| **Model** | No declarado | FACT |
| **Autonomy** | Nunca edita, omite ni excluye tests; nunca afirma "probado" sin número de ejecución o comando y resultado; no vuelve a mandar el trabajo a desarrollo por su cuenta | FACT (declarado en `AGENT.md`) |
| **HITL** | El veredicto es un insumo; el OK final es de una persona | FACT |
| **Evaluation** | NOT FOUND | — |
| **Observability** | NOT FOUND | — |
| **Metrics** | NOT FOUND | — |
| **Adopters** | Ninguno | — |
| **Last Review** | 2026-09-24 | — |
| **Evidence Reference** | Ninguna todavía | — |
| **Evaluation Reference** | Ninguna todavía | — |
| **Metric Reference** | Ninguna todavía | — |
| **Reusable Asset** | [`capabilities/agents/test-validator/AGENT.md`](../../capabilities/agents/test-validator/AGENT.md) | — |
| **Action Type** | READ | — |
| **Context Requirements** | Acceso al repo; Azure CLI con `azure-devops` para leer CI (opcional) | — |

## Nota de selección

Cubre el rol `tester` que el workflow `spec-driven-development` nivel Full nombraba sin
definir, y el paso previo al OK final del KO. CI es la fuente de verdad cuando existe; el
Agent la lee, no la reemplaza.
