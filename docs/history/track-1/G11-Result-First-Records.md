# G11 — El resultado primero, el proceso después

**Fase**: G11. Precondición: G10. Solo se modificó `MOA-AI-Engineering`.

## 1. Disparador

El mismo developer volvió a probar, sobre el archivo ya reescrito en lenguaje natural en
G10, y dio el mismo tipo de feedback de nuevo: el archivo sigue hablando del modelo antes
de mostrarle su resultado ("esta es la ejecución más importante de las 6... la primera con
actor independiente de quien diseñó el modelo"). G10 arregló el tono (jerga, oraciones
más simples); esto es un problema distinto y más de fondo: **el orden y el foco del
contenido**.

## 2. El diagnóstico correcto

No alcanza con que el texto suene natural — si lo primero que lee alguien es información
sobre el gobierno interno del modelo (quién lo diseñó, qué tan significativa es esta
ejecución comparada con otras), sigue sintiéndose como "el modelo hablando de sí mismo"
en vez de darle a la persona lo que pidió. La regla que faltaba: **el resultado real va
primero, sin ninguna introducción sobre el proceso; el detalle de trazabilidad va al
final, claramente marcado como opcional.**

## 3. Cambios aplicados

- `records/jira-ARMOA277-45/EXEC-20260909-001/evidence.md` reestructurado: arranca
  directo con la historia de usuario/criterios/reglas/preguntas (lo que el developer
  pidió), sigue con un "¿y ahora qué?" breve, y todo el detalle técnico (contrato,
  JSON, restricciones) quedó en un bloque colegable (`<details>`) al final, marcado
  explícitamente como "no hace falta leer esto para usar el resultado de arriba". Se
  eliminó por completo la comparación con otras ejecuciones y la mención a "quién diseñó
  el modelo" — eso vive en `PILOT-003`/Registry, no en el archivo que la persona abre.
- Mismo criterio aplicado a `evaluation.md` (arranca con la invitación directa a dar la
  revisión humana, la tabla de 9 criterios queda después) y `measurement.md` (arranca
  diciendo "no hay nada medido, y está bien" antes de la justificación).
- Los 3 templates (`adoption/templates/*.md`) ahora tienen una sección "Regla de oro" con
  el orden obligatorio, para que esto no dependa de que alguien se acuerde de aplicarlo
  cada vez.
- Auditoría de integridad: 622 links (cualquier extensión), 0 rotos.

## 4. Qué sigue igual

Los otros 6 registros de ejecución todavía tienen la estructura vieja (contenido
correcto, orden sin corregir) — pendiente de decisión del usuario, igual que quedó en
G10.
