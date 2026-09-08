# Execution Record — plantilla operacional

Registro operativo de **una ejecución concreta** de una capability ya adoptada. **No
duplica ni redefine el Evidence Contract** — es un registro más liviano y orientado a
"qué pasó en esta corrida puntual" (herramienta, modelo, ticket), que después **enlaza**
al Evidence Record oficial (ver [`evidence-record.md`](evidence-record.md)), que sí es el
contrato canónico.

## Cómo usar esta plantilla

1. Copiá este archivo por cada ejecución real — un `adoption_id` puede tener muchos
   `execution_id`.
2. Completá `actual_output_reference` y `execution_status` **después** de ejecutar, nunca
   antes.
3. Cuando termines esto, completá el Evidence Record correspondiente
   ([`evidence-record.md`](evidence-record.md)) — este archivo no lo reemplaza.

## Execution Record

| Campo | Valor |
|---|---|
| `execution_id` | *(identificador único de esta ejecución — mismo que usarás en el Evidence Record)* |
| `adoption_id` | *(referencia al Adoption Record — ver `adoption-record.md`)* |
| `date` | *(fecha de esta ejecución)* |
| `team` | *(tu equipo real)* |
| `project` | *(tu proyecto real)* |
| `repository` | *(repo donde se ejecutó)* |
| `branch` | *(rama donde se ejecutó)* |
| `ticket_or_work_item` | *(ticket/work item real que motiva esta ejecución — nunca inventado)* |
| `golden_path` | *(Golden Path seguido, si aplica)* |
| `capability_id` | *(ID del Registry)* |
| `capability_version` | *(versión usada en esta ejecución)* |
| `tool` | *(asistente de IA usado — Copilot, Claude, u otro; MOA-AI-Engineering no obliga a uno)* |
| `model` | *(modelo concreto, si se conoce y es relevante)* |
| `input_reference` | *(referencia al insumo real — ticket, requerimiento, diff, etc.)* |
| `context_provided` | *(qué contexto adicional se le dio al asistente — instructions, skill, ejemplos)* |
| `expected_output` | *(qué se esperaba obtener, declarado antes de ejecutar)* |
| `actual_output_reference` | *(referencia al resultado real obtenido — completar después de ejecutar)* |
| `human_review_required` | *(`true`/`false`)* |
| `human_review_status` | *(`PENDING` / `DONE` / `NOT APPLICABLE`)* |
| `execution_status` | *(`EXECUTED` / `PARTIAL` / `FAILED`)* |
| `notes` | *(cualquier observación relevante — ej. ambigüedades encontradas, falsos positivos descartados)* |

## Después de completar esto

Completá el [Evidence Record oficial](evidence-record.md) — este Execution Record queda
como bitácora operativa de la corrida, el Evidence Record es lo que se referencia desde
el Registry.
