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

## Roadmap de este repositorio (PROPOSAL)

Este repositorio sigue una progresión Foundation → Evolution, alineada al roadmap general
de MOA, pero acotada a la construcción de la base de AI Engineering:

### Foundation (esta entrega)
- Estrategia, principios, modelo de madurez, roadmap.
- Arquitectura de referencia y mapeo inicial del SDLC con IA.
- Gobierno corporativo (AI governance + agent governance).
- Catálogo inicial de integraciones (clasificadas EXISTING/POSSIBLE/PROPOSED).
- Framework de métricas + KPIs propuestos por el KO.
- Catálogo de casos de uso identificados en el KO.
- Modelo de equipos reales de MOA (DataAgro, Scato Logística, MOA Operaciones, Scato
  Puerto, Orquestador), con `moa-sdlc`/`moa-metrics` referenciadas como herramientas de
  Baufest para la iniciativa, no como equipos (corregido 2026-09-04, ver
  `teams/README.md`).
- Templates para nuevas capacidades.

### Evolution (siguiente fase — REQUIRES VALIDATION de alcance con MOA)
- Promoción de capacidades concretas (skills/agents/instructions) a `skills/`/`agents/`
  reusable, una vez pasadas por el pipeline de `assessment/README.md` — evaluando por
  igual las candidatas de cualquier repo con evidencia real (DataAgro, Scato Logística,
  `moa-sdlc`, `moa-metrics`; ver `assessment/relevamiento-capacidades.md`), no
  privilegiando ninguna por defecto.
- Catálogo real de servidores MCP (autenticación, scope, auditoría) — no se documentará
  ningún MCP server hasta que exista uno realmente desplegado o aprobado.
- Onboarding de equipos sin implementación aún (Data, QA, Security, DevOps, Operations
  fuera de los ya mapeados).
- Baseline real medido (no solo proyectado) con `moa-metrics`.

### Iteration (continuo)
- Ciclo de mejora de prompts/skills/agentes en base a auditorías reales.
- Revisión de gobierno y métricas por ciclo, según el modelo de 5 pasos del KO.

## Metas proyectadas por MOA a Q3/Q4 2026 (PROPOSAL — proyecciones del KO, no baseline medido)

**[REQUIRES VALIDATION]** El propio KO Interno aclara (pág. 19): *"Porcentajes proyectados
sobre una media de las métricas actuales del primer Half - 2026"* y *"Esta propuesta de
métricas son una estrategia inicial que consideramos de valor, pero que se deberán
refinar en base a las necesidades de MOA y la disponibilidad de la información."* Es
decir: **estos números no son un compromiso confirmado**, sino una proyección de KO. Ver
detalle completo en [`metrics/kpis.md`](../metrics/kpis.md).

## Preguntas abiertas para MOA (heredadas del análisis de discovery)

1. ¿`moa-sdlc`/`moa-metrics` se referencian o se consolidan dentro de este repo?
2. ¿Hay más material de referencia (actas, Confluence, decks) fuera de este workspace?
3. ¿Los equipos con madurez ya mapeada (DataAgro/MOA Oper./Scato Puerto/Scato Logística)
   son los únicos alcanzados por Track 1, o hay más equipos a incorporar?
4. ¿Quién aprueba formalmente el contenido de `governance/` — los líderes listados en el
   KO (Elmer Charre, Fernando Pagano, Tito Picón), u otro proceso?
5. ¿Estos principios y este roadmap deben ser ratificados por un comité de gobierno antes
   de aplicarse como norma para todos los equipos?
