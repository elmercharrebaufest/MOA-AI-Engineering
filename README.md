# MOA-AI-Engineering

**Common AI Engineering Foundation for MOA (Molinos Agro)**

Este repositorio es la base central y reutilizable de AI Engineering para MOA. Establece
estrategia, arquitectura de referencia, patrones, gobierno, métricas y mecanismos de
adopción de IA aplicados al SDLC y a las actividades de ingeniería.

> **No es un repositorio monolítico.** MOA-AI-Engineering establece la base común; cada
> equipo decide qué adoptar, adaptar o no utilizar según sus necesidades, manteniendo los
> principios y controles corporativos.

## Origen y alcance

Este repositorio implementa el **Track 1** de la iniciativa de Estrategia de IA de MOA:

> "Evolucionar la Productividad de los Servicios Actuales"

Fuente primaria: *BAUFEST - Escalando el Valor del Delivery Mediante IA Aplicada (KO
Interno)* — deck de kick-off interno (29 páginas), leído y utilizado como fuente principal
para todo el contenido de este repositorio. Todo el contenido está clasificado como:

- **FACT** — respaldado explícitamente por el KO o por un repositorio existente.
- **INFERENCE** — deducción razonable a partir de hechos disponibles.
- **PROPOSAL** — propuesta del arquitecto, no es decisión oficial de MOA.
- **EXTERNAL EVIDENCE** — buena práctica o benchmark externo a MOA.
- **REQUIRES VALIDATION** — información faltante o decisión pendiente de MOA.

> Ninguna capacidad existente en un equipo (ej. un `AGENTS.md`, un skill, un agente) se
> considera automáticamente un estándar reutilizable solo por estar documentada como FACT.
> Debe pasar por el pipeline de assessment (ver [`assessment/README.md`](assessment/README.md))
> antes de proponerse como capacidad REUSABLE.

## Para quién es esto

Cualquier equipo de MOA (DataAgro, Scato Logística, Scato Puerto, MOA Operaciones,
Orquestador, u otro futuro) que quiera incorporar IA en su SDLC de forma sistemática en
vez de improvisada — desarrolladores, POs y QA. No reemplaza el trabajo del equipo: es
algo que se **consume y adapta**, no un framework obligatorio idéntico para todos.

## Cómo adoptar

Punto de entrada práctico: [`adoption/README.md`](adoption/README.md) →
[`adoption/getting-started.md`](adoption/getting-started.md) (6 pasos: entender, descubrir,
evaluar, adoptar/adaptar + generar evidencia, evaluar el resultado, medir).

## Estado actual (G5.1 — Reusable Capability Library)

**READY FOR DELIVERY WITH CONDITIONS** — ver
[`G5-Track-1-Finalization-and-Delivery-Readiness.md`](docs/architecture/G5-Track-1-Finalization-and-Delivery-Readiness.md)
y [`G5.1-Reusable-Capability-Library.md`](docs/architecture/G5.1-Reusable-Capability-Library.md)
para el detalle completo. Resumen:

- **Construido y consistente**: Common Core, Team Adaptation, Capability Model, Capability
  Registry (6 capacidades reales, 3 nuevas en G5.1), **una biblioteca reusable real**
  ([`capabilities/`](capabilities/README.md): 3 Skills, 1 Agent, 1 Instruction, 1
  Workflow, cada una generalizada de evidencia real, no copiada), 1 Golden Path con 2
  ejecuciones reales + 2 Golden Paths fortalecidos con capacidades nuevas, contratos de
  Evidence/Evaluation/Measurement, Adoption Kit, Contribution Model, Governance con 12
  decisiones explícitamente bloqueadas (no ocultas — 1 nueva en G5.1, sobre validación de
  certificado SSL en una integración AFIP real).
- **Validado en controlled dry-run** *(no "pilotos reales" — corregido en G5.2)*: el
  flujo puede ejecutarse técnicamente sobre requerimientos reales y generar evidencia/
  hallazgos útiles. Concretamente: 2 controlled dry-runs (`EXEC-20260907-001`,
  `EXEC-20260908-001`), ambos sobre requerimientos reales de DataAgro (MOA-1816,
  MOA-1765), con ejecución técnica real, evidencia generada, evaluación
  `model-assisted` (no humana independiente), y análisis de gaps genuinos (verificables,
  no inventados). `Real Use Status: EXECUTED` en el Registry — **no** `VERIFIED`: no hubo
  evaluación humana independiente, no existe baseline cuantitativo, no existe medición
  comparativa de valor.
- **No validado todavía — pendiente, no bloqueante**: adopción independiente real (las 2
  ejecuciones existentes fueron hechas por el mismo agente que diseñó el modelo, no por
  un miembro de un equipo de MOA), feedback humano real, y cualquier medición de impacto
  con baseline. Ver sección "Real Adoption Status" del documento G5 — es trabajo posterior
  a esta entrega, con un plan ya definido para ejecutarlo.

## Estructura

```
MOA-AI-Engineering/
├── strategy/          Visión, principios, modelo de madurez, roadmap
├── architecture/       **Histórica/superseded** (fase G1) — ver docs/architecture/ para
│                       la arquitectura canónica vigente. Se conserva por contenido FACT
│                       todavía válido (stack del KO), no por ser la referencia actual
├── governance/         Gobierno corporativo de IA y de agentes
├── integrations/        Catálogo de integraciones (existentes/propuestas)
├── metrics/            Framework de métricas e indicadores (KPIs)
├── use-cases/          Catálogo de casos de uso por etapa del SDLC
├── teams/              Modelo de adopción por equipo y referencias a implementaciones
├── assessment/          Relevamiento de capacidades reales por equipo + pipeline de
│                       evaluación (problema→caso de uso→capacidad→piloto→medición→
│                       gobierno) antes de promover cualquier capacidad a REUSABLE
├── templates/           Plantillas para nuevas capacidades reutilizables
├── docs/architecture/    Especificación arquitectónica G3.3-G4.5 — Reference Architecture,
│                       Operating Model, Capability Model, Lifecycle, Assessment Gate,
│                       Capability Registry, Security & Governance, Evaluation &
│                       Observability, Golden Paths, Product Architecture Baseline,
│                       Registry MVP, Evidence/Evaluation/Measurement, Real Adoption
│                       Pilot, Product Hardening, Independent Adoption & Validation,
│                       Track 1 Finalization, Reusable Capability Library. **Arquitectura
│                       canónica vigente — documento de entrada**:
│                       docs/architecture/reference-architecture.md (no confundir con
│                       architecture/reference-architecture.md, histórica/superseded)
├── registry/            Capability Registry operativo — README, INDEX (discovery) y
│                       entries/ (6 capacidades reales con evidencia, ninguna todavía
│                       Corporate Standard)
├── capabilities/         Biblioteca reusable (G5.1) — Skills/Agents/Instructions/
│                       Workflows generalizados, listos para adoptar/adaptar, + guía de
│                       Best Practices. Punto de entrada: capabilities/README.md
├── adoption/            Adoption Kit — guía práctica para que un equipo nuevo empiece,
│                       adapte y contribuya sin depender permanentemente del arquitecto.
│                       Punto de entrada: adoption/README.md
├── evidence/            Evidence Records reales de ejecuciones de capacidades (schema:
│                       docs/architecture/G4.3-Evidence-Evaluation-Measurement.md)
├── evaluation/           Evaluation Records reales — resultado de aplicar el Evaluation
│                       Contract a una evidencia concreta
└── measurements/         Measurement Results reales — incluye resultados NOT MEASURED
                        explícitamente justificados, no solo mediciones exitosas
```

**Corrección respecto a G4.5**: `capabilities/` se había diferido hasta que existiera al
menos 1 capacidad `Corporate Standard: Y` — G5.1 revisó esa condición: `capabilities/` no
requiere `Corporate Standard: Y`, requiere **evidencia real + evaluación explícita**
(Existing Practice + External Best Practice + Architectural Judgment → Decisión), que ya
existe para 6 capacidades — ver
[`capabilities/README.md`](capabilities/README.md) y
`docs/architecture/G5.1-Reusable-Capability-Library.md`. Ninguna es todavía Corporate
Standard; la carpeta documenta candidatas evaluadas, no estándares impuestos.
`golden-paths/` (como carpeta dedicada, hoy es un único archivo en `docs/architecture/`)
sigue diferida hasta que exista un segundo Golden Path con evidencia real, no conceptual.
`enablement/` y `integrations/mcp/` (con contenido operativo) se incorporarán en fases
posteriores, cuando existan casos concretos que los justifiquen — MCP en particular
**no se implementa** por decisión explícita de alcance, pese a 2 hallazgos reales
documentados en G5.1 (ver `docs/architecture/security-governance.md`)
(ver principio "Start small and scale progressively").

### Fases y documentos (`docs/architecture/`)

| Fase | Documento | Qué produjo |
|---|---|---|
| G3.3 | [`reference-architecture.md`](docs/architecture/reference-architecture.md) | Arquitectura de referencia (documento de entrada) |
| G4.1 | [`G4.1-Product-Architecture-Baseline.md`](docs/architecture/G4.1-Product-Architecture-Baseline.md) | Baseline de producto |
| G4.2 | [`G4.2-Registry-MVP-and-Golden-Path.md`](docs/architecture/G4.2-Registry-MVP-and-Golden-Path.md) | Registry MVP + primer Golden Path |
| G4.3 | [`G4.3-Evidence-Evaluation-Measurement.md`](docs/architecture/G4.3-Evidence-Evaluation-Measurement.md) | Contratos de Evidence/Evaluation/Measurement |
| G4.4 | [`G4.4-Real-Adoption-Pilot.md`](docs/architecture/G4.4-Real-Adoption-Pilot.md) | Primer controlled dry-run (no piloto real independiente) |
| G4.5 | [`G4.5-Product-Hardening-and-Adoption-Model.md`](docs/architecture/G4.5-Product-Hardening-and-Adoption-Model.md) | Adoption Kit, Golden Path endurecido, Contribution Model |
| G4.6 | [`G4.6-Independent-Adoption-and-Validation.md`](docs/architecture/G4.6-Independent-Adoption-and-Validation.md) | Segundo controlled dry-run, Independence Test (resultado: `NOT INDEPENDENTLY VALIDATED`) |
| G5 | [`G5-Track-1-Finalization-and-Delivery-Readiness.md`](docs/architecture/G5-Track-1-Finalization-and-Delivery-Readiness.md) | Consolidación final — estado de entrega |
| G5.1 | [`G5.1-Reusable-Capability-Library.md`](docs/architecture/G5.1-Reusable-Capability-Library.md) | Biblioteca de capacidades reutilizables + Best Practices — `capabilities/` |

Decisiones sin resolver, explícitas y sin ocultar: [`BLOCKED-DECISIONS.md`](docs/architecture/BLOCKED-DECISIONS.md).

## Relación con `moa-sdlc` y `moa-metrics` (corregido 2026-09-04)

**Este repositorio (`MOA-AI-Engineering`) es el que se está construyendo como la base
común de buenas prácticas de IA para todos los proyectos de MOA** (existentes y
nuevos) — no al revés. `moa-sdlc` y `moa-metrics` son herramientas de referencia
construidas por Baufest para la propia iniciativa (template de gobierno de agentes +
spec-driven development, y pipeline de indicadores, respectivamente); **no son equipos
de MOA** y su contenido no es la fuente de la que este repositorio deriva su gobierno o
sus principios. Se tratan como **evidencia/candidatos a evaluar**, al mismo nivel que
cualquier otro repo real relevado (DataAgro, Scato Logística, MOA Operaciones, Scato
Puerto, Orquestador — ver [`teams/README.md`](teams/README.md)), nunca como estándar por
default.

| Repositorio | Qué es | Rol |
|---|---|---|
| [`moa-sdlc`](../moa-sdlc) | Herramienta de referencia de Baufest (no un equipo de MOA) | Evidencia/candidato a evaluar |
| [`moa-metrics`](../moa-metrics) | Herramienta de referencia de Baufest (no un equipo de MOA) | Evidencia/candidato a evaluar |

Ver [`teams/README.md`](teams/README.md) para el detalle de los equipos reales de MOA y
su evidencia, y [`assessment/README.md`](assessment/README.md) para el pipeline que
cualquier capacidad —incluidas las de `moa-sdlc`/`moa-metrics`— debe atravesar antes de
promoverse.

## Principios

Ver [`strategy/principles.md`](strategy/principles.md).

## Cómo contribuir una nueva capacidad

Ruta completa (9 pasos, Team-Specific → Common Core, con evidencia en cada paso):
[`adoption/contribution-guide.md`](adoption/contribution-guide.md). Si involucra un
agente autónomo, seguir además el modelo TRIGGER→CONTEXT→DECISION→ACTION→VALIDATION→AUDIT
de [`governance/agent-governance.md`](governance/agent-governance.md).
