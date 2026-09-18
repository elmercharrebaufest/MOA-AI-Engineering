# Modelo de equipos

## Principio (FACT — brief de la iniciativa)

> "MOA-AI-Engineering establece la base común; cada equipo decide qué adoptar, adaptar o
> no utilizar según sus necesidades, manteniendo los principios y controles
> corporativos."

Ningún equipo está obligado a usar exactamente las mismas herramientas o prácticas que
otro. Este repositorio no reemplaza los repos de cada equipo — los referencia.

## Equipos reales de MOA con evidencia directa (FACT — repos de código relevados 2026-09-04)

| Equipo | Repositorio(s) real(es) | Nivel de madurez con evidencia |
|---|---|---|
| DataAgro | `DataAgro/DataAgro` | Agents/Skills/Instructions **formalizados** (validado por lectura directa); uso efectivo REQUIRES VALIDATION |
| Scato Logística | `Scato Logistica/Scato%20Logistica` (+ satélites: OrquestadorAkka, PocScatoLogisticaAws, WebApiCoreAfip) | Agents/Skills/Instructions **formalizados y más integrados** que DataAgro; uso efectivo REQUIRES VALIDATION |
| MOA Operaciones | `MoaOperaciones/MoaOperaciones` | Sin capacidades de IA formalizadas encontradas en el repo (CRAWL según KO) |
| Scato Puerto | `ScatoPuerto/scatopuerto`, `ScatoPuerto/scatopuertoAPINet` | Sin capacidades de IA formalizadas encontradas — pese a compartir dominio/arquitectura con Scato Logística |
| Orquestador | `Orquestador/Orquestador`, `Orquestador/OrquestadorAkka`, `Orquestador/Intercomunicador` | Sin capacidades de IA formalizadas encontradas |

## Equipos del framework sin implementación documentada aún (REQUIRES VALIDATION)

Data (más allá de métricas), Web Development, QA/Testing, Seguridad, DevOps, Operaciones,
Arquitectura. Para cada uno, antes de crear contenido en `teams/<equipo>/`, se debe:

1. Confirmar que el equipo existe como tal en la estructura real de MOA (no inventar
   equipos a partir de los ejemplos del encuadre fundacional de la iniciativa).
2. Identificar su nivel de madurez actual (Crawl/Walk/Run) con evidencia, no supuestos.
3. Relevar qué stack/herramientas usa hoy, igual que se hizo para el stack general en
   `architecture/reference-architecture.md`.

## Cómo un equipo nuevo se incorpora a este modelo

1. Crear su propio repositorio o carpeta de trabajo (no dentro de `MOA-AI-Engineering`).
2. Documentar su caso de uso inicial con [`../templates/use-case-template.md`](../templates/use-case-template.md).
3. Consultar `governance/ai-governance.md` y `governance/agent-governance.md` para los
   controles corporativos mínimos (human-in-the-loop, matriz de autonomía).
4. Si el equipo produce una capacidad (skill, agente, patrón) que **parece** útil para más
   de un equipo, se documenta como candidata en [`../docs/history/track-1/relevamiento-capacidades-g2.md`](../docs/history/track-1/relevamiento-capacidades-g2.md)
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
