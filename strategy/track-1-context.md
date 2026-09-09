# Track 1 — Evolucionar los servicios actuales

**Naturaleza de este documento**: contexto rector temporal (ver sección 21). Toda
afirmación está clasificada como **FACT** (evidencia directa en el repositorio actual),
**INFERENCE** (conclusión razonable, no declarada explícitamente en ningún documento),
**PROPOSAL** (recomendación arquitectónica, no decisión ratificada) o
**REQUIRES VALIDATION** (pendiente de confirmar). Donde un documento fue superseded, se
usa el documento canónico vigente y se deja constancia del reemplazo, no del contenido
superseded.

## 1. Identidad del Track

**Nombre oficial**: Track 1 — EVOLUCIONAR LOS SERVICIOS ACTUALES. Uno de 3 tracks de la
estrategia de IA de MOA — los otros dos (acelerar time-to-market de nuevos proyectos;
integrar modelos propios en plataformas de IA) están fuera del alcance de este repositorio
(FACT — [`vision.md`](vision.md)).

## 2. Objetivo

### Objetivo rector

**FACT — vigente, tal como está documentado hoy**: "Construir un modelo base de AI
Engineering para MOA que permita a los distintos equipos y proyectos incorporar IA de
manera sistemática, gobernada, reutilizable y medible dentro del SDLC, acelerando la
evolución de los servicios actuales para mejorar productividad, calidad, seguridad,
trazabilidad y velocidad de entrega."

### Cómo se construye el modelo

**PROPOSAL — mecanismo permanente de construcción y evolución del modelo, no una fase
adicional del proyecto.** El modelo se construye combinando **dos fuentes de
conocimiento**, nunca una sola:

1. **Prácticas reales de MOA (Internal MOA Evidence)** — prácticas, patrones,
   capacidades, workflows, integraciones, agentes y mecanismos de gobierno que ya están
   siendo utilizados en proyectos reales de MOA con evidencia suficiente de utilidad o
   adopción (ver sección 13 y `../docs/history/track-1/relevamiento-capacidades-g2.md`).
2. **Expertise y mejores prácticas de AI Engineering (AI Engineering Expertise /
   External Practice)** — conocimiento especializado de la disciplina, incorporado
   cuando es relevante para MOA, nunca en reemplazo de la evidencia interna ni como
   estándar automático (ver subsección "Fuentes de conocimiento del modelo" más abajo).

Ambas fuentes pasan por el mismo filtro, sin atajos para ninguna de las dos: relevancia
→ análisis crítico → compatibilidad con MOA → riesgo → utilidad esperada → posibilidad
de validación → adaptación → validación real (detalle del pipeline: sección 3; rubric de
14 dimensiones, aplicado por igual a ambas fuentes: sección 6, capa 3).

Declaración de visión original ([`vision.md`](vision.md), sigue vigente sin
contradicción): *"Pasar del uso individual y heterogéneo actual de la IA a una adopción
sistemática en todo el SDLC de nuestros equipos para MOA, con un enfoque común, gobierno
y métricas que conecten la IA con el impacto positivo en el equipo y en el negocio."* —
*"No se trata de sumar herramientas, sino de convertir el uso de IA en una práctica
sostenida de ingeniería."* La visión declara el **para qué**; el objetivo rector de
arriba declara **qué debe entregar Track 1**; el mecanismo de esta subsección declara
**cómo se construye**. Los tres no compiten entre sí.

### Resultado esperado

El resultado de Track 1 debe ser un modelo base reutilizable que permita a los equipos:

1. Identificar oportunidades de uso de IA dentro de su SDLC.
2. Seleccionar una práctica/capability adecuada.
3. Adoptarla o adaptarla al contexto del equipo.
4. Utilizar contexto manual o conectado cuando exista una integración autorizada.
5. Ejecutarla sobre trabajo real.
6. Mantener gobierno, seguridad y HITL según el riesgo.
7. Generar evidencia trazable.
8. Evaluar la calidad/corrección del resultado.
9. Medir impacto cuando exista baseline.
10. Retroalimentar y evolucionar el modelo.

### Origen del modelo

Track 1 **no parte de cero**, pero tampoco queda limitado por el estado actual de MOA: el
modelo combina evidencia real de MOA con expertise externo de AI Engineering (ver
subsección "Fuentes de conocimiento del modelo" a continuación), sintetizados mediante el
mismo mecanismo de análisis crítico. De forma conceptual y breve (ver sección 5 y sección
6 para el detalle formal equivalente — esto es una síntesis para claridad del objetivo,
no una tercera fuente nueva):

```
MOA Real Practices + AI Engineering Expertise / Best Practices
        ↓
Análisis crítico
        ↓
Gap / Riesgo / Oportunidad
        ↓
Adopt / Adapt / Improve / Create / Discard
        ↓
MOA Target Pattern (Capability / Pattern / Golden Path)
        ↓
Modelo base reutilizable
        ↓
Adopción por otros equipos
        ↓
Ejecución real
        ↓
Evaluación + Medición
        ↓
Feedback
        ↓
Evolución del modelo
```

### Fuentes de conocimiento del modelo

**PROPOSAL — marco conceptual permanente que gobierna toda incorporación de
conocimiento al modelo, no una fase adicional.** Toda práctica que entra al modelo se
clasifica en uno de tres niveles, sin mezclarlos:

- **A. Internal MOA Evidence** — práctica observada directamente en un proyecto real de
  MOA, con evidencia verificable (código, configuración, historial de commits/PRs) — ver
  sección 13 y [`../docs/history/track-1/relevamiento-capacidades-g2.md`](../docs/history/track-1/relevamiento-capacidades-g2.md).
  Ejemplos ya identificados con evidencia (no exhaustivo, no implica que todo lo listado
  ya sea Common Core): Spec-Driven Development, agent harness, roles especializados,
  contratos de entrada/salida, estados, evidencia, human approval, retry/rollback, audit
  trail y Definition of Done en `moa-sdlc`; integración Jira + Atlassian MCP, agentes
  especializados y separación Product Owner/Architect en Orquestador; model
  selection/routing, benchmark de modelos y repository-first analysis en Scato
  Logística.
- **B. AI Engineering Expertise / External Practice** — conocimiento recomendado por la
  disciplina de AI Engineering / Agent Engineering, incorporado cuando es relevante para
  MOA: arquitectura de agentes; separación entre planning, reasoning y execution; límites
  de autonomía; Human-in-the-Loop; tool governance; least privilege; MCP governance;
  Context Engineering; Resolved Context; seguridad de agentes; prompt injection y data
  exfiltration; evaluación de capabilities/agentes/herramientas; evaluation datasets;
  evaluación humana; automated evaluation cuando corresponda; LLM-as-a-judge cuando
  corresponda y con controles; observabilidad AI-native; tracing; auditabilidad; model
  selection/routing; benchmarking; costo/latencia/calidad; gestión de estado y memoria;
  context drift; retries/rollback/recovery; multi-agent orchestration; versionado;
  lifecycle de capacidades; continuous improvement; métricas de productividad, calidad,
  seguridad y velocidad; gobierno basado en riesgo. Este repositorio ya usa esta
  categoría de forma puntual bajo el nombre `EXTERNAL EVIDENCE` — ver
  [`../capabilities/best-practices.md`](../capabilities/best-practices.md) (guía de
  seguridad de agentes de Anthropic aplicada a `read-only-code-reviewer`, CAP-003) y la
  taxonomía de evaluación de [`../assessment/README.md`](../assessment/README.md), que ya
  incluye `EXTERNAL EVIDENCE` como una de sus 5 categorías.
- **C. MOA Target Pattern** — la forma adaptada/mejorada, resultado de aplicar análisis
  crítico a A y/o B, que este repositorio propone como patrón reutilizable. Nunca es una
  copia literal de A ni una adopción directa de B — sale del Assessment Gate (sección 6,
  capa 3) con una clasificación explícita (`ADOPT`/`ADAPT`/`IMPROVE`/`CREATE`/`DISCARD`),
  no de una decisión implícita.

**Regla dura, sin excepción**: una práctica de la Fuente B **no** se convierte en
estándar de MOA por el solo hecho de ser una buena práctica reconocida — debe pasar por
el mismo pipeline que una práctica de la Fuente A (relevancia → análisis crítico →
compatibilidad con MOA → riesgo → utilidad esperada → posibilidad de validación →
adaptación → validación real, sección 3). De la misma forma, una práctica de la Fuente A
**no** se convierte en Corporate Standard solo por existir en un repo de MOA (regla ya
vigente, ver sección 4 y `lifecycle.md` regla dura #1). **Ninguna práctica de ninguna de
las 2 fuentes fue elevada a `Corporate Standard: Y` hasta hoy** (ver sección 12 y
[`../registry/INDEX.md`](../registry/INDEX.md)).

**Ejemplo de aplicación correcta (no mezclar niveles)**:

*No escribir*: "MOA utiliza Jira MCP, por lo tanto Jira MCP es el estándar."

*Sí escribir*: "Orquestador y otros proyectos proporcionan Internal MOA Evidence de uso
de Jira/MCP (Fuente A). La práctica se analiza junto con principios de Context
Engineering y tool governance (Fuente B). El MOA Target Pattern resultante (Fuente C)
desacopla el proveedor mediante Context Acquisition + Resolved Context
(`../architecture/context-acquisition-resolution.md`), permitiendo reutilizar la
capacidad con Jira, Azure DevOps u otros proveedores autorizados — evidencia real ya
registrada para ambos proveedores (`EXEC-20260908-003` vía Azure DevOps,
`EXEC-20260908-004`/`EXEC-20260908-005` vía Jira/MCP, ver
[`../registry/entries/user-story.md`](../registry/entries/user-story.md))."

Otro ejemplo: *no* "Scato usa distintos modelos, por lo tanto MOA debe usar esos
modelos" — *sí* "Scato proporciona Internal MOA Evidence de model routing y
benchmarking (Fuente A). La práctica se generaliza, con expertise de la disciplina
(Fuente B), como selección de modelo basada en tarea, calidad, costo, latencia y riesgo,
manteniendo el proveedor desacoplado (Fuente C)." Otro: *no* "`moa-sdlc` tiene 6
agentes, por lo tanto MOA debe tener esos 6 agentes" — *sí* "`moa-sdlc` proporciona
Internal MOA Evidence de separación de responsabilidades, contratos, estados, evidencia
y aprobación humana (Fuente A). El MOA Target Pattern generaliza estos principios sin
imponer un conjunto fijo de agentes (Fuente C)."

### Criterio de inclusión al Common Core

Una práctica **no** entra al Common Core simplemente porque exista en un proyecto, porque
esté documentada, porque utilice una herramienta determinada o porque haya sido creada
por varios equipos. Debe existir evidencia suficiente de utilidad y debe pasar por
análisis crítico, evaluación de reusabilidad, seguridad, riesgo y capacidad de
adaptación (pipeline completo: sección 3; rubric de 14 dimensiones: sección 6, capa 3).

Regla dura existente, sin cambios (ver también sección 4): **`CONFIGURED ≠ USED ≠ MATURE
≠ MEASURED ≠ PROVEN`**.

### Qué NO es Track 1

Track 1 **no** busca:

- crear una plataforma central de IA;
- imponer una única herramienta o proveedor;
- copiar los repositorios de los equipos;
- crear documentación extensa por sí misma;
- crear agentes/skills/MCP simplemente porque sea técnicamente posible;
- convertir automáticamente una práctica de un equipo en estándar corporativo;
- demostrar ROI sin medición;
- llenar el repositorio de artefactos que no tengan utilidad operacional.

"El repositorio es el vehículo versionado del modelo; el producto es el modelo reutilizable
de AI Engineering y su capacidad de adopción por los equipos."

### ¿Cuándo consideramos que Track 1 está terminado?

Track 1 estará listo para entrega cuando:

- exista un modelo base coherente;
- existan capacidades/patrones reutilizables derivados de prácticas reales;
- exista un mecanismo claro de adopción y adaptación;
- exista gobierno, seguridad y trazabilidad;
- exista evidencia de ejecución real;
- al menos una validación independiente haya demostrado que un equipo/persona puede
  utilizar el modelo sobre una actividad real del SDLC;
- exista un mecanismo para evaluar y medir resultados;
- las limitaciones que todavía requieran validación estén explícitamente delimitadas y
  tengan criterio de cierre.

**Importante**: no se exige que todas las capabilities estén `VERIFIED` para considerar
terminado el Track. El objetivo es validar el **modelo base** y demostrar que puede ser
reutilizado. Las capabilities individuales pueden continuar evolucionando mediante el
lifecycle (`../architecture/lifecycle.md`). Este es el criterio operativo de validación
del modelo a nivel de objetivo — la sección 19 (Criterios de finalización) mantiene,
además, el checklist formal y más granular de cierre del Track (aprobación de decisiones
pendientes, Blocked Decisions, baseline medido); ambos criterios son complementarios, no
contradictorios: este describe cuándo el **modelo** está validado, la sección 19 describe
cuándo el **Track** puede darse formalmente por cerrado.

### Orientación del trabajo actual

"El trabajo actual ya no está orientado a seguir diseñando el modelo desde cero. El
modelo base está construido; el foco ahora es ejecutar pruebas reales con equipos,
validar adopción independiente, medir cuando exista baseline y corregir únicamente
aquello que la evidencia real demuestre que debe mejorar."

## 3. Propósito estratégico

Track 1 combina **dos fuentes de conocimiento** — prácticas reales de IA que ya ocurren en
MOA (Internal MOA Evidence) y expertise / mejores prácticas actuales de AI Engineering
relevantes para MOA (AI Engineering Expertise / External Practice) — ver "Fuentes de
conocimiento del modelo" en la sección 2. No parte de un diseño en blanco limitado a lo
que MOA ya hace hoy, ni de un framework genérico externo adoptado sin validación. Sigue el
pipeline definido en [`../assessment/README.md`](../assessment/README.md): identificar
capacidades y patrones existentes — de cualquiera de las 2 fuentes — → analizarlos con
evidencia → distinguir configuración, uso real, madurez y resultados (regla dura, sin
excepción: `CONFIGURED ≠ USED ≠ MATURE ≠ MEASURED ≠ PROVEN`) → identificar fortalezas, gaps
y riesgos → mejorar las prácticas existentes → determinar qué puede convertirse en patrón
reusable → establecer un modelo base común → permitir adaptación por equipo → validar
mediante adopción y uso real → medir cuando exista baseline → incorporar feedback para
evolución continua.

**El objetivo NO es inventar desde cero un framework de IA, ni copiar únicamente lo que
MOA ya hace, ni imponer una implementación idéntica a todos los equipos** (FACT —
principio explícito en [`../operating-model.md`](../architecture/operating-model.md):
*"Common Core ≠ centralizar todo. Team autonomy debe preservarse."*). **Tampoco cualquier
recomendación externa de AI Engineering se convierte automáticamente en estándar de
MOA** — pasa por el mismo Assessment Gate que una práctica interna, sin atajos para
ninguna de las 2 fuentes (ver "Fuentes de conocimiento del modelo", sección 2).

## 4. Principios rectores

**PROPOSAL** en su totalidad (no ratificados formalmente por un gobierno de MOA — ver
sección 16, Blocked Decision #1) — vigentes como principios de trabajo de este
repositorio. Los 12 de [`principles.md`](principles.md):

1. AI augments people, it does not blindly replace them.
2. Human-in-the-loop obligatorio cuando las acciones puedan afectar código crítico,
   infraestructura, seguridad, datos, producción o decisiones relevantes.
3. Security by Design.
4. Evidence over assumptions.
5. Measure real impact, not only AI usage.
6. Reuse before reinventing — nunca automático, pasa por assessment.
7. Team autonomy within governance.
8. Start small and scale progressively.
9. Crawl → Walk → Run.
10. Experimentation must lead to measurable learning.
11. Capabilities should be reusable whenever possible.
12. Governance must enable adoption, not unnecessarily block it.

**Principios adicionales, vigentes pero documentados en otros archivos** (no forman parte
de la lista de 12 de `principles.md` — se citan por su fuente real):

- **CONFIGURED ≠ USED ≠ MATURE ≠ MEASURED ≠ PROVEN** — regla dura desde
  [`../architecture/capability-registry.md`](../architecture/capability-registry.md), las
  4 columnas se completan de forma independiente, ninguna se infiere de otra.
- **Capability ≠ Integration** — [`../architecture/capability-model.md`](../architecture/capability-model.md):
  Skill/Agent/Workflow son capacidades distintas de Integration/API y MCP; una capability
  debe poder ejecutarse con o sin integración.
- **READ ≠ ACT** — hoy vive disuelto dentro del factor "Read/write" del modelo de riesgo
  proporcional ([`../security/security-governance.md`](../security/security-governance.md)
  §1) — **no tiene contrato propio todavía** (ver sección 9 y sección 16).
- **Provider-agnostic** — [`../architecture/reference-architecture.md`](../architecture/reference-architecture.md):
  el modelo no asume GitHub Copilot, Copilot Studio ni Claude como plataforma única.
- **Una implementación de equipo no es automáticamente un estándar corporativo** —
  [`../architecture/lifecycle.md`](../architecture/lifecycle.md), regla dura #1: ninguna
  capacidad salta etapas por antigüedad, tamaño de equipo o repetición en varios repos.
- **No crear agentes solo porque es técnicamente posible** —
  [`../governance/agent-governance.md`](../governance/agent-governance.md), principio
  rector explícito.
- **No inventar métricas, evidencia, feedback ni resultados** — regla dura en
  [`../architecture/evidence-evaluation-measurement.md`](../architecture/evidence-evaluation-measurement.md):
  sin dato real, el campo dice `NOT MEASURED`/`NOT EVALUATED`, nunca un valor inventado.
- **Common Core + Assessment Gate + Team Adaptation** — las 3 capas centrales del modelo
  operativo, ver sección 6.
- **Adopt / Adapt / Validate / Promote / Iterate** — vocabulario del ciclo de vida de una
  capacidad, ver sección 5; **INFERENCE**: el orden exacto de estas 5 palabras no aparece
  como secuencia única en ningún documento — es una síntesis del bloque Adoption Status de
  `lifecycle.md` (Adopt/Adapt/Improve) combinado con el paso Promote del Capability
  Lifecycle. No confundir con la clasificación de `assessment-gate.md`
  (ADOPT/ADAPT/TEAM-SPECIFIC/VALIDATE/REJECT), que es una taxonomía distinta con el mismo
  vocabulario parcial — **contradicción de nomenclatura no resuelta**, ver sección 16.

## 5. Modelo de evolución

**FACT, con matices de orden a validar contra la fuente exacta**. El repositorio define
el pipeline (`Problema/proceso → Use Case → Valor + Riesgo → Assessment → Selección de la
capacidad adecuada → Evaluación → Piloto → Medición → Gobierno → Validación →
Reutilización/escalamiento`, [`../assessment/README.md`](../assessment/README.md)) y, en
paralelo, el **Capability Lifecycle** de una capacidad individual
(`Use Case → Value+Risk → Design → Pilot → Evaluation → Measure → Human Validation →
Promote`, [`../architecture/lifecycle.md`](../architecture/lifecycle.md)) seguido del
bloque **Adoption Status** (`Common Core = Y/N → Adopt/Adapt/Improve, en paralelo por
equipo`). Ambos representan el mismo ciclo a distinto nivel de detalle — no compiten entre
sí ([`roadmap.md`](roadmap.md)).

Forma resumida (equivalente conceptual, no una tercera fuente nueva):

```
Problema → Use Case → Value + Risk → Assessment → Pilot →
Capability (Skill/Agent/Workflow/Instruction/Integration) →
Evaluation → Measure → Human Validation → Promote →
Reusable Pattern (Common Core) → Adopt/Adapt por otros equipos
```

**Este flujo representa una evolución basada en evidencia, no una obligación mecánica
para todos los casos** — ninguna capacidad relevada hasta hoy completó el ciclo entero
(ninguna alcanzó `Human Validation` ni `Common Core = Y`, ver sección 17).

## 6. Modelo arquitectónico vigente

**FACT** — [`../architecture/reference-architecture.md`](../architecture/reference-architecture.md),
5 capas:

| Capa | Responsabilidad |
|---|---|
| **1. Team Layer** | Equipos/servicios de MOA con evidencia real. Entregan valor de negocio en su dominio — no es su responsabilidad producir capacidades reusables (aunque puede ocurrir). No gobernado por este repositorio, lo consume opcionalmente. |
| **2. Team Adaptation Layer** | Capacidades de IA específicas de cada equipo, viven en el repo del equipo. El equipo las mantiene, decide qué consume del Common Core, y qué propone para promoción. |
| **3. Assessment / Promotion Gate** | Rubric de 14 dimensiones aplicado dentro del pipeline de la sección 5. Produce una clasificación razonada, nunca una promoción automática. La aprobación final queda fuera de este gate — ver Blocked Decision #1 (sección 16). |
| **4. Common Core** | Standards, Reusable Capabilities, Golden Paths, Governance, Security, Evaluation, Observability, Metrics, Registry, Enablement — la capacidad organizacional/técnica compartida, no "todo centralizado". No impone tecnología ni reemplaza el criterio del equipo. |
| **5. AI Engineering Foundation** | Principios y visión (`strategy/`) que gobiernan todo lo anterior — si una decisión de una capa inferior contradice esta capa, la Foundation prevalece. |

## 7. Capability Model vigente

**FACT** — [`../architecture/capability-model.md`](../architecture/capability-model.md).
La taxonomía vigente **no** es idéntica a una lista simple de "Prompt/Instruction/Skill/
Workflow/Knowledge-RAG/Agent/Tool-MCP-API/Automation" — se estructura en 3 bloques
distintos, y esta distinción es intencional, no accesoria:

- **Pre-Artifact (1)**: **Prompt** — instrucción puntual, no versionada, estado informal
  previo a convertirse en cualquier capacidad. No se registra en el Registry.
- **Capabilities seleccionables (7)**: **Instruction, Skill, Workflow, Agent,
  Knowledge/RAG, Integration/API, MCP**. **Integration/API y MCP son 2 capacidades
  distintas**, no una sola "Tool/MCP/API" — Integration/API es un conector de propósito
  específico, MCP es descubrimiento dinámico gobernado. **No existe una capacidad llamada
  "Automation"** en el modelo vigente hoy — es un concepto todavía en evaluación (ver
  sección 14, Decisión #8; `PROPOSAL / REQUIRES VALIDATION`, no adoptado).
- **Cross-Cutting Concerns (3)**: **Evaluation, Observability, Metrics** — no se "eligen"
  para resolver un caso de uso de negocio, operan **sobre** instancias de las 7
  capacidades de arriba.

**Reglas de desambiguación ya vigentes** (sin cambios recientes): un checklist genérico
sin contenido accionable no es Skill; Skill es referencia estática cargada on-demand,
Agent requiere razonamiento dinámico/selección de herramienta; Workflow es secuencia fija
conocida de antemano, Agent decide dinámicamente qué hacer.

## 8. Integraciones y adquisición de contexto

**Modo manual (FACT, es el mecanismo predominante hoy)**: el usuario proporciona
directamente el contexto — copy/paste a un asistente de IA.

**Modo conectado (PROPOSAL como concepto formal; CONFIGURED como implementación parcial)**:
el usuario proporciona una referencia (ej. un ticket) y una integración autorizada
recupera el contexto desde el sistema origen. Jira, Azure DevOps, SharePoint y otros
sistemas **pueden** actuar como fuente de contexto cuando exista una integración real y
autorizada — **no todas están disponibles en todos los proyectos**.

Distinción obligatoria, aplicada sin excepción
([`../integrations/catalog.md`](../integrations/catalog.md)):

| Estado | Significado | Ejemplo real |
|---|---|---|
| **Capacidad del modelo** | El modelo conceptual permite integraciones (Integration/API, MCP) | Definido en `capability-model.md`, sin implicar ninguna instancia real |
| **Integración existente** | Hay evidencia de código/config real | Conectores Python de `moa-metrics` (Jira, Azure DevOps Repos, GitHub Copilot Metrics, SonarQube) |
| **Integración configurada** | Config real commiteada, sin evidencia de ejecución | MCP de Azure DevOps (`.vscode/mcp.json` en un repo real de equipo), MCP de Atlassian (2 repos) |
| **Integración realmente utilizada** | Evidencia directa de invocación | CLI de Azure DevOps (evidencia real en historial de commits/PRs); ningún MCP relevado alcanzó este nivel |
| **Integración pendiente de validación** | No se puede confirmar desde el repositorio | Si existe `mcp.json` a nivel de usuario/organización que respalde referencias de agents sin config local — ver Blocked Decision #4 |

**No se afirma que Context Acquisition & Resolution exista hoy como mecanismo unificado**
— es el gap arquitectónico de mayor impacto identificado hasta ahora (ver sección 14,
Decisión #1).

## 9. READ vs ACT

**PROPOSAL, sin contrato propio todavía**. El modelo distingue conceptualmente:

- **READ**: recuperar contexto, consultar información, analizar — sin modificar estado
  externo.
- **ACT**: crear/modificar información, ejecutar acciones o producir efectos en sistemas
  externos.

Hoy esta distinción vive únicamente como uno de los factores del modelo de riesgo
proporcional ([`../security/security-governance.md`](../security/security-governance.md)
§1: "Read/write, ¿lee o modifica el sistema externo?"), **no como una frontera con
contratos propios**. El modelo debe evolucionar hacia integraciones y automatizaciones
gobernadas, con controles de permisos, alcance, trazabilidad y riesgo diferenciados por
READ vs. ACT — **PROPOSAL**, no implementado. **No se asume que una integración READ
implica capacidad ACT** — regla ya aplicada en la evidencia relevada (ningún MCP READ
encontrado declara ACT por defecto; donde ACT sí está declarado, es explícito y separado,
ej. scope wildcard vs. scope acotado en agents distintos del mismo repo).

## 10. Evidence, Evaluation, Measurement y Observability

**FACT — modelo completo y vigente**,
[`../architecture/evidence-evaluation-measurement.md`](../architecture/evidence-evaluation-measurement.md):

```
Ejecución → Evidence (qué ocurrió)
Evidence → Evaluation (¿es correcto?)
Evidence → Measurement (¿qué impacto tuvo?)
```

Evaluation y Measurement son consumidores **independientes** de la misma Evidence, no
pasos secuenciales entre sí — una capacidad puede tener Evaluation sin Measurement, o
viceversa. **Evidence demuestra que algo ocurrió; Evaluation determina calidad/corrección
contra criterios declarados antes de evaluar; Measurement determina resultados
cuantitativos únicamente cuando existe baseline real** (`NOT MEASURED` explícito si no lo
hay — nunca un `0` inventado). **Observability** ([`../architecture/evaluation-observability.md`](../architecture/evaluation-observability.md))
responde qué ocurrió durante la ejecución (tool calls, errores, latencia, modelo,
costo, trazabilidad) — brecha fundacional confirmada sin excepción en toda la evidencia
relevada: **NOT FOUND** en los equipos de MOA analizados.

**Regla de ejecución**: Evaluation y Observability se ejecutan en el contexto local del
equipo cuando es técnicamente viable — el Common Core define el contrato (Standards,
Patterns, Contracts, Reporting interfaces), no impone una plataforma centralizada
obligatoria.

## 11. Human-in-the-loop

**FACT — distinción vigente**, introducida para separar 2 conceptos que se confundían:

- **Human Review operativo**: revisión humana rápida del resultado generado, detecta
  errores obvios, decide si reintentar. **No sustituye** la evaluación formal.
- **Human Evaluation formal**: evaluación contra criterios explícitos declarados antes de
  evaluar, genera el Evaluation Record, requiere HITL obligatorio cuando el resultado
  puede habilitar una promoción real o tener impacto en producción.
- **Human Approval**: el paso `Human Validation` del Capability Lifecycle — una persona
  con mandato revisa evidencia y decide explícitamente antes de `Promote`. **REQUIRES
  VALIDATION quién tiene ese mandato** (Blocked Decision #1).
- **Límites de autonomía**: matriz de 3 niveles ALWAYS / ASK FIRST / NEVER — el **formato**
  es una definición propia del Common Core; el **contenido** es específico de cada
  equipo/stack, sin una matriz de referencia única a copiar.

**No se asume que una revisión humana preparada (declarada en el diseño de un agente)
equivale a una revisión humana ejecutada** — regla explícita, consistente con
`CONFIGURED ≠ USED` aplicado a HITL específicamente.

## 12. Estado actual del producto

**FACT, estado real del repositorio** — el modelo está construido y la biblioteca de
capacidades es real y usable, con condiciones:

- **Arquitectura**: 5 capas definidas ([`../architecture/reference-architecture.md`](../architecture/reference-architecture.md)),
  taxonomía de capacidades definida, ciclo de vida definido, rubric de assessment
  definido.
- **Registry**: modelo conceptual de campos definido
  ([`../architecture/capability-registry.md`](../architecture/capability-registry.md));
  6 entradas reales pobladas ([`../registry/INDEX.md`](../registry/INDEX.md)) — ninguna
  `Corporate Standard: Y`.
- **Capabilities**: 6 capacidades materializadas como fuente/patrón reusable
  ([`../capabilities/README.md`](../capabilities/README.md)) — 3 Skills, 1 Agent, 1
  Workflow, 1 Instruction.
- **Golden Paths**: 6 documentados, **solo 1 (AI-Assisted Requirements) tiene ejecuciones
  reales** (`HARDENED` en el sentido de evidencia real, no de validación independiente) —
  los otros 5 son `PROPOSAL` conceptual.
- **Adoption Model**: guía paso a paso, modelo de ejecución de 12 pasos, plantillas
  operativas de Adoption/Execution/Evidence/Evaluation/Measurement Record.
- **Evidence/Evaluation/Measurement contracts**: definidos y aplicados 2 veces —
  `evidence/`, `evaluation/`, `measurements/` tienen 2 registros reales cada uno, ambos
  `CONTROLLED DRY-RUN` del mismo actor, ninguno independiente.
- **Governance**: pipeline de agentes (`TRIGGER→CONTEXT→DECISION→ACTION→VALIDATION→AUDIT`),
  niveles de gobierno (Corporate/Reusable/Team-Specific), human-in-the-loop obligatorio
  para acciones de alto impacto.
- **Security**: modelo de riesgo proporcional (no binario), gobierno específico de MCP,
  2 hallazgos reales de MCP documentados con su estado de riesgo.
- **Contribution model**: definido, **ninguna contribución real todavía**.
- **Documentación**: benchmark de prácticas reales (6 repos analizados) e input de
  decisión arquitectónica ya producidos, pendientes de aprobación del Arquitecto
  Supervisor (ver sección 14).

## 13. Evidencia del ecosistema MOA

**FACT donde se cita evidencia directa; INFERENCE donde se marca explícitamente.** 3 de 6
equipos/repos analizados tienen capacidades de IA formalizadas reales (agents, skills,
instructions) — 3 no tienen ninguna. Hallazgos concretos con respaldo directo:

- **Agents/Skills/Instructions** formalizados en 3 repos, con contenido leído directamente
  (no inferido por nombre de archivo).
- **MCP Azure DevOps** (config real, 1 repo) y **MCP Atlassian/Jira** (config real en 1
  repo, referenciado sin config local en 2 repos más) — **ningún MCP tiene evidencia de
  invocación real**.
- **Azure DevOps CLI**: uso real confirmado (evidencia de commits/PRs reales).
- **`moa-sdlc`**: herramienta de referencia de Baufest, **no un equipo de MOA** — aporta
  un patrón de Workflow formal (harness de roles con contrato explícito), sin capacidades
  Agent/Skill propias materializadas en el Registry.
- **Copilot Studio / "Mola"**: chatbot de producción real, embebido en un producto de un
  equipo de MOA — no encaja en la taxonomía actual de capacidades (ver sección 14,
  Decisión #5).
- **GitHub Copilot**: asistente de codificación de uso extendido; **no existe evidencia de
  una plataforma de IA única sancionada por MOA** (Blocked Decision #2 sigue abierta).

**No se afirma convergencia corporativa solo porque varios equipos tengan patrones
similares** — la evidencia de autoría real muestra concentración en pocas personas, no
adopción distribuida independiente (`../architecture/lifecycle.md`, regla dura #3:
Origin ≠ Ownership ≠ Adoption ≠ Standardization).

## 14. Benchmark → Target Model

**FACT** — estado tal como quedó documentado en
[`benchmark-to-target-model-decision-input.md`](../architecture/benchmark-to-target-model-decision-input.md),
**pendiente de aprobación del Arquitecto Supervisor** — nada de esto está implementado:

| # | Área de decisión | Estado |
|---|---|---|
| 1 | Context Acquisition & Resolution | **GAP** |
| 2 | Capability vs. Integration | **DO NOT CHANGE** (ya correcto) |
| 3 | READ vs. ACT | **GAP** |
| 4 | Evaluation & Observability | **DO NOT CHANGE** (modelo ya correcto); reagrupación de señales = **ADOPT WITH MODIFICATION** menor |
| 5 | Copilot Studio / Conversational AI | **GAP** (requiere concepto nuevo "Channel/Interface", no una 8va capacidad) |
| 6 | Capability taxonomy | **DO NOT CHANGE** |
| 7 | Knowledge / RAG | **ADOPT WITH MODIFICATION** (corregir precisión del estado documentado, no implementar RAG) |
| 8 | Automation / Autonomy | **REQUIRES VALIDATION** (riesgo de duplicar el campo `Autonomy` ya existente) |
| 9 | Common Core evolution | **DO NOT CHANGE** (estructura de 10 componentes) |
| 10 | Registry evolution | **GAP** (4 campos candidatos identificados, ninguno implementado) |

**Ninguna decisión pendiente fue resuelta para completar esta sección** — donde el input
de decisión la deja como `REQUIRES VALIDATION`, se mantiene así acá.

## 15. Decisiones vigentes

| Decisión | Estado | Evidencia / referencia | Impacto |
|---|---|---|---|
| Taxonomía de 7 capacidades + Pre-Artifact + 3 Cross-Cutting Concerns | Vigente | [`../architecture/capability-model.md`](../architecture/capability-model.md) | Alto — base de todo el modelo |
| Modelo de 5 capas (Team → Team Adaptation → Assessment Gate → Common Core → Foundation) | Vigente | [`../architecture/reference-architecture.md`](../architecture/reference-architecture.md) | Alto |
| Fork Evidence → [Evaluation, Measurement] → Feedback, independientes entre sí | Vigente | [`../architecture/evidence-evaluation-measurement.md`](../architecture/evidence-evaluation-measurement.md) | Alto |
| Evaluation/Observability se ejecutan localmente; el Common Core provee contrato, no ejecución | Vigente | [`../architecture/evaluation-observability.md`](../architecture/evaluation-observability.md) §0 | Medio |
| No implementar MCP en esta fase (alcance explícito) | Vigente | [`../capabilities/README.md`](../capabilities/README.md) | Alto — bloquea el Modo conectado de contexto (sección 8) |
| 6 capacidades materializadas como fuente reusable (no `Corporate Standard`) | Vigente | [`../registry/INDEX.md`](../registry/INDEX.md) | Medio |
| Golden Path #1 es el único con evidencia real de ejecución; los otros 5 son conceptuales | Vigente | [`../golden-paths/README.md`](../golden-paths/README.md) | Medio |
| Formato de matriz de autonomía ALWAYS/ASK FIRST/NEVER (sin contenido de referencia único) | Vigente | [`../governance/agent-governance.md`](../governance/agent-governance.md) | Medio |
| `moa-sdlc`/`moa-metrics` son herramientas de referencia de Baufest, no equipos de MOA | Vigente (corrección de alcance ya aplicada) | [`../teams/README.md`](../teams/README.md) | Alto — evita tratarlas como fuente de verdad de gobierno |

## 16. Decisiones pendientes

| Decisión pendiente | Por qué importa | Evidencia faltante | Próximo paso |
|---|---|---|---|
| Quién tiene mandato formal para aprobar/gobernar el Common Core | Sin esto, ninguna capacidad puede avanzar más allá de evidencia técnica | Confirmación explícita de MOA | Ver Blocked Decision #1 completa en [`../governance/BLOCKED-DECISIONS.md`](../governance/BLOCKED-DECISIONS.md) |
| Cómo representar formalmente Context Acquisition & Resolution | Es el gap de mayor impacto identificado (sección 14, Decisión #1) | Ninguna instancia real que valide un diseño concreto | Llevarlo al Assessment Gate como Use Case formal |
| Si READ y ACT deben tener contratos diferenciados propios | Es la causa raíz arquitectónica del único riesgo de seguridad repetido entre equipos | Decisión del Arquitecto sobre extender el contrato de HITL de Evaluation a cualquier ACT | Ver sección 9 |
| Alcance de gobierno de Copilot Studio / productos conversacionales | No está claro si es alcance de Track 1 | Confirmación de gobierno/ownership del producto | Ver sección 14, Decisión #5 |
| Si ASSIST/AUGMENT/AUTOMATE reemplaza, mapea o coexiste con el campo `Autonomy` existente | Riesgo de duplicar taxonomía | Reconciliación explícita | Ver sección 14, Decisión #8 |
| Unificación (o coexistencia deliberada) de los esquemas de clasificación `ADOPT/ADAPT/TEAM-SPECIFIC/VALIDATE/REJECT` (`assessment-gate.md`) y `ADOPT/ADOPT WITH MODIFICATION/TEAM-SPECIFIC/GAP/REQUIRES VALIDATION/DO NOT CHANGE` (usado en la evolución más reciente) | Ambigüedad de vocabulario entre documentos | Decisión explícita del Arquitecto | No resuelto en ningún documento vigente |
| Plataforma de IA oficialmente sancionada por MOA | Determina si la arquitectura debe seguir siendo multi-proveedor | Decisión formal de MOA | Blocked Decision #2 |
| Política formal de clasificación de datos | Condiciona cualquier decisión de gobierno de MCP/RAG sobre datos sensibles | Política de MOA | Blocked Decision #3 |

**Listado completo de 12 Blocked Decisions, sin duplicar acá**: ver
[`../governance/BLOCKED-DECISIONS.md`](../governance/BLOCKED-DECISIONS.md).

## 17. Estado del Track 1

**FACT — estados distinguidos explícitamente, sin confundirlos**:

- **Construido**: el modelo (arquitectura, taxonomía, contratos, Registry conceptual,
  Golden Paths, Adoption Kit, gobierno, seguridad) está documentado y es consistente
  internamente (con las contradicciones señaladas en este documento).
- **Validado técnicamente**: las 6 capacidades tienen configuración `VERIFIED` (archivos
  reales, bien formados, leídos completos).
- **Ejecutado**: 2 ejecuciones reales de CAP-002 sobre requerimientos reales de un equipo
  de MOA — `EXECUTED`, no `VERIFIED`.
- **Validado por humanos**: **ninguna** — las 2 evaluaciones existentes son
  `model-assisted`, hechas por el mismo actor que generó la evidencia, no por un
  evaluador humano independiente confirmado.
- **Medido**: **ninguna** capacidad tiene medición real — ambos registros de Measurement
  son `NOT MEASURED`, sin baseline.
- **Probado en adopción independiente**: **ninguna** — cero contribuciones reales, cero
  ejecuciones por un equipo distinto del que diseñó la capacidad.

**Estado consolidado (tal como lo declara el propio [`../README.md`](../README.md))**:
**READY WITH CONDITIONS** — utilizable hoy, pero nada debe presentarse como "validado"
más allá de lo que esta lista distingue.

## 18. Plan restante para culminar Track 1

Solo los pasos que el estado actual del repositorio deja pendientes — no se agregan fases
nuevas:

1. **Cerrar Benchmark → Target Model**: obtener la aprobación/rechazo del Arquitecto
   Supervisor sobre las 10 decisiones de la sección 14 — ninguna está aprobada todavía.
2. **Implementar las evoluciones aprobadas** (solo las que se aprueben) — ninguna
   implementación debe anticiparse a la aprobación.
3. **Validar técnicamente** cualquier cambio que se implemente, antes de exponerlo como
   disponible.
4. **Ejecutar pilotos reales** con equipos de MOA (no con el mismo actor que diseñó la
   capacidad) — condición explícita para superar el estado `EXECUTED` sin `VERIFIED`.
5. **Obtener feedback humano real** — el mecanismo de contribución existe, ninguna
   contribución real fue recibida todavía.
6. **Medir cuando exista baseline** — no antes; no inventar un baseline para poder medir.
7. **Cerrar condiciones de entrega** — resolver, o dejar explícitamente abiertas con
   dueño asignado, las Blocked Decisions más estructurales (sección 16).
8. **Preparar la culminación de Track 1** — consolidar este documento y el resto del
   contexto temporal en los documentos canónicos definitivos (ver sección 21).

## 19. Criterios de finalización

Track 1 se considera terminado cuando, como mínimo:

- Las 10 decisiones de la sección 14 fueron aprobadas o explícitamente rechazadas por el
  Arquitecto Supervisor — no basta con que estén documentadas.
- Al menos una capacidad alcanzó el estado `Human Validation` del Capability Lifecycle
  (evaluación independiente, no `model-assisted` del mismo actor).
- Al menos un Golden Path tiene una ejecución real por un equipo de MOA distinto del que
  construyó la capacidad.
- Blocked Decision #1 (mandato de gobierno del Common Core) está resuelta — sin esto,
  ninguna promoción a `Common Core = Y` tiene validez formal.
- Existe al menos un baseline real medido para al menos una capacidad — no una proyección.

**"Documentado" no equivale a "validado en operación"** — un documento completo,
internamente consistente y sin contradicciones no es, por sí mismo, evidencia de que el
modelo funciona en la práctica con equipos reales de MOA.

## 20. Reglas para futuras revisiones arquitectónicas

Toda futura revisión de Track 1 debe:

1. Tomar este documento como contexto rector temporal.
2. Contrastarlo con el estado actual del repositorio — este documento puede quedar
   desactualizado, el repositorio es la fuente de verdad.
3. Priorizar evidencia sobre afirmaciones.
4. No asumir que `CONFIGURED = USED`.
5. No asumir que `USED = MATURE`.
6. No asumir que `MATURE = MEASURED`.
7. No asumir que `MEASURED = PROVEN`.
8. Identificar cualquier contradicción antes de proponer cambios.
9. Distinguir claramente `FACT` / `INFERENCE` / `PROPOSAL` / `REQUIRES VALIDATION`.
10. Evitar rediseñar lo que ya funciona sin evidencia que lo justifique.

## 21. Naturaleza temporal del documento

Este documento es un **artefacto temporal de contexto** para acompañar la construcción de
`MOA-AI-Engineering` Track 1. **No constituye por sí mismo un Corporate Standard de MOA.**
Al culminar Track 1, su contenido deberá consolidarse en los documentos canónicos
definitivos del producto, y este archivo podrá eliminarse, archivarse o transformarse en
histórico según corresponda.

## 22. Referencias

- [`vision.md`](vision.md) · [`principles.md`](principles.md) · [`maturity-model.md`](maturity-model.md) · [`roadmap.md`](roadmap.md)
- [`../README.md`](../README.md)
- [`../architecture/reference-architecture.md`](../architecture/reference-architecture.md) · [`../architecture/capability-model.md`](../architecture/capability-model.md) · [`../architecture/capability-registry.md`](../architecture/capability-registry.md) · [`../architecture/lifecycle.md`](../architecture/lifecycle.md) · [`../architecture/operating-model.md`](../architecture/operating-model.md) · [`../architecture/assessment-gate.md`](../architecture/assessment-gate.md) · [`../architecture/evidence-evaluation-measurement.md`](../architecture/evidence-evaluation-measurement.md) · [`../architecture/evaluation-observability.md`](../architecture/evaluation-observability.md) · [`../architecture/benchmark-to-target-model-decision-input.md`](../architecture/benchmark-to-target-model-decision-input.md)
- [`../capabilities/README.md`](../capabilities/README.md) · [`../golden-paths/README.md`](../golden-paths/README.md) · [`../registry/INDEX.md`](../registry/INDEX.md)
- [`../adoption/getting-started.md`](../adoption/getting-started.md) · [`../adoption/adoption-flow.md`](../adoption/adoption-flow.md) · [`../adoption/execution-model.md`](../adoption/execution-model.md)
- [`../governance/BLOCKED-DECISIONS.md`](../governance/BLOCKED-DECISIONS.md) · [`../governance/agent-governance.md`](../governance/agent-governance.md) · [`../governance/ai-governance.md`](../governance/ai-governance.md)
- [`../security/security-governance.md`](../security/security-governance.md)
- [`../integrations/catalog.md`](../integrations/catalog.md)
- [`../evidence/README.md`](../evidence/README.md) · [`../evidence/current-moa-ai-practices-benchmark.md`](../evidence/current-moa-ai-practices-benchmark.md) · [`../evaluation/README.md`](../evaluation/README.md) · [`../measurements/README.md`](../measurements/README.md)
- [`../teams/README.md`](../teams/README.md) · [`../assessment/README.md`](../assessment/README.md) · [`../metrics/framework.md`](../metrics/framework.md)
