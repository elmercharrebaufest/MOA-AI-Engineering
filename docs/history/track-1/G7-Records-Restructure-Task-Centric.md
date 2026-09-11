# G7 — Reestructuración de Evidence/Evaluation/Measurement a `records/` por tarea

**Fase**: G7. **Estado**: FACT (migración mecánica, verificada) + EXTERNAL EVIDENCE citada.
Precondición: G6 (CORE alineado). Solo se modificó `MOA-AI-Engineering`. Sin commit al
momento de escribir este documento, a la espera de confirmación del usuario para subir.

## 1. Disparador — feedback real, no una preferencia de diseño

Un developer real (`PILOT-003`, cold-start independiente sobre `ARMOA277-45`) reportó, en
2 interacciones separadas e independientes, la misma fricción: la evidencia de su tarea
estaba repartida entre `evidence/`, `evaluation/` y `measurements/` (3 carpetas paralelas
por tipo de artefacto), obligándolo a cruzar IDs a mano para ver todo lo suyo. Cita literal
de la segunda confirmación: *"me pide registrar bajo un formato de fecha en varias
carpetas... no es mejor que se guarden en directorios individuales por tareas."*

## 2. Las 2 fuentes, aplicadas sin atajos (mismo pipeline que el resto del repo)

- **Internal MOA Evidence**: `moa-sdlc` ya usa `_sdd/specs/<TICKET>-<slug>/` — una carpeta
  por ticket, con todo el contenido de la spec adentro.
- **AI Engineering Expertise / External Practice**, verificado con fuentes reales (no de
  memoria): [GitHub Spec Kit](https://github.com/github/spec-kit/blob/main/spec-driven.md)
  usa exactamente el mismo patrón (`specs/[###-feature]/`) — confirmado que **no** define
  snapshots por versión, confía en `git log` como historial, igual que `moa-sdlc`. La API
  oficial de GitHub Actions (`GET /repos/{owner}/{repo}/actions/runs/{run_id}/artifacts`)
  confirma el patrón complementario que sí necesitábamos: repo → `run_id` → artifacts,
  para el caso de ejecuciones repetibles de la misma unidad de trabajo.
- **Síntesis (MOA Target Pattern, no una copia literal de ninguna de las 2)**: ninguna de
  las 2 fuentes necesita resolver "misma tarea, ejecutada varias veces, cada vez como
  snapshot inmutable comparable" — es un requisito propio del Evidence Contract de este
  repositorio (`architecture/evidence-evaluation-measurement.md`, vigente desde G4.3, sin
  cambios de fondo). La estructura final combina la agrupación por tarea (de ambas
  fuentes) con el anidado por ejecución (de GitHub Actions) — declarado explícitamente
  como criterio propio, no como copia de ninguna fuente.

## 3. Estructura nueva

```
records/<fuente>-<tarea>/<EXEC-ID>/
  evidence.md
  evaluation.md      (si existe)
  measurement.md      (si existe)
```

Ejemplo real: `records/jira-ARMOA277-45/EXEC-20260909-001/`.

## 4. Migración ejecutada

- **19 archivos reales** movidos con `git mv` (preserva historial completo, sin
  pérdida): 7 `evidence/EXEC-*.md`, 6 `evaluation/EXEC-*.md`, 6 `measurements/EXEC-*.md`
  (`EXEC-20260908-002` nunca tuvo evaluation/measurement — quedó `BLOCKED` antes de esa
  etapa, correctamente sin archivos inventados).
- **58 links reales corregidos en 20 archivos** (relativos, recalculados según la
  profundidad real de cada archivo referenciante) + **14 links de salida** corregidos
  dentro de los propios archivos movidos (su profundidad cambió de 1 a 3 niveles) + **7
  links rotos preexistentes**, no causados por esta migración, corregidos de paso
  (2 casos de profundidad mal contada en `PILOT-001`/`PILOT-003`, 3 referencias a
  archivos ya eliminados de `PILOT-002` — de-linkeadas, no recreadas).
- `evidence/README.md`, `evaluation/README.md`, `measurements/README.md` reescritos como
  **índices cruzados por tipo** (no eliminados) — apuntan a `records/`, documentan la
  convención nueva.
- `architecture/evidence-evaluation-measurement.md` actualizado (nueva sección "§5. Dónde
  viven los registros") con la convención y su justificación.
- **Auditoría final de integridad** (mismo método que G5.1): 608 links relativos
  verificados, **0 rotos**.

## 5. Qué NO cambió

- El schema de los 3 contratos (Evidence/Evaluation/Measurement) — 0 campos agregados,
  removidos o redefinidos. Es una reubicación física, no un rediseño del contrato.
- El contenido de ninguna de las 19 ejecuciones reales — solo ubicación y, en 4 casos,
  los links de cruce entre ejecuciones (que apuntaban a un archivo "hermano" que dejó de
  serlo al mudarse cada uno a su propia carpeta de tarea).
- La independencia lógica entre Evaluation y Measurement (ambos siguen siendo consumidores
  independientes de la misma Evidence, no pasos secuenciales) — separados como archivos
  distintos dentro de la misma carpeta de ejecución, no fusionados.

## 6. Estado final

**Records restructure: COMPLETE, 0 broken links.** Pendiente: confirmación del usuario
para subir este cambio a `origin/main` (mismo criterio que el resto de la sesión — el
usuario autoriza el push explícitamente cada vez).
