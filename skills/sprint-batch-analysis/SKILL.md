---
name: sprint-batch-analysis
description: Analiza en batch todos los tickets asignados a una persona en el sprint activo — diseño de solución, sistemas impactados, riesgos, ambigüedades, estimación — antes de la reunión de planning, en vez de analizar ticket por ticket. Nunca escribe en Jira/Azure DevOps por sí misma.
---

# sprint-batch-analysis

**Idioma de la respuesta**: español neutro y formal: tratar a la persona de usted, sin
voseo ni regionalismos, aunque la persona escriba de otra forma.

## Propósito

Antes de la reunión de planning, analizar de una sola vez todos los tickets ya asignados
a una persona en el sprint activo — en vez de que cada ticket se analice recién cuando se
empieza a trabajar en él. Reduce sorpresas en planning (ambigüedades, dependencias no
vistas) al traerlas ya identificadas, no descubiertas en la reunión.

## Cuándo usarla

Antes de una reunión de planning real, con tickets reales ya asignados a una persona en
un sprint activo.

## Cuándo NO usarla

- Para un solo ticket puntual — ahí corresponde CAP-001/CAP-004 directamente, sin el
  overhead de batch.
- Si el equipo no tiene sprints con asignación previa a planning — el valor depende de
  que exista ese momento "tickets ya asignados, planning todavía no ocurrió".

## Entradas

La lista real de tickets asignados a una persona en el sprint activo (vía Resolved
Context de CAP-002/CAP-003, o pegados a mano) — nunca inventados ni asumidos.

## Salidas

**Siempre un borrador, nunca publicado por esta skill**: por cada ticket, un análisis con
diseño de solución propuesto, sistemas/componentes impactados, dependencias con otros
tickets del mismo sprint, riesgos técnicos, ambigüedades sin resolver, y una estimación
honesta en horas. La persona decide si lo publica como comentario del ticket, lo usa solo
para la reunión, o lo descarta.

## Instrucciones

### 1. Traer los tickets reales del sprint activo

Vía Context Provider ya existente (CAP-002 Azure DevOps / CAP-003 Jira) si está
configurado, o la lista que la persona pegue directamente — nunca inventar qué tickets
están en el sprint.

### 2. Analizar cada ticket, en paralelo si el mecanismo lo permite

Por cada ticket: diseño de solución propuesto (no una implementación, un enfoque),
sistemas/componentes reales que impacta (leyendo el código real si está disponible,
nunca asumiendo), dependencias con otros tickets del mismo lote (si dos tickets tocan el
mismo módulo, señalarlo), riesgos técnicos concretos, ambigüedades del ticket que
necesitan resolverse antes de estimar con confianza, y una estimación en horas con el
mismo criterio de honestidad que CAP-010 (suma de pasos reales, no un número redondeado).

### 3. Nunca escribir en el sistema origen

A diferencia del patrón de origen (que comenta y aplica labels directo en Jira), esta
skill **nunca publica nada por sí misma** — entrega el análisis para que la persona lo
revise y decida qué hacer con él, mismo criterio que CAP-011/CAP-016.

## Revisión humana

Obligatoria — el análisis es un insumo para la reunión de planning, nunca una conclusión
aplicada automáticamente (ni como comentario, ni como estimación oficial del ticket).

## Dependencias

Reutiliza CAP-002/CAP-003 para traer los tickets reales — no define un mecanismo de
acceso propio.

## Herramientas / permisos

Ninguna de escritura — produce texto estructurado. Si consume un Context Provider real,
hereda su alcance de solo lectura.

## Seguridad

Riesgo bajo — no escribe en ningún sistema externo, no ejecuta código.

## Origen de esta propuesta

**External Best Practice / evidencia externa**: generalización de la skill `post-planning`
de un cliente de Baufest (Camuzzi) — analizar todo el sprint en batch antes de planning,
en vez de ticket por ticket. **No se copia** el proyecto Jira hardcodeado (`CMZ100`) ni
los nombres reales de herramientas MCP de ese cliente. **Corrección deliberada respecto al
original**: la versión real de Camuzzi escribe comentarios y aplica labels directamente en
Jira sin paso de revisión — esta versión generalizada nunca publica nada por sí misma,
siguiendo la misma disciplina ya vigente en CAP-011/CAP-016 de este Registry.

## Compatibilidad / adaptación

Portable a cualquier equipo con sprints reales y un Context Provider de tickets ya
configurado (CAP-002/CAP-003) — sin eso, sigue funcionando con tickets pegados a mano,
solo pierde la automatización de traerlos.
