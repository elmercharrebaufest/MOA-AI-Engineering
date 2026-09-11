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
| [`EXEC-20260908-002.md`](EXEC-20260908-002.md) | CAP-008 (`jira-context`) | Ejecución real del vertical slice Jira → Resolved Context — `status: FAILED` honesto (`BLOCKED`, sin credenciales/MCP disponibles en este entorno), no simulado |
| [`EXEC-20260908-003.md`](EXEC-20260908-003.md) | CAP-007 (`azure-devops-context`) + CAP-002 (`user-story`) | **Primer vertical slice completo de punta a punta**: Work Item real #7 (proyecto "AWS Portal de créditos") → Resolved Context real → CAP-002 real — `status: EXECUTED` |
| [`EXEC-20260908-004.md`](EXEC-20260908-004.md) | CAP-008 (`jira-context`) + CAP-002 (`user-story`) | **Primer vertical slice real de Connected Context vía MCP (Prioridad 1)**: issue real `ARMOA277-191` (tipo Error/Bug, tenant `baufest.atlassian.net`) → Atlassian Rovo MCP `getJiraIssue` → Resolved Context real → CAP-002 real — `status: EXECUTED` |
| [`EXEC-20260908-005.md`](EXEC-20260908-005.md) | CAP-008 (`jira-context`) + CAP-002 (`user-story`) | **Segundo vertical slice real de Connected Context vía MCP (Prioridad 1)**: issue real `ARMOA277-180` (tipo Tarea/Task, sin descripción, mismo tenant) → Atlassian Rovo MCP `getJiraIssue` → Resolved Context real → CAP-002 real — `status: EXECUTED`, demuestra generalización a un tipo de issue distinto |
| [`EXEC-20260909-001.md`](EXEC-20260909-001.md) | CAP-008 (`jira-context`) + CAP-002 (`user-story`) | **Tercer vertical slice real de Connected Context vía MCP (Prioridad 1)**: issue real `ARMOA277-45` (tipo Test/Xray, con descripción, mismo tenant/proyecto) → Atlassian Rovo MCP `getJiraIssue` → Resolved Context real → CAP-002 real — `status: EXECUTED`, tercer tipo de issue distinto probado |

**Ninguno es una ejecución independiente** — todos fueron generados por el
mismo agente que diseñó la capacidad, no por un miembro de un equipo de MOA. Ver el
propio archivo de cada registro para el detalle completo y la clasificación exacta
(`status: EXECUTED`, no `VERIFIED`).

## Pilotos en sandbox (no integrados a ningún repo real)

| Carpeta | Capacidad | Qué documenta |
|---|---|---|
| [`../docs/history/track-1/pilots/PILOT-001-moa-operaciones-cap005/`](../docs/history/track-1/pilots/PILOT-001-moa-operaciones-cap005/README.md) | CAP-005 (`repository-governance`) | Primer intento de adopción independiente — borrador de `AGENTS.md` para MoaOperaciones (repo real sin ninguna capacidad de IA formalizada). `status: PARTIAL`, no integrado al repo real, pendiente de revisión humana del equipo de MoaOperaciones |

## Cómo generar un registro nuevo

Ver [`../adoption/getting-started.md`](../adoption/getting-started.md) — completá el
Evidence Contract al ejecutar cualquier capacidad de [`../capabilities/`](../capabilities/README.md).
