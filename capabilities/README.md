# Capabilities — Biblioteca reusable de ai-engineering

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
- **`user-story`** (CAP-001) — toma un requerimiento, o un ticket existente largo y
  desordenado, y lo deja como una historia breve: criterios de aceptación que se pueden
  probar, lo que queda fuera de alcance, los datos que hacen falta, las preguntas que
  bloquean y un veredicto de si está lista, con propuesta de división si es demasiado
  grande. El objetivo es que el equipo no necesite una reunión para entender el ticket.
  **En uso real** en 3 equipos de MOA.
- **`product-owner`** (CAP-004) — el rol de Product Owner como asistente: hace lo mismo
  que `user-story`, trae el ticket directo de Jira y, con su confirmación, deja el
  resultado en el ticket (la historia en la descripción, las preguntas como comentario,
  las historias divididas como tickets nuevos). Al terminar, ofrece pasar a desarrollo.
  **Propuesta nueva, todavía sin probar por ningún equipo.**
- **`ticket-update`** (CAP-023) — la forma segura en que cualquier asistente escribe en
  Jira o Azure DevOps: muestra el cambio exacto, espera su confirmación, escribe, verifica
  que quedó bien y deja una marca visible de que se generó con asistencia. Nunca borra.
  **Propuesta nueva, todavía sin probar por ningún equipo.**

**Desarrollar y abrir el Pull Request**
- **`spec-driven-development`** (CAP-005) — organiza el desarrollo de un ticket en pasos y
  roles claros (quien especifica, quien escribe el código, quien lo prueba), dejando
  registro de cada paso en vez de perder ese detalle en el camino. **En uso real** en 2
  equipos, con una versión simple (recomendada para empezar) y una más completa.
- **`spec-review`** (CAP-007) — audita lo que generó `spec-driven-development` (¿quedó
  algo ambiguo sin resolver? ¿alguna tarea no cubre nada de lo pedido?), sin escribir
  contenido nuevo. **Propuesta nueva, todavía sin probar por ningún equipo.**
- **`spec-reader`** (CAP-018) — responde preguntas sobre lo que ya está documentado (¿qué
  hace esta feature? ¿cuáles son sus criterios?), citando siempre de dónde sale la
  respuesta — nunca inventa ni completa con conocimiento general. No escribe ni audita,
  solo consulta. **Propuesta nueva, todavía sin probar por ningún equipo.**
- **`repository-governance`** (CAP-006) — un archivo que le dice al asistente de IA qué
  puede hacer siempre sin preguntar, qué debe confirmar antes, y qué nunca debe hacer en
  ese repositorio, para que su comportamiento sea predecible. **En uso real** en 4
  repositorios.
- **`documentation-style`** (CAP-022) — regla de estilo para toda la documentación de
  este modelo: español formal y natural (nunca voseo), contenido acotado que aporta valor
  real, sin relleno. Aplica siempre, igual que `repository-governance`, pero a cómo se
  escribe en vez de a qué puede hacer un asistente. **Ya aplicada de forma retroactiva
  sobre este mismo repositorio**, sin adopción externa todavía.
- **`azure-devops-cli`** (CAP-008) — ayuda a operar Azure DevOps desde la línea de
  comandos sin tener que buscar la sintaxis exacta de cada comando. **En uso real** en 2
  equipos.
- **`ticket-kickoff`** (CAP-010) — un rol de asistente que, con aprobación explícita,
  encadena todo lo anterior: investiga el ticket, arma un plan técnico con horas
  estimadas, y — solo si el plan se aprueba — implementa el código él mismo en un
  espacio de trabajo aislado (usando `git-worktree-setup`, CAP-009, para no pisar otras
  tareas en paralelo), corriendo los tests antes de dejarlo listo para revisión. Nunca
  hace push; con su confirmación, deja el plan en el ticket y crea el PR. Al terminar,
  ofrece revisar el código o generar las pruebas. Siempre detrás de una aprobación
  explícita. **Propuesta nueva, todavía sin probar por ningún equipo.**
- **`pr-description`** (CAP-011) — redacta el título y la descripción de un Pull Request
  a partir del ticket de origen y del cambio real de código, para no escribirlo desde
  cero cada vez. **Propuesta nueva, todavía sin probar por ningún equipo.**

**Revisar el código**
- **`read-only-code-reviewer`** (CAP-012) — revisa un cambio de código y señala problemas
  de seguridad, errores sin manejar, tests faltantes o de mala calidad — pero no puede
  modificar ningún archivo por sí mismo, solo informa. Es una segunda mirada antes de que
  una persona apruebe el cambio, nunca la reemplaza. **En uso real** en 2 equipos.
- **`stack-best-practices-template`** (CAP-013) — una plantilla vacía para que cada
  equipo documente las reglas reales de su propio stack tecnológico, para que
  `read-only-code-reviewer` las aplique correctamente. No trae contenido — las reglas de
  un stack no sirven para otro.

**Probar y cerrar el ticket**
- **`test-case-generation`** (CAP-014) — a partir de los criterios de aceptación de una
  historia de usuario, redacta los casos de prueba que se desprenden directamente de
  ellos, para que QA dedique el tiempo a lo que es más difícil de anticipar. **Propuesta
  nueva, todavía sin probar por ningún equipo.**
- **`regression-test-generation`** (CAP-015) — mirando un caso de prueba ya redactado,
  decide si conviene automatizarlo (con un criterio explícito, no a ojo) y, si conviene,
  genera el código del test siguiendo la estructura que el repo ya use. No lo ejecuta
  automáticamente en ningún pipeline — eso sigue dependiendo de una integración que hoy
  ningún equipo de MOA tiene. **Propuesta nueva, todavía sin probar por ningún equipo.**
- **`qa-analyst`** (CAP-024) — el rol de QA como asistente: arma los casos de prueba de
  cada criterio, decide cuáles conviene automatizar, escribe y corre esos tests en el
  repo, y con su confirmación publica los casos en el ticket. Nunca toca código de
  producción. **Propuesta nueva, todavía sin probar por ningún equipo.**
- **`test-validator`** (CAP-025) — antes del OK final, verifica con evidencia que el
  cambio está probado: resultado del pipeline o de la corrida local, cada criterio con su
  prueba, tests para el código modificado y ningún test desactivado. Solo lee, nunca
  modifica nada. **Propuesta nueva, todavía sin probar por ningún equipo.**
- **`test-pipeline-setup`** (CAP-026) — configura que los tests corran solos en cada
  cambio y en cada PR de Azure DevOps, con el resultado visible y una política que impide
  completar un PR con tests fallando. **Propuesta nueva, todavía sin probar por ningún
  equipo.**
- **`ticket-closure-assist`** (CAP-016) — antes de cerrar un ticket, revisa si sus
  criterios de aceptación realmente se cumplieron (con evidencia real, no una suposición),
  estima cuántas horas cargar a partir del historial real de commits y redacta el
  comentario de cierre; con su confirmación, lo publica, carga las horas y pasa el ticket
  a Done. **Propuesta nueva, todavía sin probar por ningún equipo.**

**Traer el contenido de un ticket automáticamente**
- **`azure-devops-context`** (CAP-002) y **`jira-context`** (CAP-003) — con solo dar la
  referencia de un ticket o Work Item (por ejemplo, `MOA-1234`), el asistente trae su
  contenido real automáticamente, en vez de que alguien tenga que copiarlo y pegarlo a
  mano. Ambos son de solo lectura. El mecanismo quedó probado durante la construcción; la
  evidencia de uso real por un equipo está en curso.

**Investigar un problema en producción**
- **`production-incident-investigation`** (CAP-017) — dado un error o incidente real
  (pegado a mano, o consultado de una plataforma de monitoreo si el equipo ya tiene una
  conectada), busca la causa más probable citando evidencia real, sin modificar nada.
  Cubre solo el diagnóstico — no cubre las otras 4 líneas de soporte que menciona el KO
  (comunicación al cliente, cierre asistido, detección de recurrencia), que siguen sin
  propuesta. **Propuesta nueva, todavía sin probar por ningún equipo.**

**Qué significa "en uso real" vs. "propuesta nueva"**: "en uso real" quiere decir que al
menos un equipo de MOA ya tenía esa práctica funcionando por su cuenta, y este repositorio
la generalizó para que cualquier otro equipo la pueda adoptar. "Propuesta nueva" quiere
decir que ningún equipo la probó todavía — está lista para usarse, pero corresponde
pilotearla antes de confiar en ella igual que en una capacidad ya probada. Ninguna, en
ningún caso, está impuesta como estándar obligatorio.

## Catálogo técnico completo

Referencia rápida con el tipo de cada capacidad, dónde está el archivo, y el link a su
entrada completa del Registry (con la evidencia detallada detrás de cada una). Se divide
en varias tablas — no porque unas valgan más que otras, sino porque el origen de la
evidencia es distinto en cada grupo.

### Con evidencia real de al menos un equipo de MOA (6)

| Capacidad | Tipo | Dónde | Para qué | Registry |
|---|---|---|---|---|
| `azure-devops-cli` | Skill | [`skills/azure-devops-cli/SKILL.md`](skills/azure-devops-cli/SKILL.md) | Operar Azure DevOps por CLI sin inventar sintaxis | [CAP-008](../registry/entries/azure-devops-cli.md) |
| `user-story` | Skill | [`skills/user-story/SKILL.md`](skills/user-story/SKILL.md) | Estructurar requerimientos en historias de usuario | [CAP-001](../registry/entries/user-story.md) |
| `read-only-code-reviewer` | Agent | [`agents/read-only-code-reviewer/AGENT.md`](agents/read-only-code-reviewer/AGENT.md) | Code review acotado al diff, sin poder de escritura | [CAP-012](../registry/entries/dotnet-code-reviewer.md) |
| `spec-driven-development` | Workflow | [`workflows/spec-driven-development/WORKFLOW.md`](workflows/spec-driven-development/WORKFLOW.md) | Llevar un ticket de spec a código verificado, con trazabilidad | [CAP-005](../registry/entries/spec-driven-development.md) |
| `repository-governance` | Instruction | [`instructions/repository-governance/INSTRUCTIONS.md`](instructions/repository-governance/INSTRUCTIONS.md) | Declarar qué puede/no puede hacer un asistente sin supervisión | [CAP-006](../registry/entries/repository-governance.md) |
| `stack-best-practices-template` | Skill | [`skills/stack-best-practices-template/SKILL.md`](skills/stack-best-practices-template/SKILL.md) | Plantilla para documentar las buenas prácticas del stack real de cada equipo | [CAP-013](../registry/entries/stack-best-practices-template.md) |
| `documentation-style` | Instruction | [`instructions/documentation-style/INSTRUCTIONS.md`](instructions/documentation-style/INSTRUCTIONS.md) | Lenguaje formal, natural y acotado en toda la documentación del modelo | [CAP-022](../registry/entries/documentation-style.md) |

### Propuestas nuevas — sin evidencia de origen todavía (CAP-004, CAP-011, CAP-014, CAP-016)

**Distinción deliberada respecto a la tabla de arriba**: las 6 capacidades anteriores son
generalizaciones de patrones reales ya en uso por al menos un equipo de MOA. Las 4 de
esta tabla **no lo son** — son propuestas directas para cerrar brechas de las 11 etapas
del SDLC del KO que no tenían ni capacidad ni propuesta, justificadas por Existing
Practice (KO/hallazgos reales de otro tipo) + External Best Practice + Architectural
Judgment (`assessment/README.md`), sin ejecución real ni piloto de ningún equipo
todavía. Ver el detalle de evidencia de cada una en su entrada del Registry.

| Capacidad | Tipo | Dónde | Para qué | Registry |
|---|---|---|---|---|
| `pr-description` | Skill | [`skills/pr-description/SKILL.md`](skills/pr-description/SKILL.md) | Título/descripción de PR a partir del ticket y el diff real | [CAP-011](../registry/entries/pr-description.md) |
| `test-case-generation` | Skill | [`skills/test-case-generation/SKILL.md`](skills/test-case-generation/SKILL.md) | Derivar casos de prueba de los criterios de aceptación | [CAP-014](../registry/entries/test-case-generation.md) |
| `ticket-closure-assist` | Skill | [`skills/ticket-closure-assist/SKILL.md`](skills/ticket-closure-assist/SKILL.md) | Verificar criterios, redactar el cierre y, con confirmación, publicarlo, cargar horas y pasar a Done | [CAP-016](../registry/entries/ticket-closure-assist.md) |
| `product-owner` | Agent | [`agents/product-owner/AGENT.md`](agents/product-owner/AGENT.md) | Rol de PO: refinar y, con confirmación, actualizar el ticket; traspaso a desarrollo | [CAP-004](../registry/entries/product-owner.md) |

### Roles del SDLC y escritura en tickets — pedido de MOA (CAP-023 a CAP-026)

Completan la cadena de traspasos guiados (PO → desarrollo → revisión → QA → validación →
cierre). Tienen precedentes reales —el `qa-tester` de DataAgro, los traspasos del PO de
Scato Logística, los patrones de confirmación de Camuzzi— pero son capacidades nuevas del
Common Core, `PROPOSAL` hasta el primer piloto.

| Capacidad | Tipo | Dónde | Para qué | Registry |
|---|---|---|---|---|
| `ticket-update` | Skill | [`skills/ticket-update/SKILL.md`](skills/ticket-update/SKILL.md) | Escritura segura en Jira / Azure DevOps, con confirmación por cambio | [CAP-023](../registry/entries/ticket-update.md) |
| `qa-analyst` | Agent | [`agents/qa-analyst/AGENT.md`](agents/qa-analyst/AGENT.md) | Rol de QA: casos de prueba, tests automatizados, publicación en el ticket | [CAP-024](../registry/entries/qa-analyst.md) |
| `test-validator` | Agent | [`agents/test-validator/AGENT.md`](agents/test-validator/AGENT.md) | Verificar con evidencia que el cambio está probado, antes del OK final | [CAP-025](../registry/entries/test-validator.md) |
| `test-pipeline-setup` | Skill | [`skills/test-pipeline-setup/SKILL.md`](skills/test-pipeline-setup/SKILL.md) | Tests automáticos en cada PR de Azure DevOps | [CAP-026](../registry/entries/test-pipeline-setup.md) |

### Propuestas con evidencia externa de un cliente de Baufest (CAP-007, CAP-009, CAP-010, CAP-015, CAP-017, CAP-018)

**Distinción respecto a las 2 tablas de arriba**: no son generalizaciones de un equipo de
MOA (como CAP-001, CAP-005, CAP-006, CAP-008, CAP-012, CAP-013), ni propuestas sin ninguna
instancia de referencia (como CAP-004, CAP-011, CAP-014, CAP-016) — tienen una instancia
real de origen, pero de un **cliente distinto de
Baufest (Camuzzi), no un equipo de MOA** (reunión 2026-09-21). Mismo tratamiento que el
resto: `PROPOSAL`, nunca `Corporate Standard`, contenido generalizado sin copiar nombres
de repos ni convenciones específicas de ese cliente.

| Capacidad | Tipo | Dónde | Para qué | Registry |
|---|---|---|---|---|
| `git-worktree-setup` | Agent | [`agents/git-worktree-setup/AGENT.md`](agents/git-worktree-setup/AGENT.md) | Aislar el trabajo de cada tarea en su propio `git worktree` | [CAP-009](../registry/entries/git-worktree-setup.md) |
| `ticket-kickoff` | Agent (orquestador) | [`agents/ticket-kickoff/AGENT.md`](agents/ticket-kickoff/AGENT.md) | Investigar, planificar e implementar un ticket, con 2 checkpoints humanos | [CAP-010](../registry/entries/ticket-kickoff.md) |
| `spec-review` | Skill | [`skills/spec-review/SKILL.md`](skills/spec-review/SKILL.md) | Auditar los artefactos de `spec-driven-development` | [CAP-007](../registry/entries/spec-review.md) |
| `regression-test-generation` | Skill | [`skills/regression-test-generation/SKILL.md`](skills/regression-test-generation/SKILL.md) | Clasificar y generar código de test de regresión | [CAP-015](../registry/entries/regression-test-generation.md) |
| `production-incident-investigation` | Agent | [`agents/production-incident-investigation/AGENT.md`](agents/production-incident-investigation/AGENT.md) | Investigar la causa raíz de un incidente de producción | [CAP-017](../registry/entries/production-incident-investigation.md) |
| `spec-reader` | Agent | [`agents/spec-reader/AGENT.md`](agents/spec-reader/AGENT.md) | Responder preguntas sobre specs ya documentadas, con citas | [CAP-018](../registry/entries/spec-reader.md) |

### Propuesta opt-in, generalizada de un equipo real de MOA (CAP-019)

**Distinción respecto a las 3 tablas anteriores**: tiene evidencia real e interna de MOA
(no es de Camuzzi), pero **no es transversal** — a diferencia de CAP-001/005/006/008/012/013,
no aplica a todo equipo, solo a proyectos reales con Windows Workflow Foundation 4.5. No
está en la primera tabla justamente para no dar a entender que es de uso general.

| Capacidad | Tipo | Dónde | Para qué | Registry |
|---|---|---|---|---|
| `workflow-documenter` | Agent | [`agents/workflow-documenter/AGENT.md`](agents/workflow-documenter/AGENT.md) | Documentar workflows WF4.5 (`.xamlx`) y diagnosticar workflows `Faulted` — **solo si el proyecto usa WF4.5** | [CAP-019](../registry/entries/workflow-documenter.md) |
| `dotnet-modernization-guide` | Skill | [`skills/dotnet-modernization-guide/SKILL.md`](skills/dotnet-modernization-guide/SKILL.md) | Guía para usar bien el agente oficial de modernización .NET de Copilot, con restricciones reales de MOA | [CAP-020](../registry/entries/dotnet-modernization-guide.md) |
| `sprint-batch-analysis` | Skill | [`skills/sprint-batch-analysis/SKILL.md`](skills/sprint-batch-analysis/SKILL.md) | Analizar todos los tickets del sprint antes de planning, en un solo lote — nunca publica en el sistema origen | [CAP-021](../registry/entries/sprint-batch-analysis.md) |

### Patrones de adquisición de contexto (2)

No son Skill/Agent/Workflow/Instruction — son la implementación concreta de traer
automáticamente el contenido real de un ticket, y por eso viven en
[`../integrations/`](../integrations/catalog.md), no en las carpetas de `capabilities/`.
Se listan acá para que la cobertura de las 11 etapas del KO quede completa en un solo
lugar — ver la sección "Sigue sin existir `capabilities/integrations/`" más abajo para la
razón completa de por qué no están en las tablas anteriores.

| Capacidad | Tipo | Dónde | Para qué | Registry |
|---|---|---|---|---|
| `azure-devops-context` | Integration/API | [`../integrations/azure-devops-context-provider.md`](../integrations/azure-devops-context-provider.md) | Traer automáticamente el contenido real de un Work Item de Azure DevOps | [CAP-002](../registry/entries/azure-devops-context.md) |
| `jira-context` | MCP | [`../integrations/jira-context-provider.md`](../integrations/jira-context-provider.md) | Traer automáticamente el contenido real de un ticket de Jira, vía MCP Atlassian | [CAP-003](../registry/entries/jira-context.md) |

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

`ai-engineering` contiene la **fuente/patrón reusable** — no el runtime ejecutable
de ningún equipo. Copiar un archivo de acá a un repo de equipo **no lo convierte
automáticamente en capacidad corporativa** — sigue siendo Team-Specific hasta que pase
por Assessment/Human Governance (`../architecture/assessment-gate.md`), sin importar
cuántas veces se copie.

```text
ai-engineering Capability Source   (capabilities/)
              ↓
      Platform Mapping                 (depende del proveedor del equipo)
              ↓
Team Repository Runtime Implementation (el equipo la adapta y ejecuta)
```

Ejemplo — Skill (GitHub Copilot):
```text
ai-engineering/capabilities/skills/user-story/SKILL.md
              ↓
Team Repository/.github/skills/user-story/SKILL.md
```

Ejemplo — Agent (GitHub Copilot):
```text
ai-engineering/capabilities/agents/read-only-code-reviewer/AGENT.md
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

**Claude Code** tiene su propio mecanismo real de distribución, ya construido —
[`../integrations/claude-code-plugin-provider.md`](../integrations/claude-code-plugin-provider.md).
Es un ecosistema separado de GitHub Copilot: instalar el plugin en uno no lo instala en
el otro (hallazgo real, 2026-09-23).

**Otras plataformas** (Copilot Studio u otras — ver Blocked Decision #2, MOA no tiene una
plataforma única sancionada): el mapeo de archivos/convenciones cambia, la **fuente y el
patrón no**. Esta tabla documenta el mapeo conocido hoy (GitHub Copilot, por ser la
plataforma con evidencia interna real dominante) — no es una nueva arquitectura, es una
aclaración de cómo se usa la ya existente.

### Camino más maduro — distribución automática (investigado y resuelto, 2026-09-21)

Copiar el archivo a mano a cada repo (como describe la tabla de arriba) es el camino que
funciona hoy, pero no el más maduro posible. Se investigó a fondo, contra fuentes
oficiales, si existe un camino automático — el resultado, sin especular, es este:

**GitHub Agent Plugins 1.0 no aplica a MOA.** GitHub/VS Code tienen, desde agosto 2026,
una especificación oficial (repo especial `.github` de organización, agents/skills/
instructions distribuidos automáticamente a todo developer que abre un repo de esa
organización) — confirmada con documentación oficial y una demostración real de un cliente
distinto de Baufest (no de MOA). Pero ese mecanismo depende de que el repo tenga su remote
en github.com bajo esa organización — y los repos reales de MOA están en **Azure DevOps**
(`az repos pr create`, Work Items — ver CAP-008/CAP-002). Se investigaron además 3
mecanismos adicionales de GitHub Enterprise que podrían no depender del hosting del repo;
ninguno resultó aplicable (detalle completo en
[`../TRACK-1/analisis-camuzzi-agent-plugins.md`](../TRACK-1/analisis-camuzzi-agent-plugins.md)).

**Actualización (2026-09-22) — corrección importante**: sí existe un camino nativo para el
resto del ciclo, distinto del repo especial `.github` de organización descartado arriba.
Ver los puntos 3 y 4.

**Lo que sí aplica, en 4 partes:**

1. **Para Code Review (una sola etapa del KO)**: Azure DevOps tiene su propio mecanismo
   nativo — instrucciones de Copilot a nivel organización/proyecto/repositorio,
   configurables en Azure DevOps Settings, sin necesidad de GitHub. Real, en preview
   público, requiere permisos de Project Collection Administrator para habilitarlo (ver
   `governance/BLOCKED-DECISIONS.md` #13).
2. **Para distribución automática, sin acción del developer**:
   [`../integrations/capability-distribution.md`](../integrations/capability-distribution.md)
   — sync por Pull Request, reutilizando `az repos pr create` (la técnica en sí ya la usan
   en producción Scato Logística/Orquestador, pero como mecanismo de distribución de este
   repositorio sigue `PROPOSAL`, sin piloto de ningún equipo todavía — a diferencia del
   punto 3, que ya es `EXECUTED`). El cambio le llega al equipo sin que nadie lo pida,
   siempre con revisión humana antes de aceptarlo. Requiere que un administrador de Azure
   DevOps habilite el permiso de escritura del pipeline — no es autoservicio.
3. **Para adopción individual con VS Code / GitHub Copilot, sin pedirle nada a un
   administrador**:
   [`../integrations/agent-plugin-provider.md`](../integrations/agent-plugin-provider.md) —
   Agent Plugins 1.0 de VS Code, confirmado real contra Azure DevOps. `EXECUTED`,
   instalación real confirmada por 3 caminos, con Agents y Skills reconocidos —
   recomendado, vía marketplace (`copilot plugin marketplace add` + `install`), por ser el
   único que GitHub no tiene marcado para discontinuar. Guía paso a paso:
   [`../adoption/agent-plugin-quickstart.md`](../adoption/agent-plugin-quickstart.md).
4. **Para adopción individual con Claude Code**: mismo objetivo que el punto 3, pero es
   un ecosistema separado — instalar uno no instala el otro.
   [`../integrations/claude-code-plugin-provider.md`](../integrations/claude-code-plugin-provider.md),
   `CONFIGURED`, sin instalación real todavía. Guía paso a paso:
   [`../adoption/claude-code-plugin-quickstart.md`](../adoption/claude-code-plugin-quickstart.md).

Las 4 no compiten entre sí — cubren necesidades distintas (gobierno centralizado vs.
autoservicio individual por plataforma vs. una etapa puntual del KO).

`ai-engineering` (este repositorio) sigue siendo, siempre, la **fuente** del modelo —
donde vive el Registry, la documentación y cada capacidad. Ningún mecanismo de
distribución (ni el de Azure DevOps para Code Review, ni el sync por PR) reemplaza esa
fuente — son formas distintas de que el contenido llegue desde acá hasta cada repo de
equipo, igual que hoy un equipo copia una capacidad a mano a su propio repo.

## Cómo usar una capacidad — ejemplo concreto, de punta a punta

No hace falta instalar nada nuevo — el propio asistente de IA ya disponible (Copilot,
Claude, el que esté en uso en el proyecto) hace el trabajo mecánico. Ejemplo real,
con `user-story` (CAP-001), aplicable de la misma forma a cualquier otra capacidad de
este catálogo.

**Antes del Paso 1 — decidir cómo va a llegar el contenido al repo.** Si ya se instaló
el plugin ([`../adoption/agent-plugin-quickstart.md`](../adoption/agent-plugin-quickstart.md)),
Skills/Agents/Workflows ya están disponibles — no hace falta ningún paso más, saltar
directo al Paso 2. Si no, hay 2 caminos, no uno solo:

- **¿Solo se necesita probarla una vez, sobre un ticket real?** → seguir el Paso 1 de
  abajo (copia manual, vía agente). Sin pedir nada a nadie, disponible ahora mismo.
- **¿El equipo va a adoptarla de forma continua, y se necesita que se mantenga
  actualizada sola cuando cambie acá?** → no copiar a mano — sumar el repo al mecanismo
  de distribución automática por Pull Request. Ver
  [`../integrations/capability-distribution.md`](../integrations/capability-distribution.md)
  y la guía paso a paso:
  [`../adoption/capability-distribution-quickstart.md`](../adoption/capability-distribution-quickstart.md).
  Requiere una decisión de gobierno (agregar tu repo a una lista explícita) — una vez
  hecho, los `agents`/`skills` te llegan como Pull Request cada vez que cambian, sin que
  nadie tenga que copiar nada.

En los 3 casos, las **Instructions** son la excepción — el plugin nunca las instala, a
propósito, siempre se completan a mano por equipo (ver
[`../adoption/getting-started.md`](../adoption/getting-started.md#2-el-camino-más-corto)).

**Paso 1 — traer la capacidad a tu repositorio (camino manual, uso puntual).** Con
`ai-engineering` clonado o accesible en tu entorno, en tu propio repositorio de
aplicación, en modo agente:

```text
Se necesita adoptar la capability CAP-001 (user-story) de ai-engineering en este
repositorio.

1. Leer capabilities/skills/user-story/SKILL.md del repositorio ai-engineering.
2. Copiar su contenido a este repositorio, en la carpeta que se use para
   instrucciones/skills de IA (si no existe ninguna, preguntar antes de crear una
   nueva).
3. En la sección "Sobre el rol", preguntar primero qué roles reales existen en este
   dominio antes de completarla — no inventar roles.
4. Mostrar el archivo final antes de guardarlo.
```

**Paso 2 — usarla sobre un ticket real de tu proyecto.** No hace falta nombrar "CAP-001"
— ese ID es solo una referencia interna de este repositorio, el asistente no lo necesita.
Alcanza con describir la tarea (detalle completo: [`../adoption/how-to-use.md`](../adoption/how-to-use.md)):

```text
Necesito refinar este ticket en una historia de usuario con criterios de aceptación:
[pegar el ticket real de tu proyecto acá]
```

**Paso 3 — revisar el resultado** antes de darlo por bueno (nunca se aprueba una salida
de IA solo por generarse), y **registrar la evidencia** copiando
[`../adoption/templates/evidence-record.md`](../adoption/templates/evidence-record.md)
a algo como `records/<tarea>/evidence.md` en el propio repositorio, completado con el
resultado real.

Con esto ya queda el primer resultado real. El resto de este documento (tablas, qué se
adapta y qué no) es para cuando se necesite el panorama completo o adoptar más de una
capacidad — la guía completa, paso a paso, con más detalle de configuración por
plataforma (Jira/Azure DevOps/Copilot) y cómo evaluar/medir, está en
[`../adoption/getting-started.md`](../adoption/getting-started.md).

## Cómo usar cualquier otra capacidad

Mismo patrón que el ejemplo de arriba, cambiando solo el nombre de la capability y el
archivo a leer — y la misma decisión de arriba (copia puntual vs. distribución
automática) aplica igual:

1. Abrir el archivo de la capacidad (no solo la tabla de este documento) — cada una
   tiene: cuándo usarla, cuándo NO, entradas/salidas, seguridad, HITL, ejemplos, y qué
   adaptar.
2. Copiar **la estructura**, no el contenido literal de otro equipo — cada capacidad
   generalizada está deliberadamente sin contenido de dominio específico donde ese
   contenido no es portable (ver `stack-best-practices-template` como el caso más
   explícito).
3. Completar el Evidence/Evaluation/Measurement Contract al ejecutarla.

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
├── skills/              12 capacidades (ver la entrada de cada una en el Registry)
├── agents/              9 capacidades (roles del SDLC, orquestador de desarrollo y agentes de consulta)
├── instructions/         2 capacidades
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
[CAP-002](../registry/entries/azure-devops-context.md) (Azure DevOps) y
[CAP-003](../registry/entries/jira-context.md) (Jira) — pero **viven en
[`../integrations/`](../integrations/catalog.md), no en `capabilities/`**, precisamente
porque no son capacidades de negocio seleccionables de la misma forma que Skill/Agent/
Workflow/Instruction — son la implementación concreta de un concern transversal. Ver
[`security/security-governance.md`](../security/security-governance.md)
para el detalle completo de gobierno de MCP.
