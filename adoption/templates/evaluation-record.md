# Evaluation Record — plantilla operacional

> Este archivo es una plantilla operacional. El contrato canónico está en
> [`../../architecture/evidence-evaluation-measurement.md`](../../architecture/evidence-evaluation-measurement.md#2-evaluation).
> Esta plantilla **no redefine** ese contrato.

## Cómo usar esta plantilla

1. **Declará los criterios ANTES de mirar el resultado** — si ya viste el resultado y
   recién ahora escribís los criterios, no es una evaluación honesta.
2. Copiá este archivo a `evaluation/EXEC-<fecha>-<número>.md`, mismo `execution_id` que
   el Evidence Record que evalúa.
3. Completá el `method` real — `model-assisted` (autoevaluación por el mismo actor que
   ejecutó) **no sustituye** una evaluación humana independiente, sin excepción.

## Evaluation Contract

| Campo | Valor |
|---|---|
| `capability_id` | *(ID del Registry)* |
| `evidence_reference` | *(qué Evidence Record se evaluó)* |
| `criteria` | *(lista de criterios — declarados antes de evaluar)* |
| `method` | *(`human` / `deterministic` / `automated` / `model-assisted`)* |
| `evaluator` | *(persona/mecanismo — `REQUIRES VALIDATION` si no hay evaluador confirmado)* |
| `result` | *(`PASS` / `FAIL` / `PARTIAL`)* |
| `rationale` | *(justificación del resultado — no un campo opcional)* |
| `evaluated_at` | *(fecha)* |
| `hitl_required` | *(`true`/`false` — si esta evaluación requería validación humana)* |
| `hitl_confirmed_by` | *(quién confirmó, si `hitl_required = true`; si no hay nadie confirmado, decilo)* |

## Qué NO hacer

- No tratar un `result: PASS` de `method: model-assisted` como si fuera una aprobación
  humana — son cosas distintas, sin importar cuántas veces se repita la ejecución.
- No omitir `rationale` — un resultado sin justificación no es una evaluación.

## Después de completar esto

Si hay baseline disponible, seguí con
[`measurement-record.md`](measurement-record.md). Si no, el ciclo de esta ejecución
termina acá — y eso es un resultado válido.
