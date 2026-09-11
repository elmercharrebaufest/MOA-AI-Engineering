# Measurement Record — EXEC-20260908-005

## Measurement Contract

| Campo | Valor |
|---|---|
| `metric_id` | MET-CTX-01 (reutilizada, no ratificada — misma métrica candidata que en `EXEC-20260908-004`) |
| `capability_id` | CAP-002 / CAP-008 |
| `evidence_reference` | [`EXEC-20260908-005`](evidence.md) |
| `evaluation_reference` | [`EXEC-20260908-005`](evaluation.md) |
| `value` | — (sin medir) |
| `unit` | — |
| `period` | — |
| `baseline_reference` | **REQUIRES VALIDATION** — no existe baseline ratificado |
| `confidence` | — |
| `status` | **NOT MEASURED** |

## Justificación de `NOT MEASURED`

Esta es la **tercera ejecución real** documentada de este patrón en total
(`EXEC-20260908-002` BLOCKED/REST, `EXEC-20260908-004` EXECUTED/MCP,
`EXEC-20260908-005` EXECUTED/MCP — esta), pero solo la **segunda ejecución real exitosa**
sobre el camino MCP. Dos puntos de datos exitosos no constituyen una serie estadística
válida para ratificar `MET-CTX-01` ni ningún baseline de completitud/calidad:

- No hay una muestra representativa de tipos de issue (solo 2 tipos probados: `Error` y
  `Tarea`, de los 17 tipos reales que existen en el proyecto).
- El ejecutor de ambas ejecuciones MCP es el mismo actor que definió el patrón — no hay
  variación de ejecutor que permita separar "calidad del patrón" de "calidad del
  ejecutor".
- No existe evaluación humana en ninguna de las dos ejecuciones MCP, por lo que no hay una
  etiqueta de verdad (ground truth) validada contra la cual calcular una métrica de
  precisión/completitud real.

## Nota para futuras mediciones

Los campos de este registro quedan preparados con la misma estructura que
`measurements/EXEC-20260908-004.md` para cuando exista:
1. Una evaluación humana confirmada (`hitl_confirmed_by` distinto de "Ninguno") sobre al
   menos una ejecución de este patrón, y
2. Un volumen de ejecuciones suficiente (recomendado: ≥5, con variación real de tipo de
   issue y de ejecutor) para ratificar `MET-CTX-01` como métrica activa con baseline.

No se declara ningún valor, unidad ni período simulado para completar esta tabla.
