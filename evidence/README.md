# Evidence

Registros reales de ejecuciones de capacidades — el esquema completo (Evidence Contract)
vive en [`../architecture/evidence-evaluation-measurement.md`](../architecture/evidence-evaluation-measurement.md#1-evidence).
Esta página es un **índice cruzado por tipo de artefacto** — el contenido real vive en
[`../records/`](../records/), organizado **por tarea** (una carpeta por ticket, con cada
ejecución anidada adentro — ver la nota de convención al final de este archivo).

## Registros

**Sin registros todavía.** Las ejecuciones que probaron el mecanismo durante la
construcción (Direct Context y Connected Context vía CAP-007/CAP-008) fueron pruebas
propias de quien diseñó la capacidad — se purgaron deliberadamente al pasar a la etapa
real de adopción, para no contar como "evidencia real de uso" algo que no lo era. La
evidencia real empieza con la prueba en curso de un developer real de MOA sobre
`ARMOA277-194` (Jira/MCP) — esta tabla se completa cuando esa ejecución quede registrada.

| Ejecución | Tarea | Capacidad | Qué documenta |
|---|---|---|---|
| *(vacío)* | — | — | Sin ejecuciones registradas todavía |

## Convención de carpetas (`records/<fuente>-<tarea>/<EXEC-ID>/`)

Cada ejecución vive en una carpeta propia dentro de [`../records/`](../records/),
agrupada primero por **tarea** (ticket real) y anidada por **ejecución** — alineado a 2
estándares oficiales verificados: [GitHub Spec Kit](https://github.com/github/spec-kit)
(una carpeta por unidad de trabajo) y el propio modelo de `runs` anidados de la API de
GitHub Actions (`GET /repos/{owner}/{repo}/actions/runs/{run_id}/artifacts`) para
ejecuciones repetibles de la misma tarea. Dentro de cada `EXEC-ID/` conviven
`evidence.md`, `evaluation.md` (si existe) y `measurement.md` (si existe) — los 3
contratos de una misma ejecución, en un solo lugar navegable.

## Pilotos en sandbox (no integrados a ningún repo real)

| Carpeta | Capacidad | Qué documenta |
|---|---|---|
| [`../docs/history/track-1/pilots/PILOT-001-moa-operaciones-cap005/`](../docs/history/track-1/pilots/PILOT-001-moa-operaciones-cap005/README.md) | CAP-005 (`repository-governance`) | Primer intento de adopción independiente — borrador de `AGENTS.md` para MoaOperaciones (repo real sin ninguna capacidad de IA formalizada). `status: PARTIAL`, no integrado al repo real, pendiente de revisión humana del equipo de MoaOperaciones |

## Cómo generar un registro nuevo

Ver [`../adoption/getting-started.md`](../adoption/getting-started.md) — completá el
Evidence Contract al ejecutar cualquier capacidad de [`../capabilities/`](../capabilities/README.md).
