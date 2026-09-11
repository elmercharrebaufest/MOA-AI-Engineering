# Measurement Record — EXEC-20260909-001

## Measurement Contract

| Campo | Valor |
|---|---|
| `metric_id` | MET-CTX-01 (todavía no es una métrica oficial, es candidata) |
| `capability_id` | CAP-002 / CAP-008 |
| `evidence_reference` | [`evidence.md`](evidence.md) |
| `evaluation_reference` | [`evaluation.md`](evaluation.md) |
| `value` | — (no hay medición) |
| `unit` | — |
| `period` | — |
| `baseline_reference` | Todavía no hay un baseline confirmado |
| `confidence` | — |
| `status` | No medido |

## Por qué no hay medición todavía

Esta es la cuarta vez que se prueba este mismo camino (traer contexto de Jira/ADO y
generar la historia de usuario), y la tercera vez que sale bien. Tres casos exitosos
todavía no alcanzan para sacar una conclusión estadística ni para confirmar esta métrica
como algo oficial:

- Ya se probaron 3 tipos distintos de issue (un bug, una tarea, y ahora un caso de
  prueba), de los 17 tipos que existen en el proyecto real — es un buen avance, pero
  sigue siendo poca muestra.
- Las 3 ejecuciones las hizo la misma persona que diseñó el patrón — todavía no hay forma
  de separar "qué tan bueno es el método" de "qué tan bien lo usa quien lo inventó".
- Ninguna de las 3 tiene todavía una revisión humana confirmada — sin eso, no hay con qué
  comparar si el resultado fue realmente bueno o no.

## Qué haría falta para poder medir esto

1. Que al menos una de estas ejecuciones tenga una revisión humana real confirmada.
2. Un número más grande de ejecuciones (recomendado: 5 o más), con variedad de tipo de
   issue y, si es posible, de quién las ejecuta.

No se completa ningún valor ni porcentaje inventado mientras tanto — que diga "no medido"
es un resultado honesto, no una plantilla a medio llenar.
