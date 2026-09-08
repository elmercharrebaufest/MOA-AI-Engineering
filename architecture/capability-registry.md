# Capability Registry

**Estado**: PROPOSAL — modelo conceptual del schema. **No se implementa base de datos ni
servicio** (decisión de alcance vigente — ver `registry/README.md` para el mecanismo
real, archivos en git). El
[relevamiento histórico de capacidades](../docs/history/track-1/relevamiento-capacidades-g2.md)
fue la instancia manual/narrativa que este Registry formaliza — se mantiene como
registro histórico, no se duplica.

## Propósito

Responder, para cualquier capacidad de IA en MOA: qué es, quién la originó, quién la
mantiene, quién la usa, en qué repo/rama vive, qué riesgo tiene, y en qué estado del
ciclo de vida está — de forma consultable, no dispersa en documentos narrativos.

## Por qué el modelo se amplió en G3.3

El modelo de 18 campos propuesto en G3.1 (`ID, Name, Type, Owner, Team, Purpose, Risk,
Data, Tools, Model, Autonomy, HITL, Version, Evaluation, Metrics, Status, Lifecycle, Last
Review`) no distinguía **quién originó** una capacidad de **quién la usa hoy** —
exactamente la ambigüedad que surgió en G3.2.5 al encontrar que la "convergencia
cross-team" entre DataAgro/Scato Logística/Orquestador correspondía, en realidad, a un
grupo reducido de autores. Este documento incorpora esa distinción explícitamente
(Principio #2: Origin ≠ Ownership ≠ Adoption ≠ Standardization).

## Modelo conceptual — campos

| Campo | Qué captura | Ejemplo (con evidencia real de G3.2.5) |
|---|---|---|
| `ID` | Identificador único | — |
| `Name` | Nombre legible | `azure-devops-cli` |
| `Type` | Una de las 7 capacidades seleccionables de `capability-model.md` (Instruction/Skill/Workflow/Agent/Knowledge-RAG/Integration-API/MCP) — Prompt no se registra (es pre-artifact); Evaluation/Observability/Metrics no se registran como `Type` (son cross-cutting concerns, ver campos `Evaluation Status`/`Observability Status`/`Metrics` más abajo) | `Skill` |
| `Purpose` | Problema/proceso que resuelve, trazable a un Use Case | "Ejecutar operaciones de Azure DevOps vía CLI sin recordar sintaxis de memoria" |
| **`Origin`** *(nuevo en G3.3)* | De dónde surgió originalmente — repo, persona, iniciativa | Scato Logística, rama `feature/cardless2`, commit inicial de Manuel Davila |
| **`Originator`** *(nuevo)* | Persona/equipo que lo creó — distinto de quién lo mantiene hoy | Manuel Davila (evidencia de autoría por `git log`, G3.2.5) |
| `Owner` | Responsable actual de mantenerlo | **REQUIRES VALIDATION** en todos los casos relevados — no hay evidencia de ownership formal más allá del autor original |
| **`Maintainer`** *(nuevo)* | Quién aplica cambios hoy (puede diferir del Owner) | REQUIRES VALIDATION |
| `Team` | Equipo(s) que lo usa(n) hoy | Scato Logística (confirmado), Orquestador (misma skill, contenido parcialmente compartido — ver `assessment-gate.md`) |
| **`Adopters`** *(nuevo)* | Lista de equipos que lo adoptaron/adaptaron, distinto de `Team` (uso primario) | Orquestador, si se confirma que adaptó (no copió literalmente) la versión de Scato Logística |
| **`Domain`** *(nuevo)* | Dominio de negocio al que aplica, si es team-specific | N/A para este ejemplo (es transversal); "AFIP/logística" para `afip-cpe-ctg` |
| `Risk` | Nivel de riesgo evaluado (`assessment-gate.md`) | Bajo (solo lectura de recursos ADO documentados) |
| **`Data Classification`** *(nuevo)* | Clasificación del dato que toca, según política de MOA | **REQUIRES VALIDATION — la política no existe todavía (Blocked Decision #3)** |
| `Tools` | Herramientas/permisos que puede invocar | `az cli` (Azure DevOps) |
| `Model` | Modelo de IA subyacente, si aplica | No declarado en los agents de Orquestador que la cargan; `claude-opus-4.8` en el agent de Scato Logística que carga skills similares |
| `Autonomy` | Nivel de autonomía (ALWAYS/ASK FIRST/NEVER) | No aplica directo (es Skill, no Agent) — el Agent `devops` que la invoca sí declara reglas duras (secretos nunca en YAML, etc.) |
| `HITL` | Punto(s) de validación humana | Implícito en las reglas duras del agent que la usa — no declarado explícitamente en la Skill misma |
| `Version` | Versión de la capacidad | No versionado formalmente en ningún repo relevado — **REQUIRES VALIDATION** si hay convención de versionado |
| **`Configuration Status`** *(nuevo en G3.3 Corrections)* | ¿El artefacto existe y está bien formado? Valores: `VERIFIED` / `PARTIAL` / `NOT FOUND` / `REQUIRES VALIDATION` | `VERIFIED` (frontmatter real, contenido específico leído completo) |
| **`Real Use Status`** *(nuevo en G3.3 Corrections; escala unificada en G4.5)* | ¿Se usó de verdad, más allá de la configuración? Valores: `NOT FOUND` (sin evidencia de que exista) → `CONFIGURED` (existe, bien formado, cero ejecuciones) → `EXECUTED` (al menos 1 ejecución real registrada, no necesariamente independiente) → `VERIFIED` (ejecución independiente + evaluación humana confirmadas). **Regla dura: no se infiere desde `Evaluation Status` ni `Observability Status`** — son 3 preguntas independientes; que algo esté evaluado no prueba que se use, y viceversa | `EXECUTED` — CAP-002 (`user-story`) tiene 2 ejecuciones reales registradas (`EXEC-20260907-001`, `EXEC-20260908-001`), ninguna `VERIFIED` porque ninguna es independiente (ver `registry/entries/user-story.md`) |
| `Evaluation Status` | Estado de evaluación (`evaluation-observability.md`). Valores: `VERIFIED` / `PARTIAL` / `NOT FOUND` / `REQUIRES VALIDATION` | `NOT FOUND` — sin evaluación documentada |
| **`Observability Status`** *(separado de Evaluation)* | Si existe trazabilidad de ejecución. Mismos valores controlados | `NOT FOUND` |
| `Metrics` | Métricas asociadas y su estado | NOT FOUND |
| `Lifecycle State` | Estado dentro del **Capability Lifecycle** de `lifecycle.md` (Use Case…Promote) — **no** el Adoption Status ni Deprecation, que son bloques separados | **Pilot** |
| **`Corporate Standard`** *(nuevo en G3.3 Corrections)* | `Y` / `N` — derivado del Adoption Status de `lifecycle.md` (`Y` únicamente si la capacidad alcanzó `Common Core = Y` vía `Promote`). **No es lo mismo que `Lifecycle State`**: una capacidad puede estar en `Pilot` (Capability Lifecycle) y `Corporate Standard = N` simultáneamente — eso es, de hecho, el estado de todo lo relevado hasta ahora | `N` — ninguna capacidad relevada completó el Gate |
| **`Repository`** *(nuevo)* | Repo físico donde vive | `Scato Logistica/Scato%20Logistica` y `Orquestador/Orquestador` (2 entradas si el contenido diverge) |
| **`Branch`** *(nuevo)* | Rama donde vive — crítico dado el caso Orquestador | `master` (Scato Logística) / `feature/cardless4`, **no integrada** (Orquestador) |
| **`Integration Status`** *(nuevo)* | Si está en la línea principal del repo o en una rama no integrada | Scato Logística: integrado. Orquestador: **no integrado** — ver Blocked Decision #9 |
| `Last Review` | Última fecha de revisión | 2026-09-04 (esta sesión, G3.2.5) |

## Configuration ≠ Real Use ≠ Process Maturity ≠ Results — mapeo explícito a campos (G3.3 Corrections)

El principio más repetido de todo el proyecto desde G2 no tenía, hasta esta corrección,
campos dedicados que lo operacionalizaran. Mapeo explícito:

| Dimensión (Principio #1) | Campo del Registry |
|---|---|
| **Configuration** | `Configuration Status` |
| **Real Use** | `Real Use Status` — **nunca se infiere de `Evaluation Status` u `Observability Status`**, se completa con evidencia directa de invocación (logs, menciones en una feature real cerrada, etc.) |
| **Process Maturity** | `Lifecycle State` (posición dentro del Capability Lifecycle) |
| **Results** | `Metrics` |

Las 4 columnas se completan de forma **independiente** — el ejemplo real que motivó esta
corrección (G3.2.5): los Agents de Orquestador (`feature/cardless4`) tienen
`Configuration Status = VERIFIED` (config leída completa, de alta calidad) mientras que
`Real Use Status`, `Lifecycle State` (más allá de `Pilot`) y `Metrics` son todos
`REQUIRES VALIDATION`/`NOT FOUND` — las 4 columnas no se mueven juntas.

## Por qué `Repository`/`Branch`/`Integration Status` son campos obligatorios, no opcionales

El caso de Orquestador (G3.2) demostró un riesgo concreto: un relevamiento que solo mira
`working tree` de la rama por defecto puede reportar **NOT FOUND** sobre una capacidad que
existe, con 8 meses de desarrollo real, en una rama no integrada. Sin estos 3 campos, el
Registry repetiría ese mismo blind spot a escala. **Regla**: ninguna entrada del Registry
se considera "vigente" (`Integration Status = integrated`) sin confirmar explícitamente
en qué rama vive.

## Relación con Lifecycle y Assessment Gate

- `Lifecycle State` (este documento) usa exactamente los estados del bloque **Capability
  Lifecycle** de `lifecycle.md` (Use Case…Promote) — `Corporate Standard` es el campo que
  refleja el bloque **Adoption Status** (`Common Core = Y/N`), no `Lifecycle State`.
- `Risk`, `Data Classification`, `Evaluation Status`, `Observability Status`, `Metrics`
  son los mismos campos que alimenta el rubric de `assessment-gate.md` — el Registry es
  donde ese resultado queda persistido, no un modelo paralelo.
- `Configuration Status` y `Real Use Status` no vienen del rubric de 14 dimensiones — se
  completan de forma directa e independiente (ver sección de mapeo arriba).

## Qué NO es este documento

- No es una base de datos — es el modelo de datos conceptual.
- No es un mandato de qué herramienta usar para implementarlo (Airtable, una tabla en
  `moa-metrics`, un archivo YAML por capacidad) — esa es una decisión técnica diferida a
  una fase posterior a G3.3.
- No pre-llena entradas reales todavía — la tabla de ejemplo de arriba usa un solo caso
  (`azure-devops-cli`) de forma ilustrativa; poblar el Registry completo con las
  capacidades ya relevadas es trabajo de una fase siguiente, no de este documento.
