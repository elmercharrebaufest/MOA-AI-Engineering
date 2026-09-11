# MOA-AI-Engineering

**Base común de AI Engineering para Molinos Agro (MOA).**

## 1. ¿Qué es esto?

Un modelo base + una biblioteca de capacidades reutilizables para incorporar IA al SDLC
de forma **sistemática, gobernada, reutilizable, medible y trazable** — no una
plataforma, no un framework obligatorio idéntico para todos los equipos.

> **No es un repositorio monolítico.** Establece la base común; cada equipo decide qué
> adoptar, adaptar o no utilizar, manteniendo los principios y controles corporativos.

## 2. ¿Qué problema resuelve?

Los equipos de MOA ya usan IA — de forma heterogénea, sin un modelo común de evidencia,
evaluación o medición. Sin eso, no se puede saber qué realmente funciona, comparar
resultados entre equipos, ni promover con confianza lo que sí demostró valor. Este
repositorio da la estructura para cerrar esa brecha: Common Core + Team Adaptation,
capacidades reutilizables, un Registry, y contratos de Evidence/Evaluation/Measurement.

## 3. ¿Para quién es?

Cualquier equipo de MOA (DataAgro, Scato Logística, Scato Puerto, MOA Operaciones,
Orquestador, u otro futuro) que quiera incorporar IA en su SDLC de forma sistemática —
desarrolladores, POs, QA. Se **consume y adapta**, no se impone.

## 4. ¿Qué puedo utilizar actualmente?

**6 capacidades reales**, cada una con evidencia y clasificación honesta (ninguna es
`Corporate Standard: Y` todavía):

| Capacidad | Tipo | Para qué sirve |
|---|---|---|
| [`azure-devops-cli`](capabilities/skills/azure-devops-cli/SKILL.md) (CAP-001) | Skill | Operar Azure DevOps por CLI sin inventar sintaxis |
| [`user-story`](capabilities/skills/user-story/SKILL.md) (CAP-002) | Skill | Estructurar requerimientos en historias de usuario |
| [`read-only-code-reviewer`](capabilities/agents/read-only-code-reviewer/AGENT.md) (CAP-003) | Agent | Code review acotado al diff, sin poder de escritura |
| [`spec-driven-development`](capabilities/workflows/spec-driven-development/WORKFLOW.md) (CAP-004) | Workflow | Llevar un ticket a código verificado, con trazabilidad |
| [`repository-governance`](capabilities/instructions/repository-governance/INSTRUCTIONS.md) (CAP-005) | Instruction | Declarar qué puede/no puede hacer un asistente sin supervisión |
| [`stack-best-practices-template`](capabilities/skills/stack-best-practices-template/SKILL.md) (CAP-006) | Skill | Plantilla para documentar buenas prácticas de tu stack real |

Catálogo completo con evidencia: [`registry/INDEX.md`](registry/INDEX.md). Catálogo
consumible: [`capabilities/README.md`](capabilities/README.md).

Además, el Registry contiene 2 patrones transversales de Context Acquisition
(CAP-007 Azure DevOps Context y CAP-008 Jira Context), que no se materializan bajo
`capabilities/` porque representan patrones de adquisición de contexto, no capabilities
de negocio — ver [`registry/entries/azure-devops-context.md`](registry/entries/azure-devops-context.md)
y [`registry/entries/jira-context.md`](registry/entries/jira-context.md). Ninguno de los
dos es `Corporate Standard`.

## 5. ¿Cómo empiezo?

[`adoption/getting-started.md`](adoption/getting-started.md) — guía práctica paso a paso.

## Quiero usar IA en mi proyecto

Si es tu primera vez, seguí en orden:

1. [`adoption/getting-started.md`](adoption/getting-started.md) — la guía paso a paso.
2. [`adoption/adoption-flow.md`](adoption/adoption-flow.md) — el modelo mental completo.
3. [`adoption/execution-model.md`](adoption/execution-model.md) — cómo ejecutar sobre tu
   proyecto real.

```
Necesidad → Golden Path → Capability → Adapt → Execute →
Evidence → Evaluate → Measure → Improve
```

**No necesitás copiar este repositorio dentro de tu proyecto.** Adoptás únicamente las
capacidades puntuales que necesitás — el resto queda acá como catálogo de referencia.

## 6. Flujo de adopción

```
Team → Discover → Understand → Adopt/Adapt → Execute → Evidence →
Evaluate → Measure → Feedback/Contribute → Promotion/Iteration
```

## 7. ¿Cómo adopto/adapto una capacidad?

Copiá la estructura, adaptá el contenido a tu dominio. Qué podés cambiar libremente y qué
no: [`adoption/team-adaptation.md`](adoption/team-adaptation.md).

## 8. ¿Cómo evalúo?

Declarás tus criterios *antes* de mirar el resultado y completás el Evaluation Contract —
ver [`architecture/evidence-evaluation-measurement.md`](architecture/evidence-evaluation-measurement.md#2-evaluation).
Un resultado `model-assisted` (autoevaluación) **no sustituye** una evaluación humana
independiente.

## 9. ¿Cómo mido?

Con el Measurement Result Contract — ver
[`architecture/evidence-evaluation-measurement.md`](architecture/evidence-evaluation-measurement.md#3-measurement).
Si no hay baseline, el resultado es `NOT MEASURED`, explícito — nunca un `0` inventado.

## 10. ¿Cómo contribuyo?

Reportar feedback o proponer que algo se vuelva reutilizable:
[`adoption/contribution-guide.md`](adoption/contribution-guide.md).

## 11. ¿Dónde encuentro arquitectura, gobierno y seguridad?

| Qué buscás | Dónde |
|---|---|
| Arquitectura de referencia (canónica y vigente) | [`architecture/reference-architecture.md`](architecture/reference-architecture.md) |
| Modelo de capacidades (Instruction/Skill/Workflow/Agent/Knowledge-RAG/Integration/MCP) | [`architecture/capability-model.md`](architecture/capability-model.md) |
| Ciclo de vida de una capacidad | [`architecture/lifecycle.md`](architecture/lifecycle.md) |
| Rubric de evaluación para promover una capacidad | [`architecture/assessment-gate.md`](architecture/assessment-gate.md) |
| Golden Paths (caminos de adopción guiados) | [`golden-paths/README.md`](golden-paths/README.md) |
| Gobierno de agentes y de IA | [`governance/`](governance/) |
| Decisiones bloqueadas (12, sin resolver, visibles) | [`governance/BLOCKED-DECISIONS.md`](governance/BLOCKED-DECISIONS.md) |
| Seguridad — modelo de riesgo proporcional, MCP | [`security/security-governance.md`](security/security-governance.md) |
| Evidencia / Evaluación / Medición reales | [`evidence/`](evidence/README.md) · [`evaluation/`](evaluation/README.md) · [`measurements/`](measurements/README.md) |
| Estrategia (visión, principios, madurez, roadmap) | [`strategy/`](strategy/) |

## Estado actual

**READY WITH CONDITIONS** — el modelo está construido, la biblioteca de capacidades es
real y usable, pero:

- Ninguna ejecución existente es una **validación humana independiente** — CAP-002 tiene
  **5 ejecuciones reales registradas** (`evidence/README.md`): 2 *controlled dry-runs* con
  Direct Context (`EXEC-20260907-001`, `EXEC-20260908-001`) y 3 adicionales con Connected
  Context vía Context Provider (`EXEC-20260908-003` Azure DevOps, `EXEC-20260908-004` y
  `EXEC-20260908-005` Jira/MCP) — todas hechas por el mismo agente que diseñó la
  capacidad, no por un miembro de un equipo de MOA.
- No existe todavía **baseline cuantitativo** ni **medición comparativa de valor** para
  ninguna capacidad.
- Ninguna capacidad es `Corporate Standard: Y` — todas son candidatas evaluadas con
  evidencia, no estándares impuestos.
- **12 decisiones de gobierno siguen bloqueadas** — la más estructural: quién tiene
  mandato para aprobar el Common Core (`governance/BLOCKED-DECISIONS.md` #1). Sin
  resolverla, ninguna capacidad puede avanzar más allá de evidencia técnica.

Esto no bloquea usar el producto hoy — bloquea declarar algo "validado" que todavía no lo
está. La validación independiente con equipos reales de MOA es la evolución pendiente.

## De IA a valor — la cadena que este repositorio mantiene explícita

```
AI capability → SDLC activity → resultado técnico/de negocio →
Evidence → Evaluation → Measurement → valor para MOA
```

Ejemplo real: CAP-002 (`user-story`) → refinamiento de un requerimiento real de DataAgro
→ historia + criterios + reglas + análisis de gaps → Evidence Record → Evaluation Record
(`PARTIAL`, no independiente) → Measurement Result (`NOT MEASURED`, sin baseline). No se
completa la cadena inventando el eslabón que falta.

## `moa-sdlc` y `moa-metrics`

Son herramientas de referencia de Baufest, **no equipos de MOA** — se tratan como
evidencia/candidatos a evaluar, nunca como fuente de gobierno. Detalle:
[`teams/README.md`](teams/README.md).

## Historial de construcción

Las fases que construyeron este repositorio (G3.3 a G9) están preservadas, con su
razonamiento completo, en [`docs/history/track-1/`](docs/history/track-1/) — no forman
parte de la navegación principal del producto, pero nada se descartó.
