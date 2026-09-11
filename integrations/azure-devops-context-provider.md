# Azure DevOps Context Provider (pattern)

**Registry**: [`CAP-007`](../registry/entries/azure-devops-context.md).
**Cross-Cutting Concern que implementa**: [`../architecture/context-acquisition-resolution.md`](../architecture/context-acquisition-resolution.md)
— Modelo B (Connected Context).
**Action Type**: **READ**. No implementa `ACT`.
**Origen del patrón**: generalización de la Skill real `azure-devops-cli`
([CAP-001](../registry/entries/azure-devops-cli.md), evidencia real en Scato Logística y
Orquestador) — **no es una copia literal** de ninguna de las 2 instancias. CAP-001 opera
Azure DevOps en general (pipelines, PRs, builds); este patrón extrae específicamente el
subconjunto de esa capacidad que resuelve **contexto a partir de una referencia**, y lo
formaliza contra el contrato de Resolved Context.

## Propósito

Convertir una referencia a un recurso de Azure DevOps (Work Item, PR) en un `Resolved
Context` que cualquier capability pueda consumir, sin que la capability necesite saber que
el origen fue Azure DevOps.

## Flujo

```text
Reference (ej. Work Item #1234)
        ↓
Azure DevOps (consulta READ)
        ↓
Work Item / recurso
        ↓
Resolved Context
```

## Input

```
reference: <ID de Work Item o número de PR>
resource_type: work_item | pull_request
```

## Output

Un `Resolved Context` ([`../architecture/context-acquisition-resolution.md`](../architecture/context-acquisition-resolution.md#resolved-context-contract)):

```yaml
source_type: connected
source_system: azure-devops
source_identifier: <reference>
resolved_at: <timestamp>
content_reference: <URL del Work Item/PR en Azure DevOps>
content: <título + descripción + campos relevantes, en texto>
metadata:
  state: <estado del work item>
  work_item_type: <tipo>
  assigned_to: <REQUIRES VALIDATION si el dato es sensible en el contexto del equipo>
provenance: "azure-devops-context-provider v1"
retrieval_status: resolved | failed | not_found
```

## Dependencia

- Azure CLI (`az`) con la extensión `azure-devops` — **mismo mecanismo ya real** que
  `azure-devops-cli` (CAP-001), no una herramienta nueva.
- Sesión autenticada contra la organización de Azure DevOps del equipo. **Esto es Team
  Adaptation, no Common Core**: la organización/proyecto configurados dependen de cada
  equipo — este patrón no asume ni documenta ningún nombre de organización real.

## Autenticación requerida

**No definida por este patrón.** Depende de la cuenta/token con el que `az` esté
autenticado en el entorno de cada equipo — mismo principio ya vigente en CAP-001: *"esta
skill no define ni eleva permisos, opera con los que ya existen en el entorno"*. Este
documento **no incluye ningún token, credencial, ni nombre de organización real**.

## Permisos mínimos

- Lectura de Work Items / Pull Requests del proyecto correspondiente — nada más.
- **Nunca** permisos de escritura/administración para este patrón — es READ-only por
  diseño, no por configuración opcional.

## Errores

| Situación | `retrieval_status` |
|---|---|
| Reference no existe en el proyecto configurado | `not_found` |
| Sesión no autenticada / permisos insuficientes | `failed` — reportar el error real de `az`, nunca asumir un contexto vacío como válido |
| Work Item existe pero campos relevantes vienen vacíos | `partial` — nunca completar con contenido inventado |

## Límites

- No resuelve referencias ambiguas (ej. texto libre que podría matchear varios Work
  Items) — solo IDs exactos. Si en el futuro se necesita búsqueda por texto, requiere
  evaluar `confidence` en el contrato (ver `context-acquisition-resolution.md`) como una
  extensión separada, no incluida en esta versión.
- No pagina resultados grandes — un Work Item por resolución.
- No sigue links a Work Items relacionados automáticamente — devuelve el recurso
  solicitado, no un grafo.

## Provenance

Todo `Resolved Context` producido por este patrón declara `provenance:
"azure-devops-context-provider v1"` — permite distinguir, en auditoría posterior, qué
mecanismo produjo un contexto dado.

## Evidencia

- El mecanismo subyacente (`az` CLI + extensión `azure-devops`) tiene evidencia real de
  uso en 2 repos de equipos de MOA (ver CAP-001).
- **Este patrón específico de resolución de contexto (Reference → Resolved Context) ya
  tiene evidencia de ejecución real**: `EXEC-20260908-003` (Work Item #7, proyecto "AWS
  Portal de créditos", org `molinosagro`) — Reference real → Resolved Context real →
  CAP-002 real, de punta a punta. `Real Use Status: EXECUTED` (no `VERIFIED`: sigue sin
  evaluación humana independiente, ver
  [`../registry/entries/azure-devops-context.md`](../registry/entries/azure-devops-context.md)).

## Uso esperado

Un equipo con Azure DevOps ya configurado en su entorno puede usar este patrón para
resolver un Work Item hacia contexto, y pasarlo a cualquier capability que acepte
`Resolved Context` (ej. CAP-002, ver
[`../capabilities/skills/user-story/SKILL.md`](../capabilities/skills/user-story/SKILL.md#context-input)).
No reemplaza el flujo manual (Direct Context) — es una alternativa, no una obligación.

## Implementación ejecutable

- [`scripts/azure-devops-context.ps1`](scripts/azure-devops-context.ps1) — script real,
  usa `az` CLI (mismo mecanismo que CAP-001), READ-only, sin credenciales hardcoded.
- [`scripts/resolved-context.schema.json`](scripts/resolved-context.schema.json) —
  serialización JSON del contrato de `../architecture/context-acquisition-resolution.md`
  (no un contrato nuevo — ver la nota del propio schema).
- [`scripts/invoke-cap002-with-context.ps1`](scripts/invoke-cap002-with-context.ps1) —
  adaptador hacia CAP-002, sin tocar CAP-002 mismo.
- Quick Start ejecutable completo:
  [`../adoption/context-providers-quickstart.md`](../adoption/context-providers-quickstart.md).

## Qué es Team Adaptation, explícitamente

- La organización/proyecto de Azure DevOps configurados.
- La identidad/autenticación usada por `az`.
- Cualquier campo adicional de `metadata` que un equipo necesite extraer de su propio
  proceso (este patrón define el mínimo, no un máximo cerrado).
