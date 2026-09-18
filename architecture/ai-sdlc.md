# SDLC con IA

## Alcance del SDLC a evaluar

**28 etapas de referencia propuestas actualmente, pendientes de validación
transversal** [PROPOSAL, corregido en G3.1 review — no son un estándar definitivo de
MOA]: Idea, Requirements, Discovery, Business Analysis,
Refinement, User Stories, Estimation, Planning, Architecture, Design, Development, Pull
Request, Code Review, Unit Testing, QA, Functional Testing, Regression Testing, CI/CD,
Build, Release, Deployment, Observability, Operations, Incident Management,
Troubleshooting, Documentation, Knowledge Management, Continuous Improvement.

> No se asume que la IA deba usarse en todas. El objetivo es identificar dónde aporta
> valor, dónde no, dónde hay riesgo y dónde hay oportunidad de reutilización.

## Mapeo Hoy vs. Q4 2026 (FACT — KO Interno, pág. 23-26)

Este mapeo es evidencia real recolectada por Baufest/MOA para las etapas de desarrollo y
soporte; **no cubre las 28 etapas del encuadre fundacional de la iniciativa** (ver gaps al final).
**Es la proyección original del KO — sección "Cobertura real hoy" (más abajo) es la que
contrasta esto contra lo que el repositorio efectivamente construyó desde entonces.**

| Etapa (KO) | Hoy en MOA | Con IA ampliada (Q4) | Impacto esperado (Q4, proyectado) |
|---|---|---|---|
| Recepción del requerimiento | PO carga ticket en Jira manual/asistido; inconsistencias se detectan recién en refinamiento | Rovo Agent analiza el ticket al crearlo, detecta ambigüedades, genera preguntas antes del refinamiento | +10% HU ref./sprint·mes, +30% Reqs/Mej./sprint·mes, -20% lead time |
| Refinamiento y estimación | Reunión grupal, estimación manual sujeta a sesgos | Rovo Agent propone estimación inicial basada en historial del equipo | (incluido arriba) |
| Planning | Validación de asunciones consultando compañeros/documentación dispersa | Copilot + Skills + MCP Jira/Confluence sugiere dependencias y componentes afectados | (incluido arriba) |
| Desarrollo del código | Alto costo de cambio de contexto (Jira → Confluence → editor) | Copilot + Skills + MCP Jira/Confluence disponible sin salir del editor | +30% productividad DEVs, 100% team con Copilot |
| Apertura del PR | Manual en Azure DevOps (descripción + revisores) | Copilot + Skills + MCP Jira + MCP Azure DevOps crea el PR automáticamente tras el push | (incluido arriba) |
| Code Review | Revisor humano lee el diff manualmente | GitHub Copilot Code Review for Azure DevOps analiza el diff automáticamente | 100% team con Copilot, SQ Reliability A/B, Zero Critical Vulns, +15% unit tests |
| Testing funcional (QA) | Validación manual siguiendo casos escritos | Copilot + Skills + MCP Jira/Confluence propone casos de prueba automáticamente en el ticket | 100% team con Copilot, -10% tiempo generación CP, -10% bugs QA/PROD |
| Test de regresión | Escritos y mantenidos manualmente, ejecución de horas | Tests generados por Copilot + Skills + MCP Playwright corren automáticamente en el pipeline | (incluido arriba) |
| Cierre del ticket | Registro manual de horas y estado, propenso a omisión | Copilot + Skills + MCP Jira sugiere registro de horas y actualiza estado automáticamente | +30% productividad DEVs, +30% Reqs/Mej., -20% lead time |
| Soporte productivo | Análisis de logs reactivo, ante incidentes | Copilot + MCP App Insights + MCP BD analiza logs periódicamente, detecta patrones, propone ajustes preventivos | No cuantificado en el KO |
| Build & CI | Azure DevOps ejecuta pipeline; falla bloquea merge | DevOps agents ejecutan/validan corridas con `gh cli` para diagnosticar fallos | No cuantificado en el KO |

## Cobertura real hoy — capacidades del Registry vs. etapas del SDLC (FACT, actualizado 2026-09-17)

**Registry, 12 entradas** (`registry/INDEX.md`): 8 con origen en evidencia real de al
menos un equipo (`docs/history/track-1/G5.1-Reusable-Capability-Library.md`) y 4 nuevas
(CAP-009 a CAP-012, agregadas en este trabajo de cobertura de las 11 etapas del KO) que
son propuestas directas, sin instancia real de origen — ver la nota de clasificación en
cada una de esas 4 entradas. Ninguna fila de esta tabla es aspiracional en el sentido de
"inventada": cada capacidad citada tiene su propio `Real Use Status` declarado en
`registry/INDEX.md` — hoy `CONFIGURED` como mínimo (documentada y bien formada), no
necesariamente `EXECUTED`; ninguna entrada del Registry llegó todavía a `VERIFIED`.

| Etapa del SDLC | Capacidad real que la cubre | Golden Path | Estado real |
|---|---|---|---|
| Recepción del requerimiento / Refinamiento / User Stories / Estimation | **CAP-002** (`user-story`) + **CAP-007** (Azure DevOps) / **CAP-008** (Jira, vía Atlassian Rovo MCP real) + **CAP-012** (`product-owner`, empaquetado alternativo como Agent) | [Golden Path #1 — AI-Assisted Requirements](../golden-paths/README.md#1-ai-assisted-requirements) | `CONFIGURED` (CAP-002/007/008) — mecanismo probado de punta a punta durante la construcción, pruebas purgadas al pasar a adopción real; evidencia real en curso sobre `ARMOA277-194`. **Cumplimiento explícito del KO** para esta etapa (*"Rovo Agent... genera preguntas para el PO antes del refinamiento"*): CAP-002 produce, además de los gaps, una **recomendación de próximo paso** cuando la historia no está lista (a quién contactar, real si el Resolved Context lo trae — nunca inventado, prioriza `reporter` sobre `assignee`) — la acción la toma el reporter/PO, nunca el agente (`READ`, no `ACT`, ver `security-governance.md` §1.5). CAP-012 es `PROPOSAL` — Agent nuevo que empaqueta la misma lógica con scope MCP acotado, motivado por el hallazgo real del `product-owner` de Scato Logística/Orquestador (uso intensivo real, pero con MCP wildcard) |
| Planning / Development | **CAP-004** (`spec-driven-development`, nivel Lite) + **CAP-005** (`repository-governance`) | [Golden Path #2 — AI-Assisted Development](../golden-paths/README.md#2-ai-assisted-development) | `PROPOSAL` fortalecido — evidencia real del Workflow que lo alimenta (DataAgro, 2 tickets, nivel Lite), sin Evidence Record propio del camino completo. El nivel Full (6 roles, contratos JSON) es `PROPOSAL` conceptual, sin evidencia de ejecución real de ningún equipo de MOA |
| Design | *(parcial, dentro de CAP-004)* — un artefacto de diseño (`design.md`) forma parte del nivel Full propuesto del Workflow | — | `PROPOSAL` conceptual — sin evidencia de ejecución real; cubierto solo como parte de spec-driven-development, no como capacidad independiente |
| Pull Request (apertura) | **CAP-009** (`pr-description`) | [Golden Path #2 — AI-Assisted Development](../golden-paths/README.md#2-ai-assisted-development) | `PROPOSAL` — capacidad nueva, sin ejecución real ni piloto de ningún equipo todavía. Cierra la brecha `NOT FOUND` de la versión anterior de esta tabla — reutiliza el Resolved Context de CAP-007/CAP-008, no define una integración nueva |
| Code Review | **CAP-003** (`.NET Code Reviewer`) + **CAP-006** (`stack-best-practices-template`) | [Golden Path #4 — AI Code Review](../golden-paths/README.md#4-ai-code-review) | `PROPOSAL` fortalecido — patrón real en 2 repos (Orquestador, Scato Logística), cero Evidence Records de una ejecución real de este Golden Path específico |
| Testing funcional (QA) | **CAP-010** (`test-case-generation`) | [Golden Path #3 — AI-Assisted QA](../golden-paths/README.md#3-ai-assisted-qa) | `PROPOSAL` — capacidad nueva, sin ejecución real ni piloto de ningún equipo todavía. Consume los criterios de aceptación ya producidos por CAP-002, no define un formato propio |
| Test de regresión | *(sin capacidad materializada ni propuesta)* — depende de un mecanismo de ejecución automática (MCP Playwright) sin evidencia real en ningún repo relevado | [Golden Path #3 — AI-Assisted QA](../golden-paths/README.md#3-ai-assisted-qa) | **REQUIRES VALIDATION** — proponer esta integración sin evidencia ni piloto violaría la regla dura del assessment (`assessment/README.md`); el próximo paso es validar un caso de uso real de MCP Playwright, no construir la integración |
| Cierre del ticket | **CAP-011** (`ticket-closure-assist`) | [Golden Path #2 — AI-Assisted Development](../golden-paths/README.md#2-ai-assisted-development) | `PROPOSAL` — capacidad nueva, sin ejecución real ni piloto de ningún equipo todavía. **Corrección respecto a la versión anterior de esta tabla**: esta etapa no figuraba, ni siquiera como `NOT FOUND` — defecto de documentación corregido acá |
| Soporte productivo / Incident Management / Troubleshooting | *(sin capacidad materializada)* — el KO propone 5 líneas de trabajo (triage, respuesta Nivel 1, comunicaciones, cierre asistido, detección de recurrencia) | — | **REQUIRES VALIDATION** — sin evidencia de implementación (ver sección "Operación y soporte" abajo). **Deliberadamente sin propuesta de capacidad todavía** — la amplitud (5 líneas distintas, sin evidencia de ninguna) y el riesgo de sobredimensionar contenido (lección real de `dotnet-best-practices`, abandonado en Scato Logística por costo de tokens) hacen prioritario relevar con un equipo real de soporte antes de proponer algo — ver las 5 preguntas de relevamiento en la sección "Operación y soporte" |
| Build & CI / Release / Deployment | **CAP-001** (`azure-devops-cli`) | — (sin Golden Path propio) | `CONFIGURED` — 2 instancias reales casi idénticas, cero ejecuciones registradas como capability (uso real vía CLI ya confirmado en historial de commits/PRs, pero no vía Evidence Record) |
| MCP / Integration Onboarding *(transversal, no una etapa)* | **CAP-007/CAP-008** como patrones de referencia + **CAP-012** como ejemplo de scope acotado aplicado | [Golden Path #6 — MCP / Integration Onboarding](../golden-paths/README.md#6-mcp--integration-onboarding) | `PROPOSAL` — el propio Golden Path señala que debería aplicarse retroactivamente al MCP Atlassian de Orquestador, algo que todavía no ocurrió |

**Etapas sin ninguna capacidad ni Golden Path, ni siquiera conceptual**: Idea, Discovery,
Business Analysis, Architecture *(fuera de lo parcial ya anotado en CAP-004)*,
Observability *(como etapa de producto — distinto de la Observability de capacidades, ver
`architecture/evaluation-observability.md`)*, Documentation, Knowledge Management,
Continuous Improvement. No se inventa cobertura para ninguna — quedan **sin evidencia
disponible**, igual que en la versión anterior de este documento.

### Lectura obligatoria de esta tabla (EXTERNAL EVIDENCE — DORA, State of AI-assisted Software Development 2025/2026)

El hallazgo central de DORA sobre adopción de IA en el ciclo de entrega de software es que
**la IA amplifica, no corrige** — acelera el paso donde se aplica (ej. escribir código) sin
que el resto del ciclo (testing, deployment, coordinación) automáticamente se mantenga al
mismo ritmo, a menos que existan capacidades organizacionales sólidas de base (control de
versiones, batches pequeños, plataforma de calidad). Aplicado a la tabla de arriba: MOA
tiene su mecanismo más maduro en **Requirements** (`CONFIGURED`, evidencia real en curso)
y evidencia parcial en **Development** y **Code Review**, pero **cero cobertura real en
Testing/QA** — solo una propuesta sin ejecución (CAP-010, agregada en este trabajo)
— exactamente el tipo de desequilibrio que DORA advierte que genera cuellos de botella
nuevos si el desarrollo se acelera sin que QA lo acompañe. Proponer CAP-010 no resuelve
este desequilibrio por sí mismo — solo lo hace un piloto real con un equipo de QA; la
razón concreta de priorizar esa validación **antes** de seguir sumando cobertura en las
etapas ya fuertes sigue vigente. Fuente:
[DORA — State of AI-assisted Software Development 2025](https://dora.dev/dora-report-2025/).

## Gaps frente al alcance completo del encuadre fundacional de la iniciativa (REQUIRES VALIDATION)

El KO Interno **no** documenta evidencia para: Idea (fase temprana pre-Jira), Discovery,
Business Analysis (como disciplina separada de refinamiento), Architecture, Design,
Release/Deployment (como etapas separadas de Build&CI), Incident Management/
Troubleshooting (más allá de "soporte productivo"), Documentation/Knowledge Management
como práctica formal, Continuous Improvement como etapa (existe como paso 5 del roadmap
general, no como etapa de SDLC). Estas etapas quedan marcadas como **sin evidencia
disponible** — no se debe inferir contenido para ellas sin nueva fuente.

## Operación y soporte (FACT — KO Interno, pág. 27)

5 líneas de trabajo propuestas para acelerar tareas día a día de soporte:

1. Triage asistido y respuesta automática (clasificación de workflow/puesto/severidad).
2. Respuesta sugerida a Nivel 1 (3 casos históricos similares + fragmento de manual).
3. Comunicaciones de estado automáticas (borrador de mail con formato ANS).
4. Cierre asistido con calidad de datos (campo Efecto, inicio/fin de interrupción, causa raíz).
5. Detección de recurrencia y alerta preventiva (agrupación de tickets por patrón).

**[REQUIRES VALIDATION]** Estas 5 líneas están descritas como propuesta del KO; no hay
evidencia de que ya estén implementadas.

### Próximo paso — relevamiento con un equipo real de soporte, antes de proponer una capacidad

A diferencia de las demás brechas cerradas en este trabajo (CAP-009 a CAP-011), acá no se
propone todavía una capacidad piloto — la amplitud (5 líneas distintas) y la lección real
de `dotnet-best-practices` (contenido abandonado en Scato Logística por costo de tokens)
hacen prioritario preguntarle a un equipo real de soporte/operaciones antes de escribir
nada:

1. ¿Cuáles de estas 5 líneas, si alguna, ya se resuelven hoy de forma informal (aunque sea
   sin IA)?
2. ¿Qué sistema de logs/monitoreo real está disponible (App Insights, otro) y quién tiene
   acceso hoy?
3. ¿Existe algún historial de incidentes clasificado o buscable, que sirva de base para
   "3 casos históricos similares" (línea 2)?
4. ¿Qué formato real de comunicación de estado (ANS u otro) se usa hoy, y quién lo redacta?
5. Si se tuviera que elegir **una sola** de las 5 líneas para pilotear primero, ¿cuál
   generaría el mayor impacto con el menor riesgo?
