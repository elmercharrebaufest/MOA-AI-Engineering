# Briefing para el developer — piloto de adopción independiente (cold-start)

**No leas `AGENTS.md.proposal.md` de esta misma carpeta antes de terminar tu intento.**
Ese archivo es un borrador de referencia para comparar después — si lo leés antes, el
piloto deja de servir (dejaría de ser adopción independiente).

## Contexto que SÍ podés tener

Sos developer de `MoaOperaciones`. Nunca usaste `MOA-AI-Engineering`. Tu tarea:

> Tu proyecto (`MoaOperaciones`) no tiene ninguna regla declarada sobre qué puede hacer
> un asistente de IA (Copilot, Claude, etc.) de forma autónoma y qué no. Andá al
> repositorio `MOA-AI-Engineering` (es un sibling de tu repo en este mismo workspace) y
> resolvé eso para tu proyecto, usando lo que encuentres ahí. Guiate solo — anotá en un
> archivo de texto (o dictame) cada vez que no sepas por dónde seguir, qué te confundió,
> o qué tuviste que adivinar.

No te digo por dónde empezar. Si en algún punto te trabás de verdad y no hay forma de
seguir, anotalo como hallazgo (eso también es feedback válido) y contame para desbloquear.

## Qué se espera que produzcas al final

Un archivo `AGENTS.md` (o el nombre que el propio repo te indique) en tu propio entorno de
trabajo — **no lo subas al repo real de MoaOperaciones todavía**, guardalo en esta misma
carpeta como `AGENTS.md.developer-attempt.md` cuando termines.

## Qué se te va a preguntar después (adelanto, no lo respondas ahora)

Basado en las preguntas reales de
[`../../../../adoption/contribution-guide.md`](../../../../../adoption/contribution-guide.md):

1. ¿Encontraste por dónde empezar sin que nadie te lo dijera? ¿Cuánto tardaste en
   encontrar `adoption/getting-started.md` o el Registry?
2. ¿Qué parte del contenido te resultó clara?
3. ¿Qué parte te generó retrabajo o confusión?
4. ¿Qué tuviste que adivinar sobre tu propio proyecto que el repo no te ayudó a
   resolver?
5. ¿Qué te faltó — algo que buscaste y no encontraste?
6. ¿Usarías esto de nuevo para otra capacidad (no solo gobierno)?
7. ¿Qué cambiarías del propio `MOA-AI-Engineering` para que alguien como vos, en frío,
   llegue más rápido a un resultado?

## Nota para quien coordina el piloto (vos)

Cuando el developer termine, completá:
- [`execution-record.md`](execution-record.md) con sus datos reales (fecha, tiempo
  insumido, si terminó o quedó bloqueado).
- [`feedback-record.md`](feedback-record.md) con sus respuestas literales a las 7
  preguntas — no las resumas ni las completes vos por él.
- Recién ahí, comparar su `AGENTS.md.developer-attempt.md` contra
  `AGENTS.md.proposal.md` (mi borrador) — las diferencias son señal real de qué falta en
  la plantilla CAP-005, no al revés.
