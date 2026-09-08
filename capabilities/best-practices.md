# Best Practices — cómo MOA recomienda usar cada tipo de capacidad

Guía práctica, no teoría. Cada sección responde: "necesito X, ¿qué hago?" — con el
camino real, no el ideal. Clasificación de evidencia aplicada sin excepción: **FACT**
(evidencia interna verificada), **EXTERNAL EVIDENCE** (fuente externa citada), **PROPOSAL**
(recomendación de esta iniciativa, no decisión oficial de MOA).

## Instructions

**Usar cuando**: una regla debe aplicarse siempre que se trabaje en una ruta/capa
específica, sin que nadie tenga que acordarse de mencionarla.
**Camino real**: completar [`repository-governance`](instructions/repository-governance/INSTRUCTIONS.md)
(CAP-005) — un `AGENTS.md` con matriz ALWAYS/ASK FIRST/NEVER, más `.instructions.md` por
capa si el repo lo justifica.
**No hacer**: instructions genéricas sin contenido accionable ("escribí buen código") —
si no cambia el comportamiento de un asistente de forma verificable, no es una Instruction
útil.

```text
Necesito que el asistente respete reglas de mi proyecto siempre
        ↓
Instruction: repository-governance (CAP-005)
        ↓
AGENTS.md con matriz ALWAYS/ASK FIRST/NEVER, completada con contenido real del equipo
```

## Skills

**Usar cuando**: hay conocimiento de dominio o procedimiento que un asistente debe
consultar solo cuando la tarea lo amerita (no siempre — eso sería Instruction).
**Camino real**: `azure-devops-cli` (CAP-001) para operar Azure DevOps;
`user-story` (CAP-002) para refinar requerimientos; `stack-best-practices-template`
(CAP-006) para documentar las convenciones reales de tu stack.
**No hacer**: copiar el contenido de la skill de otro equipo con un stack distinto —
`stack-best-practices-template` existe precisamente porque 2 instancias reales
(`dotnet-best-practices` en Scato Logística y Orquestador) probaron que el contenido no
es intercambiable entre versiones de stack, aunque el género sí.

```text
Necesito mejorar Requirements
        ↓
Golden Path: AI-Assisted Requirements
        ↓
Skill: user-story (CAP-002)
        ↓
Human Review
        ↓
Evidence → Evaluation → Measurement
```

## Agents

**Usar cuando**: el problema requiere razonamiento dinámico o selección de herramienta —
no cuando la secuencia de pasos ya es conocida de antemano (eso es Workflow).
**Camino real**: `read-only-code-reviewer` (CAP-003) — el patrón mejor gobernado
encontrado en todo el relevamiento.
**No hacer**: agregar `tools: edit` a un Agent de revisión "para que también arregle lo
que encuentra" — eso destruye el control de seguridad estructural que es la razón de ser
del patrón. No crear un Agent "porque técnicamente es posible" — cada uno debe resolver
un problema real (`governance/agent-governance.md`).

```text
Necesito Code Review asistido por IA
        ↓
Reusable Agent Pattern: read-only-code-reviewer (CAP-003)
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
**Camino real**: `spec-driven-development` (CAP-004) — **empezar por el nivel Lite** (3
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
**Integraciones directas (no-MCP) reales**: `moa-metrics` tiene 4 conectores REST reales
(Jira, Azure DevOps, GitHub Copilot Metrics, SonarQube) — código de aplicación, no un
patrón de capability reusable en el sentido de esta biblioteca (son específicos del
pipeline de métricas).

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
sin cambios en G5.1. `moa-sdlc` define un esquema de log de auditoría (nivel Full de
`spec-driven-development`) pero sin evidencia de que esté en uso.
**Recomendación (PROPOSAL)**: priorizar Observability para cualquier capacidad con
autonomía (Agent, MCP) antes de escalar su nivel de autonomía — no es necesaria para
Instructions/Skills estáticas sin ejecución propia.

## Metrics

**Estado real en MOA**: `moa-metrics` implementa 8/8 indicadores propuestos por el KO, con
ETL real y tests — el artefacto de medición más maduro de todo el relevamiento. Sigue
siendo `STRONG CANDIDATE → ASSESS → VALIDATE → PROMOTE`, no promovido automáticamente
(`../architecture/assessment-gate.md`).
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
