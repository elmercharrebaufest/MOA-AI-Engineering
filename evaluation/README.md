# Evaluation

Registros reales de evaluación de evidencia — el esquema completo (Evaluation Contract)
vive en [`../architecture/evidence-evaluation-measurement.md`](../architecture/evidence-evaluation-measurement.md#2-evaluation).
Esta carpeta contiene únicamente instancias reales, nunca ejemplos sintéticos.

## Registros

Índice cruzado por tipo — el contenido real vive en [`../records/`](../records/), una
carpeta por tarea con cada ejecución anidada adentro (ver la nota de convención en
[`../evidence/README.md`](../evidence/README.md#convención-de-carpetas-recordsfuente-tareaexec-id)).

| Ejecución | Tarea | Evidencia evaluada | Método | Resultado |
|---|---|---|---|---|
| [`EXEC-20260907-001`](../records/jira-MOA-1816/EXEC-20260907-001/evaluation.md) | MOA-1816 | [`evidence.md`](../records/jira-MOA-1816/EXEC-20260907-001/evidence.md) | `model-assisted` (no `human`) | `PARTIAL` |
| [`EXEC-20260908-001`](../records/jira-MOA-1765/EXEC-20260908-001/evaluation.md) | MOA-1765 | [`evidence.md`](../records/jira-MOA-1765/EXEC-20260908-001/evidence.md) | `model-assisted` (no `human`) | `PARTIAL` |
| [`EXEC-20260908-003`](../records/ado-7/EXEC-20260908-003/evaluation.md) | ADO #7 | [`evidence.md`](../records/ado-7/EXEC-20260908-003/evidence.md) (vertical slice CAP-007 → CAP-002) | `model-assisted` (no `human`) | `PARTIAL` |
| [`EXEC-20260908-004`](../records/jira-ARMOA277-191/EXEC-20260908-004/evaluation.md) | ARMOA277-191 | [`evidence.md`](../records/jira-ARMOA277-191/EXEC-20260908-004/evidence.md) (vertical slice CAP-008 MCP → CAP-002, issue Error/Bug) | `model-assisted` (no `human`) | `PARTIAL` |
| [`EXEC-20260908-005`](../records/jira-ARMOA277-180/EXEC-20260908-005/evaluation.md) | ARMOA277-180 | [`evidence.md`](../records/jira-ARMOA277-180/EXEC-20260908-005/evidence.md) (vertical slice CAP-008 MCP → CAP-002, issue Tarea/Task) | `model-assisted` (no `human`) | `PARTIAL` |
| [`EXEC-20260909-001`](../records/jira-ARMOA277-45/EXEC-20260909-001/evaluation.md) | ARMOA277-45 | [`evidence.md`](../records/jira-ARMOA277-45/EXEC-20260909-001/evidence.md) (vertical slice CAP-008 MCP → CAP-002, issue Test/Xray, **actor independiente — `PILOT-003`**) | `model-assisted` (no `human`) | `PARTIAL` |

**Ninguna evaluación es independiente todavía** — todas fueron hechas por el mismo actor
que generó la evidencia que evalúan, no por un evaluador humano confirmado
(`../governance/BLOCKED-DECISIONS.md` #1) — independiente de que `EXEC-20260909-001` sí
tenga un **actor de ejecución** independiente (`PILOT-003`); son 2 ejes distintos. Un
resultado `model-assisted` no sustituye una evaluación humana, sin excepción.

## Cómo generar un registro nuevo

Ver [`../adoption/getting-started.md`](../adoption/getting-started.md) — declará tus
criterios **antes** de mirar el resultado, y completá el Evaluation Contract.
