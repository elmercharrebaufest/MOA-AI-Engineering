# Catálogo de integraciones

Clasificación según lo pide el encuadre fundacional de la iniciativa: **EXISTING** (implementada en código en
algún repo de MOA), **POSSIBLE** (herramienta ya en el stack, integración no confirmada),
**PROPOSED** (mencionada en el KO como "a incorporar"), **REQUIRES VALIDATION** (sin
evidencia suficiente).

| Integración | Estado | Evidencia |
|---|---|---|
| **Jira (API REST)** | **REQUIRES VALIDATION** | Sin evidencia de integración real (conector, auth, extracción) en ningún repo de equipo de MOA. |
| **Azure DevOps Repos (API)** | **REQUIRES VALIDATION** | Sin evidencia de una integración real de extracción (PRs, commits, builds/releases) en ningún repo de equipo de MOA. |
| **GitHub Copilot Metrics (API)** | **REQUIRES VALIDATION** | Sin evidencia de una extracción real de métricas de uso/adopción vía API Enterprise/Org en ningún repo de equipo de MOA. |
| **SonarQube (API)** | **REQUIRES VALIDATION** | El KO dice que SonarQube aún debe instalarse (pág. 16, 22) — sin evidencia de un conector real conectado a una fuente real en ningún repo de equipo de MOA. |
| **SharePoint / Microsoft Graph** | **REQUIRES VALIDATION** | Sin evidencia de integración real en ningún repo de equipo de MOA. |
| **Confluence** | **REQUIRES VALIDATION** | Mencionada en el KO como repositorio de documentación (Baufest). No se encontró conector ni evidencia de integración técnica en ningún repo. |
| **MCP servers (Jira, Confluence, Azure DevOps, SQL Server)** | **PROPOSED** | KO Interno (pág. 16): *"Garantizar el acceso por MCP para las herramientas existentes."* Sin evidencia de gobierno de MCP (auth/scope/auditoría) documentada en ningún repo de equipo de MOA. |
| **MCP Atlassian (`com.atlassian/atlassian-mcp-server`)** | **CONFIGURATION VERIFIED / REAL USE REQUIRES VALIDATION** *(para las configuraciones wildcard encontradas en equipos)* | Referenciado en agents de DataAgro, Scato Logística y Orquestador (rama `feature/cardless4` en este último, **no integrada a `master`**), con scope `/*` en algunos casos (sin acotar a solo lectura). Sin evidencia de identidad, autenticación, ni ejecución real **para esas configuraciones wildcard específicas**. Ver [`../security/security-governance.md`](../security/security-governance.md) — prioridad de revisión de seguridad. **Actualización**: el patrón acotado (scope único `getJiraIssue`, CAP-008) quedó probado de punta a punta durante la construcción — esas pruebas se purgaron al pasar a adopción real, sin ejecuciones reales registradas todavía (ver [`../evidence/README.md`](../evidence/README.md)) — y esto tampoco valida ni extiende a las configuraciones wildcard de los repos de equipo, que siguen `REQUIRES VALIDATION`. |
| **MCP Azure DevOps (`mcp.dev.azure.com/molinosagro`)** | **CONFIGURATION VERIFIED / REAL USE REQUIRES VALIDATION** | `.vscode/mcp.json` real en DataAgro, apuntando a un servidor MCP con nombre de organización real de MOA. Ver [`../security/security-governance.md`](../security/security-governance.md). |
| **Application Insights** | **PROPOSED** | KO Interno (pág. 16): *"Para centralizar los logs de aplicación y poder alimentar información de errores productivos a los agentes."* Sin evidencia de implementación. |
| **Power BI (tablero de métricas)** | **PROPOSED** | KO Interno (pág. 16, 18): tablero ejecutivo con datos de GitHub y Jira. No se encontró el dashboard en sí implementado en ningún repo relevado. |
| **Playwright (MCP)** | **PROPOSED** | KO Interno (pág. 15, 25): tests de regresión generados vía Copilot + Skills + MCP Playwright. Sin evidencia de un MCP de Playwright configurado en ningún repo relevado. |
| **CI/CD (Azure DevOps Pipelines)** | **REQUIRES VALIDATION** | KO confirma Azure DevOps como plataforma de build/CI, pero no se encontró un pipeline de CI/CD real (`azure-pipelines.yml` o equivalente) en ningún repo de equipo de MOA relevado. |

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
