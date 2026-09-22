# Best Practices — cómo MOA recomienda usar cada tipo de capacidad

Guía práctica, no teoría. Cada sección responde: "necesito X, ¿qué hago?" — con el
camino real, no el ideal. Clasificación de evidencia aplicada sin excepción: **FACT**
(evidencia interna verificada), **EXTERNAL EVIDENCE** (fuente externa citada), **PROPOSAL**
(recomendación de esta iniciativa, no decisión oficial de MOA).

## Instructions

**Usar cuando**: una regla debe aplicarse siempre que se trabaje en una ruta/capa
específica, sin que nadie tenga que acordarse de mencionarla.
**Camino real**: completar [`repository-governance`](instructions/repository-governance/INSTRUCTIONS.md)
(CAP-006) — un `AGENTS.md` con matriz ALWAYS/ASK FIRST/NEVER, más `.instructions.md` por
capa si el repo lo justifica. Para el estilo de la documentación misma (lenguaje formal,
sin voseo, contenido acotado), aplicar [`documentation-style`](instructions/documentation-style/INSTRUCTIONS.md)
(CAP-022) — misma lógica que CAP-006, pero sobre cómo se escribe en vez de sobre qué
puede hacer un asistente.
**No hacer**: instructions genéricas sin contenido accionable ("escribir buen código") —
si no cambia el comportamiento de un asistente de forma verificable, no es una Instruction
útil.

```text
Necesito que el asistente respete reglas de mi proyecto siempre
        ↓
Instruction: repository-governance (CAP-006)
        ↓
AGENTS.md con matriz ALWAYS/ASK FIRST/NEVER, completada con contenido real del equipo
```

## Skills

**Usar cuando**: hay conocimiento de dominio o procedimiento que un asistente debe
consultar solo cuando la tarea lo amerita (no siempre — eso sería Instruction).
**Camino real**: `azure-devops-cli` (CAP-008) para operar Azure DevOps;
`user-story` (CAP-001) para refinar requerimientos; `stack-best-practices-template`
(CAP-013) para documentar las convenciones reales del stack propio.
**No hacer**: copiar el contenido de la skill de otro equipo con un stack distinto —
`stack-best-practices-template` existe precisamente porque 2 instancias reales
(`dotnet-best-practices` en Scato Logística y Orquestador) probaron que el contenido no
es intercambiable entre versiones de stack, aunque el género sí.

```text
Necesito mejorar Requirements
        ↓
Golden Path: AI-Assisted Requirements
        ↓
Skill: user-story (CAP-001)
        ↓
Human Review
        ↓
Evidence → Evaluation → Measurement
```

## Agents

**Usar cuando**: el problema requiere razonamiento dinámico o selección de herramienta —
no cuando la secuencia de pasos ya es conocida de antemano (eso es Workflow).
**Camino real**: `read-only-code-reviewer` (CAP-012) — el patrón mejor gobernado
encontrado en todo el relevamiento.
**No hacer**: agregar `tools: edit` a un Agent de revisión "para que también arregle lo
que encuentra" — eso destruye el control de seguridad estructural que es la razón de ser
del patrón. No crear un Agent "porque técnicamente es posible" — cada uno debe resolver
un problema real (`governance/agent-governance.md`).

```text
Necesito Code Review asistido por IA
        ↓
Reusable Agent Pattern: read-only-code-reviewer (CAP-012)
        ↓
Least Privilege — tools sin "edit"
        ↓
Human approval antes de merge
        ↓
Evidence → Evaluation
```

**EXTERNAL EVIDENCE**: la guía de seguridad de Anthropic para agentes ("CISO's guide to
agentic AI") sostiene que el entorno de un agente nunca debería tener una capacidad que
valga la pena explotar — el diseño sin `edit` de `read-only-code-reviewer` aplica ese
principio de forma literal, no solo declarativa.

## Workflows

**Usar cuando**: la secuencia de pasos es fija y conocida de antemano, sin razonamiento
dinámico sobre qué hacer o con qué herramienta.
**Camino real**: `spec-driven-development` (CAP-005) — **empezar por el nivel Lite** (3
roles, evidencia real de 2 tickets), escalar al nivel Full (6 roles, contratos JSON) solo
si el equipo necesita un gate formal de `security-reviewer` y puede mantenerlo.
**No hacer**: adoptar el nivel Full "porque está mejor especificado" — mejor especificado
no es lo mismo que probado (ver la propia capability para el detalle de esta distinción).

## Knowledge / RAG

**Estado real en MOA**: `NOT FOUND` — ninguna instancia real de indexación + recuperación
semántica encontrada en todo el relevamiento (G2 a G5.1). Lo más cercano es documentación
estática (wiki de Scato Logística).
**Recomendación (PROPOSAL)**: no implementar RAG sin un caso de uso real donde el volumen/
dispersión de conocimiento haga inviable cargar el contexto completo — instructions/skills
estáticas siguen siendo más simples y ya cubren la evidencia real encontrada.

## MCP / Integrations

**Estado real en MOA**: 2 hallazgos reales — un `mcp.json` commiteado en DataAgro
apuntando a un servidor MCP de Azure DevOps real (`mcp.dev.azure.com/molinosagro`), y
referencias a herramientas MCP de Atlassian en agentes de 3 repos (DataAgro, Scato
Logística, Orquestador), sin gobierno de identidad/scope/auditoría confirmado en ningún
caso. Ver [`../security/security-governance.md`](../security/security-governance.md)
para el detalle completo.
**Recomendación (PROPOSAL)**: antes de habilitar o escalar cualquier MCP, completar el
modelo de riesgo proporcional de `security-governance.md` §1 — identidad de servicio
dedicada (no personal), scope explícito y mínimo (nunca wildcard `/*` sin justificación
documentada), y auditoría antes de la primera ejecución real. **Esta iniciativa no
implementa ningún MCP** — es una decisión de gobierno pendiente (`../governance/BLOCKED-DECISIONS.md`
#4), no una capacidad para materializar todavía.

## Evaluation

**Recomendación (PROPOSAL, ya vigente desde G4.3)**: declarar los criterios **antes** de
ejecutar, no después. Diferenciar siempre el método (`human` / `deterministic` /
`automated` / `model-assisted`) — un resultado `model-assisted` (autoevaluación por el
mismo actor) no sustituye una evaluación humana independiente, sin excepción, sin importar
cuántas veces se repita (ver `G4.6-Independent-Adoption-and-Validation.md` §14: 2
ejecuciones del mismo actor siguen sin ser independencia).
**EXTERNAL EVIDENCE**: la guía de Anthropic "Demystifying evals for AI agents" recomienda
combinar evals automatizados, monitoreo en producción, y revisión humana periódica —
nunca depender de un solo modo.

## Observability

**Estado real en MOA**: `NOT FOUND` de forma sistemática — brecha fundacional desde G3.1,
sin cambios desde entonces, con una excepción real: el esquema de log de auditoría del
nivel Full de `spec-driven-development` (CAP-005) **ya tiene evidencia de uso real** en
`moa-sdlc`/DataAgro (corregido 2026-09-22) — pero esta versión generalizada de MOA
todavía no tiene ejecución propia con ese log.
**Recomendación (PROPOSAL)**: priorizar Observability para cualquier capacidad con
autonomía (Agent, MCP) antes de escalar su nivel de autonomía — no es necesaria para
Instructions/Skills estáticas sin ejecución propia.

## Revisión de código en tiempo real (IDE) — distinto de la investigación de incidentes

**No confundir con CAP-017** (`production-incident-investigation`): CAP-017 y los scripts
reales de [`../integrations/production-diagnostics-provider.md`](../integrations/production-diagnostics-provider.md)
son para **cuando ya ocurrió un error en producción** (AWS CloudWatch / Azure Application
Insights) — reactivo, sobre una aplicación ya desplegada. Esto es distinto: revisar el
código **mientras se escribe, en el editor**, antes de que llegue a un PR o a producción.

**Estado real en MOA**: `NOT FOUND` — sin evidencia de ninguna herramienta de análisis en
tiempo real configurada en ningún repo relevado.

**EXTERNAL EVIDENCE (2026)**: SonarQube for IDE — análisis estático en tiempo real dentro
del editor, con corrección sugerida al momento de escribir el código, no recién en la
revisión de PR. Conecta directo con algo que el propio KO ya planea (pág. 16, 22:
instalar SonarQube) — no es una herramienta nueva sin relación con el plan de MOA, es la
misma herramienta, en el punto del ciclo donde más temprano puede detectar un problema.
Snyk Code es la opción equivalente enfocada específicamente en vulnerabilidades de
seguridad, con hallazgos en el propio editor y en el flujo de PR.

**Recomendación (PROPOSAL)**: no construir una capacidad propia — igual que con la
modernización .NET (CAP-020) y el Code Review nativo de Azure DevOps, activar SonarQube
for IDE cuando SonarQube ya esté instalado (KO, plan ya existente) es el camino de menor
esfuerzo y mayor cobertura — antes de evaluar cualquier herramienta adicional.

## Metrics

**Estado real dentro de este modelo base**: `NOT FOUND` — ninguna capacidad de este
Registry mide su propio impacto todavía (ver `Metrics` en cada entrada). El framework de
métricas e indicadores propuestos por el KO está definido en
[`../metrics/framework.md`](../metrics/framework.md) y
[`../metrics/kpis.md`](../metrics/kpis.md), pendiente de un baseline real.
**Hallazgo EXPERIMENTAL de G5.1**: Scato Logística tiene un `copilot-config.yml` real que
asigna un modelo distinto por agente según criticidad/costo (ej. `security-review` forzado
a un modelo premium, con nota de benchmark "17/18 tareas exitosas | 0 USD costo AI"). Es
el ejemplo más concreto encontrado de una práctica real de costo/calidad por tier de
riesgo — pero es **1 sola instancia, sin evaluación cruzada con otros equipos** — se
clasifica `EXPERIMENTAL`, no se convierte en Best Practice todavía. **Recomendación
(PROPOSAL)**: si otros equipos adoptan una práctica similar, vale la pena reevaluar esto
como candidato a `REUSABLE PATTERN` en una fase futura — no antes.
**Regla explícita, sin excepción**: la cantidad de Agents/Skills/capabilities creadas
**no es un KPI de éxito** (`capability-model.md`).

## Optimización de tokens — criterio de diseño obligatorio, no opcional

**Estado real en MOA**: ya hay una lección real y costosa — `dotnet-best-practices` (la
instancia original detrás de CAP-013) fue **abandonada** en Scato Logística y Orquestador
por exceso de contenido, cargando demasiado en cada consulta. No es un riesgo
hipotético, ya pasó.

**EXTERNAL EVIDENCE (2026)**, confirma y agrega precisión a esa lección:
- Un conjunto acotado y relevante de contenido rinde mejor que uno exhaustivo pero
  disperso — la comparación citada en la industria es "2.000 tokens relevantes superan a
  20.000 sueltos". Aplica directo a cómo se escribe cada Skill/Instruction de este
  Registry: acotado y accionable, no una referencia completa de la tecnología.
- Las Skills, tal como ya están diseñadas en este modelo (cargadas solo cuando el
  asistente las considera relevantes, no siempre), siguen el patrón correcto — una
  biblioteca de 20 skills cuesta casi nada hasta que una se vuelve relevante. **No
  rediseñar esta arquitectura** — ya está alineada con la práctica recomendada.
- El contenido que se repite siempre (instructions base, reglas fijas) rinde mejor si se
  mantiene estable — los sistemas de cacheo de prompts reducen el costo real hasta un
  90% cuando el contenido inicial no cambia entre ejecuciones.
- Sesiones largas de un mismo Agent se encarecen de forma no lineal — relevante para
  CAP-010 (`ticket-kickoff`), el único orquestador de sesión potencialmente larga de este
  Registry.

**Reglas concretas a aplicar en toda capacidad nueva de este Registry**:
1. Preferir contenido acotado y accionable sobre una referencia exhaustiva de la
   tecnología — si hace falta más detalle, **referenciar la documentación oficial real**,
   no copiarla adentro de la capacidad.
2. No duplicar el mismo contenido en más de un lugar del modelo — un dato vive en un solo
   archivo, el resto enlaza.
3. Mantener estable el contenido que se repite siempre (instructions base) — evitar
   reescribirlo sin necesidad real, para no perder el beneficio del cacheo.
4. En Agents orquestadores de sesión larga, delegar a sub-agentes acotados en vez de
   acumular todo el contexto en una sola sesión extensa (ya es el patrón de CAP-010 —
   confirma que el diseño ya elegido es correcto por este motivo también).

## EXTERNAL EVIDENCE — fuentes usadas en G5.1 para contrastar estas prácticas

- GitHub Docs — Agent Skills, Custom Agents, Repository Custom Instructions: confirma que
  la taxonomía de este modelo (Instruction/Skill/Agent) coincide con el vocabulario
  oficial de la plataforma más usada en la evidencia interna (`.github/skills`,
  `.github/agents`, `copilot-instructions.md`) — [About agent skills](https://docs.github.com/en/copilot/concepts/agents/about-agent-skills),
  [Customize Copilot for your project](https://docs.github.com/en/copilot/how-tos/copilot-on-github/customize-copilot/customize-copilot-overview).
- DORA — AI Capabilities Model (2025/2026): 7 prácticas que amplifican el efecto positivo
  de la IA — "clear AI stance", "healthy data ecosystems", "strong version control",
  "working in small batches", entre otras — consistente con por qué esta biblioteca prioriza
  patrones con evidencia real y HITL explícito sobre volumen de capacidades —
  [DORA 2025 Report](https://dora.dev/dora-report-2025/).
- Anthropic — "Demystifying evals for AI agents" y "CISO's guide to agentic AI": citadas
  en las secciones Evaluation y Agents arriba.
- NIST AI RMF + Generative AI Profile: ya citado en G5 (`G5-Track-1-Finalization-and-Delivery-Readiness.md`
  §23) — se reafirma acá sin nueva investigación, sigue validando la separación
  Governance/Assessment/Measurement ya vigente.
