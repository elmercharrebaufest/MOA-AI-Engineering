# CAP-004 — product-owner

**Nota de clasificación**: a diferencia de CAP-011/CAP-014/CAP-016, esta propuesta sí
tiene una instancia real de respaldo (el agent `product-owner` de Orquestador/Scato
Logística, en uso intensivo real) — pero esa instancia fue evaluada y clasificada
TEAM-SPECIFIC en G5.1 por contenido de dominio, no generalizable directamente. Este Agent
no adopta ese contenido — empaqueta la función ya generalizada en CAP-001, corrigiendo el
hallazgo de seguridad real de esa instancia (scope MCP wildcard). Queda `PROPOSAL` hasta
que un equipo real lo pilotee con el scope acotado.

| Campo | Valor | Evidencia / clasificación |
|---|---|---|
| **ID** | CAP-004 | — |
| **Name** | product-owner | FACT (existe el archivo) |
| **Type** | Agent | FACT |
| **Purpose** | Rol de Product Owner del SDLC: refinar requerimientos y tickets existentes con la lógica de CAP-001 y, con confirmación, dejar el resultado en el ticket (descripción, preguntas como comentario, historias divididas). Traspaso guiado a desarrollo (`ticket-kickoff`) | FACT |
| **Owner** | REQUIRES VALIDATION | `governance/BLOCKED-DECISIONS.md` #1 |
| **Maintainer** | REQUIRES VALIDATION | Ídem |
| **Origin** | Función generalizada de CAP-001. Instancia real de referencia (no adoptada como contenido): `product-owner.agent.md` de Orquestador y Scato Logística — uso real e intensivo confirmado en la reunión con el equipo de Scato Logística (2026-09-18), clasificada TEAM-SPECIFIC en `docs/history/track-1/G5.1-Reusable-Capability-Library.md` | FACT (uso real) + FACT (clasificación TEAM-SPECIFIC) |
| **Originator** | No aplica al Agent nuevo — la instancia real de referencia es de Manuel Davila (Orquestador/Scato Logística) | FACT (instancia de referencia) |
| **Team** | Ninguno todavía adoptó este Agent nuevo | FACT |
| **Domain** | Transversal — sin contenido específico de dominio propio, más allá de lo que ya requiere CAP-001 | FACT |
| **Repository** | No aplica | — |
| **Branch** | No aplica | — |
| **Integration Status** | No integrado a ningún repo de equipo todavía | FACT |
| **Configuration Status** | VERIFIED — contenido completo escrito y revisado en esta sesión | FACT |
| **Real Use Status** | **CONFIGURED** — mecanismo documentado, cero ejecuciones reales, sin evidencia de equipo real todavía | FACT |
| **Lifecycle State** | Proposal | Sin ejecución real todavía |
| **Corporate Standard** | N | Sin evidencia de uso real |
| **Version** | Sin versionado semántico | — |
| **Risk** | Medio | Escribe en el ticket. Acotado por lista cerrada de 7 herramientas (sin estado, horas ni borrado), nunca wildcard, y confirmación por escritura (CAP-023) |
| **Data** | Lee contenido de tickets de Jira vía MCP — no accede a otros datos | FACT (por `tools` declarado) |
| **Data Classification** | REQUIRES VALIDATION | Política no existe (`BLOCKED-DECISIONS.md` #3) |
| **Tools** | Lectura: `read`, `search` (repo, solo lectura), `getJiraIssue`, `listJiraIssueComments`, `getJiraIssueTypeMetaWithFields`. Escritura: `editJiraIssue`, `addOrEditJiraIssueComment`, `createJiraIssue`, `createJiraIssueLink` — explícitamente sin wildcard | FACT (nombres verificados en la documentación oficial de Atlassian Rovo MCP) |
| **Model** | No declarado — mismo criterio que CAP-012 | FACT |
| **Autonomy** | Control estructural: `tools` sin wildcard actúa como el límite real, no una regla en prosa | FACT + INFERENCE |
| **HITL** | Doble: el PO aprueba la historia, y cada escritura en el ticket se confirma antes de ocurrir; nunca cambia el estado | FACT (declarado en `AGENT.md`) |
| **Evaluation** | NOT FOUND | — |
| **Observability** | NOT FOUND | — |
| **Metrics** | NOT FOUND | — |
| **Adopters** | Ninguno | — |
| **Last Review** | 2026-09-24 | — |
| **Evidence Reference** | Ninguna todavía | — |
| **Evaluation Reference** | Ninguna todavía | — |
| **Metric Reference** | Ninguna todavía | — |
| **Reusable Asset** | [`capabilities/agents/product-owner/AGENT.md`](../../capabilities/agents/product-owner/AGENT.md) | — |
| **Action Type** | ACT acotado — editar descripción, comentar, crear y vincular historias, siempre vía CAP-023 con confirmación; nunca cambia estado, sprint ni asignado | Reemplaza el permiso total de la instancia de referencia por una lista cerrada — ver `security/security-governance.md`, "Escritura en tickets" |
| **Context Requirements** | MCP Atlassian configurado y autenticado por el desarrollador (mismo mecanismo de CAP-003) | Reutiliza mecanismo ya existente |

## Nota de selección

Complementa las etapas "Recepción del requerimiento" y "Refinamiento y estimación" del
KO, ya `CONFIGURED` vía CAP-001/002/003 — no las reemplaza. Resuelve directamente un
hallazgo de seguridad real (scope MCP wildcard del `product-owner` observado en Scato
Logística/Orquestador, relacionado con `governance/BLOCKED-DECISIONS.md` #4) sin adoptar
el contenido específico de ningún equipo ni reabrir su clasificación TEAM-SPECIFIC.
