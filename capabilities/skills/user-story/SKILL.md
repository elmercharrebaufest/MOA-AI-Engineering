---
name: user-story
description: Refina un requerimiento, o un ticket existente largo y desordenado, en una historia de usuario breve y lista para desarrollo — criterios Dado/Cuando/Entonces verificables, fuera de alcance, datos necesarios, preguntas bloqueantes y veredicto de preparación, dividiendo la historia cuando una parte está lista y otra no. Usar antes de Planning, o cuando un ticket no se entiende sin una reunión.
---

# user-story

**Idioma de la respuesta**: español neutro y formal, en lenguaje natural que se entienda
sin conocer el modelo: tratar a la persona de usted, sin voseo ni regionalismos, sin jerga
ni identificadores internos innecesarios, aunque la persona escriba de otra forma.

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

**Límite con Planning, del propio KO**: esta etapa "detecta ambigüedades y genera
preguntas" (Recepción/Refinamiento); "sugerir dependencias o componentes afectados" es
Planning, y en este modelo lo hace [`ticket-kickoff`](../../agents/ticket-kickoff/AGENT.md)
(CAP-010), con sus propias salvaguardas (revisión humana del plan, entorno aislado).
Confirmar lo que el pedido nombra, sí — mapear todo lo que podría verse afectado, no.

## 1. Formato de salida (entre 30 y 40 líneas por historia lista)

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
**Impacto técnico a confirmar en Planning**: [una señal concreta encontrada al verificar
lo que el pedido nombra, sin investigarla — o "Ninguna detectada"]

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

Si el veredicto es ✂️, la historia lista lleva el formato completo. La historia bloqueada,
y toda historia ⛔, lleva solo la historia, el contexto, "Datos y dependencias", "Impacto
técnico a confirmar en Planning", las preguntas y los supuestos, sin criterios de
aceptación: los criterios dependen de las respuestas y se escriben cuando las haya.

## 2. Veredicto y cierre, siempre

| Veredicto | Cuándo |
|---|---|
| ✅ **Lista** | Sin preguntas bloqueantes |
| 🟡 **Lista con supuestos** | Solo quedan preguntas no bloqueantes; los supuestos se listan |
| ✂️ **Dividir** | La historia es demasiado grande (más de 7 criterios o más de un objetivo), **o una parte está lista y otra bloqueada** — la parte lista avanza sin esperar a la otra, si aporta valor por sí sola (sección 3, "Tamaño y división") |
| ⛔ **No lista** | Todo depende de una pregunta bloqueante |

El veredicto es una recomendación para el PO, no una barrera. Cerrar siempre con la frase
que corresponde:

```text
✅ / 🟡  Historia lista para revisión del PO o referente funcional. Con su aprobación,
        corresponde pedirle al asistente que la actualice en el ticket y que empiece a
        implementarla, con el plan aprobado antes de tocar código.

✂️      Conviene dividirla: [historia A] puede avanzar ya; [historia B] espera [qué].
        (Si A sola no logra el beneficio del pedido: [historia A] puede avanzar, pero
        sola no logra [beneficio]; el PO decide si la quiere antes que [historia B].)
        Con la aprobación del PO, corresponde pedirle al asistente que cree las
        historias en el sistema de tickets.

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

**Verificar lo que el pedido nombra — ubicar por ruta, nunca por contenido.** Convertir el
nombre de la pantalla o sección que da el pedido (o que muestra una captura) a la
convención de archivos del repo (kebab-case de carpeta/componente, PascalCase de entidad,
u otra si el repo la documenta) y buscarlo como **ruta de archivo o carpeta**, no como
texto dentro del código: una búsqueda de contenido por una palabra común del dominio
("Localidad", "Partido", el nombre de la pantalla) devuelve cientos de resultados en
cualquier repo real; una búsqueda por ruta encuentra los 2 o 3 archivos reales de esa
pantalla en un solo paso. Leer solo esos archivos, completos. Recién si ninguna ruta
coincide con ese nombre, hacer una búsqueda de contenido acotada a la carpeta más
probable — nunca al repositorio completo ni por un término genérico.

Mirar el código solo para responder una pregunta concreta: ¿la historia describe
correctamente cómo funciona hoy lo que el pedido nombra (la pantalla, el campo, el texto)?
Detenerse apenas esa pregunta está respondida — no es una investigación de impacto, es una
confirmación de partida.

No corresponde a esta etapa (es Planning, ver "Propósito"): mapear todas las pantallas,
reportes, traspasos o integraciones que podrían verse afectados. Si al confirmar lo que el
pedido nombra aparece una señal concreta de más alcance (otra pantalla con el mismo dato,
una dependencia visible en el mismo archivo), no investigarla: declararla en "Impacto
técnico a confirmar en Planning" tal como se encontró, sin profundizar. No usar el código
para lo que ya dicen el pedido o el `AGENTS.md` (rol, sitio de Jira) — y nunca buscar el
rol en archivos de convenciones de stack (`skills.md`, guías de buenas prácticas): no
tienen roles de negocio.

Toda afirmación sobre el sistema lleva su origen (archivo, o el propio pedido). Lo
deducido del código se declara en "Supuestos y cambios respecto del pedido". Lo que no se
verificó es pregunta o supuesto, nunca una afirmación.

**Historia.** Rol real de quien usa la funcionalidad, tomado del ticket o de la línea de
roles del `AGENTS.md` del repositorio (por ejemplo, `- Roles: analista de créditos,
comercial`); nunca "usuario" genérico. Si no figura en ninguno de los dos, proponer el más
probable según el pedido y declararlo como supuesto, sin buscarlo en el código. Acción
observable, no un método ni un botón.

**Criterios de aceptación.**
- Dado / Cuando / Entonces, declarativo, de 3 a 5 pasos. El "Entonces" es un resultado
  que una persona puede observar. Si la redacción cambiaría al cambiar la implementación,
  está describiendo el cómo: reescribirla.
- Camino feliz, validación o error, y un caso borde relevante.
- Sin palabras vagas ("adecuado", "correctamente", "rápido", "etc.", "si existe"): se
  reemplazan por algo verificable o se convierten en pregunta.
- Un criterio que depende de una pregunta abierta lo indica: "(depende de la pregunta N)".
- Reglas de negocio solo si no están ya en un criterio. Nunca repetirlas.

**Tamaño y división.** Revisar con INVEST (independiente, negociable, valiosa, estimable,
pequeña, verificable). Para dividir, nombrar el criterio: **por camino** (flujo principal
primero), **por datos**, **por reglas**, **por interfaz**, o **investigación previa** si
hay una incógnita técnica. Cada parte tiene que aportar valor por sí sola: si la parte
lista no logra el beneficio del pedido (por ejemplo, cambiar un texto cuando lo pedido es
informar un dato distinto), decirlo, indicar qué queda pendiente y dejar que el PO decida
si la quiere igual.

**Preguntas.** Antes de preguntar, verificar que no esté resuelto en otro documento. Es
**bloqueante** si la respuesta cambia los criterios o la estimación.

**Análisis de gaps, antes de cerrar.** Repasar, en lenguaje de negocio, sin abrir código
nuevo para responderlo:
- **Ambigüedades**: ¿algún término del pedido admite más de una interpretación?
- **Escenarios faltantes**: ¿qué pasa si la acción se repite, se cancela a mitad de
  camino, o el sistema del que depende no responde?
- **Conflictos entre reglas**: ¿alguna regla de negocio contradice otra, o hay que definir
  una prioridad entre ellas?
- **Condiciones de borde**: ¿qué pasa con un valor vacío, cero, el primero o el último
  caso?
- **Integraciones**: ¿depende de un sistema externo? ¿qué pasa si falla? (si no se sabe,
  es pregunta, no investigación de código)

Cada gap real detectado se convierte en criterio, regla o pregunta — nunca queda
implícito.

**Antes de responder, una pasada final.** Confirmar, sin reabrir investigación: cada
criterio se puede responder con sí/no; ninguna palabra vaga quedó sin reemplazar; el rol
tiene su origen (ticket, `AGENTS.md`, o supuesto declarado); toda afirmación sobre el
sistema tiene su origen citado; si hay división, la parte que avanza aporta valor por sí
sola; "Impacto técnico a confirmar en Planning" está completo o dice "Ninguna detectada".

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

**Existing Practice**: prácticas reales de 3 equipos de MOA — DataAgro, Scato Logística y
Orquestador — mismo formato Historia/Criterios/RN y el mismo checklist de análisis de
gaps, generalizado aquí sin los ejemplos de dominio de cada equipo (SAP/AFIP en uno,
AFIP/SENASA en otro); sus 3 agentes `product-owner` reales ya declaran `read`/`search`,
coherente con verificar el código para entender el pedido — no con investigar su impacto
completo, que corresponde a Planning (`ticket-kickoff`, CAP-010). **External Best
Practice**:
[INVEST](https://xp123.com/invest-in-good-stories-and-smart-tasks/),
[Card, Conversation, Confirmation](https://ronjeffries.com/xprog/articles/expcardconversationconfirmation/),
[criterios de aceptación](https://www.mountaingoatsoftware.com/agile/user-stories/acceptance-criteria),
[nivel de detalle](https://www.mountaingoatsoftware.com/blog/add-the-right-amount-of-detail-to-user-stories),
["Ready" como recomendación, no compuerta](https://www.mountaingoatsoftware.com/blog/the-dangers-of-a-definition-of-ready),
[división SPIDR](https://www.mountaingoatsoftware.com/blog/five-simple-but-powerful-ways-to-split-user-stories),
[Gherkin declarativo](https://cucumber.io/docs/bdd/better-gherkin/),
[Guía Scrum 2020](https://scrumguides.org/scrum-guide.html). **Evidencia externa
(Camuzzi)**: `spec-writer` acota su lectura del workspace a "qué repos toca", nunca
detalle técnico dentro del documento; `spec-review` audita con un checklist explícito
antes de dar una spec por buena (palabras vagas, ambigüedades sin resolver, criterios no
medibles) — de ahí la pasada final de esta versión; su `Ticket Kickoff` (ya generalizado
como CAP-010 de este Registry) es quien hace el mapeo completo de impacto, nunca el
refinamiento.

Portable a cualquier equipo; la única adaptación recomendada es la línea de roles reales
del equipo en el `AGENTS.md` de su repositorio.
