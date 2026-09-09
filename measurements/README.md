# Measurements

Resultados reales de medición — el esquema completo (Measurement Result Contract) vive en
[`../architecture/evidence-evaluation-measurement.md`](../architecture/evidence-evaluation-measurement.md#3-measurement).
Esta carpeta incluye resultados `NOT MEASURED` explícitamente justificados — un resultado
honesto, no una omisión.

## Registros

| Archivo | Capacidad | Resultado | Por qué |
|---|---|---|---|
| [`EXEC-20260907-001.md`](EXEC-20260907-001.md) | CAP-002 (`user-story`) | `NOT MEASURED` | Sin baseline |
| [`EXEC-20260908-001.md`](EXEC-20260908-001.md) | CAP-002 (`user-story`) | `NOT MEASURED` | Sin baseline; 2 puntos del mismo actor no forman una serie comparable |
| [`EXEC-20260908-003.md`](EXEC-20260908-003.md) | CAP-002 + CAP-007 (vertical slice) | `NOT MEASURED` | Sin baseline de Direct Context ni de Connected Context |
| [`EXEC-20260908-004.md`](EXEC-20260908-004.md) | CAP-002 + CAP-008 (vertical slice, MCP) | `NOT MEASURED` | Sin baseline de Direct Context ni del camino MCP/REST |
| [`EXEC-20260908-005.md`](EXEC-20260908-005.md) | CAP-002 + CAP-008 (vertical slice, MCP, segunda ejecución) | `NOT MEASURED` | Sin baseline; 2 puntos MCP (issue Error/Bug y Tarea/Task) no forman una serie comparable |

**No existe todavía baseline cuantitativo ni medición comparativa de valor para ninguna
capacidad.** Ningún resultado fue inventado ni convertido en `0%` por falta de dato.

## Cómo generar un registro nuevo

Ver [`../adoption/getting-started.md`](../adoption/getting-started.md). Si no hay
baseline: `baseline_reference: REQUIRES VALIDATION` y `confidence/status: NOT MEASURED` —
nunca se inventa un valor para poder reportar un porcentaje.
