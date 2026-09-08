# Capabilities — Biblioteca reusable de MOA-AI-Engineering

Punto de entrada. Si necesitás saber **qué existe y podés usar hoy**, empezá acá.

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

## Qué hay

| Capacidad | Tipo | Dónde | Para qué | Registry |
|---|---|---|---|---|
| `azure-devops-cli` | Skill | [`skills/azure-devops-cli/SKILL.md`](skills/azure-devops-cli/SKILL.md) | Operar Azure DevOps por CLI sin inventar sintaxis | [CAP-001](../registry/entries/azure-devops-cli.md) |
| `user-story` | Skill | [`skills/user-story/SKILL.md`](skills/user-story/SKILL.md) | Estructurar requerimientos en historias de usuario | [CAP-002](../registry/entries/user-story.md) |
| `read-only-code-reviewer` | Agent | [`agents/read-only-code-reviewer/AGENT.md`](agents/read-only-code-reviewer/AGENT.md) | Code review acotado al diff, sin poder de escritura | [CAP-003](../registry/entries/dotnet-code-reviewer.md) |
| `spec-driven-development` | Workflow | [`workflows/spec-driven-development/WORKFLOW.md`](workflows/spec-driven-development/WORKFLOW.md) | Llevar un ticket de spec a código verificado, con trazabilidad | [CAP-004](../registry/entries/spec-driven-development.md) |
| `repository-governance` | Instruction | [`instructions/repository-governance/INSTRUCTIONS.md`](instructions/repository-governance/INSTRUCTIONS.md) | Declarar qué puede/no puede hacer un asistente sin supervisión | [CAP-005](../registry/entries/repository-governance.md) |
| `stack-best-practices-template` | Skill | [`skills/stack-best-practices-template/SKILL.md`](skills/stack-best-practices-template/SKILL.md) | Plantilla para documentar buenas prácticas de tu stack real | [CAP-006](../registry/entries/stack-best-practices-template.md) |

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

```
MOA-AI-Engineering Capability Source   (capabilities/)
              ↓
      Platform Mapping                 (depende del proveedor del equipo)
              ↓
Team Repository Runtime Implementation (el equipo la adapta y ejecuta)
```

Ejemplo — Skill (GitHub Copilot):
```
MOA-AI-Engineering/capabilities/skills/user-story/SKILL.md
              ↓
Team Repository/.github/skills/user-story/SKILL.md
```

Ejemplo — Agent (GitHub Copilot):
```
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
├── skills/              3 capacidades
├── agents/              1 capacidad
├── instructions/         1 capacidad
└── workflows/            1 capacidad
```

**Sigue sin existir `capabilities/integrations/`** — la decisión original de no
materializar los hallazgos de MCP como capability dentro de esta carpeta sigue vigente: el
gobierno de MCP (identidad, scope, auditoría) todavía no existe en MOA
(`../governance/BLOCKED-DECISIONS.md` #4), y esta iniciativa **sigue sin implementar
ningún MCP real** (sin servidor desplegado, sin credenciales). **Actualización**: al
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
