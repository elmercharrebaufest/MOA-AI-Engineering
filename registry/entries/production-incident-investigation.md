# CAP-017 — production-incident-investigation

**Nota de clasificación**: propuesta directa con evidencia externa (Camuzzi/Baufest) — mismo
tratamiento que el resto de las propuestas nuevas del Registry. Queda `PROPOSAL` hasta que
un equipo real de MOA lo pilotee. **Cubre 1 de las 5 líneas de Soporte productivo que
propone el KO** — ver `Purpose`.

| Campo | Valor | Evidencia / clasificación |
|---|---|---|
| **ID** | CAP-017 | — |
| **Name** | production-incident-investigation | FACT (existe el archivo) |
| **Type** | Agent | FACT |
| **Purpose** | Investigar un incidente de producción y proponer causa raíz probable con evidencia citada, sin modificar nada. A pedido, también redacta un borrador de comunicación de estado y/o un borrador de cierre a partir de la misma investigación — nunca los publica ni los envía | FACT |
| **Owner** | REQUIRES VALIDATION | `governance/BLOCKED-DECISIONS.md` #1 |
| **Maintainer** | REQUIRES VALIDATION | Ídem |
| **Origin** | No hay instancia real de ningún equipo de MOA. Evidencia externa: agent + skill reales de Camuzzi/Baufest (`appinsights-investigator`/`appinsights-diagnostics`, reunión 2026-09-18, con conexión real a Application Insights) | FACT (evidencia externa) |
| **Originator** | No aplica a la instancia de MOA | — |
| **Team** | Ninguno todavía | FACT |
| **Domain** | Transversal — funciona con o sin integración de monitoreo real | FACT |
| **Repository** | No aplica | — |
| **Branch** | No aplica | — |
| **Integration Status** | No integrado a ningún repo de equipo todavía | FACT |
| **Configuration Status** | VERIFIED — contenido completo escrito y revisado en esta sesión | FACT |
| **Real Use Status** | **CONFIGURED** — mecanismo documentado, cero ejecuciones reales | FACT |
| **Lifecycle State** | Proposal | Sin ejecución real todavía |
| **Corporate Standard** | N | Sin evidencia de uso real |
| **Version** | Sin versionado semántico | — |
| **Risk** | Bajo por diseño estructural | `tools` no incluye `edit`, no puede modificar nada sin importar qué se le pida |
| **Data** | Puede tocar logs/errores de producción si se le pegan directamente, o si consume una integración de monitoreo ya gobernada — nunca accede a datos productivos por su cuenta | INFERENCE (por `tools` y constraints declarados) |
| **Data Classification** | REQUIRES VALIDATION | `BLOCKED-DECISIONS.md` #3 — más relevante acá que en otras entradas, por la naturaleza de los datos de producción que puede llegar a ver |
| **Tools** | `[read, search, execute, web]` — explícitamente sin `edit` | FACT |
| **Model** | No declarado | FACT |
| **Autonomy** | Control estructural: sin `edit`; cualquier integración externa que consuma debe estar ya gobernada, esta capability no la gestiona | FACT |
| **HITL** | Obligatoria: el reporte es insumo, nunca una conclusión aplicada sin validación humana, especialmente antes de cualquier cambio en producción | FACT (declarado en `AGENT.md`) |
| **Evaluation** | NOT FOUND | — |
| **Observability** | NOT FOUND | — |
| **Metrics** | NOT FOUND | — |
| **Adopters** | Ninguno | — |
| **Last Review** | 2026-09-21 | — |
| **Evidence Reference** | Ninguna todavía | — |
| **Evaluation Reference** | Ninguna todavía | — |
| **Metric Reference** | Ninguna todavía | — |
| **Reusable Asset** | [`capabilities/agents/production-incident-investigation/AGENT.md`](../../capabilities/agents/production-incident-investigation/AGENT.md) | — |
| **Action Type** | READ — investiga y propone, nunca actúa sobre producción ni sobre código | Mismo principio que el resto del Registry |
| **Context Requirements** | Logs/errores reales pegados a mano, o una integración de monitoreo ya gobernada (opcional, no requerida) — implementación ejecutable real disponible para AWS CloudWatch y Azure Application Insights, ver [`integrations/production-diagnostics-provider.md`](../../integrations/production-diagnostics-provider.md) | No requiere ninguna integración externa para funcionar en su forma básica |

## Nota de selección

Cierra 3 de las 5 líneas de Soporte productivo del KO: la de evidencia externa real de
funcionar (investigación/causa raíz), más 2 salidas adicionales (comunicación de estado,
cierre) agregadas el 2026-09-21 con External Best Practice de mercado — ambas reutilizan la
misma investigación, sin requerir evidencia ni mecanismo nuevo. Las otras 2 (respuesta
Nivel 1, detección de recurrencia) siguen deliberadamente sin propuesta en este Agent —
Nivel 1 por falta de evidencia de un equipo real de soporte de MOA (el ajuste del patrón de
mercado, orientado a helpdesk de clientes, no está confirmado); detección de recurrencia
porque es un mecanismo distinto (análisis continuo, no investigación de un incidente
puntual) — ver la nota de "Multi-plataforma" abajo.

## Multi-plataforma — sin evidencia todavía, dato real confirmado (2026-09-21)

Relevamiento real de 6 repos de equipos de MOA confirmó que la infraestructura de
producción es híbrida, no un solo proveedor: on-premise (Orquestador, Scato Logística,
MoaOperaciones), AWS real (Portal de Créditos, base de datos de ScatoPuerto), y Azure como
capa de servicios/identidad, con Application Insights ya en uso real en 2 repos
(Orquestador, Scato Logística). Este agente no asume ninguna plataforma — sigue
funcionando hoy con logs pegados a mano, sin integración. Guía de conexión, cuando un
equipo quiera integrar una fuente real: [`../../adoption/production-diagnostics-quickstart.md`](../../adoption/production-diagnostics-quickstart.md).

**Para (5) detección de recurrencia** (fuera de este Agent, ver "Alcance" en el propio
`AGENT.md`) — herramienta nativa por plataforma, ninguna construida por MOA:

| Plataforma | Herramienta nativa real | Evidencia |
|---|---|---|
| Azure | Azure Copilot Observability Agent (Azure Monitor), modo "autonomous operations" | [Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-monitor/aiops/observability-agent-overview) — correlaciona alertas en segundo plano, nunca actúa solo |
| AWS | Amazon DevOps Guru — insights proactivos con ML, detecta anomalías en métricas y logs antes de que escalen | Documentación oficial AWS — mismo principio: recomienda, no actúa por su cuenta |
| On-premise | Sin herramienta nativa identificada — depende de lo que cada equipo ya tenga (ej. Grafana/Prometheus/ELK con reglas propias) | `REQUIRES VALIDATION` — no relevado todavía con ningún equipo real |

Ninguna de las 2 primeras requiere que MOA construya nada — son productos ya existentes de
cada proveedor. La fila on-premise sigue abierta.
