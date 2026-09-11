# Evidence Record — EXEC-20260908-003

Contrato canónico: [`../architecture/evidence-evaluation-measurement.md`](../../../architecture/evidence-evaluation-measurement.md#1-evidence).
**Primer vertical slice completo de punta a punta**: Azure DevOps (real) → Resolved
Context → CAP-002 (real).

| Campo | Valor |
|---|---|
| `capability_id` | CAP-002 (`user-story`), habilitado por CAP-007 (`azure-devops-context`) |
| `capability_version` | CAP-002 `1.0-generalized`; CAP-007 `1.0-pattern` (`azure-devops-context-provider v1`) |
| `execution_id` | EXEC-20260908-003 |
| `executed_at` | 2026-09-08 |
| `actor` | Ejecutor técnico de esta actividad (human+AI assistant) |
| `repository` | `MOA-AI-Engineering` |
| `branch` | `main` |
| `input_reference` | Work Item #7, proyecto **AWS Portal de créditos**, org `molinosagro` — `https://dev.azure.com/molinosagro/_workitems/edit/7` |
| `output_reference` | Historia de usuario + análisis de gaps (ver más abajo) |
| `evidence_reference` | Este mismo registro |
| `evaluation_reference` | [`EXEC-20260908-003`](evaluation.md) |
| `metric_reference` | [`EXEC-20260908-003`](measurement.md) — `NOT MEASURED` |
| `status` | **EXECUTED** — real, no simulado |

## Paso 1 — Context Provider real (CAP-007)

```powershell
$env:AZURE_DEVOPS_ORG = "https://dev.azure.com/molinosagro"
./integrations/scripts/azure-devops-context.ps1 -Reference 7 -ResourceType work_item
```

Resolved Context real, sin editar:

```json
{
    "source": "azure-devops",
    "sourceReference": "7",
    "sourceType": "connected",
    "title": "crear casos de prueba",
    "description": null,
    "status": "To Do",
    "requirements": null,
    "acceptanceCriteria": null,
    "metadata": { "workItemType": "Issue", "assignedTo": null },
    "provenance": "azure-devops-context-provider v1 (az cli)",
    "retrievalStatus": "SUCCESS",
    "retrievedAt": "2026-09-08T22:10:19Z",
    "sourceUrl": "https://dev.azure.com/molinosagro/_workitems/edit/7",
    "error": null
}
```

**Nota de proceso**: la primera ejecución de este mismo comando devolvió `sourceUrl: null`
por un bug real del script (`_links.html.href` no existe en la respuesta real de
`az boards work-item show` para esta consulta) — se corrigió en
`integrations/scripts/azure-devops-context.ps1` (URL determinística
`{org}/_workitems/edit/{id}`, no inventada) y se volvió a ejecutar. El bug y su fix quedan
documentados acá, no ocultos.

## Paso 2 — Adaptador hacia CAP-002

```powershell
./integrations/scripts/invoke-cap002-with-context.ps1 -ContextFile ado-vertical-slice-result.json
```

Salida real:
```
Ticket:
7

Requirement:
"crear casos de prueba"

Context:
"Fuente: azure-devops (7)
Estado en origen: To Do
Referencia verificable: https://dev.azure.com/molinosagro/_workitems/edit/7
Resuelto: 2026-09-08T22:10:19Z via azure-devops-context-provider v1 (az cli)"
```

## Paso 3 — Ejecución real de CAP-002 sobre ese input

Aplicado el patrón de `capabilities/skills/user-story/SKILL.md` (sección "Execution
prompt pattern"), tal cual, sin modificar la capability:

### Historia de usuario
```
Como [rol no especificado en el Work Item de origen],
quiero crear casos de prueba,
para [beneficio no especificado en el Work Item de origen].
```

### Criterios de aceptación
No fue posible derivar criterios de aceptación verificables — el Work Item de origen no
tiene descripción (`description: null`) más allá del título. **No se inventaron
criterios.**

### Reglas de negocio
Ninguna regla de negocio identificable en el Work Item de origen.

### Análisis de gaps
```
❓ No se especifica el rol/actor que solicita esto.
   Contexto: el título "crear casos de prueba" no indica quién lo necesita.
   Impacto si no se resuelve: alto — sin rol, la historia no es accionable.

❓ No hay descripción del alcance ("casos de prueba" de qué funcionalidad).
   Contexto: description = null en el Work Item de origen.
   Impacto si no se resuelve: alto — sin alcance, no se puede estimar ni desarrollar.

❓ Sin criterios de aceptación ni reglas de negocio en el origen.
   Contexto: el Work Item es de tipo "Issue", estado "To Do" — parece un placeholder de
   scaffolding, no un requerimiento refinado.
   Impacto si no se resuelve: alto.
```

## Resultado — respeta el comportamiento esperado de CAP-002

Esta ejecución **demuestra el valor real del análisis de gaps de CAP-002**, no un fallo:
frente a un Work Item genuinamente vacío de contenido, la capability lo señala
explícitamente en vez de inventar un rol, un beneficio o criterios plausibles. **Ningún
campo de la salida fue completado con contenido no presente en el Work Item real.**

## Preservación del comportamiento de Direct Context

**Verificado en la misma sesión, sin cambios**: CAP-002 sigue aceptando el bloque
`Ticket:/Requirement:/Context:` exactamente igual cuando el `Context:` se escribe a mano
— este vertical slice solo cambió *de dónde* vino el texto de `Context:`, no el contrato
de entrada de la capability (ver `capabilities/skills/user-story/SKILL.md#context-input`).
