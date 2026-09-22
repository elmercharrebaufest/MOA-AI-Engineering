# Registry INDEX

**Mecanismo de Discovery — MVP manual.** No es una base de datos ni un buscador; es un
índice mantenido a mano, agrupado por las preguntas que un equipo nuevo necesita
responder. Se actualiza junto con cada entrada nueva o modificada en `entries/`.

## Escala de `Real Use Status` (leer antes de la tabla)

`NOT FOUND` (sin evidencia de que exista) → `CONFIGURED` (existe, bien formado, cero
ejecuciones) → `EXECUTED` (al menos 1 ejecución real registrada, no necesariamente
independiente) → `VERIFIED` (ejecución independiente + evaluación humana confirmadas —
**ninguna entrada llegó a este nivel todavía**). Ver detalle unificado en G4.5 más abajo.

## Todas las entradas

| ID | Nombre | Tipo | Repos | Corporate Standard | Configuration Status | Real Use Status | Riesgo |
|---|---|---|---|---|---|---|---|
| [CAP-001](entries/user-story.md) | user-story | Skill | DataAgro, Scato Logística, Orquestador | N | VERIFIED (2/3) · PARTIAL (DataAgro) | **CONFIGURED** — mecanismo probado durante la construcción (pruebas purgadas al pasar a adopción real); sin ejecuciones reales registradas todavía, evidencia real en curso sobre `ARMOA277-194` | Bajo |
| [CAP-002](entries/azure-devops-context.md) | azure-devops-context | Integration/API | Ninguno todavía (patrón de referencia) | N | VERIFIED (documento) | CONFIGURED — mecanismo probado durante la construcción, pruebas purgadas; sin ejecuciones reales registradas todavía | Bajo |
| [CAP-003](entries/jira-context.md) | jira-context | MCP | Ninguno todavía (patrón de referencia) | N | VERIFIED (documento) | CONFIGURED — mecanismo probado durante la construcción (MCP real, incluido 1 caso `BLOCKED` histórico), pruebas purgadas; sin ejecuciones reales registradas todavía, evidencia real en curso sobre `ARMOA277-194` | Bajo-Medio |
| [CAP-004](entries/product-owner.md) | product-owner | Agent | Ninguno todavía (propuesta, corrige un hallazgo real de Scato Logística/Orquestador) | N | VERIFIED (documento) | CONFIGURED — documentada, cero ejecuciones reales | Bajo |
| [CAP-005](entries/spec-driven-development.md) | spec-driven-development | Workflow | DataAgro (Lite y Full — ver corrección 2026-09-22) | N | VERIFIED (ambos niveles) | EXECUTED (nivel Lite, 2 tickets reales). Nivel Full: **CONFIGURED con origen real** (`moa-sdlc`, en uso por DataAgro), sin ticket confirmado que haya completado el ciclo hasta `done` | Bajo (Lite) / Medio (Full) |
| [CAP-006](entries/repository-governance.md) | repository-governance | Instruction | DataAgro, Scato Logística, Orquestador | N | VERIFIED | CONFIGURED | Bajo |
| [CAP-007](entries/spec-review.md) | spec-review | Skill | Ninguno todavía (propuesta, evidencia externa Camuzzi/Baufest) | N | VERIFIED (documento) | CONFIGURED — documentada, cero ejecuciones reales | Bajo |
| [CAP-008](entries/azure-devops-cli.md) | azure-devops-cli | Skill | Scato Logística, Orquestador | N | VERIFIED | CONFIGURED | Bajo |
| [CAP-009](entries/git-worktree-setup.md) | git-worktree-setup | Agent | Ninguno todavía (propuesta, evidencia externa Camuzzi/Baufest) | N | VERIFIED (documento) | CONFIGURED — documentada, cero ejecuciones reales | Bajo |
| [CAP-010](entries/ticket-kickoff.md) | ticket-kickoff | Agent (orquestador) | Ninguno todavía (propuesta, evidencia externa Camuzzi/Baufest) | N | VERIFIED (documento) | CONFIGURED — documentada, cero ejecuciones reales | **Medio — la más alta del Registry** (primer `edit` real sobre código, acotado por 2 checkpoints humanos) |
| [CAP-011](entries/pr-description.md) | pr-description | Skill | Ninguno todavía (propuesta) | N | VERIFIED (documento) | CONFIGURED — documentada, cero ejecuciones reales | Bajo |
| [CAP-012](entries/dotnet-code-reviewer.md) | .NET Code Reviewer | Agent | Orquestador, Scato Logística | N | VERIFIED | CONFIGURED | Bajo (por diseño) |
| [CAP-013](entries/stack-best-practices-template.md) | stack-best-practices-template | Skill | Scato Logística, Orquestador | N | VERIFIED | CONFIGURED | Bajo |
| [CAP-014](entries/test-case-generation.md) | test-case-generation | Skill | Ninguno todavía (propuesta) | N | VERIFIED (documento) | CONFIGURED — documentada, cero ejecuciones reales | Bajo |
| [CAP-015](entries/regression-test-generation.md) | regression-test-generation | Skill | Ninguno todavía (propuesta, evidencia externa Camuzzi/Baufest) | N | VERIFIED (documento) | CONFIGURED — documentada, cero ejecuciones reales | Bajo |
| [CAP-016](entries/ticket-closure-assist.md) | ticket-closure-assist | Skill | Ninguno todavía (propuesta) | N | VERIFIED (documento) | CONFIGURED — documentada, cero ejecuciones reales | Bajo |
| [CAP-017](entries/production-incident-investigation.md) | production-incident-investigation | Agent | Ninguno todavía (propuesta, evidencia externa Camuzzi/Baufest) | N | VERIFIED (documento) | CONFIGURED — documentada, cero ejecuciones reales | Bajo (por diseño, sin `edit`) |
| [CAP-018](entries/spec-reader.md) | spec-reader | Agent | Ninguno todavía (propuesta, evidencia externa Camuzzi/Baufest) | N | VERIFIED (documento) | CONFIGURED — documentada, cero ejecuciones reales | Bajo (por diseño, sin `edit`) |
| [CAP-019](entries/workflow-documenter.md) | workflow-documenter | Agent | Ninguno todavía (propuesta, generalizada de Scato Logística — **opt-in, solo proyectos con WF4.5**) | N | VERIFIED (documento) | CONFIGURED — documentada, cero ejecuciones reales de la versión generalizada (la instancia de origen sí tiene ejecución real) | Bajo |
| [CAP-020](entries/dotnet-modernization-guide.md) | dotnet-modernization-guide | Skill | Ninguno todavía (propuesta — guía sobre el agente oficial de Microsoft, no herramienta propia) | N | VERIFIED (documento) | CONFIGURED — documentada, cero ejecuciones reales | Bajo |
| [CAP-021](entries/sprint-batch-analysis.md) | sprint-batch-analysis | Skill | Ninguno todavía (propuesta, evidencia externa Camuzzi/Baufest, corrige comportamiento de escritura del original) | N | VERIFIED (documento) | CONFIGURED — documentada, cero ejecuciones reales | Bajo |
| [CAP-022](entries/documentation-style.md) | documentation-style | Instruction | Ninguno todavía (regla nacida de una corrección real dentro de esta misma iniciativa, no de un repo de equipo de MOA ni de un cliente externo) | N | VERIFIED (documento) | CONFIGURED — ya aplicada de forma retroactiva sobre este repositorio, sin adopción externa todavía | Bajo |

**CAP-022** *(nueva, 2026-09-22)*: a diferencia de CAP-006 (convergencia de 3 repos de
equipo) y de las propuestas con evidencia externa de Camuzzi, nace de una corrección real
y repetida detectada dentro de esta misma iniciativa (voseo argentino y contenido extenso
sin valor real en versiones tempranas de esta documentación) — se formaliza como
Instruction para que la regla se aplique siempre, no solo mientras se recuerde
explícitamente. Ver [`entries/documentation-style.md`](entries/documentation-style.md).

**CAP-004, CAP-011, CAP-014, CAP-016** *(cobertura de las 11 etapas del KO, 2026-09-18)*: a
diferencia de todas las entradas anteriores, no son generalizaciones de una instancia real
(CAP-001, CAP-005, CAP-006, CAP-008, CAP-012, CAP-013) ni patrones extraídos de evidencia
real (CAP-002/003) — son **propuestas directas**, justificadas por KO Interno + External
Best Practice + Architectural Judgment, sin ejecución real ni piloto de ningún equipo
todavía. Cierran las etapas del KO que hasta ahora no tenían ni capacidad ni propuesta
(Apertura del PR, Testing funcional/QA, Cierre del ticket) y corrigen un hallazgo de
seguridad real (scope MCP wildcard del `product-owner` de Scato Logística/Orquestador).

**CAP-007, CAP-009, CAP-010, CAP-015, CAP-017, CAP-018** *(nuevas, 2026-09-21, evidencia
externa de un cliente de Baufest — Camuzzi, no un equipo de MOA; CAP-018 agregada en la
revisión de fidelidad, mismo día, tras leer el contenido completo)*: mismo tratamiento —
`PROPOSAL`, nunca `Corporate Standard`. Fortalecen el Golden Path #2 con un orquestador
real (`ticket-kickoff` + su subagente `git-worktree-setup`), y un auditor (`spec-review`)
más un consultor de solo lectura (`spec-reader`) de specs, y cierran, de forma acotada y
deliberadamente parcial, las 2 etapas que quedaron sin propuesta el 2026-09-18: Test de
regresión (`regression-test-generation`, solo generación de código, sin ejecución en
pipeline) y Soporte productivo (`production-incident-investigation`, solo 1 de las 5 líneas
del KO). Ver [`../architecture/ai-sdlc.md`](../architecture/ai-sdlc.md) para el mapeo
completo contra las 11 etapas.

**CAP-002/003** *(nuevas, agregadas al implementar Context Acquisition & Resolution)*: a
diferencia de CAP-001, CAP-005, CAP-006, CAP-008, CAP-012, CAP-013, no son generalizaciones de una capacidad ya ejecutada por
un equipo — son **patrones nuevos**, extraídos de evidencia real (CAP-008 y el MCP
Atlassian con scope acotado). El mecanismo de ambos quedó probado de punta a punta durante
la construcción — esas pruebas se purgaron al pasar a adopción real, para no contar como
"evidencia real de uso" algo ejecutado por quien diseñó el propio patrón. `Action Type:
READ` en ambas, sin excepción — ver
[`../architecture/context-acquisition-resolution.md`](../architecture/context-acquisition-resolution.md)
y [`../security/security-governance.md`](../security/security-governance.md) §1.5.

**CAP-005/006/013**: materializadas como capacidades reutilizables generalizadas en
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

- **Skill**: CAP-001, CAP-007, CAP-008, CAP-011, CAP-013, CAP-014, CAP-015, CAP-016, CAP-020, CAP-021
- **Agent**: CAP-004, CAP-009, CAP-010 (orquestador), CAP-012, CAP-017, CAP-018, CAP-019 (opt-in, solo WF4.5)
- **Workflow**: CAP-005
- **Instruction**: CAP-006, CAP-022
- **Integration/API**: CAP-002 (patrón, READ-only, mecanismo probado durante la construcción, sin ejecuciones reales registradas todavía)
- **MCP**: CAP-003 (patrón, READ-only, scope acotado, mecanismo probado durante la construcción vía Atlassian Rovo MCP real — pruebas purgadas al pasar a adopción real; el servidor MCP invocado es real (Atlassian Rovo, hosted), no significa que MOA haya desplegado un servidor MCP propio)
- **Knowledge/RAG**: sin entradas todavía (ver
  [`../docs/history/track-1/relevamiento-capacidades-g2.md`](../docs/history/track-1/relevamiento-capacidades-g2.md)
  para evidencia adicional no registrada aún)

## Por equipo (`Team`)

- **DataAgro**: CAP-001 (Configuration Status: PARTIAL — contenido no leído completo),
  CAP-005 (Lite, real), CAP-006
- **Scato Logística**: CAP-008, CAP-001, CAP-012, CAP-006, CAP-013, CAP-019 (origen; propuesta opt-in, no adoptada todavía en su forma generalizada)
- **Orquestador**: CAP-008, CAP-001, CAP-012, CAP-006, CAP-013 — todas en rama
  `master-logistica`, ninguna en `master`
- **Ninguno todavía**: CAP-005 (nivel Full, conceptual), CAP-004, CAP-007, CAP-009 a
  CAP-011, CAP-014 a CAP-019 — propuestas sin adopción real (CAP-004, CAP-011, CAP-014,
  CAP-016 con evidencia externa mixta KO/comunidad; CAP-007, CAP-009, CAP-010, CAP-015,
  CAP-017, CAP-018 con evidencia externa de un cliente de Baufest — Camuzzi, no un equipo
  de MOA; **CAP-019 generalizada de Scato Logística, opt-in, solo para proyectos con
  WF4.5**)

## ¿Puedo adoptarla?

Ninguna de las 22 entradas del Registry está promovida a Corporate Standard. Las entradas pueden
corresponder a capacidades reutilizables, patrones reutilizables, candidatos a Common
Core, propuestas nuevas sin evidencia de origen, o activos Team-Specific según su
clasificación individual — `Corporate Standard: N`
no implica por sí mismo que una entrada sea Team-Specific (ver la clasificación propia de
cada entrada: CAP-001/008 Reusable Capability, CAP-005/012/013 Reusable Pattern, CAP-006
Reusable Governance Pattern / Common Core Candidate, CAP-002/003 Context Acquisition
Pattern, y las 10 propuestas nuevas sin evidencia de un equipo de MOA (CAP-004, CAP-007,
CAP-009 a CAP-011, CAP-014 a CAP-018), más CAP-019 (generalizada de un equipo real de
MOA — Scato Logística — pero deliberadamente opt-in, no transversal) y CAP-022 (regla
nacida de una corrección real dentro de esta misma iniciativa) — ninguna es
Team-Specific en sentido estricto, todas son candidatas evaluadas). Cualquier equipo puede consultarlas y
adaptarlas por su cuenta (autonomía de equipo), pero **ninguna está todavía promovida
como estándar corporativo** — adoptarlas hoy es replicar/adaptar un patrón con evidencia
real, no consumir un Common Core ya aprobado por gobierno.

## ¿Necesitan adaptación?

- CAP-008 (`azure-devops-cli`): las 2 versiones existentes están muy cerca de ser
  idénticas — requiere reconciliación menor, no reescritura.
- CAP-001 (`user-story`): estructura común, contenido/ejemplos 100% específicos de cada
  dominio — requiere adaptación real del contenido, no solo reconciliación.
- CAP-012 (`.NET Code Reviewer`): el patrón de diseño es reusable; el contenido de reglas
  es específico de .NET Framework 4.7.2 — requiere adaptación si se aplica a otro stack.
- CAP-005 (`spec-driven-development`): el nivel Lite es adoptable con poca fricción
  (requiere un sistema de tickets real); el nivel Full requiere una decisión explícita de
  invertir en mantener contratos JSON y una máquina de estados — no adoptar por defecto.
- CAP-006 (`repository-governance`): la estructura de 3 columnas (ALWAYS/ASK FIRST/NEVER)
  es Common Core; el contenido de cada columna es 100% específico del equipo — requiere
  completarse desde cero, no copiarse.
- CAP-013 (`stack-best-practices-template`): plantilla de 8 secciones sin contenido —
  requiere que el equipo la complete con las reglas reales de su stack.

## ¿Qué evidencia tienen?

Ver cada entrada individual — todas fueron verificadas por lectura directa de archivo real
(no inferidas por nombre), con fuente citada (commit hash, autor, fecha donde aplica).

## Corrección respecto a G4.2 — el "formato de 4 capas" ahora SÍ está registrado

G4.2 había evaluado el formato de 4 capas (`copilot-instructions.md`+`instructions/`+
`skills/`+`agents/`) y decidido **no registrarlo**, por no encajar limpiamente en la
taxonomía de 7 tipos y por alcance deliberado del MVP ("2 o 3 entradas como máximo"). En
G5.1, con evidencia de 3 instancias independientes (DataAgro, Scato Logística,
Orquestador) y el campo `Type: Instruction` de `capability-model.md` como
encaje correcto (es una regla que se aplica siempre, no un Standard aparte), se
**reconsidera esa decisión** y se registra como **CAP-006**. Se documenta el cambio
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
