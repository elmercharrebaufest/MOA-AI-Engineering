# Catálogo de integraciones

Clasificación según lo pide el master prompt: **EXISTING** (implementada en código en
algún repo de MOA), **POSSIBLE** (herramienta ya en el stack, integración no confirmada),
**PROPOSED** (mencionada en el KO como "a incorporar"), **REQUIRES VALIDATION** (sin
evidencia suficiente).

| Integración | Estado | Evidencia |
|---|---|---|
| **Jira (API REST)** | **EXISTING** | `moa-metrics/ia-sdlc/connectors/jira.py` implementa auth, paginación y extracción de issues/sprints/changelog. `moa-sdlc/AGENTS.md` referencia MCP de Jira para crear branches. |
| **Azure DevOps Repos (API)** | **EXISTING** | `moa-metrics/ia-sdlc/connectors/ado_repos.py` implementa extracción de PRs, commits, builds/releases. Es la única fuente de código según `moa-metrics`. |
| **GitHub Copilot Metrics (API)** | **EXISTING** | `moa-metrics/ia-sdlc/connectors/copilot.py` implementa extracción de métricas de uso/adopción vía API Enterprise/Org. |
| **SonarQube (API)** | **EXISTING** | `moa-metrics/ia-sdlc/connectors/sonarqube.py` implementa extracción de bugs, vulnerabilities, coverage, quality gate. **[REQUIRES VALIDATION]** el KO dice que SonarQube aún debe instalarse (pág. 16, 22) — verificar si ya está instalado o el conector está listo pero sin fuente real conectada. |
| **SharePoint / Microsoft Graph** | **POSSIBLE** | `moa-metrics/ia-sdlc/connectors/sharepoint.py` existe pero está marcado explícitamente como "opcional, solo enriquecimiento" y con decisión pendiente de alcance en `moa-metrics`. |
| **Confluence** | **REQUIRES VALIDATION** | Mencionada en el KO como repositorio de documentación (Baufest) y en el alcance de conocimiento del master prompt. No se encontró conector ni evidencia de integración técnica en ningún repo. |
| **MCP servers (Jira, Confluence, Azure DevOps, SQL Server)** | **PROPOSED** | KO Interno (pág. 16): *"Garantizar el acceso por MCP para las herramientas existentes."* `moa-sdlc/AGENTS.md` ya asume un "MCP de Jira" para crear branches, pero no hay evidencia de gobierno de ese MCP (auth/scope/auditoría) documentada. |
| **MCP Atlassian (`com.atlassian/atlassian-mcp-server`)** | **CONFIGURATION VERIFIED / REAL USE REQUIRES VALIDATION** *(actualizado G3.2.5)* | Referenciado en 2 agents de `Orquestador/Orquestador` (rama `feature/cardless4`, **no integrada a `master`**), con scope `/*` (sin acotar a solo lectura). Es la primera evidencia concreta de un MCP real en todo el relevamiento — corrige la conclusión previa de "cero MCP desplegados". Sin evidencia de identidad, autenticación, ni ejecución real. Ver `../docs/architecture/security-governance.md` — prioridad de revisión de seguridad. |
| **Application Insights** | **PROPOSED** | KO Interno (pág. 16): *"Para centralizar los logs de aplicación y poder alimentar información de errores productivos a los agentes."* Sin evidencia de implementación. |
| **Power BI (tablero de métricas)** | **PROPOSED** | KO Interno (pág. 16, 18): tablero ejecutivo con datos de GitHub y Jira. `moa-metrics` calcula los indicadores pero no se encontró el dashboard en sí (fuera de alcance explícito de `moa-metrics`, ver su documento de requerimientos sección 7). |
| **Playwright (MCP)** | **PROPOSED** | KO Interno (pág. 15, 25): tests de regresión generados vía Copilot + Skills + MCP Playwright. `moa-sdlc` menciona Playwright como práctica de testing pero no como MCP configurado. |
| **CI/CD (Azure DevOps Pipelines)** | **EXISTING** | `moa-sdlc/azure-pipelines.yml` confirma pipeline real. KO confirma Azure DevOps como plataforma de build/CI. |

## Nota sobre gobierno de MCP (pendiente — ver `governance/ai-governance.md`)

Ningún MCP mencionado arriba tiene documentado: autenticación, autorización, scope,
auditoría, logging, ni el modelo de riesgo de sus acciones. Antes de habilitar cualquier
MCP con acceso a datos productivos (especialmente **SQL Server**), se requiere una
revisión de seguridad explícita — no se debe asumir que "poder conectar" implica que es
seguro conectar.
