# Roadmap

## Cómo se relacionan los 3 procesos que aparecen en este repositorio (aclaración, 2026-09-04)

Conviven 3 formulaciones de proceso en `MOA-AI-Engineering` — no son 3 procesos
distintos, son 3 niveles de detalle del mismo ciclo:

1. **4 pasos del KO** (pág. 14, ver `vision.md`/principios): empezar por la plataforma →
   aplicar IA en cada etapa → mantener human-in-the-loop → medir desde el día 1. Es el
   marco más general, de alto nivel.
2. **5 pasos del KO** (pág. 21-22, ver abajo): Identificar → Integrar IA → Auditar →
   Medir → Mejorar. Es el ciclo operativo de la iniciativa completa, repetido por ciclos
   (Foundation/Evolution/Iteration).
3. **Pipeline de 11 pasos del assessment** (`assessment/README.md`, definido en G3):
   Problema/proceso → Use Case → Valor+Riesgo → Assessment → Capacidad adecuada →
   Evaluación → Piloto → Medición → Gobierno → Validación → Reutilización/escalamiento.
   Es el **desglose granular** de cómo se ejecuta, capacidad por capacidad, el paso 2
   ("Integrar IA") del ciclo de 5 pasos — con los pasos 3 y 4 del ciclo de 5 pasos
   (Auditar, Medir) incorporados explícitamente dentro del mismo pipeline (Gobierno,
   Medición, Validación).

No usar los 3 como si compitieran entre sí: el pipeline de 11 pasos es el detalle
operativo del ciclo de 5 pasos, que a su vez instrumenta los 4 pasos de alto nivel del KO.

## Roadmap de la iniciativa MOA (FACT — KO Interno, pág. 22)

Ciclo continuo de 5 pasos, repetido en ciclos (Foundation → Evolution I → Evolution II →
Iteration), con tareas asignadas a Baufest [BF], MOA [MOA] o ambos [BF+MOA]:

1. **Identificar proceso/actividad** — mapear SDLC por rol y etapa, revalidar objetivos y
   modelo de madurez, acordar métricas, validar plan de trabajo y accesos.
2. **Integrar IA** — habilitar Rovo/Jira, MCPs y accesos, GitHub Copilot Code Review for
   Azure DevOps, configurar skills/agents/instructions por rol y etapa, capacitar al
   equipo, instalar SonarQube, habilitar Power BI, consolidar repositorio común, acordar
   gobierno mínimo.
3. **Auditar** — integrar proyectos en SonarQube, activar controles de calidad, validar
   human-in-the-loop.
4. **Medir resultados** — instrumentar métricas de SDLC, medir adopción, productividad,
   calidad e impacto.
5. **Mejorar** — ajustar prompts/skills/agentes y estrategia, revisar avances vs.
   objetivos, definir backlog de evolución.

## Roadmap de este repositorio (FACT — estado real al 2026-09-11, ver `strategy/track-1-context.md`)

Este repositorio sigue una progresión Foundation → Evolution → Iteration, alineada al
roadmap general de MOA. **Ya superó ampliamente la fase Foundation** — el estado real y
siempre vigente vive en [`track-1-context.md`](track-1-context.md) (documento rector,
actualizado con cada fase); esta sección resume, no duplica.

### Foundation (completada — G1 a G3.3)
- Estrategia, principios, modelo de madurez, roadmap, arquitectura de referencia, mapeo
  inicial del SDLC con IA, gobierno corporativo, catálogo inicial de integraciones,
  framework de métricas + KPIs propuestos por el KO, catálogo de casos de uso, modelo de
  equipos reales de MOA, templates.

### Evolution (completada — G4.1 a G5.1, no "siguiente fase")
- **Capability Registry real**: 8 entradas (`registry/INDEX.md`), 6 capacidades
  materializadas y reutilizables (`capabilities/README.md`) — generalizadas desde
  evidencia real de DataAgro, Scato Logística, Orquestador y `moa-sdlc` (herramienta de
  referencia de Baufest, no equipo de MOA), pasadas por el pipeline de
  `assessment/README.md`.
- **Golden Paths**: 6 documentados, 1 (`AI-Assisted Requirements`) con 6 ejecuciones
  reales — la última con un actor independiente (`PILOT-003`, ver
  `golden-paths/README.md`).
- **Evidence/Evaluation/Measurement Contracts**: definidos y aplicados 7 veces sobre
  requerimientos reales.
- **Context Acquisition & Resolution**: implementado como cross-cutting concern, con 2
  patrones reales (Azure DevOps, Jira/MCP).
- Catálogo real de servidores MCP: **todavía no existe** — 2 hallazgos de MCP real sin
  gobierno confirmado quedaron escalados como Blocked Decisions (`governance/BLOCKED-DECISIONS.md`
  #4, #12), no como catálogo aprobado.
- Onboarding de equipos sin implementación aún (Data, QA, Security, DevOps, Operations):
  **sigue sin resolver** — ningún equipo nuevo se incorporó todavía.
- Baseline real medido con `moa-metrics`: **sigue sin resolver** — todas las mediciones
  registradas son `NOT MEASURED` por falta de baseline (`measurements/README.md`).

### Iteration (en curso)
- Ciclo de mejora de prompts/skills/agentes en base a auditorías reales — aplicado en
  G5.1 (correcciones a `capability-registry.md`, `README.md`, `golden-paths.md` tras
  auditoría de consistencia).
- Revisión de gobierno y métricas por ciclo, según el modelo de 5 pasos del KO — pendiente
  de la resolución de las 12 Blocked Decisions (ver sección de preguntas abiertas, más
  abajo).

**Estado declarado por el propio repositorio**: `READY WITH CONDITIONS` (`README.md`) — no
"Foundation en curso". Ver `strategy/track-1-context.md` §12 y §17 para el detalle
completo, siempre más actual que este archivo.

## Metas proyectadas por MOA a Q3/Q4 2026 (PROPOSAL — proyecciones del KO, no baseline medido)

**[REQUIRES VALIDATION]** El propio KO Interno aclara (pág. 19): *"Porcentajes proyectados
sobre una media de las métricas actuales del primer Half - 2026"* y *"Esta propuesta de
métricas son una estrategia inicial que consideramos de valor, pero que se deberán
refinar en base a las necesidades de MOA y la disponibilidad de la información."* Es
decir: **estos números no son un compromiso confirmado**, sino una proyección de KO. Ver
detalle completo en [`metrics/kpis.md`](../metrics/kpis.md).

## Preguntas abiertas para MOA

**No duplicar el tracking en 2 lugares** — las 12 decisiones bloqueadas reales, con su
impacto y evidencia, viven únicamente en
[`../governance/BLOCKED-DECISIONS.md`](../governance/BLOCKED-DECISIONS.md) (la más
estructural: quién tiene mandato para aprobar/gobernar el Common Core, #1). De las 5
preguntas originales de este documento (discovery temprano, G1), el estado real hoy es:

1. ¿`moa-sdlc`/`moa-metrics` se referencian o se consolidan dentro de este repo? —
   **Resuelta**: se referencian como evidencia/candidatos, nunca como fuente de gobierno
   (`teams/README.md`).
2. ¿Hay más material de referencia fuera de este workspace? — Sigue abierta, no escalada
   como Blocked Decision formal (bajo impacto arquitectónico).
3. ¿Los equipos ya mapeados son los únicos alcanzados por Track 1? — Sigue abierta, sin
   evidencia nueva.
4. ¿Quién aprueba formalmente `governance/`? — **Absorbida por Blocked Decision #1**
   (mandato de gobierno del Common Core), no se resuelve por separado.
5. ¿Principios y roadmap requieren ratificación de un comité? — **Absorbida por Blocked
   Decision #1**, misma razón.
