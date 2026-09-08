# Adoption Kit

**Para quién es esto**: un equipo de MOA que quiere empezar a usar `MOA-AI-Engineering`
sobre un proyecto real — no para quien diseña la arquitectura (esa documentación vive en
[`../architecture/`](../architecture/)). Esta carpeta es **práctica y operativa**: responde
"qué hago" en segunda persona.

> **No necesitás copiar todo `MOA-AI-Engineering` dentro de tu proyecto.** Es la base
> común/referencia — tu equipo adopta únicamente las capacidades puntuales que necesita,
> el resto queda acá como catálogo.

## ¿Qué quieres hacer?

| Necesidad | Camino recomendado |
|---|---|
| Refinar requerimientos | AI-Assisted Requirements |
| Desarrollar con IA | AI-Assisted Development |
| Generar/validar pruebas | AI-Assisted QA |
| Revisar código | AI Code Review |
| Crear un Agent | Agent Creation |
| Integrar un sistema externo | MCP / Integration Onboarding |

Detalle de cada camino: [`../golden-paths/README.md`](../golden-paths/README.md). Hoy
**solo el primero tiene ejecuciones reales** — los demás son conceptuales, sin evidencia
de ejecución todavía (declarado así en el propio documento, sin excepción).

## El flujo completo

```mermaid
flowchart LR
    A["Necesidad SDLC"] --> B["Golden Path"]
    B --> C["Capability"]
    C --> D["Team Adaptation"]
    D --> E["Execution"]
    E --> F["Evidence"]
    F --> G["Evaluation"]
    F --> H["Measurement"]
    G --> I["Feedback / Improve"]
    H --> I
```

## Cómo navegar este kit

1. **Entender el modelo** → [`getting-started.md`](getting-started.md) §1
2. **Elegir el camino** → [`getting-started.md`](getting-started.md) §2, o la tabla de
   arriba
3. **Seleccionar capability** → [`getting-started.md`](getting-started.md) §3 +
   [`../registry/INDEX.md`](../registry/INDEX.md)
4. **Adoptar/adaptar** → [`getting-started.md`](getting-started.md) §5 +
   [`team-adaptation.md`](team-adaptation.md)
5. **Ejecutar sobre trabajo real** → [`getting-started.md`](getting-started.md) §6 +
   [`execution-model.md`](execution-model.md)
6. **Generar Evidence** → [`getting-started.md`](getting-started.md) §7 +
   [`templates/evidence-record.md`](templates/evidence-record.md)
7. **Evaluar** → [`getting-started.md`](getting-started.md) §8 +
   [`templates/evaluation-record.md`](templates/evaluation-record.md)
8. **Medir** → [`getting-started.md`](getting-started.md) §9 +
   [`templates/measurement-record.md`](templates/measurement-record.md)
9. **Dar feedback** → [`contribution-guide.md`](contribution-guide.md)

Modelo mental completo con Definition of Done: [`adoption-flow.md`](adoption-flow.md).

## Biblioteca de capacidades

Catálogo consumible: [`../capabilities/README.md`](../capabilities/README.md) — 6
capacidades reales (Skills/Agents/Instructions/Workflows), cada una lista para
adoptar/adaptar, con su Best Practices guide en
[`../capabilities/best-practices.md`](../capabilities/best-practices.md).

## Las 11 preguntas que responde este kit

| Pregunta | Dónde |
|---|---|
| ¿Qué es esto? | [`getting-started.md`](getting-started.md) §1 |
| ¿Qué quiero mejorar? | Tabla de arriba, o [`getting-started.md`](getting-started.md) §2 |
| ¿Cómo elijo una capacidad? | [`getting-started.md`](getting-started.md) §3-4 + [`../registry/INDEX.md`](../registry/INDEX.md) |
| ¿Cómo adapto una capacidad? | [`team-adaptation.md`](team-adaptation.md) |
| ¿Qué debo conservar (no puedo tocar)? | [`team-adaptation.md`](team-adaptation.md) |
| ¿Cómo ejecuto? | [`execution-model.md`](execution-model.md) |
| ¿Qué evidencia genero? | [`getting-started.md`](getting-started.md) §7 |
| ¿Cómo evalúo? | [`getting-started.md`](getting-started.md) §8 |
| ¿Cómo mido? | [`getting-started.md`](getting-started.md) §9 |
| ¿Cómo reporto feedback? | [`contribution-guide.md`](contribution-guide.md) |
| ¿Cómo propongo una capacidad para reutilización? | [`contribution-guide.md`](contribution-guide.md) |

## Qué NO es este kit

No es un tutorial de IA generativa, no enseña a usar Copilot/Claude — asume que tu equipo
ya tiene acceso a un asistente. Es una guía de **cómo se relaciona tu trabajo con el
Common Core** — descubrir, adoptar, adaptar, generar evidencia, evaluar, medir,
contribuir.

## Antes de empezar — la limitación honesta

La parte técnica de este flujo (descubrir → adoptar → adaptar → ejecutar → generar
evidencia) es self-serve hoy. La parte de gobierno (quién evalúa con mandato, a quién le
llega tu feedback, quién aprueba una promoción) **todavía depende de que se resuelva quién
gobierna el Common Core** — ver
[`../governance/BLOCKED-DECISIONS.md`](../governance/BLOCKED-DECISIONS.md) #1. Esto no es
un defecto oculto: está documentado así en
[el historial del primer piloto](../docs/history/track-1/G4.4-Real-Adoption-Pilot.md)
tras el primer controlled dry-run (no un piloto real independiente — ver la distinción en
ese mismo documento). Podés avanzar igual con las partes que sí son self-serve.
