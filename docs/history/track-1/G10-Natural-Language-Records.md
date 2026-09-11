# G10 — Lenguaje natural en Evidence/Evaluation/Measurement

**Fase**: G10. Precondición: G9. Solo se modificó `MOA-AI-Engineering`.

## 1. Disparador

El usuario señaló que el contenido de los registros de ejecución está bien, pero la
**forma** en que está escrito suena a reporte técnico/auditoría en vez de lenguaje
natural — citó como ejemplo un párrafo de `EXEC-20260909-001` que hablaba del proceso
("es la primera con actor real independiente de quien diseñó el modelo... 2 ejes
distintos...") en vez de contar simplemente qué pasó.

## 2. Causa raíz — no era un caso puntual, era la falta de una regla

Los 3 templates operacionales (`adoption/templates/{evidence,evaluation,measurement}-record.md`)
definen bien la tabla de campos, pero **no decían nada sobre cómo escribir el texto libre
alrededor** — nadie estableció esa regla, así que el estilo que fue apareciendo (denso,
con IDs encadenados, jerga de clasificación) se volvió la norma de facto sin que nadie lo
decidiera.

## 3. Cambios aplicados

- Los 3 templates ahora tienen una sección explícita ("Cómo escribir...") con la regla:
  lenguaje simple, como explicándole a un colega — nada de jerga interna, nada de IDs de
  otras ejecuciones en medio de una oración, contar el resultado en vez de describir el
  método de clasificación.
- Reescritos completos, con el mismo contenido/datos reales, sin perder nada verificable:
  `records/jira-ARMOA277-45/EXEC-20260909-001/{evidence,evaluation,measurement}.md`.
- Auditoría de integridad: 606 links, 0 rotos.

## 4. Qué queda pendiente (decisión del usuario, no tomada todavía)

Los otros 6 registros de ejecución reales (`records/jira-MOA-1816/`,
`jira-MOA-1765/`, `jira-MOA-1234/`, `ado-7/`, `jira-ARMOA277-191/`,
`jira-ARMOA277-180/`) tienen el mismo estilo denso — no se tocaron todavía. Aplicar el
mismo criterio ahí es mecánico (mismo patrón ya usado acá), pendiente de que el usuario
confirme si quiere que se haga ahora o más adelante.
