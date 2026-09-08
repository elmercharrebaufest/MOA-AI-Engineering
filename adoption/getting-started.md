# Getting Started

Guía práctica. Cada paso enlaza al mecanismo real (contrato, Registry, plantilla) — el
detalle de cada capacidad vive en [`../registry/INDEX.md`](../registry/INDEX.md) y
[`../capabilities/README.md`](../capabilities/README.md), no acá.

## 1. Entender qué es esto

`MOA-AI-Engineering` es la base común de AI Engineering para MOA — principios, gobierno,
un Registry de capacidades reales, un Golden Path, y contratos para generar evidencia,
evaluar y medir. No reemplaza el trabajo de tu equipo — es algo que **consumís**, no algo
que se te impone (ver [`../architecture/operating-model.md`](../architecture/operating-model.md), "Team Adaptation").

## 2. Descubrir qué capacidades existen

Abrí [`../registry/INDEX.md`](../registry/INDEX.md) (discovery, con clasificación y
riesgo por entrada) o [`../capabilities/README.md`](../capabilities/README.md) (catálogo
consumible, con los archivos listos para copiar). Hoy hay 6 capacidades reales, ninguna
`Corporate Standard: Y` — son candidatas evaluadas con evidencia, no un catálogo de "lo
que MOA ya decidió que todos deben usar".

## 3. Evaluar si te sirve (antes de adoptar)

Abrí la entrada completa en `../registry/entries/<nombre>.md`. Mirá especialmente:
`Risk`, `Data Classification`, `Configuration Status` (¿el archivo está bien armado?) y
`Real Use Status` (¿alguien lo usó de verdad, o solo existe configurado?) — **son
preguntas distintas, no asumas que una responde la otra** (ver
[`../architecture/capability-registry.md`](../architecture/capability-registry.md)).

## 4. Adoptar / Adaptar

Copiá la estructura de la capacidad, adaptá el contenido a tu dominio (ver
[`team-adaptation.md`](team-adaptation.md) para qué podés cambiar libremente y qué no).

## 5. Ejecutar y generar Evidence

Al ejecutarla sobre una actividad real de tu SDLC, completá un **Evidence Record**
siguiendo el Evidence Contract
([`../architecture/evidence-evaluation-measurement.md`](../architecture/evidence-evaluation-measurement.md#1-evidence))
— mirá [`../evidence/README.md`](../evidence/README.md) para los 2 ejemplos reales ya
hechos (2 controlled dry-runs, no pilotos independientes — la distinción está declarada
en cada registro). No hace falta tooling — es un archivo de texto con los campos del
contrato.

## 6. Evaluar el resultado

Aplicá el Evaluation Contract
([`../architecture/evidence-evaluation-measurement.md`](../architecture/evidence-evaluation-measurement.md#2-evaluation)):
declará tus criterios *antes* de mirar el resultado, el método (`human` es lo recomendado
hasta que exista un mecanismo automatizado confiable), y si el caso requiere HITL
(`hitl_required: true` para cualquier cosa que pueda promoverse o tener impacto real). Ver
[`../evaluation/README.md`](../evaluation/README.md) para los ejemplos reales.

## 7. Medir (cuando exista baseline)

Usá el Measurement Result Contract
([`../architecture/evidence-evaluation-measurement.md`](../architecture/evidence-evaluation-measurement.md#3-measurement)).
**Si no tenés baseline, no lo inventes** — registrá `baseline_reference: REQUIRES
VALIDATION` y `confidence/status: NOT MEASURED`/`NO DATA`. Eso es un resultado válido, no
una falla — ver [`../measurements/README.md`](../measurements/README.md).

## 8. Dar feedback y contribuir

Si encontraste algo que valdría la pena que otros equipos usen, o algo que faltó — ver
[`contribution-guide.md`](contribution-guide.md).
