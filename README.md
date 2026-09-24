# ai-engineering

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

## 3. ¿Para quién es, y qué le ofrece a cada rol?

Cualquier equipo de MOA (DataAgro, Scato Logística, Scato Puerto, MOA Operaciones,
Orquestador, u otro futuro) que quiera incorporar IA en su SDLC de forma sistemática. Se
**consume y adapta**, no se impone — cada rol elige qué le sirve, cuándo, y sigue siendo
responsable de revisar el resultado antes de darlo por bueno.

| Rol | Qué le ofrece este modelo hoy |
|---|---|
| **Product Owner / analista** | Convertir un ticket escrito de cualquier forma en una historia de usuario con criterios de aceptación claros y sus ambigüedades ya señaladas, antes de llegar al refinamiento — con la opción de que el asistente busque el ticket directamente en Jira/Azure DevOps, sin copiarlo a mano |
| **Developer** | Un patrón para ordenar el desarrollo por pasos y roles con registro de cada uno, reglas claras de qué puede hacer el asistente de IA sin preguntar en ese repositorio, ayuda para operar Azure DevOps por CLI y para redactar la descripción del Pull Request a partir del ticket y el diff real, y — si se prefiere delegar más — un asistente que investiga el ticket, arma un plan y lo implementa él mismo tras tu aprobación explícita, en un espacio de trabajo aislado para no pisar otras tareas en paralelo |
| **Revisor de código** | Una segunda mirada automática sobre el diff antes de aprobar un Pull Request — señala problemas de seguridad, errores sin manejar y tests faltantes, pero nunca modifica código ni sustituye la revisión humana |
| **QA / Tester** | Casos de prueba derivados directamente de los criterios de aceptación de la historia, un criterio explícito para decidir qué conviene automatizar (con el código de test generado), y una verificación de que un ticket cumple sus criterios antes de cerrarlo |
| **Soporte / Operaciones** | Un primer diagnóstico de causa raíz ante un error de producción, citando evidencia real (logs, código) en vez de arrancar la investigación desde cero |
| **Arquitecto / referente técnico** | Un Registry con evidencia real de qué prácticas de IA ya funcionan en otros equipos de MOA, criterios explícitos para crear un Agent o habilitar una integración nueva sin improvisar, y un modelo de riesgo para MCP/integraciones |
| **Cualquier rol** | Un mismo lenguaje y una misma estructura (Golden Path → Capability → Evidence → Evaluation → Measurement) para no reinventar el proceso de adoptar IA en cada equipo por separado |

**Lectura obligatoria antes de continuar**: [`capabilities/README.md`](capabilities/README.md#qué-hace-cada-capacidad-explicado-simple)
explica, en lenguaje simple, qué hace cada capacidad concreta — y, más abajo en ese mismo
documento, un ejemplo real de punta a punta de cómo operar una en tu propio proyecto.
No es opcional: sin esa lectura, la tabla de la sección 4 (abajo) se entiende a medias.

## 4. ¿Qué puedo utilizar actualmente, etapa por etapa del KO?

El KO Interno de Track 1 define 11 etapas del SDLC (pág. 23-26). Este modelo sigue esas
11 etapas al pie, una por una — ninguna queda sin analizar. Para cada una, hoy hay una de
3 situaciones: **cubierta con evidencia real** (al menos un equipo de MOA ya la usa),
**cubierta con una propuesta** (lista para pilotear, ningún equipo la probó todavía — en 2
etapas, la propuesta es deliberadamente parcial, cubre una parte de lo que pide el KO y
deja el resto pendiente), o **pendiente de relevamiento** (se decidió explícitamente no
proponer nada todavía, por falta de evidencia suficiente incluso para una propuesta
razonable).

| # | Etapa del KO | Cómo está cubierta hoy |
|---|---|---|
| 1 | Recepción del requerimiento | ✅ Real — [`user-story`](capabilities/skills/user-story/SKILL.md) (CAP-001) + traer el ticket automáticamente ([CAP-002](registry/entries/azure-devops-context.md)/[CAP-003](registry/entries/jira-context.md)). Además, propuesta: [`product-owner`](capabilities/agents/product-owner/AGENT.md) (CAP-004), el rol de PO como Agent, que con confirmación deja la historia en el ticket |
| 2 | Refinamiento y estimación | ✅ Real — misma capacidad que la etapa 1 |
| 3 | Planning | ✅ Real — [`spec-driven-development`](capabilities/workflows/spec-driven-development/WORKFLOW.md) (CAP-005) + [`repository-governance`](capabilities/instructions/repository-governance/INSTRUCTIONS.md) (CAP-006). Además, propuesta: [`ticket-kickoff`](capabilities/agents/ticket-kickoff/AGENT.md) (CAP-010), orquesta investigación + plan + implementación con 2 checkpoints humanos |
| 4 | Desarrollo del código | ✅ Real — misma capacidad que la etapa 3, más [`azure-devops-cli`](capabilities/skills/azure-devops-cli/SKILL.md) (CAP-008). Además, propuestas: `ticket-kickoff` (CAP-010) con [`git-worktree-setup`](capabilities/agents/git-worktree-setup/AGENT.md) (CAP-009) para aislar tareas en paralelo, [`spec-review`](capabilities/skills/spec-review/SKILL.md) (CAP-007) para auditar los artefactos de CAP-005, y [`spec-reader`](capabilities/agents/spec-reader/AGENT.md) (CAP-018) para consultarlos sin escribir ni auditar |
| 5 | Apertura del PR | 🆕 Propuesta — [`pr-description`](capabilities/skills/pr-description/SKILL.md) (CAP-011) |
| 6 | Code Review | ✅ Real — [`read-only-code-reviewer`](capabilities/agents/read-only-code-reviewer/AGENT.md) (CAP-012) + [`stack-best-practices-template`](capabilities/skills/stack-best-practices-template/SKILL.md) (CAP-013) |
| 7 | Testing funcional (QA) | 🆕 Propuesta — [`qa-analyst`](capabilities/agents/qa-analyst/AGENT.md) (CAP-024) con [`test-case-generation`](capabilities/skills/test-case-generation/SKILL.md) (CAP-014); [`test-validator`](capabilities/agents/test-validator/AGENT.md) (CAP-025) verifica que todo quedó probado antes del OK final |
| 8 | Test de regresión | 🆕 Propuesta (parcial) — [`regression-test-generation`](capabilities/skills/regression-test-generation/SKILL.md) (CAP-015) clasifica y genera el código del test; [`test-pipeline-setup`](capabilities/skills/test-pipeline-setup/SKILL.md) (CAP-026) hace que los tests unitarios corran en cada PR. La ejecución automática de pruebas de interfaz en pipeline (MCP Playwright) sigue pendiente |
| 9 | Cierre del ticket | 🆕 Propuesta — [`ticket-closure-assist`](capabilities/skills/ticket-closure-assist/SKILL.md) (CAP-016): con confirmación, publica el cierre, carga horas y pasa a Done vía [`ticket-update`](capabilities/skills/ticket-update/SKILL.md) (CAP-023) |
| 10 | Soporte productivo | 🆕 Propuesta (parcial) — [`production-incident-investigation`](capabilities/agents/production-incident-investigation/AGENT.md) (CAP-017) cubre 3 de 5 líneas del KO: diagnóstico de causa raíz, borrador de comunicación de estado y borrador de cierre. Detección de recurrencia se resuelve con herramienta nativa por plataforma (Azure Observability Agent / Amazon DevOps Guru — ver el Registry), no con una capacidad nueva. Respuesta Nivel 1 sigue pendiente de relevamiento con un equipo real de soporte |
| 11 | Build & CI | ✅ Real — [`azure-devops-cli`](capabilities/skills/azure-devops-cli/SKILL.md) (CAP-008) |

**Ninguna fila de esta tabla es aspiracional ni inventada** — "✅ Real" no significa
"terminado y medido" (todavía no hay baseline en ningún caso), y "🆕 Propuesta" no
significa "no sirve" — significa que está lista para usarse pero corresponde pilotearla
antes de confiar en ella como en una capacidad ya probada. Detalle completo, con la
evidencia exacta de cada fila: [`architecture/ai-sdlc.md`](architecture/ai-sdlc.md).

**¿Ya está claro qué hace cada capacidad y falta saber cómo operarla en un proyecto
propio?** El ejemplo real de punta a punta (paso 1, 2 y 3, copiar/pegar) está en
[`capabilities/README.md#cómo-usar-una-capacidad--ejemplo-concreto-de-punta-a-punta`](capabilities/README.md#cómo-usar-una-capacidad--ejemplo-concreto-de-punta-a-punta).
Catálogo técnico completo con evidencia: [`registry/INDEX.md`](registry/INDEX.md).

## 5. ¿Cómo empiezo?

**¿Ya está instalado y solo falta saber qué escribir?**
[`adoption/how-to-use.md`](adoption/how-to-use.md) — la respuesta corta, sin jerga.

Para el resto: [`adoption/getting-started.md`](adoption/getting-started.md) — guía
práctica paso a paso.

## Quiero usar IA en mi proyecto

Si es la primera vez, conviene seguir este orden:

1. [`adoption/how-to-use.md`](adoption/how-to-use.md) — qué escribir, una vez instalado.
2. [`adoption/getting-started.md`](adoption/getting-started.md) — la guía paso a paso.
3. [`adoption/adoption-flow.md`](adoption/adoption-flow.md) — el modelo mental completo.
4. [`adoption/execution-model.md`](adoption/execution-model.md) — cómo ejecutar sobre el
   proyecto real.

```text
Necesidad → Golden Path → Capability → Adapt → Execute →
Evidence → Evaluate → Measure → Improve
```

**No es necesario copiar este repositorio dentro de otro proyecto.** Se adoptan
únicamente las capacidades puntuales que se necesiten — el resto queda como catálogo de
referencia.

## 6. Flujo de adopción

```text
Team → Discover → Understand → Adopt/Adapt → Execute → Evidence →
Evaluate → Measure → Feedback/Contribute → Promotion/Iteration
```

## 7. ¿Cómo adopto/adapto una capacidad?

Se copia la estructura y se adapta el contenido al dominio propio. Qué se puede cambiar
libremente y qué no: [`adoption/team-adaptation.md`](adoption/team-adaptation.md).

## 8. ¿Cómo evalúo?

Los criterios se declaran *antes* de mirar el resultado, y se completa el Evaluation Contract —
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

| Qué se busca | Dónde |
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

- **Sin ejecuciones reales registradas todavía.** Las ejecuciones previas (dry-runs
  propios de Direct Context y las primeras pruebas de Connected Context vía MCP,
  incluida `PILOT-003`) fueron pruebas del mecanismo durante la construcción — se
  purgaron deliberadamente al pasar a la etapa real de adopción, para no contar como
  "evidencia real" algo generado por quien diseñó la propia capacidad. La evidencia real
  empieza con la prueba en curso de un developer real de MOA sobre `ARMOA277-194` — ver
  `evidence/README.md` para el estado vivo. Ninguna capacidad alcanza `VERIFIED` todavía.
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

```text
AI capability → SDLC activity → resultado técnico/de negocio →
Evidence → Evaluation → Measurement → valor para MOA
```

Ejemplo real: CAP-001 (`user-story`) → refinamiento de un requerimiento real de DataAgro
→ historia + criterios + reglas + análisis de gaps → Evidence Record → Evaluation Record
(`PARTIAL`, no independiente) → Measurement Result (`NOT MEASURED`, sin baseline). No se
completa la cadena inventando el eslabón que falta.

## Historial de construcción

Las fases que construyeron este repositorio (G3.3 a G12) están preservadas, con su
razonamiento completo, en [`docs/history/track-1/`](docs/history/track-1/) — no forman
parte de la navegación principal del producto, pero nada se descartó.
