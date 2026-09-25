---
name: user-story
description: Refina un requerimiento, o un ticket existente largo y desordenado, en una historia de usuario breve y lista para desarrollo — criterios Dado/Cuando/Entonces verificables, fuera de alcance, datos necesarios, preguntas bloqueantes y veredicto de preparación, dividiendo la historia cuando una parte está lista y otra no. Usar antes de Planning, o cuando un ticket no se entiende sin una reunión.
---

# user-story

**Idioma de la respuesta**: español neutro y formal, sin voseo ni regionalismos ("pasás",
"podés", "tenés" → "puede pasar", "puede", "tiene"), aunque la persona escriba de otra
forma.

**Capability Registry**: [`CAP-001`](../../../registry/entries/user-story.md) ·
**Golden Path**: [`AI-Assisted Requirements`](../../../golden-paths/README.md#1-ai-assisted-requirements).

## Propósito

Que una historia llegue a desarrollo entendible sin una reunión de aclaración: corta, con
criterios verificables, lo que queda afuera, los datos que hacen falta y las preguntas
que bloquean — y dividida cuando una parte puede avanzar y otra no. El detalle que no
ayuda a entender el qué y el para qué (diseño técnico, casos de prueba, historial de
conversaciones) no va en la historia.

Usarla con un requerimiento nuevo o con un ticket existente que no se entiende. No
usarla para diseño técnico ni para redactar casos de prueba detallados.

## 1. Formato de salida (entre 30 y 40 líneas por historia)

```text
## [Título corto]

**Historia**: Como [rol real], quiero [acción observable], para [beneficio explícito].

**Contexto**: [hasta 3 líneas; links a capturas y documentos, sin transcribirlos]

**Criterios de aceptación**
1. Dado ..., cuando ..., entonces ...
   (entre 3 y 7)

**Reglas de negocio**: [solo las que no están en un criterio — o "Ninguna adicional"]
**Fuera de alcance**: ...
**Datos y dependencias**: ...

**Preguntas abiertas**
❓ [Bloqueante | No bloqueante] [pregunta cerrada]
   Opciones: A) ... | B) ...   Recomendación: [cuál y por qué]
   Responsable: [reporter del ticket; sin ticket, quien hizo el pedido]

**Supuestos y cambios respecto del pedido**
- Se agregó por inferencia: [lo deducido del código o de otra pantalla, y de dónde]
- Se sacó o se movió a anexo: [solo si la entrada era un ticket existente]

**Veredicto**: [✅ | 🟡 | ✂️ | ⛔] + 1 línea de por qué

[Cierre — sección 2]
```

Si el veredicto es ✂️, se repite el formato para cada historia resultante, marcando cuál
está lista.

## 2. Veredicto y cierre, siempre

| Veredicto | Cuándo |
|---|---|
| ✅ **Lista** | Sin preguntas bloqueantes |
| 🟡 **Lista con supuestos** | Solo quedan preguntas no bloqueantes; los supuestos se listan |
| ✂️ **Dividir** | La historia es demasiado grande (más de 7 criterios o más de un objetivo), **o una parte está lista y otra bloqueada** — la parte lista avanza sin esperar a la otra |
| ⛔ **No lista** | Todo depende de una pregunta bloqueante |

El veredicto es una recomendación para el PO, no una barrera. Cerrar siempre con la frase
que corresponde:

```text
✅ / 🟡  Historia lista para revisión del PO o referente funcional. Con su aprobación,
        corresponde pedirle al asistente que la actualice en el ticket y que empiece a
        implementarla, con el plan aprobado antes de tocar código.

✂️      Conviene dividirla: [historia A] puede avanzar ya; [historia B] espera [qué].
        Con la aprobación del PO, corresponde pedirle al asistente que cree las
        historias en el ticket.

⛔      📌 No está lista: [razón concreta]. Corresponde consultar a [reporter real del
        ticket, o quien hizo el pedido] las preguntas bloqueantes y, con las respuestas,
        volver a pedirle al asistente que la refine.
```

Nunca inventar un nombre de responsable: si no se conoce, decirlo. Nunca nombrar la
capacidad siguiente por su ID o nombre técnico — describir la acción en lenguaje natural.

## 3. Cómo construir cada parte

**Separar el contenido antes de escribir.** Objetivo, rol y beneficio → historia. Reglas
→ criterios (o RN si no entran en un criterio). Datos de referencia y sistemas → "Datos
y dependencias". Detalle de implementación, casos de prueba paso a paso y capturas →
fuera de la historia (anexo o link). Repeticiones e historial de conversaciones → se
descartan. Nada se descarta en silencio: todo lo que sale de la historia se lista.

**Verificar antes de afirmar.** Si hay acceso al código o a la documentación, usarlos
para confirmar cómo funciona hoy lo que se pide cambiar y qué otras pantallas o datos
afecta. Lo deducido así se declara en "Supuestos y cambios respecto del pedido", con su
origen. Nunca afirmar algo del sistema que no se verificó.

**Historia.** Rol tomado de la tabla de roles reales del equipo, nunca "usuario"
genérico si se puede saber quién es. Acción observable, no un método ni un botón.

**Criterios de aceptación.**
- Dado / Cuando / Entonces, declarativo, de 3 a 5 pasos. El "Entonces" es un resultado
  que una persona puede observar. Si la redacción cambiaría al cambiar la implementación,
  está describiendo el cómo: reescribirla.
- Camino feliz, validación o error, y un caso borde relevante.
- Sin palabras vagas ("adecuado", "correctamente", "rápido", "etc.", "si existe"): se
  reemplazan por algo verificable o se convierten en pregunta.
- Un criterio que depende de una pregunta abierta lo indica: "(depende de la pregunta N)".
- Reglas de negocio solo si no están ya en un criterio. Nunca repetirlas.

**Tamaño.** Revisar con INVEST (independiente, negociable, valiosa, estimable, pequeña,
verificable). Para dividir, nombrar el criterio: **por camino** (flujo principal primero),
**por datos**, **por reglas**, **por interfaz**, o **investigación previa** si hay una
incógnita técnica. Caso típico: un cambio de textos listo hoy junto a un cambio de datos
bloqueado — se separan.

**Preguntas.** Antes de preguntar, verificar que no esté resuelto en otro documento. Es
**bloqueante** si la respuesta cambia los criterios o la estimación.

## 4. Actualizar el ticket (solo si la persona lo pide)

Con acceso de escritura al sistema de tickets, seguir
[`ticket-update`](../ticket-update/SKILL.md) — mostrar el cambio exacto y esperar
confirmación:

- historia lista o con supuestos → reemplazar la descripción (el original queda en el
  historial del ticket);
- preguntas abiertas → un comentario dirigido al responsable;
- división → crear las historias nuevas, vinculadas a la original.

Nunca cambiar el estado, el sprint ni el asignado del ticket.

## Cómo pedirlo

```text
Necesito refinar este requerimiento en una historia de usuario: [requerimiento real]
```

```text
Revisar este ticket, está muy largo y no se entiende: [ticket pegado, o su clave]
```

Revisión humana obligatoria: el PO valida la historia antes de Planning. Evidencia,
evaluación y medición con las plantillas de
[`../../../adoption/templates/`](../../../adoption/templates/) — métricas útiles en un
piloto: largo de la historia, idas y vueltas con el PO, y si se evitó la reunión de
refinamiento.

## Herramientas y seguridad

Ninguna herramienta propia: produce texto. La escritura en el ticket la hace el
asistente siguiendo `ticket-update`. Riesgo bajo; no reproducir datos sensibles del
requerimiento sin necesidad.

## Origen

**Existing Practice**: prácticas reales de 3 equipos de MOA (estructura común, roles y
ejemplos propios de cada uno) y 2 ejecuciones reales sobre el mismo requerimiento de
Portal de Créditos. **External Best Practice**:
[INVEST](https://xp123.com/invest-in-good-stories-and-smart-tasks/),
[Card, Conversation, Confirmation](https://ronjeffries.com/xprog/articles/expcardconversationconfirmation/),
[criterios de aceptación](https://www.mountaingoatsoftware.com/agile/user-stories/acceptance-criteria),
[nivel de detalle](https://www.mountaingoatsoftware.com/blog/add-the-right-amount-of-detail-to-user-stories),
["Ready" como recomendación, no compuerta](https://www.mountaingoatsoftware.com/blog/the-dangers-of-a-definition-of-ready),
[división SPIDR](https://www.mountaingoatsoftware.com/blog/five-simple-but-powerful-ways-to-split-user-stories),
[Gherkin declarativo](https://cucumber.io/docs/bdd/better-gherkin/),
[Guía Scrum 2020](https://scrumguides.org/scrum-guide.html). **Evidencia externa
(Camuzzi)**: fuera de alcance, dependencias, preguntas con opciones y recomendación,
detección de palabras vagas.

Portable a cualquier equipo; la única adaptación obligatoria es la tabla de roles reales
del dominio.
