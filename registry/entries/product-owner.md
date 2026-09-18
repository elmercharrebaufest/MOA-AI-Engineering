# CAP-012 — product-owner

**Nota de clasificación**: a diferencia de CAP-009/CAP-010/CAP-011, esta propuesta sí
tiene una instancia real de respaldo (el agent `product-owner` de Orquestador/Scato
Logística, en uso intensivo real) — pero esa instancia fue evaluada y clasificada
TEAM-SPECIFIC en G5.1 por contenido de dominio, no generalizable directamente. Este Agent
no adopta ese contenido — empaqueta la función ya generalizada en CAP-002, corrigiendo el
hallazgo de seguridad real de esa instancia (scope MCP wildcard). Queda `PROPOSAL` hasta
que un equipo real lo pilotee con el scope acotado.

| Campo | Valor | Evidencia / clasificación |
|---|---|---|
| **ID** | CAP-012 | — |
| **Name** | product-owner | FACT (existe el archivo) |
| **Type** | Agent | FACT |
| **Purpose** | Empaquetar como Agent la función de refinamiento ya generalizada en CAP-002, con consulta directa del ticket vía MCP Atlassian de solo lectura y alcance acotado | FACT |
| **Owner** | REQUIRES VALIDATION | `governance/BLOCKED-DECISIONS.md` #1 |
| **Maintainer** | REQUIRES VALIDATION | Ídem |
| **Origin** | Función generalizada de CAP-002. Instancia real de referencia (no adoptada como contenido): `product-owner.agent.md` de Orquestador y Scato Logística — uso real e intensivo confirmado en la reunión con el equipo de Scato Logística (2026-09-18), clasificada TEAM-SPECIFIC en `docs/history/track-1/G5.1-Reusable-Capability-Library.md` | FACT (uso real) + FACT (clasificación TEAM-SPECIFIC) |
| **Originator** | No aplica al Agent nuevo — la instancia real de referencia es de Manuel Davila (Orquestador/Scato Logística) | FACT (instancia de referencia) |
| **Team** | Ninguno todavía adoptó este Agent nuevo | FACT |
| **Domain** | Transversal — sin contenido específico de dominio propio, más allá de lo que ya requiere CAP-002 | FACT |
| **Repository** | No aplica | — |
| **Branch** | No aplica | — |
| **Integration Status** | No integrado a ningún repo de equipo todavía | FACT |
| **Configuration Status** | VERIFIED — contenido completo escrito y revisado en esta sesión | FACT |
| **Real Use Status** | **CONFIGURED** — mecanismo documentado, cero ejecuciones reales, sin evidencia de equipo real todavía | FACT |
| **Lifecycle State** | Proposal | Sin ejecución real todavía |
| **Corporate Standard** | N | Sin evidencia de uso real |
| **Version** | Sin versionado semántico | — |
| **Risk** | Bajo por diseño estructural | `tools` acotado a una sola herramienta de lectura (`getJiraIssue`), nunca wildcard — a diferencia de la instancia real de referencia |
| **Data** | Lee contenido de tickets de Jira vía MCP — no accede a otros datos | FACT (por `tools` declarado) |
| **Data Classification** | REQUIRES VALIDATION | Política no existe (`BLOCKED-DECISIONS.md` #3) |
| **Tools** | `["com.atlassian/atlassian-mcp-server/getJiraIssue"]` — explícitamente sin wildcard | FACT |
| **Model** | No declarado — mismo criterio que CAP-003 | FACT |
| **Autonomy** | Control estructural: `tools` sin wildcard actúa como el límite real, no una regla en prosa | FACT + INFERENCE |
| **HITL** | Explícito: revisión humana obligatoria antes de Planning/desarrollo; nunca publica en el ticket ni cambia su estado | FACT (declarado en `AGENT.md`) |
| **Evaluation** | NOT FOUND | — |
| **Observability** | NOT FOUND | — |
| **Metrics** | NOT FOUND | — |
| **Adopters** | Ninguno | — |
| **Last Review** | 2026-09-18 | — |
| **Evidence Reference** | Ninguna todavía | — |
| **Evaluation Reference** | Ninguna todavía | — |
| **Metric Reference** | Ninguna todavía | — |
| **Reusable Asset** | [`capabilities/agents/product-owner/AGENT.md`](../../capabilities/agents/product-owner/AGENT.md) | — |
| **Action Type** | READ (`getJiraIssue` únicamente; nunca comenta ni cambia el estado del ticket) | Corrige el hallazgo de riesgo real de la instancia de referencia — ver `security/security-governance.md` |
| **Context Requirements** | MCP Atlassian configurado y autenticado por el desarrollador (mismo mecanismo de CAP-008) | Reutiliza mecanismo ya existente |

## Nota de selección

Complementa las etapas "Recepción del requerimiento" y "Refinamiento y estimación" del
KO, ya `CONFIGURED` vía CAP-002/007/008 — no las reemplaza. Resuelve directamente un
hallazgo de seguridad real (scope MCP wildcard del `product-owner` observado en Scato
Logística/Orquestador, relacionado con `governance/BLOCKED-DECISIONS.md` #4) sin adoptar
el contenido específico de ningún equipo ni reabrir su clasificación TEAM-SPECIFIC.
