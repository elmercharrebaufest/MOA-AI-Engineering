# Catálogo de integraciones

Clasificación según lo pide el encuadre fundacional de la iniciativa: **EXISTING** (implementada en código en
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
| **Confluence** | **REQUIRES VALIDATION** | Mencionada en el KO como repositorio de documentación (Baufest). No se encontró conector ni evidencia de integración técnica en ningún repo. |
| **MCP servers (Jira, Confluence, Azure DevOps, SQL Server)** | **PROPOSED** | KO Interno (pág. 16): *"Garantizar el acceso por MCP para las herramientas existentes."* `moa-sdlc/AGENTS.md` ya asume un "MCP de Jira" para crear branches, pero no hay evidencia de gobierno de ese MCP (auth/scope/auditoría) documentada. |
| **MCP Atlassian (`com.atlassian/atlassian-mcp-server`)** | **CONFIGURATION VERIFIED / REAL USE REQUIRES VALIDATION** | Referenciado en agents de DataAgro, Scato Logística y Orquestador (rama `feature/cardless4` en este último, **no integrada a `master`**), con scope `/*` en algunos casos (sin acotar a solo lectura). Sin evidencia de identidad, autenticación, ni ejecución real. Ver [`../security/security-governance.md`](../security/security-governance.md) — prioridad de revisión de seguridad. |
| **MCP Azure DevOps (`mcp.dev.azure.com/molinosagro`)** | **CONFIGURATION VERIFIED / REAL USE REQUIRES VALIDATION** | `.vscode/mcp.json` real en DataAgro, apuntando a un servidor MCP con nombre de organización real de MOA. Ver [`../security/security-governance.md`](../security/security-governance.md). |
| **Application Insights** | **PROPOSED** | KO Interno (pág. 16): *"Para centralizar los logs de aplicación y poder alimentar información de errores productivos a los agentes."* Sin evidencia de implementación. |
| **Power BI (tablero de métricas)** | **PROPOSED** | KO Interno (pág. 16, 18): tablero ejecutivo con datos de GitHub y Jira. `moa-metrics` calcula los indicadores pero no se encontró el dashboard en sí (fuera de alcance explícito de `moa-metrics`, ver su documento de requerimientos sección 7). |
| **Playwright (MCP)** | **PROPOSED** | KO Interno (pág. 15, 25): tests de regresión generados vía Copilot + Skills + MCP Playwright. `moa-sdlc` menciona Playwright como práctica de testing pero no como MCP configurado. |
| **CI/CD (Azure DevOps Pipelines)** | **EXISTING** | `moa-sdlc/azure-pipelines.yml` confirma pipeline real. KO confirma Azure DevOps como plataforma de build/CI. |

## Ver también — patrones de Context Provider (nuevo)

Los 2 primeros patrones reusables de adquisición de contexto (Context Acquisition &
Resolution, [`../architecture/context-acquisition-resolution.md`](../architecture/context-acquisition-resolution.md)),
**ambos READ-only**, extraídos de las filas EXISTING/CONFIGURATION VERIFIED de esta tabla
(Azure DevOps CLI y MCP Atlassian con scope acotado, no del wildcard):

- [`azure-devops-context-provider.md`](azure-devops-context-provider.md) — [CAP-007](../registry/entries/azure-devops-context.md)
- [`jira-context-provider.md`](jira-context-provider.md) — [CAP-008](../registry/entries/jira-context.md)

## Nota sobre gobierno de MCP (pendiente — ver `governance/ai-governance.md`)

Ningún MCP mencionado arriba tiene documentado: autenticación, autorización, scope,
auditoría, logging, ni el modelo de riesgo de sus acciones. Antes de habilitar cualquier
MCP con acceso a datos productivos (especialmente **SQL Server**), se requiere una
revisión de seguridad explícita — no se debe asumir que "poder conectar" implica que es
seguro conectar.
