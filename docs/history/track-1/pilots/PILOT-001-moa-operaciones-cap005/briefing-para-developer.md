# Briefing para el developer — piloto de adopción independiente (cold-start)

**No debe leerse `AGENTS.md.proposal.md` de esta misma carpeta antes de terminar el
intento.** Ese archivo es un borrador de referencia para comparar después — si se lee
antes, el piloto deja de servir (dejaría de ser adopción independiente).

## Contexto que sí puede tenerse

Usted es developer de `MoaOperaciones`. Nunca usó `MOA-AI-Engineering`. Su tarea:

> Su proyecto (`MoaOperaciones`) no tiene ninguna regla declarada sobre qué puede hacer
> un asistente de IA (Copilot, Claude, etc.) de forma autónoma y qué no. Vaya al
> repositorio `MOA-AI-Engineering` (es un sibling de su repositorio en este mismo
> workspace) y resuelva eso para su proyecto, usando lo que encuentre ahí. Guíese solo —
> anote en un archivo de texto (o dicte) cada vez que no sepa por dónde seguir, qué le
> resultó confuso, o qué tuvo que adivinar.

No se le indica por dónde empezar. Si en algún punto se traba de verdad y no hay forma
de seguir, corresponde anotarlo como hallazgo (eso también es feedback válido) y
comunicarlo para desbloquear.

## Qué se espera que se produzca al final

Un archivo `AGENTS.md` (o el nombre que el propio repo indique) en el propio entorno de
trabajo — **no debe subirse al repo real de MoaOperaciones todavía**, corresponde
guardarlo en esta misma carpeta como `AGENTS.md.developer-attempt.md` al terminar.

## Qué se va a preguntar después (adelanto, no responder ahora)

Basado en las preguntas reales de
[`../../../../adoption/contribution-guide.md`](../../../../../adoption/contribution-guide.md):

1. ¿Se encontró por dónde empezar sin que nadie lo indicara? ¿Cuánto se tardó en
   encontrar `adoption/getting-started.md` o el Registry?
2. ¿Qué parte del contenido resultó clara?
3. ¿Qué parte generó retrabajo o confusión?
4. ¿Qué hubo que adivinar sobre el propio proyecto que el repo no ayudó a resolver?
5. ¿Qué faltó — algo que se buscó y no se encontró?
6. ¿Se usaría esto de nuevo para otra capacidad (no solo gobierno)?
7. ¿Qué se cambiaría del propio `MOA-AI-Engineering` para que alguien en frío llegue más
   rápido a un resultado?

## Nota para quien coordina el piloto

Cuando el developer termine, corresponde completar:
- [`execution-record.md`](execution-record.md) con sus datos reales (fecha, tiempo
  insumido, si terminó o quedó bloqueado).
- [`feedback-record.md`](feedback-record.md) con sus respuestas literales a las 7
  preguntas — no deben resumirse ni completarse por él.
- Recién ahí, comparar su `AGENTS.md.developer-attempt.md` contra
  `AGENTS.md.proposal.md` (el borrador de referencia) — las diferencias son señal real
  de qué falta en la plantilla CAP-005, no al revés.
