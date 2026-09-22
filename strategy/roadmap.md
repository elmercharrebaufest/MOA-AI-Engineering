# Roadmap

## Cómo se relacionan los 3 procesos que aparecen en este repositorio (aclaración, 2026-09-04)

Conviven 3 formulaciones de proceso en `ai-engineering` — no son 3 procesos
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
- **Capability Registry real**: 18 entradas (`registry/INDEX.md`), 6 capacidades
  materializadas y reutilizables con evidencia real (`capabilities/README.md`) —
  generalizadas desde evidencia real de DataAgro, Scato Logística y Orquestador, pasadas
  por el pipeline de `assessment/README.md`. Las 11 restantes son propuestas nuevas, sin
  evidencia de origen de un equipo de MOA todavía (ver Iteration más abajo para el detalle
  completo de cada tanda).
- **Golden Paths**: 6 documentados, 1 (`AI-Assisted Requirements`) con el mecanismo
  probado de punta a punta durante la construcción — pruebas purgadas al pasar a
  adopción real, evidencia real en curso (ver `golden-paths/README.md`).
- **Evidence/Evaluation/Measurement Contracts**: definidos, mecanismo probado durante la
  construcción — sin registros reales todavía.
- **Context Acquisition & Resolution**: implementado como cross-cutting concern, con 2
  patrones (Azure DevOps, Jira/MCP), mecanismo probado durante la construcción.
- Catálogo real de servidores MCP: **todavía no existe** — 2 hallazgos de MCP real sin
  gobierno confirmado quedaron escalados como Blocked Decisions (`governance/BLOCKED-DECISIONS.md`
  #4, #12), no como catálogo aprobado.
- Onboarding de equipos sin implementación aún (Data, QA, Security, DevOps, Operations):
  **sigue sin resolver** — ningún equipo nuevo se incorporó todavía.
- Baseline real medido: **sigue sin resolver** — todas las mediciones registradas son
  `NOT MEASURED` por falta de baseline (`measurements/README.md`).

### Iteration (en curso)
- Ciclo de mejora de prompts/skills/agentes en base a auditorías reales — aplicado en
  G5.1 (correcciones a `capability-registry.md`, `README.md`, `golden-paths.md` tras
  auditoría de consistencia).
- Revisión de gobierno y métricas por ciclo, según el modelo de 5 pasos del KO — pendiente
  de la resolución de las 13 Blocked Decisions (ver sección de preguntas abiertas, más
  abajo).
- **Cobertura de las 11 etapas del SDLC del KO, etapa por etapa (2026-09-18)**: de las 11
  etapas de `architecture/ai-sdlc.md` (pág. 23-26 del KO), 4 quedaban sin capacidad ni
  propuesta (Apertura del PR, Testing funcional/QA, Cierre del ticket — este último ni
  figuraba en la tabla, defecto de documentación corregido en el mismo trabajo) y 1
  quedaba con la clasificación de un rol clave (Product Owner) sin una versión Agent que
  corrigiera un hallazgo real de seguridad. Se agregaron 4 capacidades nuevas al Registry
  (CAP-011 `pr-description`, CAP-014 `test-case-generation`, CAP-016
  `ticket-closure-assist`, CAP-004 `product-owner`), todas `PROPOSAL`, justificadas por
  Existing Practice + External Best Practice + Architectural Judgment
  (`assessment/README.md`), sin ejecución real ni piloto de ningún equipo todavía. Dos
  etapas quedan deliberadamente sin propuesta, por decisión explícita: Test de regresión
  (depende de un MCP Playwright sin evidencia real en ningún repo) y Soporte productivo
  (5 líneas de trabajo del KO, ninguna con evidencia — se define primero un relevamiento
  con un equipo real, no una capacidad). Detalle completo en
  [`../architecture/ai-sdlc.md`](../architecture/ai-sdlc.md).
- **Incorporación de evidencia externa de un cliente de Baufest — Camuzzi (2026-09-21)**:
  reunión real (Hernan Lavrencic) mostró un setup de SDLC-IA más maduro en distribución
  técnica que MOA — un repo especial `.github` de organización que propaga agents/
  instructions/skills automáticamente a todos los repos, vía la especificación oficial
  **Agent Plugins 1.0** (GitHub/VS Code, agosto 2026), verificada con documentación oficial
  y evidencia visual directa del video de la reunión. Se agregaron 5 capacidades nuevas al
  Registry (CAP-009 `git-worktree-setup`, CAP-010 `ticket-kickoff` — primer orquestador
  real del modelo, con `edit` acotado por 2 checkpoints humanos —, CAP-007 `spec-review`,
  CAP-015 `regression-test-generation`, CAP-017 `production-incident-investigation`), todas
  `PROPOSAL` con evidencia externa (no de un equipo de MOA), cerrando de forma deliberadamente
  parcial las 2 etapas que habían quedado sin propuesta el 2026-09-18 (Test de regresión:
  solo generación de código, sin ejecución en pipeline; Soporte productivo: solo 1 de las 5
  líneas del KO). Se agregó Blocked Decision #13 (confirmar disponibilidad del plan de
  GitHub/Agent Plugins 1.0 para MOA) y una sección en `capabilities/README.md` documentando
  el mecanismo como camino de distribución más maduro, pendiente de esa confirmación.
- **Renumeración del Registry por orden de etapa del KO (2026-09-21)**: a pedido del
  usuario, los 17 CAP-ID pasaron de reflejar el orden de descubrimiento (accidente
  histórico) a reflejar la secuencia real de las 11 etapas del KO — CAP-001 es ahora
  `user-story` (etapa 1) y CAP-017 `production-incident-investigation` (etapa 10). Se
  actualizaron los 60 archivos del modelo vivo (nunca `docs/history/track-1/`, registro
  histórico) con verificación cruzada de cada link — sin discrepancias encontradas.
- **Revisión de fidelidad contra el contenido completo de Camuzzi (2026-09-21)**: lectura
  de los agents/skills que no se habían leído completos en la primera pasada. Se
  fortaleció CAP-017 (`production-incident-investigation`) con 3 patrones concretos que
  faltaban (resolución de servicio, verificación de acceso antes de consultar, consultas
  de referencia reutilizables); se agregó **CAP-018 `spec-reader`** — un rol read-only de
  consulta sobre specs ya escritas, con citas, que no duplica a CAP-005 (escribe) ni CAP-007
  (audita calidad) — hallazgo genuino de la segunda lectura, no de la primera; y se
  incorporó a CAP-010 (`ticket-kickoff`) la disciplina de "nunca asumir el comando de
  build, leer la documentación real primero" observada en el agent `Dev Runner` de ese
  mismo cliente.
- **Investigación y diseño de distribución automática de capacidades (2026-09-21)**: al
  probar en vivo el mecanismo Agent Plugins 1.0 de GitHub (organización de prueba
  `elmer-charre`), se detectó que los repos reales de MOA están en Azure DevOps, no
  GitHub (ver CAP-008/CAP-002) — el mecanismo no aplica. Investigación posterior en
  fuentes oficiales (Microsoft Learn, GitHub Docs) y de comunidad confirmó: (a) Azure
  DevOps tiene un mecanismo nativo real para Code Review (instrucciones a nivel
  organización/proyecto/repositorio, en preview público) — recomendado para esa etapa
  puntual; (b) ningún mecanismo nativo de plataforma cubre el resto del ciclo (agents/
  skills usados durante el desarrollo) para repos en Azure DevOps. Se diseñó e implementó
  [`integrations/capability-distribution.md`](../integrations/capability-distribution.md)
  — sync por Pull Request, reutilizando `az repos pr create` (mismo mecanismo real de
  CAP-008), nunca push directo, siempre revisión humana — con su script ejecutable,
  plantilla de configuración y pipeline de ejemplo. `PROPOSAL`, sin ejecución real ni
  piloto todavía. Se actualizó Blocked Decision #13 reflejando la pregunta vigente (permisos
  de Azure DevOps y curaduría de la lista de repos destino, no disponibilidad de plan de
  GitHub).

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

**No duplicar el tracking en 2 lugares** — las 13 decisiones bloqueadas reales, con su
impacto y evidencia, viven únicamente en
[`../governance/BLOCKED-DECISIONS.md`](../governance/BLOCKED-DECISIONS.md) (la más
estructural: quién tiene mandato para aprobar/gobernar el Common Core, #1). De las 5
preguntas originales de este documento (discovery temprano, G1), el estado real hoy es:

1. ¿Otras herramientas de referencia de Baufest se referencian o se consolidan dentro de
   este repo? — **Resuelta, revertida el 2026-09-18**: no. Este modelo base
   (`ai-engineering`) es el entregable de la iniciativa Track 1 — no nombra proyectos
   que no forman parte de él, aunque hayan existido en paralelo dentro de Track 1 en un
   sentido más amplio.
2. ¿Hay más material de referencia fuera de este workspace? — Sigue abierta, no escalada
   como Blocked Decision formal (bajo impacto arquitectónico).
3. ¿Los equipos ya mapeados son los únicos alcanzados por Track 1? — Sigue abierta, sin
   evidencia nueva.
4. ¿Quién aprueba formalmente `governance/`? — **Absorbida por Blocked Decision #1**
   (mandato de gobierno del Common Core), no se resuelve por separado.
5. ¿Principios y roadmap requieren ratificación de un comité? — **Absorbida por Blocked
   Decision #1**, misma razón.
