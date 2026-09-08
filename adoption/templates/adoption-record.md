# Adoption Record — plantilla operacional

No es un contrato corporativo — es un registro operativo simple que un equipo completa
**una vez, al decidir adoptar una capability**, antes de la primera Execution. Sirve para
dejar trazabilidad de la decisión, no para gobierno formal (eso sigue viviendo en
`registry/entries/`).

## Cómo usar esta plantilla

1. Copiá este archivo a tu propio repo (ej. `_ai-adoption/ADOPTION-<capability>.md`) o a
   donde tu equipo versione este tipo de decisiones.
2. Completala **antes** de ejecutar por primera vez — es la decisión de adoptar, no el
   resultado de haber ejecutado.
3. Un `adoption_id` puede tener múltiples `execution_id` después (ver
   [`execution-record.md`](execution-record.md)) — adoptás una vez, ejecutás varias.

## Adoption Record

| Campo | Valor |
|---|---|
| `adoption_id` | *(identificador único — ej. ADOPT-20260101-001)* |
| `date` | *(fecha de la decisión de adoptar)* |
| `team` | *(tu equipo real)* |
| `project` | *(tu proyecto/repo real)* |
| `repository` | *(repo donde vas a usar la capability)* |
| `sdlc_activity` | *(qué actividad del SDLC vas a mejorar — ej. "refinamiento de requerimientos")* |
| `golden_path` | *(qué Golden Path seguís, si aplica — ver `../../golden-paths/README.md`)* |
| `capability_id` | *(ID del Registry — ej. CAP-002)* |
| `capability_version` | *(versión de la capability al momento de adoptar)* |
| `objective` | *(qué esperás lograr, en una frase concreta)* |
| `reason_for_adoption` | *(por qué esta capability y no otra, o por qué ninguna existente y vas a proponer una)* |
| `team_adaptations` | *(qué adaptaste del contenido de dominio — ver `../team-adaptation.md`)* |
| `executor` | *(quién va a ejecutar — persona real, no "el equipo")* |
| `evaluator` | *(quién va a evaluar — `REQUIRES VALIDATION` si todavía no hay nadie confirmado)* |
| `risk` | *(campo `Risk` de la entrada del Registry, copiado — no reinventado)* |
| `hitl_required` | *(`true`/`false` — ver campo `HITL` de la capability)* |
| `measurement_available` | *(¿existe baseline para medir impacto? `true`/`false`)* |
| `baseline_reference` | *(si `measurement_available: false`, poné `REQUIRES VALIDATION`)* |
| `status` | *(`PLANNED` / `IN PROGRESS` / `COMPLETED` / `ABANDONED`)* |

## NOTES

*(espacio libre para contexto adicional que no encaje en los campos de arriba)*

## Después de completar esto

Cada vez que ejecutes esta capability sobre trabajo real, completá un
[`execution-record.md`](execution-record.md) nuevo, referenciando este `adoption_id`.
