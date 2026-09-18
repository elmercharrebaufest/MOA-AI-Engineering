# Capabilities — Biblioteca reusable de MOA-AI-Engineering

Punto de entrada. Este documento responde qué existe y qué se puede usar hoy.

## Qué es esto

La primera biblioteca curada de capacidades de AI Engineering de MOA — **no** una copia de
lo que cada equipo ya tiene, sino una **generalización de patrones reales seleccionados
mediante evidencia interna, assessment, buenas prácticas externas y juicio
arquitectónico**, tras el proceso de evaluación de
[proceso de evaluación documentado en el historial de construcción](../docs/history/track-1/G5.1-Reusable-Capability-Library.md).
Esto **no** equivale a valor demostrado, ROI demostrado, impacto demostrado, ni
productividad demostrada — lo que existe hoy son controlled dry-runs sobre requerimientos
reales, con evidencia de ejecución y evaluación `model-assisted`, sin validación humana
independiente ni baseline cuantitativo (ver `Real Use Status` de cada entrada en el
Registry).

**Ninguna capacidad acá es `Corporate Standard: Y`** — son candidatas evaluadas con
evidencia real, adoptables y adaptables, no un estándar impuesto. Ver
[`../registry/INDEX.md`](../registry/INDEX.md) para el estado completo de gobernanza de
cada una.

**Este documento sigue las 11 etapas del SDLC que define el KO Interno de Track 1** (pág.
23-26) — no solo las capacidades con evidencia real. Ver
[`../README.md#4-qué-puedo-utilizar-actualmente-etapa-por-etapa-del-ko`](../README.md#4-qué-puedo-utilizar-actualmente-etapa-por-etapa-del-ko)
para la tabla completa, etapa por etapa, con lo que cubre cada una hoy.

## Qué hace cada capacidad, explicado simple

Para quien recién llega y solo necesita entender qué hace cada cosa, sin tecnicismos.
Siguiendo el orden en que normalmente aparecen en el trabajo diario de un ticket:

**Refinar un requerimiento**
- **`user-story`** (CAP-002) — toma un ticket escrito de cualquier forma y lo convierte
  en una historia de usuario completa: con criterios de aceptación claros, reglas de
  negocio explícitas y una lista de preguntas pendientes, para que el equipo llegue al
  refinamiento con menos ambigüedad. **En uso real** en 3 equipos de MOA.
- **`product-owner`** (CAP-012) — hace exactamente lo mismo que `user-story`, pero como
  un rol de asistente permanente que puede ir directo a buscar el ticket en Jira, en vez
  de que alguien tenga que copiarlo y pegarlo a mano. Solo puede leer el ticket, nunca
  comentarlo ni cambiarlo. **Propuesta nueva, todavía sin probar por ningún equipo.**

**Desarrollar y abrir el Pull Request**
- **`spec-driven-development`** (CAP-004) — organiza el desarrollo de un ticket en pasos y
  roles claros (quien especifica, quien escribe el código, quien lo prueba), dejando
  registro de cada paso en vez de perder ese detalle en el camino. **En uso real** en 2
  equipos, con una versión simple (recomendada para empezar) y una más completa.
- **`repository-governance`** (CAP-005) — un archivo que le dice al asistente de IA qué
  puede hacer siempre sin preguntar, qué debe confirmar antes, y qué nunca debe hacer en
  ese repositorio, para que su comportamiento sea predecible. **En uso real** en 4
  repositorios.
- **`azure-devops-cli`** (CAP-001) — ayuda a operar Azure DevOps desde la línea de
  comandos sin tener que buscar la sintaxis exacta de cada comando. **En uso real** en 2
  equipos.
- **`pr-description`** (CAP-009) — redacta el título y la descripción de un Pull Request
  a partir del ticket de origen y del cambio real de código, para no escribirlo desde
  cero cada vez. **Propuesta nueva, todavía sin probar por ningún equipo.**

**Revisar el código**
- **`read-only-code-reviewer`** (CAP-003) — revisa un cambio de código y señala problemas
  de seguridad, errores sin manejar, tests faltantes o de mala calidad — pero no puede
  modificar ningún archivo por sí mismo, solo informa. Es una segunda mirada antes de que
  una persona apruebe el cambio, nunca la reemplaza. **En uso real** en 2 equipos.
- **`stack-best-practices-template`** (CAP-006) — una plantilla vacía para que cada
  equipo documente las reglas reales de su propio stack tecnológico, para que
  `read-only-code-reviewer` las aplique correctamente. No trae contenido — las reglas de
  un stack no sirven para otro.

**Probar y cerrar el ticket**
- **`test-case-generation`** (CAP-010) — a partir de los criterios de aceptación de una
  historia de usuario, redacta los casos de prueba que se desprenden directamente de
  ellos, para que QA dedique el tiempo a lo que es más difícil de anticipar. **Propuesta
  nueva, todavía sin probar por ningún equipo.**
- **`ticket-closure-assist`** (CAP-011) — antes de cerrar un ticket, revisa si sus
  criterios de aceptación realmente se cumplieron (con evidencia real, no una suposición)
  y redacta un borrador del comentario de cierre. **Propuesta nueva, todavía sin probar
  por ningún equipo.**

**Traer el contenido de un ticket automáticamente**
- **`azure-devops-context`** (CAP-007) y **`jira-context`** (CAP-008) — con solo dar la
  referencia de un ticket o Work Item (por ejemplo, `MOA-1234`), el asistente trae su
  contenido real automáticamente, en vez de que alguien tenga que copiarlo y pegarlo a
  mano. Ambos son de solo lectura. El mecanismo quedó probado durante la construcción; la
  evidencia de uso real por un equipo está en curso.

**Qué significa "en uso real" vs. "propuesta nueva"**: "en uso real" quiere decir que al
menos un equipo de MOA ya tenía esa práctica funcionando por su cuenta, y este repositorio
la generalizó para que cualquier otro equipo la pueda adoptar. "Propuesta nueva" quiere
decir que ningún equipo la probó todavía — está lista para usarse, pero corresponde
pilotearla antes de confiar en ella igual que en una capacidad ya probada. Ninguna, en
ningún caso, está impuesta como estándar obligatorio.

## Catálogo técnico completo

Referencia rápida con el tipo de cada capacidad, dónde está el archivo, y el link a su
entrada completa del Registry (con la evidencia detallada detrás de cada una). Se divide
en 2 tablas — no porque unas valgan más que otras, sino porque el origen de la evidencia
es distinto (ver la nota debajo de la segunda tabla).

### Con evidencia real de al menos un equipo de MOA (6)

| Capacidad | Tipo | Dónde | Para qué | Registry |
|---|---|---|---|---|
| `azure-devops-cli` | Skill | [`skills/azure-devops-cli/SKILL.md`](skills/azure-devops-cli/SKILL.md) | Operar Azure DevOps por CLI sin inventar sintaxis | [CAP-001](../registry/entries/azure-devops-cli.md) |
| `user-story` | Skill | [`skills/user-story/SKILL.md`](skills/user-story/SKILL.md) | Estructurar requerimientos en historias de usuario | [CAP-002](../registry/entries/user-story.md) |
| `read-only-code-reviewer` | Agent | [`agents/read-only-code-reviewer/AGENT.md`](agents/read-only-code-reviewer/AGENT.md) | Code review acotado al diff, sin poder de escritura | [CAP-003](../registry/entries/dotnet-code-reviewer.md) |
| `spec-driven-development` | Workflow | [`workflows/spec-driven-development/WORKFLOW.md`](workflows/spec-driven-development/WORKFLOW.md) | Llevar un ticket de spec a código verificado, con trazabilidad | [CAP-004](../registry/entries/spec-driven-development.md) |
| `repository-governance` | Instruction | [`instructions/repository-governance/INSTRUCTIONS.md`](instructions/repository-governance/INSTRUCTIONS.md) | Declarar qué puede/no puede hacer un asistente sin supervisión | [CAP-005](../registry/entries/repository-governance.md) |
| `stack-best-practices-template` | Skill | [`skills/stack-best-practices-template/SKILL.md`](skills/stack-best-practices-template/SKILL.md) | Plantilla para documentar las buenas prácticas del stack real de cada equipo | [CAP-006](../registry/entries/stack-best-practices-template.md) |

### Propuestas nuevas — sin evidencia de origen todavía (CAP-009 a CAP-012)

**Distinción deliberada respecto a la tabla de arriba**: las 6 capacidades anteriores son
generalizaciones de patrones reales ya en uso por al menos un equipo de MOA. Las 4 de
esta tabla **no lo son** — son propuestas directas para cerrar brechas de las 11 etapas
del SDLC del KO que no tenían ni capacidad ni propuesta, justificadas por Existing
Practice (KO/hallazgos reales de otro tipo) + External Best Practice + Architectural
Judgment (`assessment/README.md`), sin ejecución real ni piloto de ningún equipo
todavía. Ver el detalle de evidencia de cada una en su entrada del Registry.

| Capacidad | Tipo | Dónde | Para qué | Registry |
|---|---|---|---|---|
| `pr-description` | Skill | [`skills/pr-description/SKILL.md`](skills/pr-description/SKILL.md) | Título/descripción de PR a partir del ticket y el diff real | [CAP-009](../registry/entries/pr-description.md) |
| `test-case-generation` | Skill | [`skills/test-case-generation/SKILL.md`](skills/test-case-generation/SKILL.md) | Derivar casos de prueba de los criterios de aceptación | [CAP-010](../registry/entries/test-case-generation.md) |
| `ticket-closure-assist` | Skill | [`skills/ticket-closure-assist/SKILL.md`](skills/ticket-closure-assist/SKILL.md) | Verificar criterios y redactar el borrador de cierre del ticket | [CAP-011](../registry/entries/ticket-closure-assist.md) |
| `product-owner` | Agent | [`agents/product-owner/AGENT.md`](agents/product-owner/AGENT.md) | Empaquetado como Agent de la lógica de `user-story`, con MCP acotado | [CAP-012](../registry/entries/product-owner.md) |

### Patrones de adquisición de contexto (2)

No son Skill/Agent/Workflow/Instruction — son la implementación concreta de traer
automáticamente el contenido real de un ticket, y por eso viven en
[`../integrations/`](../integrations/catalog.md), no en las carpetas de `capabilities/`.
Se listan acá para que la cobertura de las 11 etapas del KO quede completa en un solo
lugar — ver la sección "Sigue sin existir `capabilities/integrations/`" más abajo para la
razón completa de por qué no están en las tablas anteriores.

| Capacidad | Tipo | Dónde | Para qué | Registry |
|---|---|---|---|---|
| `azure-devops-context` | Integration/API | [`../integrations/azure-devops-context-provider.md`](../integrations/azure-devops-context-provider.md) | Traer automáticamente el contenido real de un Work Item de Azure DevOps | [CAP-007](../registry/entries/azure-devops-context.md) |
| `jira-context` | MCP | [`../integrations/jira-context-provider.md`](../integrations/jira-context-provider.md) | Traer automáticamente el contenido real de un ticket de Jira, vía MCP Atlassian | [CAP-008](../registry/entries/jira-context.md) |

## Cómo se llegó a esta lista (y qué quedó afuera, a propósito)

Se inspeccionaron ~30 candidatos reales (agentes por rol, skills de dominio, instructions
de seguridad, patrones de workflow) de 6 repos de equipos de MOA. **La mayoría no está
acá** — quedaron clasificados `TEAM-SPECIFIC` (correctos para su equipo, no para
centralizar) o `EXPERIMENTAL` (interesantes, sin evidencia suficiente todavía). Ver la
tabla completa de clasificación en
[el historial de construcción](../docs/history/track-1/G5.1-Reusable-Capability-Library.md)
— nada acá llegó por "estar en 2 repos", cada una pasó por: propósito, dependencias,
qué parte es genérica vs. específica, seguridad, permisos, datos, mantenibilidad,
portabilidad, evidencia de uso, reusabilidad, y contraste con buenas prácticas externas.

## De dónde viene una capacidad y a dónde va

`MOA-AI-Engineering` contiene la **fuente/patrón reusable** — no el runtime ejecutable
de ningún equipo. Copiar un archivo de acá a un repo de equipo **no lo convierte
automáticamente en capacidad corporativa** — sigue siendo Team-Specific hasta que pase
por Assessment/Human Governance (`../architecture/assessment-gate.md`), sin importar
cuántas veces se copie.

```text
MOA-AI-Engineering Capability Source   (capabilities/)
              ↓
      Platform Mapping                 (depende del proveedor del equipo)
              ↓
Team Repository Runtime Implementation (el equipo la adapta y ejecuta)
```

Ejemplo — Skill (GitHub Copilot):
```text
MOA-AI-Engineering/capabilities/skills/user-story/SKILL.md
              ↓
Team Repository/.github/skills/user-story/SKILL.md
```

Ejemplo — Agent (GitHub Copilot):
```text
MOA-AI-Engineering/capabilities/agents/read-only-code-reviewer/AGENT.md
              ↓
Team Repository/.github/agents/read-only-code-reviewer.agent.md
              (el equipo completa `model:` según su plataforma real — ver la nota en
              el propio AGENT.md, deliberadamente sin ese campo en la fuente)
```

| Capability Type | MOA Source | GitHub/Copilot Mapping | Team Adaptation requerida |
|---|---|---|---|
| Skill | `capabilities/skills/<name>/SKILL.md` | `.github/skills/<name>/SKILL.md` | Contenido de dominio (ver cada capability) |
| Agent | `capabilities/agents/<name>/AGENT.md` | `.github/agents/<name>.agent.md` | `model:`, `tools:` si el equipo justifica ampliarlos (nunca agregar `edit` a un Agent de solo-lectura sin rediseñar el patrón) |
| Instruction | `capabilities/instructions/<name>/INSTRUCTIONS.md` | `AGENTS.md` / `copilot-instructions.md` + `.github/instructions/*.instructions.md` | Contenido de cada capa/matriz — 100% |
| Workflow | `capabilities/workflows/<name>/WORKFLOW.md` | `_sdd/` (spec-driven dev) u otro mecanismo equivalente del equipo | Todo — el Workflow describe roles y estado, no una herramienta específica |

**Otras plataformas** (Copilot Studio, Claude, u otras — ver Blocked Decision #2, MOA no
tiene una plataforma única sancionada): el mapeo de archivos/convenciones cambia, la
**fuente y el patrón no**. Esta tabla documenta el mapeo conocido hoy (GitHub Copilot, por
ser la plataforma con evidencia interna real dominante) — no es una nueva arquitectura,
es una aclaración de cómo se usa la ya existente.

## Cómo usar una capacidad

1. Abrí el archivo de la capacidad (no solo esta tabla) — cada una tiene: cuándo usarla,
   cuándo NO, entradas/salidas, seguridad, HITL, ejemplos, y qué adaptar.
2. Copiá **la estructura**, no el contenido literal de otro equipo — cada capacidad
   generalizada está deliberadamente sin contenido de dominio específico donde ese
   contenido no es portable (ver `stack-best-practices-template` como el caso más
   explícito).
3. Completá el Evidence/Evaluation/Measurement Contract cuando la ejecutes — ver
   [`../adoption/getting-started.md`](../adoption/getting-started.md).

## Best Practices

Guía práctica de cómo MOA recomienda usar cada tipo de capacidad (no solo las 6 de arriba
— también Knowledge/RAG, MCP/Integrations, Evaluation, Observability, Metrics, ninguna de
las cuales tiene todavía una capacidad materializada):
[`best-practices.md`](best-practices.md).

## Estructura (justificada, no por defecto)

```
capabilities/
├── README.md          este archivo
├── best-practices.md   guía práctica por tipo de capacidad
├── skills/              6 capacidades (3 con evidencia real, 3 propuestas — CAP-009/010/011)
├── agents/              2 capacidades (1 con evidencia real, 1 propuesta — CAP-012)
├── instructions/         1 capacidad
└── workflows/            1 capacidad
```

**Sigue sin existir `capabilities/integrations/`** — la decisión original de no
materializar los hallazgos de MCP como capability dentro de esta carpeta sigue vigente: el
gobierno de MCP (identidad, scope, auditoría) todavía no existe en MOA
(`../governance/BLOCKED-DECISIONS.md` #4). El mecanismo (Atlassian Rovo MCP,
`getJiraIssue`) quedó probado de punta a punta durante la construcción — esas pruebas se
purgaron al pasar a adopción real, y no cambiaban el gobierno pendiente de MCP como
mecanismo general de todos modos, porque MOA no ha desplegado, ni tiene previsto
desplegar, un servidor MCP propio. Al
formalizar Context Acquisition & Resolution como Cross-Cutting Concern
([`../architecture/context-acquisition-resolution.md`](../architecture/context-acquisition-resolution.md)),
se crearon 2 **patrones** de adquisición de contexto READ-only —
[CAP-007](../registry/entries/azure-devops-context.md) (Azure DevOps) y
[CAP-008](../registry/entries/jira-context.md) (Jira) — pero **viven en
[`../integrations/`](../integrations/catalog.md), no en `capabilities/`**, precisamente
porque no son capacidades de negocio seleccionables de la misma forma que Skill/Agent/
Workflow/Instruction — son la implementación concreta de un concern transversal. Ver
[`security/security-governance.md`](../security/security-governance.md)
para el detalle completo de gobierno de MCP.
