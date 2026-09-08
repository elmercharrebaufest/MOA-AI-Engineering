# Context Acquisition & Resolution

**Estado**: PROPOSAL — primera versión implementada del concepto ya evaluado en
[`benchmark-to-target-model-decision-input.md`](benchmark-to-target-model-decision-input.md)
(Decisión #1, `GAP` → primera implementación). **No es una capability de negocio
adicional.** Es un **Cross-Cutting Concern**, del mismo tipo que Evaluation, Observability
y Metrics ([`capability-model.md`](capability-model.md)) — no se "elige" para resolver un
caso de uso, **opera antes** de cualquiera de las 7 capacidades seleccionables,
resolviendo de dónde viene el input que esas capacidades consumen.

## Por qué existe

Toda capability necesita contexto para ejecutarse. Hoy ese contexto llega de 2 formas
distintas, sin que ninguna capability tenga que saber cuál — y esa independencia es
justamente lo que hay que preservar:

- Alguien lo escribe directamente (**Direct Context**).
- Alguien da una referencia (ej. un ticket) y un mecanismo autorizado la resuelve
  (**Connected Context**).

**Regla dura, sin excepción**: una capability no debe requerir saber si su contexto vino
de Jira, Azure DevOps, SharePoint u otro sistema. Recibe **Resolved Context** — el mismo
contrato, sin importar el origen.

## Modelo A — Direct Context

El usuario proporciona directamente el contexto, sin ninguna resolución de por medio.

```
Requirement:
"..."

Context:
"..."
```

Este es el modo que **ya funciona hoy** — es como CAP-002 (`user-story`) se ejecutó en
sus 2 evidencias reales ([`../evidence/README.md`](../evidence/README.md)). No requiere
ningún cambio para seguir funcionando así.

## Modelo B — Connected Context

El usuario proporciona una referencia. Una integración autorizada recupera el contexto
desde el sistema origen.

```
Reference:
MOA-1234
```

**Hoy no existe ninguna instancia real que resuelva esto de punta a punta** — es la
brecha confirmada en
[`../evidence/current-moa-ai-practices-benchmark.md`](../evidence/current-moa-ai-practices-benchmark.md)
sección 6. Esta versión define el contrato y los primeros 2 patrones concretos
(Azure DevOps, Jira — ver [`../integrations/`](../integrations/catalog.md)), ambos
**READ-only**, sin implementar infraestructura ni servicio distribuido.

## Flujo

```
Request
   │
   ▼
Context Acquisition / Resolution
   │
   ├── Direct Context ──────────────┐
   │                                │
   └── Connected Context            │
        │                           │
        ├── Azure DevOps            │
        ├── Jira                    │
        └── [otros, futuros]        │
        │                           │
        ▼                           │
   Resolved Context ◄───────────────┘
   │
   ▼
Capability (ej. CAP-002)
```

Da igual si el `Resolved Context` viene de Direct o Connected — la capability recibe la
misma forma.

## Resolved Context Contract

Contrato mínimo, provider-agnostic — debe poder representar Jira, Azure DevOps,
SharePoint, Git, u otro sistema futuro **sin cambiar este contrato**. Cada campo tiene un
propósito concreto, ninguno se agregó solo para completar una tabla:

| Campo | Propósito | Obligatorio |
|---|---|---|
| `source_type` | `direct` \| `connected` — de qué modo se obtuvo el contexto, la distinción central de este documento | Sí |
| `source_system` | Sistema origen si `connected` (ej. `azure-devops`, `jira`); `manual` si `direct` | Sí |
| `source_identifier` | La referencia usada para resolver (ej. `MOA-1234`); vacío/`N/A` si `direct` | Sí, si `connected` |
| `resolved_at` | Cuándo se resolvió — necesario para saber si el contexto pudo quedar desactualizado respecto al sistema origen | Sí |
| `content_reference` | Link/path al recurso origen, para que un humano pueda verificarlo contra la fuente real — nunca se confía en `content` sin poder rastrear de dónde vino | Sí, si `connected` |
| `content` | El contexto resuelto en sí — lo que la capability consume | Sí |
| `metadata` | Campos estructurados adicionales del recurso origen (ej. estado del ticket, asignado, tipo) que la capability puede necesitar sin reparsear `content` | No |
| `provenance` | Quién/qué ejecutó la resolución (persona, o qué Context Provider) — necesario para auditar de dónde salió el contexto que terminó en una decisión | Sí |
| `retrieval_status` | `resolved` \| `failed` \| `partial` \| `not_found` — nunca se asume `resolved` implícitamente; un fallo de resolución debe ser explícito, no silencioso | Sí |
| `confidence` | Solo si el mecanismo de resolución puede producir ambigüedad real (ej. varias coincidencias posibles para una búsqueda) — **no se agrega si `source_identifier` ya resuelve sin ambigüedad**, como es el caso de un ID exacto de work item/issue | No — condicional |

**Regla dura, heredada de `evidence-evaluation-measurement.md`**: si la resolución falla,
`retrieval_status: failed` o `not_found` — nunca un `content` vacío tratado como si fuera
un resultado válido, y nunca un `content` inventado para no dejar el campo vacío.

## Relación con el resto del modelo

- **No es una de las 7 capacidades seleccionables** de `capability-model.md` — sigue
  habiendo exactamente 7 (Instruction, Skill, Workflow, Agent, Knowledge/RAG,
  Integration/API, MCP). Es el 4º Cross-Cutting Concern, junto a Evaluation, Observability
  y Metrics.
- **Un Context Provider concreto (Azure DevOps, Jira) sí puede registrarse como
  capability** de tipo Integration/API o MCP en `capability-registry.md` — lo que produce
  (`Resolved Context`) no es una capability, pero el mecanismo que lo produce sí encaja en
  la taxonomía existente. Ver [`../integrations/azure-devops-context-provider.md`](../integrations/azure-devops-context-provider.md)
  y [`../integrations/jira-context-provider.md`](../integrations/jira-context-provider.md).
- **READ vs. ACT**: todo Context Provider de esta primera versión es **READ-only** por
  diseño — ver [`../security/security-governance.md`](../security/security-governance.md)
  para la frontera formal.
- **Observability**: `retrieval_status` y `provenance` son, específicamente, los campos
  que permiten después construir trazabilidad de ejecución sobre la adquisición de
  contexto — ver `evaluation-observability.md`.

## Implementación de referencia (ejecutable)

**El contrato de arriba es el canónico — lo que sigue es su serialización JSON
ejecutable, no un contrato nuevo.** `content` se descompone en `title`/`description`/
`requirements`/`acceptanceCriteria` porque un Work Item/Issue tiene naturalmente esa
forma; `content_reference` se serializa como `sourceUrl`; el resto son los mismos campos
en camelCase. Ver
[`../integrations/scripts/resolved-context.schema.json`](../integrations/scripts/resolved-context.schema.json)
para el JSON Schema completo con esta nota documentada en el propio archivo.

- [`../integrations/scripts/azure-devops-context.ps1`](../integrations/scripts/azure-devops-context.ps1) — CAP-007, READ-only, `az` CLI.
- [`../integrations/scripts/jira-context.ps1`](../integrations/scripts/jira-context.ps1) — CAP-008, READ-only, REST (fallback documentado — MCP `getJiraIssue` es Prioridad 1, ver [`../integrations/scripts/mcp.template.json`](../integrations/scripts/mcp.template.json)).
- [`../integrations/scripts/invoke-cap002-with-context.ps1`](../integrations/scripts/invoke-cap002-with-context.ps1) — adaptador hacia CAP-002, sin tocar la capability misma.
- Quick Start completo: [`../adoption/context-providers-quickstart.md`](../adoption/context-providers-quickstart.md).

`retrieval_status` en la implementación real usa una enumeración más granular que la
versión conceptual de arriba: `SUCCESS`, `NOT_FOUND`, `UNAUTHORIZED`, `FORBIDDEN`,
`SOURCE_UNAVAILABLE`, `INVALID_REFERENCE`, `PARTIAL` — un refinamiento del mismo campo
(`resolved`/`failed`/`partial`/`not_found` de la versión conceptual eran una
simplificación previa), no un campo nuevo.

## Qué NO implementa esta versión

- Ningún servicio distribuido, ningún cache, ninguna infraestructura de resolución.
- Ninguna resolución automática dentro de CAP-002 ni de ninguna otra capability existente
  — la resolución es un paso previo y externo, no una función interna de la capability.
- Ningún Context Provider más allá de Azure DevOps y Jira en esta primera ola — SharePoint,
  Confluence, Git u otros quedan `REQUIRES VALIDATION`/futuro, sin diseño todavía.
- Ninguna operación de escritura (`ACT`) desde ningún Context Provider.
