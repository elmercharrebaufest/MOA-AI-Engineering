# Evidence

Registros reales de ejecuciones de capacidades — el esquema completo (Evidence Contract)
vive en [`../architecture/evidence-evaluation-measurement.md`](../architecture/evidence-evaluation-measurement.md#1-evidence).
Esta página es un **índice cruzado por tipo de artefacto** — el contenido real vive en
[`../records/`](../records/), organizado **por tarea** (una carpeta por ticket, con cada
ejecución anidada adentro — ver la nota de convención al final de este archivo).

## Registros

| Ejecución | Tarea | Capacidad | Qué documenta |
|---|---|---|---|
| [`EXEC-20260907-001`](../records/jira-MOA-1816/EXEC-20260907-001/evidence.md) | MOA-1816 | CAP-002 (`user-story`) | CONTROLLED DRY-RUN sobre MOA-1816 (DataAgro) |
| [`EXEC-20260908-001`](../records/jira-MOA-1765/EXEC-20260908-001/evidence.md) | MOA-1765 | CAP-002 (`user-story`) | CONTROLLED DRY-RUN sobre MOA-1765 (DataAgro) |
| [`current-moa-ai-practices-benchmark.md`](current-moa-ai-practices-benchmark.md) | — | Todas (benchmark, no una ejecución) | Benchmark de prácticas reales de AI Engineering en 6 repos de MOA (DataAgro, Scato Logística, Orquestador, MoaOperaciones, ScatoPuerto, moa-sdlc) — entrada de evidencia para decisión arquitectónica, no propuesta final |
| [`EXEC-20260908-002`](../records/jira-MOA-1234/EXEC-20260908-002/evidence.md) | MOA-1234 (referencia de prueba, no real) | CAP-008 (`jira-context`) | Ejecución real del vertical slice Jira → Resolved Context — `status: FAILED` honesto (`BLOCKED`, sin credenciales/MCP disponibles en este entorno), no simulado |
| [`EXEC-20260908-003`](../records/ado-7/EXEC-20260908-003/evidence.md) | ADO Work Item #7 | CAP-007 (`azure-devops-context`) + CAP-002 (`user-story`) | **Primer vertical slice completo de punta a punta**: Work Item real #7 (proyecto "AWS Portal de créditos") → Resolved Context real → CAP-002 real — `status: EXECUTED` |
| [`EXEC-20260908-004`](../records/jira-ARMOA277-191/EXEC-20260908-004/evidence.md) | ARMOA277-191 | CAP-008 (`jira-context`) + CAP-002 (`user-story`) | **Primer vertical slice real de Connected Context vía MCP (Prioridad 1)**: issue real `ARMOA277-191` (tipo Error/Bug, tenant `baufest.atlassian.net`) → Atlassian Rovo MCP `getJiraIssue` → Resolved Context real → CAP-002 real — `status: EXECUTED` |
| [`EXEC-20260908-005`](../records/jira-ARMOA277-180/EXEC-20260908-005/evidence.md) | ARMOA277-180 | CAP-008 (`jira-context`) + CAP-002 (`user-story`) | **Segundo vertical slice real de Connected Context vía MCP (Prioridad 1)**: issue real `ARMOA277-180` (tipo Tarea/Task, sin descripción, mismo tenant) → Atlassian Rovo MCP `getJiraIssue` → Resolved Context real → CAP-002 real — `status: EXECUTED`, demuestra generalización a un tipo de issue distinto |
| [`EXEC-20260909-001`](../records/jira-ARMOA277-45/EXEC-20260909-001/evidence.md) | ARMOA277-45 | CAP-008 (`jira-context`) + CAP-002 (`user-story`) | **Tercer vertical slice real de Connected Context vía MCP (Prioridad 1), primera con actor independiente (`PILOT-003`)**: issue real `ARMOA277-45` (tipo Test/Xray, con descripción, mismo tenant/proyecto) → Atlassian Rovo MCP `getJiraIssue` → Resolved Context real → CAP-002 real — `status: EXECUTED`, tercer tipo de issue distinto probado |

**Ninguno es una evaluación independiente todavía** (la ejecución de `EXEC-20260909-001` sí
tuvo un actor independiente — ver arriba; su evaluación sigue siendo `model-assisted`,
ejes distintos). El resto de las ejecuciones fueron generadas por el mismo agente que
diseñó la capacidad. Ver el propio archivo de cada registro para el detalle completo y la
clasificación exacta (`status: EXECUTED`, no `VERIFIED`).

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
