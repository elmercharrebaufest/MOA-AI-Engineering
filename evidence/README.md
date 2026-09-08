# Evidence

Registros reales de ejecuciones de capacidades — el esquema completo (Evidence Contract)
vive en [`../architecture/evidence-evaluation-measurement.md`](../architecture/evidence-evaluation-measurement.md#1-evidence).
Esta carpeta contiene únicamente instancias reales, nunca ejemplos sintéticos.

## Registros

| Archivo | Capacidad | Qué documenta |
|---|---|---|
| [`EXEC-20260907-001.md`](EXEC-20260907-001.md) | CAP-002 (`user-story`) | CONTROLLED DRY-RUN sobre MOA-1816 (DataAgro) |
| [`EXEC-20260908-001.md`](EXEC-20260908-001.md) | CAP-002 (`user-story`) | CONTROLLED DRY-RUN sobre MOA-1765 (DataAgro) |
| [`current-moa-ai-practices-benchmark.md`](current-moa-ai-practices-benchmark.md) | Todas (benchmark, no una ejecución) | Benchmark de prácticas reales de AI Engineering en 6 repos de MOA (DataAgro, Scato Logística, Orquestador, MoaOperaciones, ScatoPuerto, moa-sdlc) — entrada de evidencia para decisión arquitectónica, no propuesta final |

**Ninguno de los dos es una ejecución independiente** — ambos fueron generados por el
mismo agente que diseñó la capacidad, no por un miembro de un equipo de MOA. Ver el
propio archivo de cada registro para el detalle completo y la clasificación exacta
(`status: EXECUTED`, no `VERIFIED`).

## Cómo generar un registro nuevo

Ver [`../adoption/getting-started.md`](../adoption/getting-started.md) — completá el
Evidence Contract al ejecutar cualquier capacidad de [`../capabilities/`](../capabilities/README.md).
