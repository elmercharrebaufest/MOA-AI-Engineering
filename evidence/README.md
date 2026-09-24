# Evidence

Registros reales de ejecuciones de capacidades — el esquema completo (Evidence Contract)
vive en [`../architecture/evidence-evaluation-measurement.md`](../architecture/evidence-evaluation-measurement.md#1-evidence).
Esta página es un **índice cruzado por tipo de artefacto** — el contenido real vive en
[`../records/`](../records/), organizado **por tarea** (una carpeta por ticket, con cada
ejecución anidada adentro — ver la nota de convención al final de este archivo).

## Registros

Las ejecuciones que probaron el mecanismo durante la construcción (Direct Context y
Connected Context vía CAP-002/CAP-003) fueron pruebas propias de quien diseñó la
capacidad — se purgaron deliberadamente al pasar a la etapa real de adopción, para no
contar como "evidencia real de uso" algo que no lo era.

| Ejecución | Tarea | Capacidad | Qué documenta |
|---|---|---|---|
| [EXEC-20260924-001](../records/armoa277-1-campos-propios/EXEC-20260924-001/evidence.md) | Portal de Créditos — mismo requerimiento, con el refinamiento reescrito (plugin 0.4.0) | CAP-001 (`user-story`) | Historia de ~40 líneas, criterios verificables y 2 impactos detectados en el código que el pedido no decía. Evaluación `model-assisted` `PARTIAL` (faltó dividir, voseo en el cierre); evaluación humana pendiente |
| [EXEC-20260923-001](../records/armoa277-1-campos-propios/EXEC-20260923-001/evidence.md) | Portal de Créditos — cambio "Detalle Inmueble" → "Campos Propios" / "Localidad" → "Partido" (`ARMOA277-1`, Fase 1) | CAP-001 (`user-story`) | Primera ejecución real del mecanismo de distribución vía Agent Plugin (VS Code/Copilot) — la Skill se invocó en lenguaje natural, sin nombrar ningún ID, y Copilot la reconoció sola. `status: EXECUTED`, evaluación humana pendiente |

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
| [`../docs/history/track-1/pilots/PILOT-001-moa-operaciones-cap005/`](../docs/history/track-1/pilots/PILOT-001-moa-operaciones-cap005/README.md) | CAP-006 (`repository-governance`) | Primer intento de adopción independiente — borrador de `AGENTS.md` para MoaOperaciones (repo real sin ninguna capacidad de IA formalizada). `status: PARTIAL`, no integrado al repo real, pendiente de revisión humana del equipo de MoaOperaciones |

## Cómo generar un registro nuevo

Ver [`../adoption/getting-started.md`](../adoption/getting-started.md) — completar el
Evidence Contract al ejecutar cualquier capacidad de [`../capabilities/`](../capabilities/README.md).
