# Registry INDEX

**Mecanismo de Discovery — MVP manual.** No es una base de datos ni un buscador; es un
índice mantenido a mano, agrupado por las preguntas que un equipo nuevo necesita
responder. Se actualiza junto con cada entrada nueva o modificada en `entries/`.

## Todas las entradas

| ID | Nombre | Tipo | Repos | Corporate Standard | Configuration Status | Real Use Status | Riesgo |
|---|---|---|---|---|---|---|---|
| [CAP-001](entries/azure-devops-cli.md) | azure-devops-cli | Skill | Scato Logística, Orquestador | N | VERIFIED | CONFIGURED | Bajo |
| [CAP-002](entries/user-story.md) | user-story | Skill | DataAgro, Scato Logística, Orquestador | N | VERIFIED (2/3) · PARTIAL (DataAgro) | **EXECUTED** (2 dry-runs: G4.4 MOA-1816, G4.6 MOA-1765) | Bajo |
| [CAP-003](entries/dotnet-code-reviewer.md) | .NET Code Reviewer | Agent | Orquestador, Scato Logística | N | VERIFIED | CONFIGURED | Bajo (por diseño) |
| [CAP-004](entries/spec-driven-development.md) | spec-driven-development | Workflow | DataAgro (Lite, real), `moa-sdlc` (Full, sin evidencia de ejecución) | N | VERIFIED | EXECUTED (nivel Lite) / NOT FOUND (nivel Full) | Bajo (Lite) / Medio (Full) |
| [CAP-005](entries/repository-governance.md) | repository-governance | Instruction | DataAgro, Scato Logística, Orquestador, `moa-sdlc` | N | VERIFIED | CONFIGURED | Bajo |
| [CAP-006](entries/stack-best-practices-template.md) | stack-best-practices-template | Skill | Scato Logística, Orquestador | N | VERIFIED | CONFIGURED | Bajo |
| [CAP-007](entries/azure-devops-context.md) | azure-devops-context | Integration/API | Ninguno todavía (patrón de referencia) | N | VERIFIED (documento) | EXECUTED (`EXEC-20260908-003`) | Bajo |
| [CAP-008](entries/jira-context.md) | jira-context | MCP | Ninguno todavía (patrón de referencia) | N | VERIFIED (documento) | EXECUTED (MCP real, `EXEC-20260908-004`, `EXEC-20260908-005`) | Bajo-Medio |

**CAP-007/008** *(nuevas, agregadas al implementar Context Acquisition & Resolution)*: a
diferencia de CAP-001 a CAP-006, no son generalizaciones de una capacidad ya ejecutada por
un equipo — son **patrones nuevos**, extraídos de evidencia real (CAP-001 y el MCP
Atlassian con scope acotado). **Actualización**: CAP-007 tiene 1 ejecución real de punta a
punta (`EXEC-20260908-003`, Azure DevOps) y CAP-008 tiene 3 (`EXEC-20260908-002` BLOCKED
vía REST, `EXEC-20260908-004` SUCCESS vía MCP real sobre un issue tipo Error/Bug,
`EXEC-20260908-005` SUCCESS vía MCP real sobre un issue tipo Tarea/Task) — existe
evidencia inicial de generalización a dos tipos de issue reales con diferente nivel de
completitud de información, pero ninguna de las dos capabilities alcanza `VERIFIED` (sin
evaluación humana independiente todavía). `Action Type: READ` en ambas,
sin excepción — ver
[`../architecture/context-acquisition-resolution.md`](../architecture/context-acquisition-resolution.md)
y [`../security/security-governance.md`](../security/security-governance.md) §1.5.

**CAP-004/005/006**: materializadas como capacidades reutilizables generalizadas en
[`../capabilities/`](../capabilities/README.md) — ver
[`../docs/history/track-1/G5.1-Reusable-Capability-Library.md`](../docs/history/track-1/G5.1-Reusable-Capability-Library.md)
para el proceso completo de evaluación (Existing Practice + External Best Practice +
Architectural Judgment → Decisión) que llevó a esta selección, y por qué otros
candidatos inspeccionados
(`dotnet-best-practices` como contenido, `abm-mvc`, `afip-cpe-ctg`/`afip-integration`, y
la mayoría de los agentes por rol de DataAgro/Scato Logística) **no** se materializaron
acá — quedaron clasificados TEAM-SPECIFIC o EXPERIMENTAL, con su razón documentada.

**Escala de `Real Use Status`** (unificada en G4.5): `NOT FOUND` (sin evidencia de que exista) → `CONFIGURED` (existe, bien formado, cero ejecuciones) → `EXECUTED` (al menos 1 ejecución real registrada, no necesariamente independiente) → `VERIFIED` (ejecución independiente + evaluación humana confirmadas — **ninguna entrada llegó a este nivel todavía**).

## Por tipo

- **Skill**: CAP-001, CAP-002, CAP-006
- **Agent**: CAP-003
- **Workflow**: CAP-004
- **Instruction**: CAP-005
- **Integration/API**: CAP-007 (patrón, READ-only, 1 ejecución real de punta a punta — `EXEC-20260908-003`)
- **MCP**: CAP-008 (patrón, READ-only, scope acotado, 3 ejecuciones reales — `EXEC-20260908-002` BLOCKED, `EXEC-20260908-004` SUCCESS sobre issue tipo Error/Bug, `EXEC-20260908-005` SUCCESS sobre issue tipo Tarea/Task, ambas vía Atlassian Rovo MCP real) — el servidor MCP invocado es real (Atlassian Rovo, hosted), no significa que MOA haya desplegado un servidor MCP propio
- **Knowledge/RAG**: sin entradas todavía (ver
  [`../docs/history/track-1/relevamiento-capacidades-g2.md`](../docs/history/track-1/relevamiento-capacidades-g2.md)
  para evidencia adicional no registrada aún)

## Por equipo (`Team`)

- **DataAgro**: CAP-002 (Configuration Status: PARTIAL — contenido no leído completo),
  CAP-004 (Lite, real), CAP-005
- **Scato Logística**: CAP-001, CAP-002, CAP-003, CAP-005, CAP-006
- **Orquestador**: CAP-001, CAP-002, CAP-003, CAP-005, CAP-006 — todas en rama
  `master-logistica`, ninguna en `master`
- **`moa-sdlc`** (herramienta de referencia de Baufest, no equipo de MOA): CAP-004 (Full,
  sin evidencia de ejecución), CAP-005

## ¿Puedo adoptarla?

Ninguna de las 6 entradas está promovida a Corporate Standard. Las entradas pueden
corresponder a capacidades reutilizables, patrones reutilizables, candidatos a Common
Core o activos Team-Specific según su clasificación individual — `Corporate Standard: N`
no implica por sí mismo que una entrada sea Team-Specific (ver la clasificación propia de
cada entrada: CAP-001/002 Reusable Capability, CAP-003/004/006 Reusable Pattern, CAP-005
Reusable Governance Pattern / Common Core Candidate — ninguna es Team-Specific en sentido
estricto, todas son candidatas evaluadas). Cualquier equipo puede consultarlas y
adaptarlas por su cuenta (autonomía de equipo), pero **ninguna está todavía promovida
como estándar corporativo** — adoptarlas hoy es replicar/adaptar un patrón con evidencia
real, no consumir un Common Core ya aprobado por gobierno.

## ¿Necesitan adaptación?

- CAP-001 (`azure-devops-cli`): las 2 versiones existentes están muy cerca de ser
  idénticas — requiere reconciliación menor, no reescritura.
- CAP-002 (`user-story`): estructura común, contenido/ejemplos 100% específicos de cada
  dominio — requiere adaptación real del contenido, no solo reconciliación.
- CAP-003 (`.NET Code Reviewer`): el patrón de diseño es reusable; el contenido de reglas
  es específico de .NET Framework 4.7.2 — requiere adaptación si se aplica a otro stack.
- CAP-004 (`spec-driven-development`): el nivel Lite es adoptable con poca fricción
  (requiere un sistema de tickets real); el nivel Full requiere una decisión explícita de
  invertir en mantener contratos JSON y una máquina de estados — no adoptar por defecto.
- CAP-005 (`repository-governance`): la estructura de 3 columnas (ALWAYS/ASK FIRST/NEVER)
  es Common Core; el contenido de cada columna es 100% específico del equipo — requiere
  completarse desde cero, no copiarse.
- CAP-006 (`stack-best-practices-template`): plantilla de 8 secciones sin contenido —
  requiere que el equipo la complete con las reglas reales de su stack.

## ¿Qué evidencia tienen?

Ver cada entrada individual — todas fueron verificadas por lectura directa de archivo real
(no inferidas por nombre), con fuente citada (commit hash, autor, fecha donde aplica).

## Corrección respecto a G4.2 — el "formato de 4 capas" ahora SÍ está registrado

G4.2 había evaluado el formato de 4 capas (`copilot-instructions.md`+`instructions/`+
`skills/`+`agents/`) y decidido **no registrarlo**, por no encajar limpiamente en la
taxonomía de 7 tipos y por alcance deliberado del MVP ("2 o 3 entradas como máximo"). En
G5.1, con evidencia de 4 instancias independientes (DataAgro, Scato Logística,
Orquestador, `moa-sdlc`) y el campo `Type: Instruction` de `capability-model.md` como
encaje correcto (es una regla que se aplica siempre, no un Standard aparte), se
**reconsidera esa decisión** y se registra como **CAP-005**. Se documenta el cambio
explícitamente, en vez de dejar la afirmación anterior sin corregir.

## Qué sigue sin estar en este INDEX (evaluado y descartado, no ausente por omisión)

- **`dotnet-best-practices` (contenido real)**, **`abm-mvc`**, **`afip-cpe-ctg`** /
  `afip-integration`, y la mayoría de los agentes por rol de DataAgro/Scato Logística
  (`architect`, `dba-migraciones`, `kendo-grid-builder`, `product-owner`, `qa-tester`,
  `release-manager`, `database-migration`, `devops`, `domain-validation-engineer`,
  `frontend-engineer`, `test-engineer`, `wf-activity-refactor`, `workflow-designer`,
  `xamlx-documenter`): inspeccionados en G5.1, clasificados **TEAM-SPECIFIC** o
  **EXPERIMENTAL** — no registrados como capability reusable porque su contenido no es
  portable entre equipos. Ver
  [`../docs/history/track-1/G5.1-Reusable-Capability-Library.md`](../docs/history/track-1/G5.1-Reusable-Capability-Library.md),
  tabla de clasificación completa, para la razón de cada uno.
- Otras capacidades de DataAgro/Scato Logística/Orquestador relevadas sin inspección
  profunda todavía: ver
  [`../docs/history/track-1/relevamiento-capacidades-g2.md`](../docs/history/track-1/relevamiento-capacidades-g2.md)
  para el listado completo no incorporado aún al Registry.
