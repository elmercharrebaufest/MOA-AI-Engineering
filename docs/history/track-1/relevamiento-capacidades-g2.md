# Relevamiento de capacidades de IA reales por equipo

**Qué es este documento:** el resultado de los pasos 1-2 del pipeline de
[`../../../assessment/README.md`](../../../assessment/README.md) — comprender qué existe
realmente en MOA y relevar las prácticas de los distintos equipos. Cubre 13
repositorios: 11 repos de código de equipos de MOA + los 2 repos de implementación de la
propia iniciativa (`moa-sdlc`, `moa-metrics`).

**Qué NO es este documento:**
- No es un catálogo de estándares reutilizables.
- No recomienda qué adoptar, adaptar o descartar (paso 4 del pipeline, pendiente).
- No incluye EXTERNAL EVIDENCE (paso 3, pendiente — insumo del Arquitecto).

Toda capacidad listada aquí es, como máximo, **candidata a evaluar** — ninguna está
promovida a REUSABLE por aparecer en esta lista.

## Metodología del relevamiento

Por cada repo se buscó evidencia real de: archivos de gobierno de agentes (`AGENTS.md` o
equivalente), agentes custom (`.github/agents/*`), skills/instructions
(`.github/skills/*`, `.github/instructions/*`), spec-driven development (`_sdd/`),
documentación generada por IA, scripts de automatización relacionados a IA, y CI/CD
versionado (precondición técnica para cualquier capacidad de code review/testing
automatizado con feedback cerrado). No se leyó el código de negocio en profundidad — el
foco es la capacidad de IA Engineering, no la lógica de dominio.

---

## Equipos con capacidades de IA formalizadas (evidencia fuerte)

### DataAgro — repo `DataAgro/DataAgro`

| Capacidad | Tipo (taxonomía) | Evidencia (FACT) | Problema que resuelve (INFERENCE) |
|---|---|---|---|
| Matriz de autonomía ALWAYS / ASK FIRST / NEVER | Instruction / governance pattern | `AGENTS.md` | Acotar qué puede hacer un agente de IA sin supervisión humana en un dominio con integración SAP y datos de negocio sensibles |
| Agentes por rol: architect, DBA, QA, PO, release-manager | Agent | `.github/agents/*.agent.md` | Separar responsabilidades de un agente por rol funcional, en vez de un agente genérico |
| 9 skills reutilizables dentro del repo | Skill | `.github/skills/*` | Encapsular tareas puntuales (no ambiguo cuáles sin inspeccionar contenido — REQUIRES VALIDATION el detalle de cada una) |
| Spec-driven development (specs, progress, template de feature) | Workflow | `_sdd/` | Formalizar el ciclo de una feature antes de codificar, con trazabilidad |
| Documentación generada por IA | Automation / Knowledge | `_DocumentacionCopilot/` | Reducir el costo de mantener documentación de un sistema legacy grande (~1963 archivos .cs) |
| CI/CD | — | `.github` con workflows presentes | Precondición técnica para cerrar el loop de code review/testing automatizado |

Nivel de formalización: **alto** — comparable o superior al patrón documentado en
`moa-sdlc`.

### Scato Logística (monolito) — repo `Scato Logistica/Scato%20Logistica`

| Capacidad | Tipo | Evidencia (FACT) | Problema que resuelve (INFERENCE) |
|---|---|---|---|
| `AGENTS.md` extenso con mapa de capas y convenciones por artefacto | Instruction | `AGENTS.md` | Orientar a un agente en un monolito de ~5077 archivos .cs con múltiples capas (WCF, MVC4/WebForms, Workflow Foundation 4.5, EF5) |
| 12 agentes por rol: afip-integration, dotnet-code-reviewer, test-engineer, workflow-designer, xamlx-documenter, devops, entre otros | Agent | `.github/agents/*` | Especializar agentes en integraciones regulatorias (AFIP) y en tecnología legacy específica (XAMLX de Workflow Foundation) |
| 13 skills: afip-cpe-ctg, dotnet-best-practices, ef5-n-plus-one-review, entity-scaffold, wf-activity-refactor, entre otras | Skill | `.github/skills/*` | Encapsular buenas prácticas específicas de este stack legacy (ej. detectar N+1 en EF5, refactor de actividades de Workflow Foundation) |
| Scripts de automatización con Azure DevOps CLI + generación de docs de workflows | Automation | `AiEnablement/` | Reducir trabajo manual de gestión de Azure DevOps y de documentar workflows de negocio complejos (WF4.5) |
| Herramientas de QA propias | Tool | `QaTools/` | REQUIRES VALIDATION — no se inspeccionó el contenido |
| Wiki de documentación | Knowledge | `docs/wiki/` | Base de conocimiento del dominio, posible fuente para RAG futuro (no implementado como tal hoy) |

Nivel de formalización: **el más alto observado en todo el relevamiento** (12 agentes +
13 skills + automatización propia).

### `moa-sdlc` (repo de la iniciativa, template + 1 caso real de MOA)

| Capacidad | Tipo | Evidencia (FACT) | Nota |
|---|---|---|---|
| Metodología SDD con ciclo Plan-Execute-Verify | Workflow | `_sdd/specs/`, `.github/AGENTS-HARNESS.md` | 6 roles en pipeline: spec-author→implementer→tester→reviewer→security-reviewer→human-approver |
| Contrato formal JSON por rol (I/O, allowlist de tools, estados, rollback) | Governance pattern | `.github/AGENTS-CONTRACTS.md` | Es el patrón de gobierno más formalizado en JSON de todo el relevamiento (más explícito que el `AGENTS.md` de DataAgro/Scato, aunque estos tienen más agentes/skills reales en uso) |
| Instructions: net-application-patterns, legacy-dotnet, angular, azure-devops, tooling-rules, code-quality-review, security-review | Instruction | `.github/instructions/*` | — |
| Skill: sonarqube-quality-review | Skill | `.github/skills/sonarqube-quality-review.md` | — |
| Caso real en curso: `MOA-1765-DistribuidorCupos` (DataAgro), estado `draft`, sin QA sign-off | Use case | `_sdd/specs/MOA-1765-DistribuidorCupos/`, `feature.json` | Estimación manual de ahorro: 69% en desarrollo, 48% total (81.5h→42.75h) — **estimación, no medición real todavía** |

### `moa-metrics` (repo de la iniciativa, medición)

| Capacidad | Tipo | Evidencia (FACT) | Nota |
|---|---|---|---|
| ETL de 8 indicadores de adopción/productividad/calidad | Automation / Tool | `ia-sdlc/indicators/*.py`, `ia-sdlc/connectors/*.py` | 4 conectores wireados (GitHub Copilot, Azure DevOps, Jira, SonarQube), 79 tests unitarios + 7 de integración, warehouse Postgres + dashboard Metabase |
| — | — | — | ⚠️ Hallazgo de seguridad: token de Jira y email hardcodeados en `ia-sdlc/test_jira_token.py`, señalado por el propio checklist del repo como pendiente de remediar |

---

## Equipos sin evidencia de capacidades formalizadas en el repositorio

**MOA Operaciones** (`MoaOperaciones/MoaOperaciones`), **Orquestador** (clásico, Akka,
Intercomunicador), **Scato Puerto** (`scatopuerto`, `scatopuertoAPINet`), y los
subproyectos nuevos de Scato Logística (`WebApiCoreAfip`, `PocScatoLogisticaAws`): sin
`AGENTS.md`, sin `.github/agents/`, sin skills/instructions versionadas en el repo.

**Importante (no confundir ausencia de evidencia con ausencia de uso):** el KO Interno
afirma que estos equipos sí usan IA (modo chat, autocomplete, debugging) — la ausencia
observada aquí es de una **capacidad formalizada y versionada en el repositorio** (que
pueda evaluarse, medirse y potencialmente reutilizarse), no de uso informal de Copilot en
el editor. Confirmar con cada equipo si existen prompts/prácticas informales no
versionadas (mencionado como probable en el KO — "conocimiento distribuido... prompts y
aprendizajes generados por personas y equipos").

## Señal organizacional a validar (REQUIRES VALIDATION)

`Scato Logística` (monolito) y `ScatoPuerto` (`scatopuerto`) comparten linaje de código y
dominio de negocio (mismos patrones Comando/Procesador/Repositorio, nombres de clase
similares) pero son **repositorios git independientes**, y divergen fuertemente en
madurez de IA: uno tiene 12 agentes + 13 skills, el otro ninguno. **Por qué divergieron es
una pregunta para los equipos/líderes, no una conclusión de este relevamiento.**

## Síntesis por tipo de capacidad (taxonomía completa)

| Tipo de capacidad | Dónde hay evidencia real (FACT) | Equipos sin evidencia |
|---|---|---|
| Prompt | No se encontró evidencia aislada (los prompts observados están embebidos en skills/instructions) | — |
| Instruction | DataAgro, Scato Logística, `moa-sdlc` | Resto |
| Skill | DataAgro (9), Scato Logística (13), `moa-sdlc` (1) | Resto |
| Workflow (spec-driven dev) | DataAgro, `moa-sdlc` | Scato Logística (no se confirmó `_sdd/` ahí — REQUIRES VALIDATION), resto |
| Knowledge / RAG | Wiki de Scato Logística (no implementado como RAG, es documentación estática) | Todos (ningún RAG real encontrado) |
| Agent | DataAgro (5 roles), Scato Logística (12 roles), `moa-sdlc` (6 roles en pipeline) | Resto |
| MCP / API / Tool | `moa-metrics` (4 conectores API, no MCP formal) | Ningún servidor MCP real encontrado en ningún repo — todo lo de MCP en el KO/`MOA-AI-Engineering` es PROPOSAL, no FACT |
| Automation | DataAgro (`_DocumentacionCopilot`), Scato Logística (`AiEnablement`), `moa-metrics` (ETL) | Resto |

**Lectura del relevamiento**: la brecha no es "quién usa IA y quién no" (todos, según el
KO) — es **quién formalizó esa práctica como capacidad versionada, gobernada y potencialmente medible**, y quién sigue en modo puramente informal/individual. Esto es
consistente con el marco Crawl-Walk-Run del KO, pero con más detalle real que el que tenía
el KO al momento de escribirse.

## Próximo paso según el pipeline

Estos hallazgos son el insumo de entrada. Antes de decidir qué se adopta/adapta/descarta
(paso 4), falta: (a) contrastar con EXTERNAL EVIDENCE (paso 3, pendiente), y (b) que cada
capacidad candidata pase individualmente por el assessment de valor/riesgo. No avanzar a
proponer promociones a REUSABLE sin estos pasos.
