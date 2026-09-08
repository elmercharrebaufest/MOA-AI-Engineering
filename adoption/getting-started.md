# Getting Started

Guía práctica de los primeros 6 pasos. Cada paso enlaza al mecanismo real (contrato,
Registry, plantilla) — no repite la teoría de `docs/architecture/`.

## 1. Entender qué es esto

`MOA-AI-Engineering` es la base común de AI Engineering para MOA — principios, gobierno,
un Registry de capacidades reales, un Golden Path, y contratos para generar evidencia,
evaluar y medir. No reemplaza el trabajo de tu equipo — es algo que **consumís**, no algo
que se te impone (ver `../docs/architecture/operating-model.md`, "Team Adaptation").

## 2. Descubrir qué capacidades existen

Abrí [`../registry/INDEX.md`](../registry/INDEX.md) o el catálogo práctico en
[`../capabilities/README.md`](../capabilities/README.md). Hoy hay 6 entradas reales (no
inventadas — cada una con evidencia verificable):

| Capacidad | Tipo | Para qué sirve | Clasificación | Corporate Standard |
|---|---|---|---|---|
| `azure-devops-cli` (CAP-001) | Skill | Operar Azure DevOps por CLI sin inventar sintaxis | Reusable Capability | N |
| `user-story` (CAP-002) | Skill | Estructurar requerimientos como historias de usuario | Reusable Capability | N |
| `read-only-code-reviewer` (CAP-003, ".NET Code Reviewer") | Agent | Code review acotado al diff, sin poder de escritura | Reusable Pattern | N |
| `spec-driven-development` (CAP-004) | Workflow | Llevar un ticket a código verificado, con trazabilidad | Reusable Pattern (nivel Lite, `EXECUTED`) / Experimental (nivel Full, sin evidencia de ejecución) | N |
| `repository-governance` (CAP-005) | Instruction | Declarar qué puede/no puede hacer un asistente sin supervisión | Reusable Governance Pattern / Common Core Candidate | N |
| `stack-best-practices-template` (CAP-006) | Skill | Plantilla para documentar buenas prácticas de tu stack real | Reusable Pattern | N |

**Ninguna es todavía `Corporate Standard: Y`** — son candidatas evaluadas con evidencia
real, no un catálogo de "lo que MOA ya decidió que todos deben usar". `Corporate
Standard: N` no significa que las 6 sean equivalentes entre sí ni que todas sean
Team-Specific — cada una tiene su propia clasificación (columna de arriba), desde
Reusable Capability con ejecución real hasta Common Core Candidate sin gobierno que la
haya aprobado todavía. Ninguna se presenta como `VERIFIED` — la evidencia de ejecución
real que existe (CAP-002, CAP-004 nivel Lite) es `EXECUTED`, no independiente. Adoptarlas
hoy es replicar/adaptar un patrón existente, con tus propios ojos críticos — no consumir
un estándar ya blindado.

## 3. Evaluar si te sirve (antes de adoptar)

Abrí la entrada completa en `../registry/entries/<nombre>.md`. Mirá especialmente:
`Risk`, `Data Classification`, `Configuration Status` (¿el archivo está bien armado?) y
`Real Use Status` (¿alguien lo usó de verdad, o solo existe configurado?) — **son
preguntas distintas, no asumas que una responde la otra** (ver
`../docs/architecture/capability-registry.md`).

## 4. Adoptar/adaptar y generar Evidence

Copiá la estructura de la capacidad, adaptá el contenido a tu dominio (ver
[`team-adaptation.md`](team-adaptation.md) para qué podés cambiar libremente). Al
ejecutarla, completá un **Evidence Record** siguiendo el Evidence Contract
(`../docs/architecture/G4.3-Evidence-Evaluation-Measurement.md` §6) — mirá
[`../evidence/EXEC-20260907-001.md`](../evidence/EXEC-20260907-001.md) y
[`../evidence/EXEC-20260908-001.md`](../evidence/EXEC-20260908-001.md) como ejemplos
reales ya hechos (2 controlled dry-runs, sobre 2 requerimientos distintos, G4.4 y G4.6 —
no pilotos independientes, ver la distinción en esos mismos documentos). No hace falta
tooling — es un archivo de texto con los campos del contrato.

## 5. Evaluar el resultado

Aplicá el Evaluation Contract (`G4.3...md` §8): declará tus criterios *antes* de mirar el
resultado, el método (`human` es lo recomendado hasta que exista un mecanismo automatizado
confiable), y si el caso requiere HITL (`hitl_required: true` para cualquier cosa que
pueda promoverse o tener impacto real). Ver
[`../evaluation/EXEC-20260907-001.md`](../evaluation/EXEC-20260907-001.md) y
[`../evaluation/EXEC-20260908-001.md`](../evaluation/EXEC-20260908-001.md) como ejemplos —
ambos quedaron en `PARTIAL`, ninguno con evaluación humana independiente todavía.

## 6. Medir (si es posible)

Usá el Measurement Result Contract (`G4.3...md` §10). **Si no tenés baseline, no lo
inventes** — registrá `baseline_reference: REQUIRES VALIDATION` y `confidence/status: NOT
MEASURED`/`NO DATA`. Eso es un resultado válido, no una falla — ver
[`../measurements/EXEC-20260907-001.md`](../measurements/EXEC-20260907-001.md) (incluye,
en su versión más reciente `EXEC-20260908-001`, por qué ni siquiera 2 ejecuciones del
mismo actor alcanzan para armar una serie de medición comparable).

## Y después

Si encontraste algo que valdría la pena que otros equipos usen, o algo que faltó — ver
[`contribution-guide.md`](contribution-guide.md).
