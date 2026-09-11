# PILOT-001 — CAP-005 (repository-governance) en MoaOperaciones — CERRADO SIN EJECUTAR

**Estado: CERRADO (2026-09-09) — nunca se ejecutó con un developer real independiente.**
Todos los campos de `execution-record.md`/`feedback-record.md` quedaron en "pendiente"
desde su creación — no hubo actor externo real que lo completara. Se cierra este sandbox
en vez de dejarlo abierto indefinidamente sin evidencia. **Superseded by**: el usuario
(no un developer hipotético de MoaOperaciones) va a correr el protocolo cold-start real
él mismo, con una tarea de Jira real como input — ver nota al final de este archivo.

## Por qué existe esta carpeta

Track 1 tiene 8 capacidades `VERIFIED` en configuración pero **cero** con adopción
independiente confirmada (ver `strategy/track-1-context.md` §17-19: "Probado en adopción
independiente: ninguna"). El paso de mayor apalancamiento pendiente (§18, paso 4) es
ejecutar un piloto real con un equipo/repo **distinto** del que diseñó la capacidad.

`MoaOperaciones` y `ScatoPuerto` son, según `evidence/current-moa-ai-practices-benchmark.md`
y `teams/README.md`, los únicos repos de MOA relevados **sin ninguna capacidad de IA
formalizada** — candidatos naturales para la primera adopción independiente.

**Restricción explícita del usuario (2026, esta sesión)**: no modificar ningún repositorio
de los proyectos existentes todavía. Este piloto se construye acá, en `MOA-AI-Engineering`,
como sandbox — si se valida, pasa a ser el modelo base a copiar en `MoaOperaciones` (y
luego adaptar, no copiar literal, en los demás repos sin gobierno formalizado).

## Protocolo real (actualizado — cold-start, no revisión de borrador)

Hay un developer real de MoaOperaciones disponible, **sin ningún conocimiento previo**
de `MOA-AI-Engineering`. Esa es la condición que Track 1 necesita (§19: adopción por un
equipo distinto del que construyó la capacidad) — así que el protocolo cambió: en vez de
pedirle que revise un borrador ya armado, entra en frío y se guía solo. Ver
[`briefing-para-developer.md`](briefing-para-developer.md) para las instrucciones
exactas a entregarle (sin mostrarle el borrador antes).

## Qué contiene

- [`briefing-para-developer.md`](briefing-para-developer.md) — instrucciones para
  entregarle al developer, sin revelarle el borrador ni el resultado esperado.
- [`AGENTS.md.proposal.md`](AGENTS.md.proposal.md) — mi borrador propio, generado antes
  de conocer este protocolo. **No mostrarlo al developer hasta que termine su propio
  intento** — sirve solo para comparar después (gap analysis), no como respuesta "correcta".
- [`execution-record.md`](execution-record.md) — Execution Record de este piloto.
- [`evidence-record.md`](evidence-record.md) — Evidence Record de este piloto.
- [`feedback-record.md`](feedback-record.md) — para volcar las respuestas literales del
  developer, sin resumirlas.

## Qué falta para dejar de ser SANDBOX

1. Que el developer complete su intento cold-start y produzca su propio
   `AGENTS.md.developer-attempt.md`.
2. Recolectar su feedback literal en `feedback-record.md` (7 preguntas de
   `adoption/contribution-guide.md` + puntos de bloqueo).
3. Comparar su intento contra `AGENTS.md.proposal.md` — la diferencia es la evidencia
   real de qué le falta a la plantilla CAP-005, no al revés.
4. Recién con eso, decidir qué versión (o combinación) se propone integrar como
   `AGENTS.md` real en la raíz del repositorio `MoaOperaciones` — requiere aprobación
   explícita para tocar ese repo.
5. Esto sigue sin ser `VERIFIED` en el Registry ni promovible a `Corporate Standard` —
   Blocked Decision #1 (mandato de gobierno) sigue sin resolverse, este piloto no lo
   reemplaza.

## Cierre (2026-09-09)

Ningún developer real de MoaOperaciones ejecutó este protocolo — se mantuvo en
"pendiente" desde su creación. En vez de simularlo o completarlo por inferencia, se
cierra honestamente sin evidencia y se reemplaza por un intento real: el usuario va a
actuar él mismo como la persona sin conocimiento previo del proyecto, dando como entrada
una tarea de Jira real (ver `PILOT-002`). `AGENTS.md.proposal.md` de esta carpeta sigue
disponible para comparación futura si se retoma este piloto específico con un developer
real de MoaOperaciones.
