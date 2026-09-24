---
name: user-story
description: Refina un requerimiento, o un ticket existente largo y desordenado, en una historia de usuario breve y lista para desarrollo — criterios Dado/Cuando/Entonces verificables, fuera de alcance, datos necesarios, preguntas bloqueantes y veredicto de preparación, con propuesta de división si la historia es demasiado grande. Usar antes de Planning, o cuando un ticket no se entiende sin una reunión.
---

# user-story

**Capability Registry**: [`CAP-001`](../../../registry/entries/user-story.md).
**Golden Path**: [`AI-Assisted Requirements`](../../../golden-paths/README.md#1-ai-assisted-requirements).
**Clasificación**: la **estructura** es común a cualquier equipo; el **contenido** (roles,
ejemplos, dominio) lo completa cada equipo.

## Propósito

Que una historia llegue a desarrollo entendible sin una reunión de aclaración: corta,
con criterios verificables, con lo que queda afuera, los datos que hacen falta y las
preguntas que bloquean — y, si es demasiado grande, dividida. El detalle que no aporta
a entender el qué y el para qué (diseño técnico, casos de prueba, historial de
conversaciones) no va en la historia.

## Cuándo usarla

- Un requerimiento existe en lenguaje natural o EARS y todavía no está listo para
  Planning.
- Un ticket ya existe pero es largo, desordenado o genera reuniones de entendimiento
  (modo "revisar un ticket existente", paso 9).

## Cuándo NO usarla

- Para diseño técnico o decisiones de arquitectura.
- Para redactar casos de prueba detallados — eso corresponde a la generación de casos de
  prueba, a partir de los criterios que produce esta skill.

## Entradas

Un requerimiento en lenguaje natural o EARS, o el contenido de un ticket existente (pegado
o traído desde Jira/Azure DevOps).

## Salidas

La historia en el formato del paso 8 (objetivo: entre 30 y 40 líneas), un veredicto de
preparación y, siempre, una frase de cierre que diga qué corresponde hacer.

## Instrucciones

### 1. Separar el contenido antes de escribir

Clasificar lo que trae el requerimiento o el ticket:

| Tipo de contenido | Destino |
|---|---|
| Objetivo de negocio, quién lo necesita, para qué | La historia |
| Reglas y restricciones de negocio | Criterios de aceptación (o RN, si no entran en un criterio) |
| Datos de referencia, sistemas involucrados | "Datos y dependencias" |
| Detalle de implementación (tablas, métodos, servicios) | Fuera de la historia — anexo o plan técnico |
| Casos de prueba paso a paso, capturas, pantallas | Fuera de la historia — link o anexo |
| Repeticiones, historial de conversaciones, texto sin información | Se descarta y se informa (paso 9) |

Nunca descartar información en silencio: todo lo que sale de la historia se lista en una
línea.

### 2. Historia

```text
Como [rol real del dominio],
quiero [acción observable, no un método ni un botón específico],
para [beneficio de negocio explícito].
```

El rol se toma de la tabla de roles reales del equipo; si no encaja ninguno, se pregunta
en vez de forzarlo. Nunca "como usuario" genérico cuando el requerimiento permite saber
quién es.

### 3. Criterios de aceptación

- **Entre 3 y 7.** Más de 7, o más de un objetivo independiente, indica que la historia
  es demasiado grande: proponer una división (paso 5).
- **Dado / Cuando / Entonces, declarativo, de 3 a 5 pasos.** El "Entonces" describe un
  resultado que una persona puede observar, no un estado interno del sistema. Prueba
  rápida: si la redacción tendría que cambiar cuando cambia la implementación, está
  describiendo el cómo — reescribirla.
- **Cobertura mínima**: camino feliz, validación o error esperado, y un caso borde
  relevante.
- **Sin palabras vagas**: "adecuado", "correctamente", "rápido", "amigable", "etc.",
  "si existe". Se reemplazan por algo verificable o se convierten en pregunta.
- **Reglas de negocio (RN-XX) solo si no están ya en un criterio.** Nunca repetir la
  misma regla como criterio y como RN.

### 4. Fuera de alcance, datos y dependencias

- **Fuera de alcance**: lo que alguien podría suponer incluido y no lo está.
- **Datos y dependencias**: datos de referencia necesarios (de dónde salen), sistemas
  involucrados y quién decide si hay dudas.

### 5. Tamaño y división

Revisión rápida con INVEST, una línea por criterio solo si falla:

| Criterio | Pregunta |
|---|---|
| Independiente | ¿Se puede desarrollar sin esperar otra historia? |
| Negociable | ¿Describe el qué, sin imponer la solución? |
| Valiosa | ¿El beneficio es claro para alguien real? |
| Estimable | ¿El equipo podría estimarla con lo que está escrito? |
| Pequeña | ¿Entra en un sprint? |
| Verificable | ¿Cada criterio se puede probar con un sí o un no? |

Si falla "Pequeña" o "Independiente", proponer historias separadas, nombrando el criterio
de división: **por camino** (flujo feliz primero, alternativas después), **por datos**
(un tipo de dato o de caso por vez), **por reglas** (regla simple primero), **por
interfaz** (un canal o pantalla por vez), o **investigación previa** si hay una incógnita
técnica que resolver antes. Cada historia resultante lleva su propio título y sus
criterios.

### 6. Preguntas abiertas

Antes de preguntar, verificar contra la documentación del propio requerimiento — no
preguntar lo que ya está decidido en otro lugar.

```text
❓ [Bloqueante | No bloqueante] [pregunta cerrada, que se responde eligiendo]
   Opciones: A) ... | B) ...   Recomendación: [A o B, y por qué]
   Responsable: [reporter del ticket, o referente funcional si el contexto lo trae]
```

Una pregunta es **bloqueante** si su respuesta cambia los criterios o la estimación.

### 7. Veredicto de preparación

Es una recomendación para el PO, no una barrera:

| Veredicto | Cuándo |
|---|---|
| ✅ **Lista** | Sin preguntas bloqueantes; pasa INVEST |
| 🟡 **Lista con supuestos** | Solo quedan preguntas no bloqueantes; los supuestos se listan |
| ✂️ **Dividir** | Falla "Pequeña" o "Independiente" |
| ⛔ **No lista** | Queda al menos una pregunta bloqueante |

### 8. Formato de salida

```text
## [Título corto]

**Historia**: Como ..., quiero ..., para ...

**Contexto**: [hasta 3 líneas; links a capturas y documentos, sin transcribirlos]

**Criterios de aceptación**
1. Dado ..., cuando ..., entonces ...
   (3 a 7)

**Reglas de negocio**: [solo las que no están en un criterio — o "Ninguna adicional"]

**Fuera de alcance**: ...

**Datos y dependencias**: ...

**Preguntas abiertas**: [formato del paso 6 — o "Ninguna"]

**Veredicto**: [✅ / 🟡 / ✂️ / ⛔] + 1 línea de por qué

[Cierre — paso 11]
```

### 9. Modo "revisar un ticket existente"

Cuando la entrada es un ticket ya escrito, además del formato del paso 8, agregar al
final:

```text
**Qué cambió respecto del ticket original**
- Se sacó: [repeticiones / historial / texto sin información — 1 línea cada uno]
- Se movió a anexo: [detalle técnico, casos de prueba, capturas — 1 línea cada uno]
- Se agregó como pregunta: [lo que el ticket daba por supuesto sin decirlo]
```

El objetivo es que el PO vea en un minuto qué se condensó y pueda aprobarlo o
corregirlo.

### 10. Actualizar el ticket (solo si la persona lo pide)

Si el asistente tiene acceso de escritura al sistema de tickets, seguir la skill
[`ticket-update`](../ticket-update/SKILL.md) — siempre mostrando el cambio y esperando
confirmación antes de escribir:

- **Historia lista o con supuestos**: reemplazar la descripción del ticket por la
  historia (el contenido original queda en el historial del ticket).
- **Preguntas abiertas**: un comentario dirigido al responsable de cada una.
- **Dividir**: crear las historias nuevas, vinculadas a la original.

Nunca cambiar el estado, el sprint ni el asignado del ticket desde esta skill.

### 11. Cierre, siempre

Según el veredicto:

```text
✅ / 🟡  Historia lista para revisión del PO o referente funcional. Con su aprobación,
        corresponde pedirle al asistente que la actualice en el ticket (si todavía no se
        hizo) y que empiece a implementarla — con el plan aprobado antes de tocar código.

✂️      Conviene dividirla antes de seguir, en las historias propuestas arriba. Con la
        aprobación del PO, corresponde pedirle al asistente que las cree en el ticket.

⛔      📌 No está lista: [razón concreta]. Sugerencia: contactar a [reporter real del
        ticket] para responder las preguntas bloqueantes; con las respuestas, volver a
        pedirle al asistente que la refine.
```

- Contactar siempre al **reporter**, no al asignado — el asignado suele ser quien está
  usando esta skill. Si no hay reporter en el contexto, decirlo e indicar revisar el
  campo "Reporter" del ticket. Nunca inventar un nombre.
- Nunca nombrar la capacidad siguiente por su ID o nombre técnico en el texto que lee la
  persona — describir la acción en lenguaje natural alcanza.

## Cómo usar esta capability

Ejemplos de lo que escribe la persona (sin IDs ni fórmulas):

```text
Necesito refinar este requerimiento en una historia de usuario: [requerimiento real]
```

```text
Revisar este ticket, está muy largo y no se entiende: [pegar el ticket, o su clave si
el asistente tiene acceso a Jira/Azure DevOps]
```

Si ya existe un registro de ejecución para ese ticket: si nada cambió, ese registro ya es
la evidencia; si el ticket cambió, corresponde una ejecución nueva en la misma carpeta de
tarea, sin sobrescribir la anterior (ver
[`../../../adoption/getting-started.md`](../../../adoption/getting-started.md), sección
"Ejecutar").

### Revisión humana

Obligatoria: un PO o referente de negocio valida la historia antes de Planning. Una
historia generada no se da por aprobada por generarse.

### Evidencia, evaluación y medición

[Evidence Record](../../../adoption/templates/evidence-record.md),
[Evaluation Record](../../../adoption/templates/evaluation-record.md),
[Measurement Record](../../../adoption/templates/measurement-record.md). Métricas útiles
para un piloto: largo de la historia, cantidad de idas y vueltas con el PO, y si se evitó
la reunión de refinamiento. Sin línea base, se deja explícito como no medido.

## Herramientas / permisos

Ninguna propia — produce texto. La escritura en el ticket (paso 10) la hace el asistente
siguiendo `ticket-update`, con las herramientas y los límites de esa skill.

## Seguridad

Riesgo bajo. Si el requerimiento trae datos sensibles de ejemplo (números de cliente,
montos reales), no reproducirlos en la historia sin necesidad.

## Criterios de calidad

- Entre 3 y 7 criterios verificables, sin palabras vagas y sin reglas duplicadas.
- Cada criterio traza a un requisito de la entrada; nada inventado.
- Veredicto explícito y frase de cierre siempre presentes.
- En modo revisión: todo lo que salió del ticket original está listado.

## Origen

**Existing Practice**: generalizada de prácticas reales de 3 equipos de MOA (estructura
común; roles y ejemplos propios de cada uno, no copiados). La única ejecución real
registrada mostró el problema que esta versión corrige: una historia de unas 75 líneas
para un cambio acotado, con reglas que repetían criterios, un criterio no verificable y
dos cambios independientes juntos. **External Best Practice**:
[INVEST — Bill Wake](https://xp123.com/invest-in-good-stories-and-smart-tasks/),
[Card, Conversation, Confirmation — Ron Jeffries](https://ronjeffries.com/xprog/articles/expcardconversationconfirmation/),
[criterios de aceptación — Mike Cohn](https://www.mountaingoatsoftware.com/agile/user-stories/acceptance-criteria)
("si la lista es larga, la historia puede ser demasiado grande"),
[nivel de detalle adecuado](https://www.mountaingoatsoftware.com/blog/add-the-right-amount-of-detail-to-user-stories),
[riesgos de usar "Ready" como compuerta](https://www.mountaingoatsoftware.com/blog/the-dangers-of-a-definition-of-ready),
[división SPIDR](https://www.mountaingoatsoftware.com/blog/five-simple-but-powerful-ways-to-split-user-stories),
[Gherkin declarativo — Cucumber](https://cucumber.io/docs/bdd/better-gherkin/),
[Guía Scrum 2020](https://scrumguides.org/scrum-guide.html). **Evidencia externa
(Camuzzi)**: secciones "fuera de alcance" y "dependencias", preguntas con opciones y
recomendación, detección de palabras vagas.

## Compatibilidad / adaptación

Portable a cualquier equipo y dominio. La única adaptación obligatoria es la tabla de
roles reales del dominio.
