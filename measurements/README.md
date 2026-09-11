# Measurements

Resultados reales de medición — el esquema completo (Measurement Result Contract) vive en
[`../architecture/evidence-evaluation-measurement.md`](../architecture/evidence-evaluation-measurement.md#3-measurement).
Esta carpeta incluye resultados `NOT MEASURED` explícitamente justificados — un resultado
honesto, no una omisión.

## Registros

Índice cruzado por tipo — el contenido real vive en [`../records/`](../records/), una
carpeta por tarea con cada ejecución anidada adentro (ver la nota de convención en
[`../evidence/README.md`](../evidence/README.md#convención-de-carpetas-recordsfuente-tareaexec-id)).

| Ejecución | Tarea | Capacidad | Resultado | Por qué |
|---|---|---|---|---|
| [`EXEC-20260907-001`](../records/jira-MOA-1816/EXEC-20260907-001/measurement.md) | MOA-1816 | CAP-002 (`user-story`) | `NOT MEASURED` | Sin baseline |
| [`EXEC-20260908-001`](../records/jira-MOA-1765/EXEC-20260908-001/measurement.md) | MOA-1765 | CAP-002 (`user-story`) | `NOT MEASURED` | Sin baseline; 2 puntos del mismo actor no forman una serie comparable |
| [`EXEC-20260908-003`](../records/ado-7/EXEC-20260908-003/measurement.md) | ADO #7 | CAP-002 + CAP-007 (vertical slice) | `NOT MEASURED` | Sin baseline de Direct Context ni de Connected Context |
| [`EXEC-20260908-004`](../records/jira-ARMOA277-191/EXEC-20260908-004/measurement.md) | ARMOA277-191 | CAP-002 + CAP-008 (vertical slice, MCP) | `NOT MEASURED` | Sin baseline de Direct Context ni del camino MCP/REST |
| [`EXEC-20260908-005`](../records/jira-ARMOA277-180/EXEC-20260908-005/measurement.md) | ARMOA277-180 | CAP-002 + CAP-008 (vertical slice, MCP, segunda ejecución) | `NOT MEASURED` | Sin baseline; 2 puntos MCP (issue Error/Bug y Tarea/Task) no forman una serie comparable |
| [`EXEC-20260909-001`](../records/jira-ARMOA277-45/EXEC-20260909-001/measurement.md) | ARMOA277-45 | CAP-002 + CAP-008 (vertical slice, MCP, tercera ejecución, **actor independiente**) | `NOT MEASURED` | Sin baseline; 3 puntos MCP (Error/Bug, Tarea/Task, Test/Xray) siguen sin formar una serie comparable |

**No existe todavía baseline cuantitativo ni medición comparativa de valor para ninguna
capacidad.** Ningún resultado fue inventado ni convertido en `0%` por falta de dato.

## Cómo generar un registro nuevo

Ver [`../adoption/getting-started.md`](../adoption/getting-started.md). Si no hay
baseline: `baseline_reference: REQUIRES VALIDATION` y `confidence/status: NOT MEASURED` —
nunca se inventa un valor para poder reportar un porcentaje.
