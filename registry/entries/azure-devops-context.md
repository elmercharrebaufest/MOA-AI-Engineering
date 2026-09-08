# CAP-007 — azure-devops-context

| Campo | Valor | Evidencia / clasificación |
|---|---|---|
| **ID** | CAP-007 | — |
| **Name** | azure-devops-context | FACT (nombre asignado en esta actividad) |
| **Type** | Integration/API | Consulta directa vía `az` CLI a un recurso específico — no es descubrimiento dinámico gobernado (eso sería MCP), es un conector de propósito acotado |
| **Purpose** | Resolver una referencia a un Work Item/PR de Azure DevOps hacia un `Resolved Context` consumible por cualquier capability, sin que la capability necesite saber que el origen fue Azure DevOps | PROPOSAL — patrón nuevo, generalizado a partir de evidencia real de CAP-001 |
| **Action Type** *(campo nuevo, ver `capability-registry.md`)* | READ | Declarado explícitamente — sin operaciones de escritura en esta versión |
| **Context Requirements** *(campo nuevo)* | N/A — este patrón **produce** Resolved Context, no lo consume | — |
| **Owner** | REQUIRES VALIDATION | `../../governance/BLOCKED-DECISIONS.md` #1 |
| **Maintainer** | REQUIRES VALIDATION | Ídem |
| **Origin** | Generalización de la evidencia real de `azure-devops-cli` (CAP-001) — no una nueva instancia encontrada en un repo, es un patrón extraído en esta actividad | PROPOSAL |
| **Originator** | N/A — patrón derivado, no autoría de equipo | — |
| **Team** | Ninguno todavía — sin adopción real | — |
| **Domain** | Transversal — Azure DevOps es infraestructura común | INFERENCE, igual que CAP-001 |
| **Repository** | `MOA-AI-Engineering` únicamente — no vive en ningún repo de equipo todavía | FACT |
| **Branch** | `main` | FACT |
| **Integration Status** | No integrado a ningún repo de equipo — es un patrón de referencia | FACT |
| **Configuration Status** | **VERIFIED** para el patrón/documento en sí (contrato completo, sin ambigüedad) | El patrón está completo; no hay "configuración real" adicional que verificar más allá del documento mismo |
| **Real Use Status** | **EXECUTED** | 1 ejecución real de punta a punta (`EXEC-20260908-003`) — Work Item real (#7, proyecto "AWS Portal de créditos", org `molinosagro`) → Resolved Context real → CAP-002 real. Primer vertical slice completo del modelo |
| **Lifecycle State** | Pilot | Primera ejecución real registrada (`../lifecycle.md`) |
| **Corporate Standard** | N | Ningún patrón nuevo se promueve automáticamente — requiere Assessment Gate |
| **Version** | `1.0-pattern` | — |
| **Risk** | Bajo — READ-only, sin credenciales, sin llamadas reales desde este repo | Ver `security-governance.md` §1.5 |
| **Data** | Metadata de Work Items/PRs — no datos de negocio de aplicación | INFERENCE, igual que CAP-001 |
| **Data Classification** | REQUIRES VALIDATION | Política no existe (`BLOCKED-DECISIONS.md` #3) |
| **Tools** | `az cli` + extensión `azure-devops` — mismo mecanismo que CAP-001, sin herramienta nueva | FACT |
| **Model** | No aplica — no requiere modelo de IA para resolver, es una consulta directa | — |
| **Autonomy** | No aplica — no es Agent | — |
| **HITL** | No requerido para READ de bajo riesgo — ver `security-governance.md` §1.5 | PROPOSAL |
| **Evaluation** | NOT FOUND | Sin evaluación real todavía |
| **Observability** | NOT FOUND | `retrieval_status`/`provenance` del contrato están preparados para instrumentarse, no instrumentados todavía |
| **Metrics** | NOT FOUND | — |
| **Adopters** | Ninguno | Patrón recién definido |
| **Last Review** | Esta actividad | — |
| **Evidence Reference** | [`evidence/EXEC-20260908-003.md`](../../evidence/EXEC-20260908-003.md) | Ejecución real completa, `status: EXECUTED` |
| **Evaluation Reference** | [`evaluation/EXEC-20260908-003.md`](../../evaluation/EXEC-20260908-003.md) | `PARTIAL`, `model-assisted`, no independiente |
| **Metric Reference** | [`measurements/EXEC-20260908-003.md`](../../measurements/EXEC-20260908-003.md) | `NOT MEASURED` — sin baseline |
| **Reusable Asset** | [`integrations/azure-devops-context-provider.md`](../../integrations/azure-devops-context-provider.md), implementación ejecutable en [`integrations/scripts/azure-devops-context.ps1`](../../integrations/scripts/azure-devops-context.ps1) | Patrón + código real, probado en sus rutas de error (`INVALID_REFERENCE`, `SOURCE_UNAVAILABLE`) contra este entorno; pendiente de ejecución real contra un Work Item/PR concreto |

## Nota de selección

Primera capability nueva creada al implementar Context Acquisition & Resolution
(Prioridad 3 de la fase de implementación). Extrae únicamente el subconjunto de CAP-001
relevante para resolución de contexto — no reemplaza ni duplica CAP-001, que sigue siendo
la capability de operaciones generales de Azure DevOps.
