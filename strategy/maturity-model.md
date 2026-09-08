# Modelo de madurez: Crawl → Walk → Run

## Definición del modelo (FACT — KO Interno, pág. 9)

| Nivel | Descripción | Características |
|---|---|---|
| **CRAWL** | Explorar con control | Uso inicial de IA en actividades acotadas del SDLC, bajo riesgo, foco en aprendizaje y validación de valor potencial. Experimentación, uso individual, pilotos, prompts, Copilot, skills simples. |
| **WALK** | Ordenar, repetir y medir | Adopción regular de IA en casos concretos del SDLC, con prácticas comunes, métricas iniciales y procesos controlados. Skills reutilizables, agentes controlados, integración con herramientas, patrones, conocimiento compartido, governance inicial. |
| **RUN** | Escalar y gobernar | IA integrada de forma sistemática en el SDLC, con gobierno, automatización, métricas ejecutivas y mejora continua. Capacidades transversales, AI Engineering Platform, MCP controlado, observabilidad, reutilización cross-team. |

Ejes de progreso entre niveles (FACT, pág. 9): **Método → Repetibilidad → Medición →
Gobierno → Automatización.**

> No se asume que todos los equipos deban comenzar (ni terminar) en el mismo nivel.

## Nivel actual por equipo (FACT — KO Interno, pág. 9 y 20)

| Equipo | Nivel actual | Evidencia (KO Interno) |
|---|---|---|
| DataAgro | CRAWL | DEV: autocomplete/sugerencias, debugging, poco modo agente; integración SAP; consultas sobre código existente. PM/PO/QA: documentación asistida sin herramienta específica. |
| MOA Operaciones | CRAWL | Igual grupo que DataAgro/Scato Puerto en el KO. |
| Scato Puerto | CRAWL | Igual grupo que DataAgro/MOA Operaciones en el KO. |
| Scato Logística | WALK (en transición) | DEV (Cardless): modo agente con reglas de codificación, MCP contra Jira, skills e instructions. PO: agente en prueba. QA: generación de casos con apoyo de Copilot. |

**[REQUIRES VALIDATION]** El KO no detalla el nivel de madurez de los equipos Data, Web
Development, Enterprise Applications (más allá de Scato Logística), Security, DevOps ni
Operations como categorías separadas del framework de equipos propuesto en el master
prompt. Se requiere mapear estos equipos MOA reales contra esas categorías.

## Objetivo de evolución a Q4 2026 por equipo (FACT — KO Interno, pág. 20)

- **Scato Logística** (equipo más avanzado, en camino a completar WALK): repositorio de
  prompts/skills, agentes para DEVs, IA extendida full a PO/QA/PM, PR/review/testing
  asistidos, tools conectadas, dashboard ejecutivo automatizado, gobierno formalizado.
- **DataAgro / MOA Operaciones / Scato Puerto**: prácticas IA comunes por rol, IA en
  refinamiento/documentación/desarrollo/QA, skills/prompts reutilizables, integración
  inicial con tools, baseline e indicadores, dashboard ejecutivo, métricas en SonarQube.

## Relación con las implementaciones existentes (corregido 2026-09-04)

**Aclaración de alcance**: `moa-sdlc` y `moa-metrics` no son equipos de MOA — son
herramientas de referencia construidas por Baufest para la iniciativa. No se usan para
"calificar" el nivel de madurez de ningún equipo real; se listan acá solo como ejemplos
de implementación posibles, entre otros:

- `moa-sdlc` (template SDD + agentes .NET, herramienta de Baufest) muestra roles de
  agente definidos, matriz de gobierno (`AGENTS.md`) y patrones reutilizables —
  consistente con las características del eje Automatización de WALK, como ejemplo.
- **DataAgro** y **Scato Logística** (equipos reales de MOA) tienen evidencia directa,
  validada por lectura de código el 2026-09-04, de Agents/Skills/Instructions
  formalizados — Scato Logística en particular con mayor integración cruzada que el
  patrón de `moa-sdlc`. Ver `assessment/relevamiento-capacidades.md` para el detalle. Esto
  no cambia automáticamente su nivel KO (CRAWL/WALK) porque **configuración formalizada
  no equivale a uso real, proceso ni resultados medidos** (ver
  `assessment/relevamiento-capacidades.md` — uso efectivo queda REQUIRES VALIDATION en
  ambos).
- `moa-metrics` (pipeline de indicadores, herramienta de Baufest) es **un ejemplo posible**
  de implementación del eje Medición — no la única vía ni un requisito para que un equipo
  avance de CRAWL a WALK; cualquier equipo podría construir su propia medición y llegar al
  mismo eje por otro camino.
