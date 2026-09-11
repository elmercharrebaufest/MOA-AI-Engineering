# Execution Record — PILOT-001 (CAP-005 en MoaOperaciones)

| Campo | Valor |
|---|---|
| `execution_id` | PILOT-001-EXEC-001 |
| `adoption_id` | NOT ASSIGNED — no existe Adoption Record formal todavía (piloto sandbox) |
| `date` | 2026 (fecha de esta sesión) |
| `team` | MoaOperaciones (equipo real de MOA) |
| `project` | MoaOperaciones (`SustitucionMOA.sln`) |
| `repository` | `MoaOperaciones` (real) — **el intento del developer se guarda en sandbox, no se aplica al repo real todavía** |
| `branch` | NOT APPLICABLE — no se tocó el repositorio real |
| `ticket_or_work_item` | Ninguno — es un piloto de onboarding cold-start, no un ticket de negocio |
| `golden_path` | No aplica directamente — CAP-005 es precondición transversal de todos los Golden Paths |
| `capability_id` | CAP-005 (`repository-governance`) |
| `capability_version` | `1.0-generalized` (G5.1) |
| `tool` | El que el developer elija usar por su cuenta (Copilot, Claude, u otro) — no impuesto |
| `model` | *(a completar por el developer, si aplica)* |
| `input_reference` | `MOA-AI-Engineering` completo, sin guía adicional — cold-start deliberado (ver `briefing-para-developer.md`) |
| `context_provided` | Ninguno más allá del briefing — deliberadamente sin `AGENTS.md.proposal.md` |
| `expected_output` | `AGENTS.md.developer-attempt.md` producido de forma independiente por el developer |
| `actual_output_reference` | *(pendiente — completar cuando el developer termine)* |
| `human_review_required` | true |
| `human_review_status` | PENDING |
| `execution_status` | **CANCELLED (2026-09-09) — nunca se ejecutó.** Ningún developer real de MoaOperaciones tomó este piloto; se cierra sin `actual_output_reference` en vez de quedar abierto sin fecha. |
| `notes` | Es la **primera ejecución candidata a adopción independiente real** de Track 1 — actor distinto (developer de MoaOperaciones) de quien diseñó CAP-005. `AGENTS.md.proposal.md` (mi borrador previo) se mantiene oculto hasta que termine, solo para comparación posterior. Reemplazado por un intento real del usuario con una tarea de Jira real (ver `PILOT-002`). |
