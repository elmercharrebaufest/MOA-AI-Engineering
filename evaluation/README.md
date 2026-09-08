# Evaluation

Registros reales de evaluación de evidencia — el esquema completo (Evaluation Contract)
vive en [`../architecture/evidence-evaluation-measurement.md`](../architecture/evidence-evaluation-measurement.md#2-evaluation).
Esta carpeta contiene únicamente instancias reales, nunca ejemplos sintéticos.

## Registros

| Archivo | Evidencia evaluada | Método | Resultado |
|---|---|---|---|
| [`EXEC-20260907-001.md`](EXEC-20260907-001.md) | `evidence/EXEC-20260907-001.md` | `model-assisted` (no `human`) | `PARTIAL` |
| [`EXEC-20260908-001.md`](EXEC-20260908-001.md) | `evidence/EXEC-20260908-001.md` | `model-assisted` (no `human`) | `PARTIAL` |
| [`EXEC-20260908-003.md`](EXEC-20260908-003.md) | `evidence/EXEC-20260908-003.md` (vertical slice CAP-007 → CAP-002) | `model-assisted` (no `human`) | `PARTIAL` |

**Ninguna evaluación es independiente todavía** — ambas fueron hechas por el mismo actor
que generó la evidencia que evalúan, no por un evaluador humano confirmado
(`../governance/BLOCKED-DECISIONS.md` #1). Un resultado `model-assisted` no sustituye una
evaluación humana, sin excepción.

## Cómo generar un registro nuevo

Ver [`../adoption/getting-started.md`](../adoption/getting-started.md) — declará tus
criterios **antes** de mirar el resultado, y completá el Evaluation Contract.
