# Adoption Kit

**Para quién es esto**: un equipo de MOA que quiere empezar a usar `MOA-AI-Engineering`
— no para quien diseña la arquitectura (esa documentación vive en
[`../docs/architecture/`](../docs/architecture/)). Esta carpeta es **práctica y
operativa**, no conceptual: responde "qué hago" en segunda persona, cruza referencia a la
arquitectura en vez de repetirla.

## Biblioteca de capacidades (nuevo en G5.1)

Si ya sabés cómo funciona el modelo y solo querés ver **qué hay para usar hoy**:
[`../capabilities/README.md`](../capabilities/README.md) — 6 capacidades reales
(Skills/Agents/Instructions/Workflows), cada una lista para adoptar/adaptar, con su Best
Practices guide en [`../capabilities/best-practices.md`](../capabilities/best-practices.md).

## Las 10 preguntas que responde este kit

| Pregunta | Dónde |
|---|---|
| ¿Cómo empiezo? | [`getting-started.md`](getting-started.md) |
| ¿Qué debo revisar? | [`getting-started.md`](getting-started.md) |
| ¿Cómo sé qué capacidades puedo utilizar? | [`../capabilities/README.md`](../capabilities/README.md) (catálogo) + [`getting-started.md`](getting-started.md) §2 (Registry, con la evidencia completa) |
| ¿Cómo adapto una capacidad? | [`team-adaptation.md`](team-adaptation.md) |
| ¿Qué debo conservar (no puedo tocar)? | [`team-adaptation.md`](team-adaptation.md) |
| ¿Qué evidencia genero? | [`getting-started.md`](getting-started.md) §4 |
| ¿Cómo evalúo? | [`getting-started.md`](getting-started.md) §5 |
| ¿Cómo mido? | [`getting-started.md`](getting-started.md) §6 |
| ¿Cómo reporto feedback? | [`contribution-guide.md`](contribution-guide.md) |
| ¿Cómo propongo una capacidad para reutilización? | [`contribution-guide.md`](contribution-guide.md) |

## Qué NO es este kit

No es un tutorial de IA generativa, no enseña a usar Copilot/Claude — asume que tu equipo
ya tiene acceso a un asistente (la mayoría de los equipos de MOA ya lo tiene, ver
`../strategy/vision.md`). Es una guía de **cómo se relaciona tu trabajo con el Common
Core** — descubrir, adoptar, adaptar, generar evidencia, evaluar, medir, contribuir.

## Antes de empezar — la limitación honesta

La parte técnica de este flujo (descubrir → adoptar → adaptar → ejecutar → generar
evidencia) es self-serve hoy. La parte de gobierno (quién evalúa con mandato, a quién le
llega tu feedback, quién aprueba una promoción) **todavía depende de que se resuelva quién
gobierna el Common Core** — ver
[`../docs/architecture/BLOCKED-DECISIONS.md`](../docs/architecture/BLOCKED-DECISIONS.md)
#1. Esto no es un defecto oculto: está documentado así en
[`../docs/architecture/G4.4-Real-Adoption-Pilot.md`](../docs/architecture/G4.4-Real-Adoption-Pilot.md)
tras el primer controlled dry-run (no un piloto real independiente — ver la distinción
en ese mismo documento). Puedes avanzar igual con las partes que sí son self-serve.
