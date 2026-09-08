# Catálogo de casos de uso

Clasificación: **EXISTING** (implementado en un repo real), **PROPOSED** (descrito en el
KO como objetivo Q4, sin evidencia de implementación), **REQUIRES VALIDATION** (mencionado
pero sin detalle suficiente para evaluarlo).

> **EXISTING no significa "listo para reutilizar en otros equipos".** Solo indica que hay
> evidencia real de que el caso de uso existe en el repo citado. Antes de proponerlo a
> otro equipo, debe pasar por el pipeline de assessment de
> [`../assessment/README.md`](../assessment/README.md). Ver también
> [`../assessment/relevamiento-capacidades.md`](../assessment/relevamiento-capacidades.md)
> para el relevamiento por capacidad (no solo por caso de uso) que incluye equipos con
> repos de código real (DataAgro, Scato Logística, etc.), más allá de `moa-sdlc`/`moa-metrics`.

## Desarrollo y evolutivos (equipo Enterprise Applications / .NET — `moa-sdlc`)

| Caso de uso | Etapa SDLC | Estado | Evidencia |
|---|---|---|---|
| Spec-Driven Development asistido (requirements/design/tasks por feature) | Refinement, Planning, Design | **EXISTING** | `moa-sdlc/_sdd/specs/`, feature real `MOA-1765-DistribuidorCupos` |
| Generación de tests para lógica nueva/modificada | Unit Testing | **EXISTING** | `moa-sdlc/AGENTS.md`, regla ALWAYS |
| Revisión de calidad previa a SonarQube | Code Review | **EXISTING** | `moa-sdlc/.github/skills/sonarqube-quality-review.md`, `.github/instructions/code-quality-review.instructions.md` |
| Revisión de seguridad de código | Code Review | **EXISTING** | `moa-sdlc/.github/instructions/security-review.instructions.md`, rol `security-reviewer` |
| PR automático con descripción y vínculo a Jira | Pull Request | **PROPOSED** | KO Interno pág. 24 — no se encontró evidencia de implementación en `moa-sdlc` |
| Code review automático (GitHub Copilot Code Review for Azure DevOps) | Code Review | **PROPOSED** | KO Interno pág. 25 |
| Generación automática de casos de prueba desde el ticket | QA / Functional Testing | **PROPOSED** | KO Interno pág. 25 |
| Tests de regresión automáticos vía MCP Playwright | Regression Testing | **PROPOSED** | KO Interno pág. 25 |
| Registro de horas y cierre de ticket asistido | Documentation/Knowledge Mgmt | **PROPOSED** | KO Interno pág. 26 |
| Análisis proactivo de logs de producción (App Insights + BD) | Operations / Incident Mgmt | **PROPOSED** | KO Interno pág. 26 |
| Agentes DevOps para diagnóstico de fallos de build (`gh cli`) | CI/CD, Build | **PROPOSED** | KO Interno pág. 26 |

## Métricas y adopción (equipo Data / métricas — `moa-metrics`)

| Caso de uso | Etapa SDLC | Estado | Evidencia |
|---|---|---|---|
| ETL de métricas de adopción/productividad/calidad desde Jira, Azure DevOps, Copilot, SonarQube | Continuous Improvement | **EXISTING** | `moa-metrics/ia-sdlc/connectors/`, `indicators/`, warehouse documentado |
| Dashboard ejecutivo de métricas (Power BI) | Continuous Improvement | **PROPOSED** | KO Interno pág. 16, 18; fuera de alcance explícito de `moa-metrics` (solo calcula datos, no construye el dashboard) |

## Operación y soporte (KO Interno, pág. 27)

| Caso de uso | Estado | Nota |
|---|---|---|
| Triage asistido y respuesta automática | **PROPOSED** | Sin repo/código asociado encontrado |
| Respuesta sugerida a Nivel 1 (casos históricos similares) | **PROPOSED** | Idem |
| Comunicaciones de estado automáticas (formato ANS) | **PROPOSED** | Idem |
| Cierre asistido con calidad de datos | **PROPOSED** | Idem |
| Detección de recurrencia y alerta preventiva | **PROPOSED** | Idem |

## Equipos sin caso de uso documentado todavía (REQUIRES VALIDATION)

Data (más allá de métricas), QA/Testing como equipo independiente, Seguridad, DevOps,
Operaciones (más allá de las 5 líneas de soporte del KO), Arquitectura. El master prompt
lista áreas posibles para cada uno (SQL/ETL, Playwright/regresión, vulnerability
analysis, Terraform/CI-CD, runbooks/observabilidad) pero **son ejemplos iniciales, no
casos de uso aprobados** — así lo indica explícitamente el propio master prompt.
