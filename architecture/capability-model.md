# Capability Model

**Estado**: PROPOSAL (taxonomía) con ejemplos FACT donde hay evidencia real.
Provider-agnostic a nivel conceptual — no se asume GitHub Copilot, Copilot Studio,
Claude, ni ningún proveedor como plataforma oficial única (ver Blocked Decision #2).

## Propósito

Dar vocabulario común para clasificar cualquier capacidad de IA, y **evitar el sesgo hacia
Agent por defecto** ya observado en la evidencia real (dos de cinco equipos con evidencia
—DataAgro, Scato Logística— construyeron Agents antes de tener Evaluation u Observability
formalizados — ver
[`../docs/history/track-1/relevamiento-capacidades-g2.md`](../docs/history/track-1/relevamiento-capacidades-g2.md)).

## Principio rector

> Technology does not drive the use case. Use Case → Value → Risk → Architecture →
> Technology. (Principio #4) · Workflow before Agent when the process is deterministic
> (Principio #6) · Agent only when dynamic reasoning/tool selection/autonomy provides
> demonstrable value (Principio #7).

## Estructura de la taxonomía (corregido en G3.3 Corrections)

La revisión final de consistencia de G3.3 encontró que la lista original de "11
capacidades" mezclaba 3 cosas de naturaleza distinta. Se separan explícitamente:

- **Pre-Artifact** (1): Prompt — no es una capacidad con lifecycle propio.
- **Capabilities seleccionables** (7): Instruction, Skill, Workflow, Agent, Knowledge/RAG,
  Integration/API, MCP — esto es lo que un equipo elige para resolver un caso de uso
  (Principio #4: Use Case → Value → Risk → Architecture → Technology).
- **Cross-Cutting Concerns** (3): Evaluation, Observability, Metrics — no se "eligen" para
  resolver un caso de uso de negocio; son disciplinas del Common Core que **operan sobre**
  instancias de las 7 capacidades de arriba.

## Pre-Artifact: Prompt

**Qué es**: instrucción puntual, no versionada como artefacto propio independiente —
**estado informal, previo a convertirse en cualquier capacidad**.
**Cuándo usarlo**: para una interacción única, no repetible, sin necesidad de
mantenimiento futuro.
**Cuándo NO usarlo (es decir, cuándo promoverlo a una capacidad real)**: si la misma
instrucción se reutiliza más de una vez — en ese punto debería promoverse a Instruction o
Skill.
**Relación**: es el átomo — toda Instruction/Skill/Agent contiene prompts, pero un prompt
no necesita convertirse en un artefacto versionado para ser útil. **No se registra en
`capability-registry.md` como entrada propia** — solo lo hacen las 7 capacidades y, si
aplica, los 3 concerns transversales.
**Evidencia real**: no se encontró ningún prompt documentado como artefacto
independiente en ningún repo — vive embebido dentro de Skills/Instructions/Agents
(**NOT FOUND** como capacidad separada, en la evidencia relevada).

## Capabilities (7, seleccionables)

Para cada una: qué es, cuándo usarla, cuándo NO usarla, relación con las demás.

### 1. Instruction

**Qué es**: regla que se inyecta automáticamente según contexto/ruta (patrón `applyTo`
por glob, observado consistentemente en 3 repos).
**Cuándo usarla**: reglas que deben aplicarse **siempre** que se trabaje en una ruta/capa
específica del código (ej. "todo archivo en `Repositorio/` sigue este patrón").
**Cuándo NO usarla**: conocimiento que no vale la pena cargar siempre (eso es Skill) o que
requiere una secuencia de pasos con estado (eso es Workflow).
**Relación**: convive con Skills y Agents — un Agent puede indicar "lee las instructions
de esta capa antes de proponer código" (visto literalmente en `architect.agent.md` de
Orquestador).
**Evidencia real (FACT — G2, G3.2.5)**: VERIFIED en DataAgro (6), Scato Logística (14),
Orquestador (8, en rama no integrada a master).

### 2. Skill

**Qué es**: referencia especializada, cargada on-demand (no siempre), con comportamiento
o contenido específico no genérico.
**Cuándo usarla**: conocimiento de dominio o procedimiento reutilizable dentro de un
mismo repo/equipo, que un agente o asistente debe consultar solo cuando la tarea lo
amerita.
**Cuándo NO usarla**: si es solo un checklist genérico sin contenido específico
accionable — eso no cumple el estándar de "definición y comportamiento" (regla fijada en
la validación de evidencia de G2).
**Relación**: los Agents declaran qué Skills cargar (ej. `dotnet-code-reviewer.agent.md`
de Orquestador: *"Load and apply the following skills: `dotnet-best-practices`,
`dotnet-performance-fx472`"*).
**Evidencia real (FACT)**: VERIFIED en DataAgro (13+1), Scato Logística (13), Orquestador
(6, en rama). Comparación de contenido real entre repos: ver G3.2.5 sección 3 (`user-story`
= evolución de patrón común; `azure-devops-cli` = fuerte evidencia de origen común;
`dotnet-best-practices` = mismo género, contenido 100% independiente por versión de stack).

### 3. Workflow

**Qué es**: proceso de múltiples pasos con estado, determinístico o semi-determinístico
(a diferencia de un Agent, no requiere razonamiento dinámico para decidir el siguiente
paso).
**Cuándo usarlo**: cuando la secuencia de pasos es conocida de antemano y no cambia según
el contexto — ej. spec-driven development (`_sdd/`: requirements → design → tasks →
implementación → QA).
**Cuándo NO usarlo**: si el proceso requiere que el sistema decida dinámicamente qué
herramienta usar o qué camino tomar — eso es un Agent (Principio #6: Workflow antes que
Agent cuando el proceso es determinístico).
**Relación**: un Golden Path (ver [`../golden-paths/README.md`](../golden-paths/README.md)) es la expresión de más alto nivel de
un Workflow — un camino de adopción completo, no solo una tarea. **Criterio de
desambiguación con Agent** (agregado en G3.3 Corrections, cierra un solapamiento real
encontrado en la revisión final): si la secuencia de pasos y el actor de cada paso son
fijos de antemano y no requieren que el sistema decida dinámicamente "qué hacer o con qué
herramienta", es Workflow — aunque tenga varios roles (ej. el harness de 6 roles de
`moa-sdlc` es un Workflow con roles fijos, no una orquestación de Agents autónomos, porque
la secuencia spec-author→implementer→tester→reviewer→security-reviewer→human-approver no
cambia dinámicamente). Si el sistema debe decidir en tiempo de ejecución qué paso o
herramienta usar, es Agent (o una orquestación de Agents).
**Evidencia real (FACT — G2, G3.2)**: VERIFIED en DataAgro (`_sdd/`, 1 caso real
`MOA-1765`) y `moa-sdlc` (harness de 6 roles con contrato JSON, `AGENTS-CONTRACTS.md` —
el ejemplo más formalizado de Workflow encontrado). **NOT FOUND** en Scato Logística ni
Orquestador (confirmado, no tienen `_sdd/`).

### 4. Agent

**Qué es**: especialista con `tools`, alcance, y pasos propios, invocable — capaz de
razonamiento dinámico y selección de herramientas (a diferencia del Workflow).
**Cuándo usarlo**: cuando el problema requiere que el sistema decida dinámicamente qué
hacer, con qué herramienta, en qué orden — y ese valor no se puede lograr con una
Instruction o Skill estática (Principio #7).
**Cuándo NO usarlo**: "no crear agentes sólo porque técnicamente sea posible" (principio
ya vigente desde `governance/agent-governance.md`). Si el proceso es determinístico, usar
Workflow.
**Relación**: puede cargar Skills, leer Instructions, y (evidencia nueva de G3.2.5) puede
tener `handoffs` hacia otro Agent (`product-owner` → `architect`, visto en Orquestador,
rama no integrada — **sin evidencia de ejecución real**, ver `assessment-gate.md`).
**Evidencia real (FACT)**: VERIFIED como configuración en DataAgro (6), Scato Logística
(13), Orquestador (4, en rama). **REQUIRES VALIDATION en los 3 casos**: uso real más allá
de la configuración (regla central desde G2: Configuration ≠ Real Use).
**Patrón de gobierno destacado**: el agent `.NET Code Reviewer` de Orquestador (rama) es
el ejemplo mejor gobernado encontrado — `tools: [execute, read, search]` **sin `edit`**,
scope acotado al diff (`git diff --staged`), salida estructurada por severidad. Candidato
a **patrón de diseño** (no de contenido) para cualquier Agent de solo-revisión.

### 5. Knowledge / RAG

**Qué es**: base de conocimiento indexada y consultable por un modelo (recuperación
semántica, no solo archivos estáticos).
**Cuándo usarlo**: cuando el volumen/dispersión de conocimiento hace inviable cargarlo
completo en el contexto de cada interacción.
**Cuándo NO usarlo**: si la documentación es pequeña y estable — ahí alcanza con
Instruction o Skill (contexto cargado directo, sin indexación).
**Relación**: es la capacidad menos madura de todo el modelo — no hay evidencia de que
ningún equipo la necesite todavía.
**Evidencia real (corregido tras el benchmark de prácticas reales)**: existe un mecanismo
real **CONFIGURADO** — un submodule de Azure DevOps Wiki (`docs/wiki/`), presente en 2
repos, **parcialmente poblado** (con contenido real en 1 de los 2 casos), **sin consumo
confirmado** por ningún agent relevado. El estado correcto ya no es "NOT FOUND" — es
`CONFIGURED, PARTIALLY POPULATED, NO CONFIRMED CONSUMPTION`. Sigue sin existir ningún
mecanismo de indexación ni recuperación semántica real (RAG propiamente dicho) en ningún
repo — ver [`../evidence/current-moa-ai-practices-benchmark.md`](../evidence/current-moa-ai-practices-benchmark.md)
sección 16 (gap 5). No se implementa RAG en esta actividad.

### 6. Integration / API

**Qué es**: conexión programática directa a un sistema externo (no vía protocolo MCP,
sino integración a medida — ej. los conectores Python de `moa-metrics`).
**Cuándo usarla**: cuando se necesita extraer/enviar datos de un sistema externo de forma
controlada y con un propósito específico y acotado (ej. ETL de métricas).
**Cuándo NO usarla**: si un agente necesita descubrir y usar la herramienta
dinámicamente — eso es el rol de MCP.
**Relación**: MCP puede exponer una Integration/API existente de forma estandarizada para
que un Agent la use; no son excluyentes.
**Evidencia real (FACT)**: EXISTING — Jira API, Azure DevOps Repos API, GitHub Copilot
Metrics API, SonarQube API, todas implementadas como conectores Python reales en
`moa-metrics` (ver `../integrations/catalog.md`).

### 7. MCP (Model Context Protocol)

**Qué es**: mecanismo de integración estandarizado que permite a un Agent descubrir y
usar herramientas/datos externos dinámicamente.
**Cuándo usarlo**: cuando varios Agents/equipos necesitan acceso equivalente y gobernado
a un mismo sistema externo, y ese acceso debe poder auditarse.
**Cuándo NO usarlo**: para una integración de un solo propósito, estable, sin necesidad de
descubrimiento dinámico — ahí alcanza una Integration/API directa.
**Relación**: **sujeto a gobierno específico** — identidad, autorización, least privilege,
gobierno de datos, HITL, auditoría y observabilidad (Principio #8). Ver
[`../security/security-governance.md`](../security/security-governance.md).
**Evidencia real**: 2 hallazgos concretos — referencias a `com.atlassian/
atlassian-mcp-server` en agents de DataAgro, Scato Logística y Orquestador (este último en
rama `feature/cardless4`, no integrada a `master`), y un `.vscode/mcp.json` real en
DataAgro apuntando a un servidor MCP de Azure DevOps (`mcp.dev.azure.com/molinosagro`).
Ambos son **CONFIGURATION VERIFIED** (los archivos existen, se leyeron completos) —
**REAL USE REQUIRES VALIDATION** (no hay evidencia de ejecución, ni de que estén
autenticados/autorizados/auditados). No se debe asumir read-only, ni producción, ni
autenticación — ver Blocked Decision #4 y
[`../security/security-governance.md`](../security/security-governance.md). Todo lo demás
mencionado sobre MCP en el KO (Jira, Confluence, SQL Server, Playwright) sigue siendo
**PROPOSED**, sin evidencia de despliegue.

## Cross-Cutting Concerns (4) — no son capacidades seleccionables

**Corrección aplicada en G3.3 Corrections**: estos no se "eligen" para resolver un caso
de uso de negocio de la misma forma que se elige entre Skill o Agent — son disciplinas del
Common Core que **operan sobre instancias** de las 7 capacidades de arriba (un equipo no
decide "voy a usar Evaluation", decide "voy a evaluar el Agent que construí"). Esto corrige
una inconsistencia real detectada en la revisión final: este documento las listaba
originalmente como capacidades #9/#10/#11, mientras que `reference-architecture.md` y
`evaluation-observability.md` ya las trataban como componentes/servicios del Common Core.
Ver `evaluation-observability.md` para el modelo completo de Evaluation/Observability/
Metrics, incluido el modelo de ejecución (local vs. común).

**4º concern, agregado en esta actividad**: **Context Acquisition & Resolution** — opera
**antes** de cualquier capability, no sobre su resultado. Ver
[`context-acquisition-resolution.md`](context-acquisition-resolution.md) para el modelo
completo. Al igual que los otros 3, no se elige para un caso de uso de negocio — resuelve
de dónde viene el input que cualquier capability va a consumir.

### Evaluation

**Qué es**: el concern que responde *¿la capacidad produce el resultado esperado?*
**Cuándo aplica**: sobre cualquier capacidad, siempre, antes de que pase de Team
Adaptation a candidata de Common Core (Assessment Gate).
**Cuándo NO se confunde**: con Observability (qué pasó durante la ejecución) ni con
Metrics (qué impacto tuvo en el negocio) — las 3 son disciplinas independientes
(Principio #9).
**Evidencia real**: no se encontró una práctica de evaluación formal en ningún repo — lo
más cercano son roles de revisión humana manual (`reviewer`, `security-reviewer` en
`moa-sdlc`; QA manual en `MOA-1765`, sin sign-off). Brecha fundacional confirmada desde
G3.1.

### Observability

**Qué es**: el concern que responde *¿qué ocurrió durante la ejecución?*
**Cuándo aplica**: sobre cualquier capacidad con autonomía (Agent, MCP) antes de aumentar
su nivel de autonomía — no es necesaria para Instructions o Skills estáticas sin
ejecución propia.
**Evidencia real**: no se encontró observabilidad específica de IA en ningún repo. No
implementar todavía una plataforma sin decisión tecnológica (instrucción explícita del
alcance de G3.3).

### Metrics

**Qué es**: el concern que responde *¿qué impacto produce en el proceso o negocio?*
**Cuándo aplica**: sobre el efecto agregado de una capacidad ya en uso — no reemplaza a
Evaluation (correctness) ni a Observability (ejecución).
**Regla explícita (Principio de G3.3)**: la cantidad de Agents/Skills creados **no es un
KPI de éxito**.
**Evidencia real (FACT)**: `moa-metrics` implementa 8/8 indicadores propuestos por el KO,
con ETL real, tests, warehouse. Se trata como **STRONG CANDIDATE → ASSESS → VALIDATE →
PROMOTE** (no se redefine automáticamente como estándar corporativo — ver
`evaluation-observability.md`).

## Matriz resumen

### Capabilities (7) + Pre-Artifact

| Capacidad | Estado/madurez | Determinístico vs. dinámico | Requiere Evaluation antes de escalar | Requiere Observability |
|---|---|---|---|---|
| Prompt *(pre-artifact)* | No evidenciado como artefacto propio | — | No aplica | No aplica |
| Instruction | VERIFIED, maduro (3 repos) | Determinístico (regla pasiva) | Baja prioridad | No aplica |
| Skill | VERIFIED, maduro (3 repos) | Determinístico (contenido cargado on-demand) | Media prioridad | No aplica |
| Workflow | VERIFIED (DataAgro, `moa-sdlc`) | Determinístico | Alta prioridad | Media (trazar transiciones de estado) |
| Agent | VERIFIED config, uso real sin confirmar (3 repos) | Dinámico | **Alta prioridad** | **Alta prioridad** |
| Knowledge/RAG | NOT FOUND en evidencia revisada | — | Alta (antes de confiar en recuperación) | Media |
| Integration/API | EXISTING (`moa-metrics`) | Determinístico | Media | Media |
| MCP | 1 referencia CONFIGURATION VERIFIED, resto PROPOSED | Dinámico (habilita a Agents) | **Alta prioridad** | **Alta prioridad — obligatoria antes de producción** |

### Cross-Cutting Concerns (4)

| Concern | Estado/madurez | Opera sobre |
|---|---|---|
| Evaluation | Brecha fundacional (NOT FOUND) | Cualquiera de las 7 capacidades |
| Observability | Brecha fundacional (NOT FOUND) | Cualquiera de las 7, prioritario en Agent/MCP |
| Metrics | `moa-metrics` (STRONG CANDIDATE) | El efecto agregado de cualquier capacidad en uso |
| Context Acquisition & Resolution | Contrato definido (`context-acquisition-resolution.md`), 2 patrones concretos (Azure DevOps, Jira) — ninguno con evidencia de resolución automática real todavía | Antes de cualquiera de las 7 capacidades, no sobre su resultado |
