# Measurement Result — plantilla operacional

> Este archivo es una plantilla operacional. El contrato canónico está en
> [`../../architecture/evidence-evaluation-measurement.md`](../../architecture/evidence-evaluation-measurement.md#3-measurement).
> Esta plantilla **no redefine** ese contrato.

## Cómo usar esta plantilla

1. Copiá este archivo a `measurements/EXEC-<fecha>-<número>.md`.
2. **Si no existe baseline, no lo inventes.** Completá:
   - `status: NOT MEASURED`
   - `baseline_reference: REQUIRES VALIDATION`

   Eso es un resultado válido y honesto — no una plantilla a medio completar.
3. Nunca conviertas la ausencia de dato en `0` ni en un porcentaje estimado.

## Measurement Result Contract

| Campo | Valor |
|---|---|
| `capability_id` | *(ID del Registry)* |
| `capability_version` | *(versión medida)* |
| `metric_id` | *(si coincide con una de `../../metrics/framework.md`, reutilizala; si es nueva, declarala)* |
| `metric_name` | *(nombre legible)* |
| `metric_definition` | *(cómo se calcula, en una frase verificable — sin esto no es una métrica)* |
| `value` | *(el valor medido — obligatorio solo si `status = MEASURED`)* |
| `unit` | *(%, horas, cantidad, etc. — obligatorio si hay `value`)* |
| `period` | *(ventana de tiempo que cubre la medición)* |
| `baseline_reference` | *(a qué se compara — `REQUIRES VALIDATION` si no existe baseline)* |
| `source` | *(`moa-metrics` (referencia) o `local measurement` — con quién/cómo)* |
| `calculation_reference` | *(link a query, o descripción del conteo manual)* |
| `measured_at` | *(fecha)* |
| `owner` | *(quién es responsable del dato — `REQUIRES VALIDATION` si no confirmado)* |
| `confidence/status` | *(`MEASURED` / `NOT MEASURED` / `NO DATA`)* |

## Reglas duras, sin excepción

- Si no existe medición real: `NOT MEASURED` o `NO DATA` — **nunca `0`**.
- Si no existe baseline: `baseline_reference: REQUIRES VALIDATION` — no se inventa un
  baseline para poder calcular un porcentaje de mejora.

## Después de completar esto

Seguí con [`../contribution-guide.md`](../contribution-guide.md) si encontraste algo que
valdría la pena compartir con otros equipos.
