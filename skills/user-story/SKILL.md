---
name: user-story
description: Plantillas para historias de usuario, criterios de aceptación (Given/When/Then), reglas de negocio (RN-XX) y análisis de gaps. Usar para definir o refinar requerimientos funcionales antes de que lleguen a desarrollo.
---

# user-story

**Capability Registry**: [`CAP-001`](../../../registry/entries/user-story.md).
**Golden Path**: [`AI-Assisted Requirements`](../../../golden-paths/README.md#1-ai-assisted-requirements).
**Clasificación**: la **estructura** (Historia/Criterios/Reglas/Gaps) es común a
cualquier equipo que la use; el **contenido** (roles, ejemplos, dominio) lo completa cada
equipo — ver la nota de roles más abajo.

## Propósito

Estructurar un requerimiento crudo (ticket, idea de negocio en lenguaje natural) en una
historia de usuario con criterios de aceptación verificables, reglas de negocio
explícitas, y un análisis de gaps que expone ambigüedades antes de que lleguen a
desarrollo — no después, como retrabajo.

## Cuándo usarla

- Un requerimiento existe en lenguaje natural o formato EARS pero todavía no está listo
  para Planning/desarrollo.
- Se quiere una revisión sistemática de ambigüedades antes de estimar o desarrollar.

## Cuándo NO usarla

- El requerimiento ya es una historia de usuario completa y refinada.
- Para documentar decisiones ya tomadas de arquitectura o diseño técnico — eso es una
  Instruction o un documento de diseño, no una historia de usuario.

## Entradas

Un requerimiento en lenguaje natural, o ya en formato EARS ("Cuando X, el sistema debe
Y"), con o sin ticket asociado.

## Salidas

Historia de usuario + criterios de aceptación + reglas de negocio + análisis de gaps —
lista para revisión humana, no para desarrollo directo sin esa revisión. **Siempre**
cierra con una frase explícita de qué corresponde hacer con el resultado — nunca termina
en el análisis de gaps sin decir qué sigue, haya o no gaps bloqueantes (ver sección 5).

## Instrucciones

### 1. Historia de usuario

```text
Como [rol],
quiero [objetivo],
para [beneficio].
```

**El rol siempre se adapta al dominio real.** Cada equipo debe completar su propia tabla
de roles antes de usar esta skill, y actualizarla cuando aparezca un rol que no esté
cubierto. No corresponde forzar un rol existente si no encaja.

**Objetivo**: acción observable, no implementación técnica.
**Beneficio**: valor de negocio explícito y medible.

Ejemplo correcto (genérico, reemplazar por el dominio real):
```text
Como [rol real del dominio],
quiero [acción observable, no un método o botón específico],
para [beneficio de negocio explícito].
```

Ejemplo incorrecto (evitar):
```text
Como usuario,
quiero que el sistema llame al método ActualizarX,
para que funcione el botón.
```

### 2. Criterios de aceptación

Dado/Cuando/Entonces, un escenario por criterio. Cubrir siempre: camino feliz, validación
o error esperado, y al menos un caso borde relevante.

```text
Dado que [contexto/precondición],
cuando [acción],
entonces [resultado verificable y observable].
```

### 3. Reglas de negocio

```text
RN-01: [restricción expresada como afirmación]
RN-02: [restricción]
```

Los ejemplos de reglas de negocio son ilustrativos del formato, no reglas certificadas
contra el código — cada regla debe validarse contra la implementación real antes de dar
una historia por cerrada.

### 4. Análisis de gaps

Revisar siempre, antes de cerrar el requerimiento:

- **Ambigüedades**: ¿hay términos con doble interpretación?
- **Escenarios faltantes**: ¿qué pasa si una integración externa no responde? ¿si un dato
  requerido viene vacío o corrupto?
- **Conflictos entre reglas**: ¿alguna RN contradice otra?
- **Condiciones de borde**: ¿qué pasa con valores en 0, listas vacías, o el caso "sin
  resultado previo"?
- **Preguntas abiertas**: listar explícitamente qué bloquea la implementación.
- **Integraciones**: ¿depende de un sistema externo? ¿cómo se comporta si falla?

```text
❓ [Pregunta que bloquea la implementación]
   Contexto: [por qué es importante]
   Opciones: A) ... | B) ...
   Impacto si no se resuelve: [alto / medio / bajo]
```

Antes de reportar un gap, corresponde verificar contra la documentación técnica existente
del propio requerimiento — no reportar como ambigüedad algo que ya fue decidido y
documentado en otro lugar.

### 5. Cierre — siempre, nunca terminar en el análisis de gaps sin más

**Hallazgo real (2026-09-23)**: un developer real usó esta skill dos veces (una con gaps
sin resolver, otra después de responderlos) y en ambos casos el resultado terminaba en
seco — no sabía si eso era todo, si faltaba algo, o qué se suponía que hiciera con el
resultado. La salida siempre necesita una frase de cierre explícita; cuál frase depende
de si quedan gaps bloqueantes o no.

**Si la historia NO está lista** (quedan gaps bloqueantes sin resolver), sumar una
recomendación de próximo paso, no solo la lista de preguntas:

```text
📌 Recomendación: [1 frase — la historia no está lista para Planning/desarrollo por
   [razón concreta, ej. "falta descripción y criterios de aceptación en el ticket de
   origen"]].
   Sugerencia: contactar a [nombre real del reporter, si el contexto lo trae — ej.
   "Jesús Gutiérrez (reporter)"] para completar [qué falta exactamente] antes de
   continuar.
```

**Corresponde contactar siempre al `reporter`, no al `assignee`.** El `assignee` va a
implementar la historia — con frecuencia es la misma persona que está usando esta skill
en ese momento, de modo que sugerirle que se contacte a sí mismo no aporta nada. El
`reporter` es quien originó el requerimiento y es el mejor contacto disponible para
completar lo que falta. Solo corresponde mencionar al `assignee` si no hay `reporter`
disponible, o si el contexto trae un responsable funcional distinto de ambos.

**Es texto, nunca una acción**: la recomendación es parte del resultado que lee la
persona — no dispara ningún comentario ni cambio de estado en Jira o Azure DevOps. La
única acción real es que un humano, después de leerla, decida contactar a alguien por su
cuenta.

**Nunca debe inventarse un nombre.** Si no hay `reporter` disponible en el contexto,
corresponde decirlo de forma explícita e indicar la acción concreta que falta:

```text
   Sugerencia: no fue posible identificar quién reportó esta historia con el contexto
   disponible — revisar el campo "Reporter" del ticket directamente en Jira antes de
   contactar al PO real, para completar [qué falta exactamente].
```

**Si la historia SÍ está lista** (no quedan gaps bloqueantes — ya sea porque nunca los
hubo, o porque la persona ya los respondió en el mismo intercambio), cerrar igual, con una
frase corta que lo diga explícitamente — nunca terminar en la última sección de contenido
sin más:

```text
✅ Historia lista para revisión humana (PO o referente de negocio) — no se publicó ni se
   pegó en ningún lado automáticamente. El siguiente paso es que una persona la revise y
   la apruebe; con esa aprobación, corresponde pedirle al asistente que empiece a
   implementarla — documentando primero qué se va a hacer, generando tests, y con
   revisión humana antes de dar el trabajo por terminado. Esta skill no hace ese paso.
```

**Nunca nombrar la capacidad siguiente por su ID o nombre técnico** (`CAP-005`,
`spec-driven-development`) en el texto que lee la persona — mismo criterio que
[`how-to-use.md`](../../../adoption/how-to-use.md): describir la acción en lenguaje
natural alcanza, el asistente reconoce sola qué corresponde usar.

**Hallazgo real (2026-09-23), un escalón más adelante del anterior**: un developer real
respondió los gaps con el PO, recibió la historia ya refinada, y no supo qué seguía
porque nada en la salida apuntaba al siguiente paso del SDLC (`spec-driven-development`).
La frase de cierre de arriba tiene que nombrar el próximo Golden Path/capability real, no
quedarse en un genérico "pasa a Planning/desarrollo" que no dice adónde ir.

Si la propia historia mezcla contenido técnico de implementación (nombres de archivo,
tablas, servicios concretos) porque hizo falta verificar contra el código real, sumar
además una frase señalándolo — no corresponde asumir en silencio que ese detalle técnico
queda mezclado con el requisito para siempre:

```text
ℹ️ Esta versión incluye detalle técnico de implementación (ver "Notas Técnicas") porque
   fue necesario para no dejar un gap sin resolver. Si el equipo prefiere separar el
   requisito del diseño técnico, corresponde mover esa sección a un documento aparte
   antes de continuar.
```

## Cómo usar esta capability

### Entrada

```
Ticket:
MOA-XXXX

Requirement:
"[requerimiento real, en lenguaje natural o EARS — nunca inventado]"

Context:
"[contexto disponible: dominio, roles reales del equipo, restricciones conocidas]"
```

El campo `Context:` funciona igual sin importar si se escribió a mano o si vino resuelto
automáticamente desde un ticket real (Jira, Azure DevOps) — esta skill no necesita saber
de dónde vino.

### Patrón de ejecución

Ejemplo de instrucción para el asistente de IA — adaptar a la interfaz real de la
herramienta utilizada:

```
Usa la capability CAP-001 user-story.

Analiza el siguiente requerimiento real.

Contexto:
[contexto real del dominio — rol, sistema, restricciones]

Requerimiento:
[el requerimiento real, sin parafrasear]

Genera:
1. Historia de usuario
2. Criterios de aceptación
3. Reglas de negocio
4. Análisis de gaps

No inventes reglas de negocio.
No conviertas decisiones técnicas ya documentadas en gaps.
Si falta información necesaria, declárala explícitamente como gap.

La salida debe quedar lista para revisión humana.
```

### Resultado esperado

```
### Historia de usuario
Como [rol real], quiero [objetivo], para [beneficio].

### Criterios de aceptación
1. Dado [contexto], cuando [acción], entonces [resultado].
   (camino feliz, validación/error, caso borde — al menos 3)

### Reglas de negocio
RN-01: [restricción real]

### Análisis de gaps
❓ [pregunta real que bloquea implementación, si existe alguna]

### Cierre (siempre, sin excepción)
📌 [si quedan gaps bloqueantes: 1 frase de por qué no está lista + a quién contactar] o
✅ [si no quedan gaps bloqueantes: lista para revisión humana; con la aprobación,
   corresponde pedirle al asistente que empiece a implementarla]
```

### Si ya existe una ejecución para este ticket

Si el asistente indica que ya existe un registro para esa tarea, no se trata de un
error — corresponde elegir según el caso:

1. No cambió nada → no hay nada que hacer, ese registro ya es la evidencia.
2. El ticket cambió o el resultado tiene algo para corregir → pedirle al asistente una
   ejecución nueva, anidada en la misma carpeta de tarea, sin sobrescribir la anterior.
3. Se puede revisar si el resultado existente es correcto → pedirle al asistente que
   actualice el registro de evaluación con el veredicto real.

Detalle completo en [`../../../adoption/getting-started.md`](../../../adoption/getting-started.md)
(sección "Ejecutar").

### Revisión humana

Obligatoria — ver "Revisión humana obligatoria" más abajo, mismo criterio.

### Evidencia

Registrar la ejecución con
[`../../../adoption/templates/evidence-record.md`](../../../adoption/templates/evidence-record.md).

### Evaluación

Aplicar
[`../../../adoption/templates/evaluation-record.md`](../../../adoption/templates/evaluation-record.md)
— los criterios se declaran antes de mirar el resultado.

### Medición

Completar
[`../../../adoption/templates/measurement-record.md`](../../../adoption/templates/measurement-record.md)
— si no hay baseline, dejarlo explícito como no medido, nunca inventado.

## Dependencias

Ninguna técnica — es contenido de referencia, no requiere acceso a sistemas externos.

## Herramientas / permisos

Ninguna — produce texto estructurado, no ejecuta código ni accede a datos.

## Seguridad

Riesgo bajo — no toca sistemas externos ni datos sensibles directamente. Si el
requerimiento de entrada contiene datos sensibles de ejemplo (números de cliente, montos
reales), no deben reproducirse textualmente en la historia generada sin necesidad.

## Datos

No requiere acceso a datos de producción — opera sobre el texto del requerimiento que se
le pasa como entrada.

## Revisión humana obligatoria

Un PO o referente de negocio debe validar la historia antes de pasar a
Planning/desarrollo, sin excepción. Una historia generada no debe tratarse como aprobada
sin esa revisión.

## Criterios de calidad

- La historia sigue el formato Como/quiero/para, con objetivo observable y beneficio
  explícito.
- Cada criterio de aceptación traza 1:1 a un requisito de entrada.
- El análisis de gaps cubre las 5 categorías del checklist, no solo la primera que se
  encuentra.

## Criterios de evaluación

Estructura, claridad, criterios de aceptación verificables, ausencia de ambigüedad,
trazabilidad, consistencia con convenciones del proyecto, ajuste del rol al catálogo real
del equipo.

## Origen

Generalizada a partir de prácticas reales de 3 equipos distintos (roles, ejemplos y
convenciones propios de cada uno, no copiados) — esta versión mantiene la estructura
común y deja el contenido de dominio para que cada equipo lo complete.

## Compatibilidad / adaptación

Portable a cualquier equipo, cualquier dominio — la única adaptación obligatoria es la
tabla de roles reales del dominio; todo lo demás (formato Given/When/Then, RN-XX,
checklist de gaps) se mantiene igual entre equipos.
