**¿El developer o el PO ya revisaron esta historia?** Es la oportunidad de confirmarlo:
si están de acuerdo, cambiar `method` a `human` y completar `evaluator` y
`hitl_confirmed_by` con quien revisó. Si no, lo mismo con `result: FAIL` o `PARTIAL` y la
razón real.

| Campo | Valor |
|---|---|
| `capability_id` | CAP-001 (`user-story`) |
| `evidence_reference` | [`evidence.md`](evidence.md) |
| `criteria` | Declarados antes de la ejecución: (1) entre 30 y 40 líneas; (2) entre 3 y 7 criterios Dado/Cuando/Entonces verificables; (3) sin reglas repetidas; (4) fuera de alcance, datos y dependencias; (5) preguntas marcadas como bloqueantes o no, con opciones y responsable; (6) veredicto y frase de cierre; (7) división cuando corresponde; (8) nada inventado sobre el sistema; (9) español formal, sin voseo |
| `method` | `model-assisted` |
| `evaluator` | Asistente que mantiene el modelo base (no independiente) |
| `result` | `PARTIAL` |
| `rationale` | Cumple 1 a 6 y 8: unas 40 líneas, 6 criterios verificables, sin repeticiones, todas las afirmaciones sobre el código verificadas como ciertas, y detectó 2 impactos que el pedido no decía (el cambio de texto libre a lista y las otras 2 pantallas). Falla 7: el renombre estaba listo y el cambio de datos bloqueado, y debió proponer dividir en lugar de frenar todo. Falla 9: cerró con "si me pasás el ID". El cierre tampoco siguió el formato previsto: el asistente leyó la skill hasta la línea 200 de 287 y la sección de cierre empezaba en la 193. Corregido en la versión 0.4.1 de la skill |
| `evaluated_at` | 2026-09-24 |
| `hitl_required` | `true` |
| `hitl_confirmed_by` | Nadie todavía — pendiente del PO o del developer |
