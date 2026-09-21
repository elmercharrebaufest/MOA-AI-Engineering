# CAP-009 — git-worktree-setup

**Nota de clasificación**: propuesta directa con evidencia externa (Camuzzi/Baufest, no un
equipo de MOA) — mismo tratamiento que el resto de las propuestas nuevas del Registry.
Queda `PROPOSAL` hasta que un equipo real de MOA lo pilotee.

| Campo | Valor | Evidencia / clasificación |
|---|---|---|
| **ID** | CAP-009 | — |
| **Name** | git-worktree-setup | FACT (existe el archivo) |
| **Type** | Agent | FACT |
| **Purpose** | Preparar y limpiar entornos de trabajo aislados (`git worktree`) por tarea, para trabajar varios tickets en paralelo sobre el mismo repo sin pisarse | FACT |
| **Owner** | REQUIRES VALIDATION | `governance/BLOCKED-DECISIONS.md` #1 |
| **Maintainer** | REQUIRES VALIDATION | Ídem |
| **Origin** | No hay instancia real de ningún equipo de MOA. Evidencia externa: agent real de Camuzzi/Baufest (`git-worktree-setup.agent.md`, reunión 2026-09-18), generalizado sin copiar contenido específico de ese cliente | FACT (evidencia externa) |
| **Originator** | No aplica a la instancia de MOA | — |
| **Team** | Ninguno todavía | FACT |
| **Domain** | Transversal — el patrón (aislar por rama) es independiente del dominio | FACT |
| **Repository** | No aplica | — |
| **Branch** | No aplica | — |
| **Integration Status** | No integrado a ningún repo de equipo todavía | FACT |
| **Configuration Status** | VERIFIED — contenido completo escrito y revisado en esta sesión | FACT |
| **Real Use Status** | **CONFIGURED** — mecanismo documentado, cero ejecuciones reales | FACT |
| **Lifecycle State** | Proposal | Sin ejecución real todavía |
| **Corporate Standard** | N | Sin evidencia de uso real |
| **Version** | Sin versionado semántico | — |
| **Risk** | Bajo | Solo ejecuta comandos `git`; nunca edita código, nunca hace commit/push, nunca borra trabajo sin confirmación explícita |
| **Data** | No toca datos de negocio | FACT (por `tools` declarado) |
| **Data Classification** | REQUIRES VALIDATION | `BLOCKED-DECISIONS.md` #3 |
| **Tools** | `[execute, read]` — solo comandos `git` | FACT |
| **Model** | No declarado — buen candidato a modelo económico (tarea mecánica, repetitiva) | FACT |
| **Autonomy** | Control estructural: nunca borra un worktree/rama con trabajo sin confirmar, sin excepción | FACT |
| **HITL** | Explícito: cualquier borrado forzado (modo cleanup, con cambios sin commitear o sin pushear) requiere confirmación humana previa | FACT (declarado en `AGENT.md`) |
| **Evaluation** | NOT FOUND | — |
| **Observability** | NOT FOUND | — |
| **Metrics** | NOT FOUND | — |
| **Adopters** | Ninguno | — |
| **Last Review** | 2026-09-21 | — |
| **Evidence Reference** | Ninguna todavía | — |
| **Evaluation Reference** | Ninguna todavía | — |
| **Metric Reference** | Ninguna todavía | — |
| **Reusable Asset** | [`capabilities/agents/git-worktree-setup/AGENT.md`](../../capabilities/agents/git-worktree-setup/AGENT.md) | — |
| **Action Type** | ACT acotado — ejecuta comandos `git worktree`/`git branch` reales, nunca sobre código de negocio ni sistemas externos; nunca sin poder revertirse antes de confirmar en modo cleanup | Primera entrada del Registry con `ACT` explícito sobre el propio repositorio (no solo `READ`) — acotado por diseño a comandos de aislamiento, ver `Seguridad` en `AGENT.md` |
| **Context Requirements** | Nombre completo de rama + lista explícita de repos del workspace (nunca asumida por defecto) | — |

## Nota de selección

Cierra un gap real que ni siquiera se había identificado en el relevamiento de los 5 equipos
de MOA — ningún equipo documentó un mecanismo de aislamiento por tarea. Base habilitante para
CAP-010 (`ticket-kickoff`), que delega en este agente la preparación del entorno de trabajo
antes de implementar.
