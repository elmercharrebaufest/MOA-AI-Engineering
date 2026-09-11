# PILOT-003 — Cold-start independiente real sobre ARMOA277-45 (Portal de Créditos)

**Estado: EN CURSO — primer piloto con actor real e independiente (no simulado).**

## Por qué este piloto es distinto de PILOT-001 y PILOT-002

PILOT-001 y PILOT-002 se cerraron sin ejecutar (`../PILOT-001-moa-operaciones-cap005/README.md`,
`../PILOT-002-aws-portal-creditos-ARMOA277-44/README.md`) — estaban diseñados para un
developer real que nunca llegó a completarlos. Este piloto es la primera vez que existe
un actor real, en una sesión de chat separada de esta (sin el historial de diseño de
`MOA-AI-Engineering`), recibiendo únicamente un código de tarea de Jira como input —
exactamente el escenario cold-start que Track 1 necesitaba (`strategy/track-1-context.md`
§19: adopción independiente, actor distinto de quien construyó la capacidad).

**Coordinación**: el usuario relaya prints/texto literal de esa sesión. Esta sesión
(la que arma este registro) no instruye al developer qué hacer — solo documenta lo que
ya ocurrió, sin resumir ni completar en su nombre.

## Secuencia real observada (verificada contra hechos del repo, no solo el print)

1. Input real, literal: solo el código `ARMOA277-45` — sin mención de `MOA-AI-Engineering`
   ni de capabilities.
2. El asistente de esa sesión resolvió el issue real vía Jira (Xray Test Case, no historia
   origen) y **espontáneamente** sugirió "Connected Context capabilities (CAP-002/CAP-008)"
   sin que el input lo pidiera.
3. El developer preguntó "¿debo leer el README?" antes de decidir — punto de fricción real,
   no una decisión autónoma inmediata (ver `feedback-record.md`).
4. El developer eligió `CAP-002`. El asistente aplicó CAP-002 (`user-story`) reconstruyendo
   la historia de usuario hacia atrás desde un caso de prueba (comportamiento correcto:
   CAP-002 no asume que el issue ya es una historia).
5. Salida real generada: historia de usuario + criterios de aceptación + reglas de negocio
   + **análisis de gaps con 3 preguntas explícitas** (comportamiento sin datos, timeout de
   integración SAP, rol no declarado) — consistente con la disciplina de
   `FACT/INFERENCE/REQUIRES VALIDATION` del propio repo, sin que el input se lo pidiera.
6. El asistente propuso registrar esto como una nueva ejecución real (`EXEC-YYYYMMDD-NNN`)
   siguiendo el patrón de las 5 ejecuciones previas de CAP-002 — **verificado, no
   inventado**: hoy existen exactamente 5 (`evidence/README.md`,
   `registry/entries/user-story.md`).

## Qué falta para cerrar este piloto

1. Confirmación del developer/usuario de que efectivamente reguistra la ejecución
   `EXEC-YYYYMMDD-NNN` en `evidence/`, `evaluation/` y `measurements/` **desde esa misma
   sesión** — si se hace desde acá, deja de ser evidencia independiente.
2. Completar `feedback-record.md` con el resto de la interacción real, literal, incluyendo
   si el developer terminó usando el resultado o no.
3. Con eso, actualizar `registry/entries/user-story.md` (pasaría a 6 ejecuciones, la
   primera con actor verdaderamente independiente) — requiere confirmar que el `EXEC-*`
   ya existe como archivo real antes de tocar el Registry.

## Mejora aplicada a partir del feedback (2026-09-09)

El punto de fricción #2 (`feedback-record.md`: "está todo mezclado... quiero toda la
información de mi tarea en un directorio bien distribuido") se tradujo en una corrección
concreta al modelo, **no solo un finding documentado**: [`../../../../adoption/getting-started.md`](../../../../../adoption/getting-started.md)
ahora deja explícito (pasos 4 y 7) que (a) la tabla de Evidence/Evaluation/Measurement de
una entrada del Registry es historial acumulado del modelo, no lectura obligatoria para
ejecutar una tarea, y (b) la evidencia de cada developer vive en un único archivo
`EXEC-<fecha>-<n>.md` propio de su ticket, sin necesidad de abrir los de otros
tickets/equipos. Esto se aplicó **antes** de pedirle al developer que repita el ejercicio
de cero, precisamente para no mezclar el trabajo de corrección del modelo con la
ejecución de su próxima actividad real.
