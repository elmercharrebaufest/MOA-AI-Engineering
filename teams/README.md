# Modelo de equipos

## Principio (FACT — brief de la iniciativa)

> "MOA-AI-Engineering establece la base común; cada equipo decide qué adoptar, adaptar o
> no utilizar según sus necesidades, manteniendo los principios y controles
> corporativos."

Ningún equipo está obligado a usar exactamente las mismas herramientas o prácticas que
otro. Este repositorio no reemplaza los repos de cada equipo — los referencia.

## Corrección de alcance (2026-09-04) — `moa-sdlc`/`moa-metrics` no son equipos de MOA

**[FACT, corregido]** `moa-sdlc` y `moa-metrics` **no son repos de un equipo de MOA** —
son herramientas/plantillas de referencia construidas por Baufest para la propia
iniciativa Track 1 (`moa-sdlc` = template de gobierno de agentes + spec-driven
development; `moa-metrics` = pipeline de indicadores). No hay evidencia de que ningún
equipo de negocio de MOA los use como su repo de trabajo diario. Tratarlos como "el
equipo Enterprise Applications" o "el equipo Data/Métricas" fue un error de una iteración
anterior de este documento — se corrige acá. **`MOA-AI-Engineering` es el repositorio que
se está construyendo como base común de buenas prácticas para todos los proyectos de
MOA** (existentes y nuevos); `moa-sdlc`/`moa-metrics` son solo dos piezas de evidencia
más, al mismo nivel que cualquier otro repo relevado — no la fuente de la que este
repositorio deriva su contenido.

## Equipos reales de MOA con evidencia directa (FACT — repos de código relevados 2026-09-04)

| Equipo | Repositorio(s) real(es) | Nivel de madurez con evidencia |
|---|---|---|
| DataAgro | `DataAgro/DataAgro` | Agents/Skills/Instructions **formalizados** (validado por lectura directa); uso efectivo REQUIRES VALIDATION |
| Scato Logística | `Scato Logistica/Scato%20Logistica` (+ satélites: OrquestadorAkka, PocScatoLogisticaAws, WebApiCoreAfip) | Agents/Skills/Instructions **formalizados y más integrados** que DataAgro; uso efectivo REQUIRES VALIDATION |
| MOA Operaciones | `MoaOperaciones/MoaOperaciones` | Sin capacidades de IA formalizadas encontradas en el repo (CRAWL según KO) |
| Scato Puerto | `ScatoPuerto/scatopuerto`, `ScatoPuerto/scatopuertoAPINet` | Sin capacidades de IA formalizadas encontradas — pese a compartir dominio/arquitectura con Scato Logística |
| Orquestador | `Orquestador/Orquestador`, `Orquestador/OrquestadorAkka`, `Orquestador/Intercomunicador` | Sin capacidades de IA formalizadas encontradas |

## Herramientas de referencia de la iniciativa (no equipos — FACT)

| Repositorio | Qué es | Rol |
|---|---|---|
| [`moa-sdlc`](../../moa-sdlc) | Template de Baufest: SDD + gobierno de agentes para desarrollo .NET | Evidencia/candidato a evaluar, **no** un equipo de MOA |
| [`moa-metrics`](../../moa-metrics) | Pipeline de Baufest: ETL + cálculo de indicadores de adopción de IA | Evidencia/candidato a evaluar, **no** un equipo de MOA |

**[REQUIRES VALIDATION]** Confirmar con MOA si `moa-sdlc` fue construido a partir de /
para el equipo "Scato Logística" del KO Interno (coincide en descripción: "modo agente,
MCP contra Jira, skills e instructions") — de ser así, el patrón real y más rico de
evidencia sigue siendo el repo de Scato Logística mismo (ver tabla de arriba), no
`moa-sdlc`.

## Equipos del framework sin implementación documentada aún (REQUIRES VALIDATION)

Data (más allá de métricas), Web Development, QA/Testing, Seguridad, DevOps, Operaciones,
Arquitectura. Para cada uno, antes de crear contenido en `teams/<equipo>/`, se debe:

1. Confirmar que el equipo existe como tal en la estructura real de MOA (no inventar
   equipos a partir de los ejemplos del master prompt).
2. Identificar su nivel de madurez actual (Crawl/Walk/Run) con evidencia, no supuestos.
3. Relevar qué stack/herramientas usa hoy, igual que se hizo para el stack general en
   `architecture/reference-architecture.md`.

## Cómo un equipo nuevo se incorpora a este modelo

1. Crear su propio repositorio o carpeta de trabajo (no dentro de `MOA-AI-Engineering`).
2. Documentar su caso de uso inicial con [`../templates/use-case-template.md`](../templates/use-case-template.md).
3. Consultar `governance/ai-governance.md` y `governance/agent-governance.md` para los
   controles corporativos mínimos (human-in-the-loop, matriz de autonomía).
4. Si el equipo produce una capacidad (skill, agente, patrón) que **parece** útil para más
   de un equipo, se documenta como candidata en [`../assessment/relevamiento-capacidades.md`](../assessment/relevamiento-capacidades.md)
   y pasa por el pipeline de [`../assessment/README.md`](../assessment/README.md)
   (problema → caso de uso → valor/riesgo → assessment → evaluación → piloto → medición →
   gobierno → validación) antes de proponerse como REUSABLE. Ninguna capacidad se promueve
   solo por existir o por parecer útil.
5. Este README se actualiza agregando la fila correspondiente en la tabla de equipos.

## Líderes de la iniciativa (FACT — KO Interno, pág. 17)

- Líderes: Elmer Charre, Fernando Pagano, Tito Picón.
- Soporte: Adrián Bepré, Ariel Bensussán.
- Participantes: todo el equipo (según backlog que se vaya sumando por equipo).

**[REQUIRES VALIDATION]** Confirmar si estos líderes son los responsables de aprobar
contenido de `governance/` en este repositorio, o si existe otro proceso de gobierno.
