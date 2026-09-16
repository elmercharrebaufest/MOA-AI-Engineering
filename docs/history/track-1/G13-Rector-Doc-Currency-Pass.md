# G13 — Corrección de vigencia del documento rector y del Registry

**Fase**: G13. **Estado**: FACT donde se cita evidencia directa; PROPOSAL en las
correcciones editoriales. Precondición: G6 CORE DOCUMENT FULLY ALIGNED. Solo se modificó
`MOA-AI-Engineering`. Disparador: revisión solicitada explícitamente por el usuario antes
de pedir una nueva prueba a un developer real, en paralelo con la continuación de
`PILOT-003`.

## 1. Origen y disparador

El usuario subió `TRACK-1/BAUFEST - Escalando el Valor del Delivery Mediante IA
Aplicada.txt` (extracción plana del KO, ya existente como `.md` estructurado desde G6) y
pidió una revisión del proyecto de adopción antes de solicitar una nueva prueba al
developer. La revisión encontró que `strategy/track-1-context.md` — el documento rector
— y `registry/INDEX.md` habían quedado **un paso atrás de su propia evidencia real**:
secciones enteras seguían citando conteos de antes de la validación real de Jira vía
Atlassian Rovo MCP y de `PILOT-003` (la primera adopción independiente real), aunque esos
eventos ya estaban completamente documentados en otros archivos del propio repositorio
(`registry/entries/user-story.md`, `registry/entries/jira-context.md`,
`evidence/README.md`, `golden-paths/README.md` secciones intermedias).

## 2. Por qué esto no lo agarró G6

G6 auditó el documento rector contra 9 puntos verificables del CORE (KO) — no contra la
consistencia interna del propio `track-1-context.md` ni contra `registry/INDEX.md`. Ambos
documentos habían sido editados en distintos momentos por distintas fases (G7 en
adelante), y algunas secciones se actualizaron mientras otras, con la misma información,
no.

## 3. Inconsistencias encontradas y corregidas

| Archivo | Qué decía (stale) | Qué dice ahora |
|---|---|---|
| `strategy/track-1-context.md` §12 | "6 entradas reales pobladas", "aplicados 2 veces" | 8 entradas; 6 ejecuciones reales (2 Direct + 4 Connected) |
| `strategy/track-1-context.md` §13 | "ningún MCP tiene evidencia de invocación real" (ambiguo respecto a la validación posterior) | Aclarado: el hallazgo es sobre configuraciones de equipo, no contradice la validación real de `MOA-AI-Engineering` vía Atlassian Rovo MCP hosted |
| `strategy/track-1-context.md` §15 | "6 capacidades materializadas... no Corporate Standard" | 8 capacidades del Registry; distinción explícita `capabilities/` (6) vs. `integrations/` (CAP-007/008) |
| `strategy/track-1-context.md` §17 | "2 ejecuciones", "adopción independiente: ninguna" | 6 ejecuciones; adopción independiente **parcial** (actor sí, evaluación no) — `PILOT-003` citado con su estado real `EN CURSO` |
| `strategy/track-1-context.md` §18-19 | "ninguna contribución real todavía", criterio de Golden Path independiente sin matizar | Reconocen el feedback real de `PILOT-003` y marcan el criterio como parcialmente satisfecho, no cerrado |
| `registry/INDEX.md` | Fila resumen de CAP-002 (5 ejecuciones) y CAP-008 (3 ejecuciones) desincronizadas de sus propias entradas (`entries/user-story.md`, `entries/jira-context.md`, que ya decían 6 y 4) | Sincronizadas: 6 y 4 respectivamente, con la nota de actor independiente |
| `golden-paths/README.md` | El resumen superior y la tabla "Evidence/Evaluation/Measurement/Feedback/Contribution" de Golden Path #1 seguían en "2 ejecuciones", con links rotos a rutas `evidence/EXEC-*.md` eliminadas por la restructuración a `records/` | Actualizada a 6 ejecuciones; Feedback/Contribution reflejan `PILOT-003`; links corregidos a `records/<tarea>/<EXEC-ID>/` |
| `capabilities/README.md`, `adoption/context-providers-quickstart.md`, `integrations/catalog.md`, `architecture/capability-registry.md`, `README.md` (raíz) | Contaban 2 ejecuciones MCP (`EXEC-20260908-004/005`) sin `EXEC-20260909-001` | Corregidas a 3 (o 6 para CAP-002 en `README.md`), con la nota de actor independiente donde aplica |

## 4. Qué NO se hizo en G13 (alcance explícito)

- No se cerró `PILOT-003` — sigue `EN CURSO`, con 4 de 7 preguntas de feedback pendientes.
  El usuario va a pedirle directamente al developer las respuestas restantes, en paralelo
  a esta corrección.
- No se aprobó ni rechazó ninguna de las 10 decisiones de
  `benchmark-to-target-model-decision-input.md` — sigue REQUIRES VALIDATION.
- No se resolvió ninguna Blocked Decision.
- No se materializó ninguna capacidad nueva ni se modificó el contenido de ningún
  contrato — esta fase es puramente de **vigencia/consistencia** de conteos y links ya
  documentados en otro lugar del repositorio, no una fase de diseño.

## 5. Estado final

**Documento rector y Registry: al día con su propia evidencia real**, al 2026-09-16. El
estado general del Track 1 no cambia (`READY WITH CONDITIONS`, `PILOT-003 EN CURSO`, 12
Blocked Decisions abiertas) — lo que cambia es que el repositorio ya no subestima su propio
avance real en los documentos que un lector nuevo consultaría primero.
