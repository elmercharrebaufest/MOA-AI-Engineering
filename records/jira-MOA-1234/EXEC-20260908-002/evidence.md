# Evidence Record — EXEC-20260908-002

Contrato canónico: [`../architecture/evidence-evaluation-measurement.md`](../../../architecture/evidence-evaluation-measurement.md#1-evidence).

| Campo | Valor |
|---|---|
| `capability_id` | CAP-008 (`jira-context`) |
| `capability_version` | `1.0-pattern` (jira-context-provider v1) |
| `execution_id` | EXEC-20260908-002 |
| `executed_at` | 2026-09-08, mismo día de la implementación |
| `actor` | Ejecutor técnico de esta actividad (human+AI assistant) |
| `repository` | `MOA-AI-Engineering` |
| `branch` | `main` |
| `input_reference` | `Reference: MOA-1234` (referencia de prueba, no un issue real confirmado) |
| `output_reference` | Resolved Context JSON, `retrievalStatus: SOURCE_UNAVAILABLE` (ver más abajo) |
| `evidence_reference` | Este mismo registro |
| `evaluation_reference` | `NOT EVALUATED` |
| `metric_reference` | `NOT MEASURED` |
| `status` | **FAILED — real, no simulado** |

## Qué se ejecutó realmente

```powershell
./integrations/scripts/jira-context.ps1 -Reference "MOA-1234"
```

Ejecución real del script `jira-context.ps1` contra este entorno. **No se llamó a ningún
sistema externo** — el script detectó, antes de intentar cualquier llamada de red, que
faltan las 3 variables de entorno requeridas (`JIRA_BASE_URL`, `JIRA_EMAIL`,
`JIRA_API_TOKEN`) y devolvió el resultado real de esa condición.

## Resultado real (JSON completo, sin editar)

```json
{
    "source": "jira",
    "sourceReference": "MOA-1234",
    "sourceType": "connected",
    "title": null,
    "description": null,
    "status": null,
    "requirements": null,
    "acceptanceCriteria": null,
    "metadata": {},
    "provenance": "jira-context-provider v1 (REST fallback -- MCP getJiraIssue es Prioridad 1, ver mcp.template.json)",
    "retrievalStatus": "SOURCE_UNAVAILABLE",
    "retrievedAt": "2026-09-08T22:01:06Z",
    "sourceUrl": null,
    "error": "BLOCKED: faltan variables de entorno requeridas (JIRA_BASE_URL, JIRA_EMAIL, JIRA_API_TOKEN). Este script no simula un resultado -- requiere autenticacion real (MCP Atlassian o REST) que no esta disponible en este entorno de ejecucion."
}
```

## Causa raíz de BLOCKED

1. **No hay ningún MCP de Atlassian invocable en este entorno de ejecución** — se buscó
   explícitamente (`ToolSearch`) antes de intentar cualquier cosa, sin resultado. El
   mecanismo Prioridad 1 (`getJiraIssue`) no está disponible desde esta sesión, aunque sí
   está documentado como patrón (`mcp.template.json`) para un entorno VS Code + Copilot
   real de un equipo.
2. **No hay credenciales de Jira (REST, Prioridad 2) configuradas en este entorno** — sin
   `JIRA_BASE_URL`/`JIRA_EMAIL`/`JIRA_API_TOKEN`.

## Requisito necesario para desbloquear

Uno de los dos:
- Un cliente MCP real (VS Code/Copilot) con `mcp.template.json` instalado y autenticado
  contra la instancia real de Jira de MOA, o
- Las 3 variables de entorno (`JIRA_BASE_URL`, `JIRA_EMAIL`, `JIRA_API_TOKEN`) con un API
  token real de una cuenta autorizada, provistas de forma segura (nunca commiteadas).

**No se intentó ningún workaround** (no se buscaron credenciales alternativas, no se
simuló una respuesta) — consistente con la regla explícita de esta actividad.
