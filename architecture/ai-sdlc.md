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
soporte; **no cubre las 28 etapas del master prompt** (ver gaps al final).

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

## Gaps frente al alcance completo del master prompt (REQUIRES VALIDATION)

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
