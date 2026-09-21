# Catálogo de casos de uso

Clasificación: **EXISTING** (implementado en un repo real), **PROPOSED** (descrito en el
KO como objetivo Q4, sin evidencia de implementación), **REQUIRES VALIDATION** (mencionado
pero sin detalle suficiente para evaluarlo).

> **EXISTING no significa "listo para reutilizar en otros equipos".** Solo indica que hay
> evidencia real de que el caso de uso existe en el repo citado. Antes de proponerlo a
> otro equipo, debe pasar por el pipeline de assessment de
> [`../assessment/README.md`](../assessment/README.md).

## Desarrollo y evolutivos (KO Interno, pág. 24-26)

| Caso de uso | Etapa SDLC | Estado | Evidencia |
|---|---|---|---|
| PR automático con descripción y vínculo a Jira | Pull Request | **PROPOSED** — capacidad diseñada: [`pr-description`](../registry/entries/pr-description.md) (CAP-011) | KO Interno pág. 24 |
| Code review automático (GitHub Copilot Code Review for Azure DevOps) | Code Review | **PROPOSED** | KO Interno pág. 25 |
| Generación automática de casos de prueba desde el ticket | QA / Functional Testing | **PROPOSED** — capacidad diseñada: [`test-case-generation`](../registry/entries/test-case-generation.md) (CAP-014) | KO Interno pág. 25 |
| Tests de regresión automáticos vía MCP Playwright | Regression Testing | **PROPOSED (parcial)** — capacidad diseñada solo para la generación de código: [`regression-test-generation`](../registry/entries/regression-test-generation.md) (CAP-015). La ejecución automática vía MCP Playwright sigue **REQUIRES VALIDATION** — depende de un MCP sin evidencia real en ningún repo, ver `architecture/ai-sdlc.md` | KO Interno pág. 25 |
| Registro de horas y cierre de ticket asistido | Documentation/Knowledge Mgmt | **PROPOSED** — capacidad diseñada: [`ticket-closure-assist`](../registry/entries/ticket-closure-assist.md) (CAP-016) | KO Interno pág. 26 |
| Análisis proactivo de logs de producción (App Insights + BD) | Operations / Incident Mgmt | **PROPOSED** — capacidad diseñada: [`production-incident-investigation`](../registry/entries/production-incident-investigation.md) (CAP-017) | KO Interno pág. 26 |
| Agentes DevOps para diagnóstico de fallos de build (`gh cli`) | CI/CD, Build | **PROPOSED** | KO Interno pág. 26 |

## Métricas y adopción (KO Interno, pág. 16-18)

| Caso de uso | Etapa SDLC | Estado | Evidencia |
|---|---|---|---|
| ETL de métricas de adopción/productividad/calidad desde Jira, Azure DevOps, Copilot, SonarQube | Continuous Improvement | **REQUIRES VALIDATION** | KO Interno pág. 16-18 — sin capacidad ni evidencia dentro de este modelo base |
| Dashboard ejecutivo de métricas (Power BI) | Continuous Improvement | **PROPOSED** | KO Interno pág. 16, 18 |

## Operación y soporte (KO Interno, pág. 27)

| Caso de uso | Estado | Nota |
|---|---|---|
| Triage asistido y respuesta automática | **PROPOSED (parcial)** | Capacidad diseñada solo para el diagnóstico de causa raíz: [`production-incident-investigation`](../registry/entries/production-incident-investigation.md) (CAP-017) — no cubre clasificación/triage automático de severidad ni la respuesta en sí |
| Respuesta sugerida a Nivel 1 (casos históricos similares) | **PROPOSED** | Idem |
| Comunicaciones de estado automáticas (formato ANS) | **PROPOSED** | Idem |
| Cierre asistido con calidad de datos | **PROPOSED** | Idem |
| Detección de recurrencia y alerta preventiva | **PROPOSED** | Idem |

## Equipos sin caso de uso documentado todavía (REQUIRES VALIDATION)

Data (más allá de métricas), QA/Testing como equipo independiente, Seguridad, DevOps,
Operaciones (más allá de las 5 líneas de soporte del KO), Arquitectura. El encuadre fundacional de la iniciativa
lista áreas posibles para cada uno (SQL/ETL, Playwright/regresión, vulnerability
analysis, Terraform/CI-CD, runbooks/observabilidad) pero **son ejemplos iniciales, no
casos de uso aprobados** — así lo indica explícitamente el propio encuadre fundacional de la iniciativa.
