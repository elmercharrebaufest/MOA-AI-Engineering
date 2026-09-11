# G6 — Alineación completa contra el documento CORE del Track 1

**Fase**: G6. **Estado**: FACT donde se cita evidencia directa; PROPOSAL en las
correcciones editoriales. Precondición: G5.1 READY WITH CONDITIONS. Solo se modificó
`MOA-AI-Engineering`. Commit `ff6bd30` (pusheado a `origin/main` a pedido explícito del
usuario — única fase de este repositorio con push real hasta la fecha).

## 1. Origen y disparador

El usuario fijó `TRACK-1/BAUFEST_Escalando_el_Valor_del_Delivery_Mediante_IA_Aplicada.md`
(extracción estructurada completa del KO Interno, 29 páginas) como **documento rector
permanente** de todo el trabajo en este repositorio, con instrucción explícita de validar
cada punto del repositorio contra él y no dejar nada desalineado.

## 2. Validación punto por punto (5 secciones del CORE)

| Sección del CORE | Artefacto en el repo | Estado al cierre de G5.1 | Estado al cierre de G6 |
|---|---|---|---|
| 1. Contexto y objetivos | `strategy/vision.md`, `strategy/track-1-context.md` §1 | Alineado | Sin cambios — alineado |
| 3. Madurez Crawl/Walk/Run por equipo | `strategy/maturity-model.md` | **Desactualizado** — no declaraba la meta de nivel por equipo | **Corregido** — columna "Meta fin 2026" explícita (WALK/WALK/WALK/**RUN**), verificado contra la slide 20 del KO |
| 3. Stack actual (Jira/SharePoint/Confluence/VS+Copilot/testing/ADO/SQL Server) | `architecture/reference-architecture.md` | Sin verificar en esta ronda | **Verificado** — coincide 1:1 con el CORE, sin cambios necesarios |
| 4. Plataforma de IA — stack a agregar (MCP, Power BI, App Insights, SonarQube) | `integrations/catalog.md`, `governance/BLOCKED-DECISIONS.md` | Alineado | Sin cambios — alineado |
| 4. Modelo de métricas + metas Q3/Q4 | `metrics/framework.md`, `metrics/kpis.md` | Alineado | Sin cambios — alineado |
| 4. Enfoque de 5 pasos / roadmap general BF+MOA | `strategy/roadmap.md` | **Desactualizado** — describía el repo como "Foundation en curso" | **Corregido** — refleja Foundation+Evolution completadas (G1-G5.1), estado real `READY WITH CONDITIONS` |
| 4. SDLC etapa por etapa (11 con evidencia + 28 de encuadre) | `architecture/ai-sdlc.md` | **Sin tocar desde G1** — 0 conexión con las 8 capacidades reales del Registry | **Corregido** — tabla de cobertura real (Registry → etapa → Golden Path → estado), enriquecida con EXTERNAL EVIDENCE de DORA |
| 4. Líderes de la iniciativa | `teams/README.md` | Alineado | Sin cambios — alineado |
| 4. Operación y soporte (5 líneas, KO pág. 27) | `architecture/ai-sdlc.md` (sección propia) | `REQUIRES VALIDATION`, sin evidencia de implementación | Sin cambios — sigue siendo la lectura honesta, no se inventa cobertura |

**Conclusión de la validación**: las 9 filas de arriba cubren la totalidad de los puntos
verificables del CORE contra un artefacto real del repositorio. Al cierre de G6, **0 filas
quedan desalineadas** — 3 estaban desactualizadas (madurez, roadmap, SDLC) y se
corrigieron; el resto ya estaba correcto o se confirmó sin necesidad de cambios.

## 3. Hallazgos de integridad encontrados durante la validación (no eran parte del pedido original, pero afectaban directamente la fidelidad del modelo)

1. **`PILOT-003` (primera adopción independiente real) no estaba reflejado en los
   registros canónicos** — `evidence/EXEC-20260909-001.md` tenía un `actor` genérico y
   `golden-paths/README.md` seguía hablando de "2 ejecuciones" cuando ya había 6, la
   última con un developer real e independiente. Corregido en ambos documentos,
   distinguiendo explícitamente independencia de **actor** (resuelta) de independencia de
   **evaluación** (sigue `model-assisted`, sin resolver — no se mezclan los 2 ejes).
2. **Cambios reales pendientes de commit desde antes de esta fase** (registrados
   informalmente como "G5.2" en 3 archivos, sin documento de fase propio): la corrección
   de que `moa-sdlc` (nivel Full de `spec-driven-development`) tiene evidencia real de
   ejecución hasta `tester` sobre `MOA-1765-DistribuidorCupos` (build verde, 1228/1228
   NUnit). Se incorporó como baseline de esta fase en vez de rehacerse.

## 4. Re-relevamiento de evidencia interna (Fase 1 del plan acordado con el usuario)

Se verificó `git log` real de los 6 repos relevantes (los 5 del CORE + `moa-sdlc`): **cero
commits posteriores al 2026-09-09** (fecha del relevamiento de G5.1) en cualquiera de los
6. Conclusión: no había evidencia nueva que relevar — el inventario de G5.1 seguía vigente
tal cual, y el re-escaneo completo de archivos se evitó por no aportar nada verificable
nuevo (evitar trabajo sin evidencia que lo justifique, mismo principio que rige el resto
del assessment).

## 5. Qué NO se hizo en G6 (alcance explícito)

- No se materializó ninguna capacidad nueva en el Registry — el único candidato con
  evidencia reforzada (`spec-driven-development` nivel Full) ya estaba materializado como
  CAP-004 desde G5.1; solo se corrigió su estado de evidencia, no se creó nada.
- No se resolvió ninguna Blocked Decision — siguen las 12 de
  `governance/BLOCKED-DECISIONS.md`, sin cambios.
- No se completó `PILOT-003` — sigue `EN CURSO`, con 4 de 7 preguntas de feedback
  pendientes de respuesta literal del developer real.
- No se inventó cobertura de SDLC para ninguna etapa sin evidencia (Testing/QA completo,
  Pull Request, Incident Management, Idea/Discovery/Business Analysis/Documentation/
  Knowledge Management/Continuous Improvement siguen `NOT FOUND`/`REQUIRES VALIDATION`).

## 6. Estado final

**CORE DOCUMENT: FULLY ALIGNED** — cada punto verificable del documento rector tiene hoy
un artefacto real y actualizado en `MOA-AI-Engineering`, o está honestamente marcado sin
evidencia donde corresponde. Esto no cambia el estado general del Track 1
(`READY WITH CONDITIONS`, sin adopción independiente medida, 12 Blocked Decisions
abiertas) — es una condición distinta y ya satisfecha: que el repositorio **dice la
verdad** sobre lo que el CORE pide, en cada punto.

**Próximo paso real, no documental**: cerrar `PILOT-003` con el developer real (las 4
preguntas de feedback pendientes), y escalar Blocked Decision #1 — ninguno de los dos se
resuelve agregando más documentación.
