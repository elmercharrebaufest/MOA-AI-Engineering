# Evidence Record — PILOT-001 (CAP-005 en MoaOperaciones)

## Evidence Contract

| Campo | Valor |
|---|---|
| `capability_id` | CAP-005 (`repository-governance`) |
| `capability_version` | `1.0-generalized` (G5.1) |
| `execution_id` | PILOT-001-EXEC-001 |
| `executed_at` | 2026 (fecha de esta sesión) |
| `actor` | human (responsable de Track 1) + AI assistant (GitHub Copilot / Claude Sonnet 4.5) |
| `repository` | Sandbox en `MOA-AI-Engineering` (`docs/history/track-1/pilots/PILOT-001-moa-operaciones-cap005/`) — **no** el repositorio real `MoaOperaciones` |
| `branch` | NOT APPLICABLE |
| `input_reference` | Estructura pública de carpetas de `MoaOperaciones` (sin leer código fuente) |
| `output_reference` | [`AGENTS.md.proposal.md`](AGENTS.md.proposal.md) |
| `evidence_reference` | Este mismo archivo |
| `evaluation_reference` | NOT EVALUATED — pendiente de revisión humana por el equipo real de MoaOperaciones |
| `metric_reference` | NOT MEASURED |
| `status` | PARTIAL |

## Nota de honestidad (regla de `strategy/track-1-context.md` §20)

Este no es un piloto de adopción independiente todavía — es la preparación de una
propuesta de gobierno para que un piloto de adopción independiente **pueda** ejecutarse
después, sujeto a: (1) revisión humana del equipo real de MoaOperaciones sobre el
contenido `INFERENCE`, (2) aprobación explícita para integrarlo al repositorio real. No
se declara `EXECUTED` en el sentido del Registry porque no hubo ejecución sobre el repo
real, y CAP-005 en sí misma no se declara `EXECUTED`/`VERIFIED` por diseño (es
documentación de gobierno continua, no una ejecución puntual — ver
`registry/entries/repository-governance.md`).
