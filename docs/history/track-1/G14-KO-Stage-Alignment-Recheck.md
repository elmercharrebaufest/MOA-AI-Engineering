# G14 — Re-chequeo de alineación etapa por etapa contra el KO

**Fase**: G14. **Estado**: FACT donde se cita evidencia directa; PROPOSAL en las
correcciones editoriales. Precondición: G13 (vigencia del documento rector). Disparador:
el usuario pidió, mientras el developer seguía probando, revisar que el trabajo reciente
(Context Acquisition & Resolution operativo, `agent-execution-contract.md`, la
recomendación nueva de CAP-002) siguiera alineado "a cada punto y etapa del KO".

## 1. Qué se revisó

`architecture/ai-sdlc.md` — el artefacto que ya mapea etapas del KO contra capacidades
reales del Registry (creado en G6) — estaba desactualizado desde 2026-09-11: contaba 6
ejecuciones de CAP-002 cuando ya había 7, y describía CAP-007/CAP-008 como "Context
Acquisition" genérico sin reflejar que la validación real de Jira vía Atlassian Rovo MCP
ya había ocurrido.

## 2. Hallazgo de alineación positivo (no solo corrección de conteos)

La recomendación nueva de CAP-002 (sección 5 de `user-story/SKILL.md`, agregada esta
misma sesión) **ya cumple, textualmente, algo que el KO pedía para esta etapa y que
todavía no estaba implementado**: *"Rovo Agent... genera preguntas para el PO antes del
refinamiento"* (etapa "Recepción del requerimiento", KO pág. 23). No es una función
nueva sin respaldo — es cerrar una brecha entre lo que el KO ya pedía y lo que el
Registry todavía no hacía. Se documentó esta conexión explícitamente en
`architecture/ai-sdlc.md`.

## 3. Corrección de vigencia (conteos y IDs, mismo tipo de trabajo que G13)

Se sincronizó el conteo de ejecuciones de CAP-002 (6→7) y de CAP-008 (4→5) en 9 archivos:
`README.md`, `architecture/ai-sdlc.md`, `architecture/capability-registry.md`,
`capabilities/skills/user-story/SKILL.md`, `golden-paths/README.md`, `registry/INDEX.md`,
`registry/entries/jira-context.md`, `registry/entries/user-story.md`,
`strategy/roadmap.md`, `strategy/track-1-context.md`.

**Hallazgo adicional durante la corrección**: el ID de la 7ma ejecución cambió de
`EXEC-20260916-001` a `EXEC-20260917-001` entre que se citó por primera vez en esta
sesión y que se corrigió acá — la carpeta original ya no existía en disco cuando se fue a
verificar. Se corrigieron las 5 referencias rotas resultantes (mismo string, reemplazo
1:1, verificado que el nuevo ID sí existe en disco antes de enlazarlo).

## 4. Hallazgo de proceso, no resuelto — volatilidad de `records/jira-ARMOA277-194/`

Esta carpeta apareció y desapareció **al menos 3 veces** durante esta sesión (una con
`EXEC-20260916-001`, luego ausente, luego con `EXEC-20260917-001`, luego ausente de
nuevo, verificado inmediatamente antes de cerrar esta fase). No hay evidencia de que esto
sea un problema de este repositorio — el patrón coincide con el ya confirmado
explícitamente por el usuario para `ARMOA277-45` (borrado intencional al cerrar la tarea
en Jira). **Queda como `REQUIRES VALIDATION`**: confirmar si es el mismo hábito
intencional aplicado a `ARMOA277-194`, o algo distinto (ej. el developer limpia la carpeta
entre corridas de prueba sucesivas). No se especula más allá de esto ni se intenta
"arreglar" — la carpeta, si existe al momento de leerse, es evidencia real; si no existe,
no se inventa contenido para completarla.

## 5. Qué NO se hizo en G14

- No se tocó `strategy/roadmap.md`/`strategy/maturity-model.md`/`metrics/`/`teams/` más
  allá del conteo puntual ya corregido — se confirmó por grep que el trabajo reciente
  (Context Acquisition, contrato de agente) no los afecta, y ya estaban alineados desde
  G6.
- No se resolvió `PILOT-003` (sigue con 4 de 7 preguntas de feedback pendientes).
- No se agregó cobertura real a ninguna etapa del KO más allá de "Recepción del
  requerimiento" — Planning, Desarrollo, PR, Code Review, Testing/QA, Regresión, Cierre,
  Soporte y Build&CI siguen exactamente en el estado que `ai-sdlc.md` ya declaraba
  (`PROPOSAL`/`NOT FOUND`/`REQUIRES VALIDATION`, según la fila).

## 6. Estado final

El repositorio vuelve a decir la verdad sobre su propio avance en los artefactos que un
lector nuevo (o el Arquitecto Supervisor) consultaría primero. El re-chequeo confirma que
el trabajo reciente está **correctamente acotado a una sola etapa del KO**
(Recepción del requerimiento/Refinamiento) — no se infló cobertura hacia las demás
etapas, y la brecha detectada (`records/jira-ARMOA277-194/` volátil) queda registrada,
no resuelta unilateralmente.
