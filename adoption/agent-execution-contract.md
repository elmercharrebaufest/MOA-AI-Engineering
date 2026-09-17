# Agent Execution Contract

**Para quién es**: el agente de IA (Copilot, Claude, u otro) que ejecuta una capability
de `MOA-AI-Engineering` en nombre de una persona, sobre una tarea real de su SDLC. **No es
una guía de exploración del modelo** — para eso está [`getting-started.md`](getting-started.md).
Este documento es corto a propósito: es lo único que un agente necesita leer para ejecutar
una tarea de forma correcta, rápida y sin ruido.

## El principio — no es una lista de casos, es un límite ya existente en el modelo

`MOA-AI-Engineering` ya distingue **Team Adaptation** (lo que un equipo/persona hace en su
propio contexto) de **Common Core** (lo compartido — Registry, Golden Paths, capability
model — que solo cambia por revisión deliberada, el Assessment Gate, ver
[`../architecture/operating-model.md`](../architecture/operating-model.md)). **Ejecutar
una tarea real para una persona es Team Adaptation, punto** — nunca Common Core. El
límite no es una regla nueva inventada para este documento: es el mismo límite que ya
gobierna todo el modelo, aplicado a lo que hace un agente en cada ejecución.

**Del KO** (documento rector del Track 1,
[`../TRACK-1/BAUFEST_Escalando_el_Valor_del_Delivery_Mediante_IA_Aplicada.md`](../TRACK-1/BAUFEST_Escalando_el_Valor_del_Delivery_Mediante_IA_Aplicada.md)):
*"No se trata de sumar herramientas, sino de convertir el uso de IA en una práctica
sostenida de ingeniería."* Una práctica de ingeniería madura es predecible, acotada y
silenciosa sobre su propio funcionamiento interno — no una herramienta que narra su
proceso a quien solo quiere un resultado. Esto es lo mismo que ya rige, en la misma
sección del KO, el enfoque human-in-the-loop: *"validación y corrección humana estricta
antes de integrar cualquier salida"* — la persona valida **su** resultado, no la
mecánica del modelo.

**De prácticas de SDLC maduro, ya aplicadas en otros mecanismos de este repositorio**:

- **Least privilege / least context** — el mismo principio que ya rige el scope de MCP
  ([`../security/security-governance.md`](../security/security-governance.md) §1.5): un
  agente lee y escribe solo lo mínimo necesario para su tarea, nunca "por si acaso".
  Aplicado a contexto en vez de a permisos de sistema, pero es el mismo principio.
  Confirmado con evidencia real: 3 hallazgos independientes con developers distintos —
  leer archivos ajenos a la tarea, comentar sobre tareas ajenas, y escribir en archivos
  compartidos del Registry — eran ese mismo antipatrón (over-broad context) en 3 formas
  distintas.
- **Promoción controlada, no escritura directa a lo compartido** — el mismo patrón de un
  PR que no hace merge directo a `main`: una ejecución individual es una rama de trabajo,
  el Registry es la rama principal, y solo se actualiza por una revisión deliberada
  (ver [`../architecture/lifecycle.md`](../architecture/lifecycle.md), regla dura #1 —
  ninguna capacidad ni su estado saltan etapas).
- **Separación de audiencias** — este mismo documento existe separado de
  `getting-started.md` por la misma razón que un runbook operativo se separa de un
  documento de arquitectura: quien ejecuta una tarea puntual y quien diseña/mantiene el
  sistema necesitan información distinta, y mezclarlas degrada la experiencia de ambos.

## El contrato, en 5 reglas

1. **Leé solo**: la capability que vas a usar (`capabilities/<tipo>/<nombre>/`) y, si
   existe, `records/<fuente>-<tu-tarea>/` (para no duplicar una ejecución ya hecha sobre
   la misma tarea — esto sigue siendo correcto, no lo elimines). Nada más, salvo que la
   persona te lo pida explícitamente.
2. **Escribí solo**: dentro de `records/<fuente>-<tu-tarea>/<EXEC-ID>/`
   (`evidence.md`/`evaluation.md`/`measurement.md`, usando
   [`templates/`](templates/)). Nunca `registry/`, `golden-paths/`, `capabilities/`,
   ni ningún otro archivo compartido del Common Core.
3. **Mostrale a la persona solo el resultado de su tarea** — ninguna acción de
   mantenimiento del modelo (la hayas hecho, considerado, o descartado) se narra en tu
   respuesta. Si dudás si algo es "interno del modelo" o "parte del resultado de la
   persona", es interno. Esto incluye, explícitamente, cualquier comando de
   housekeeping que corras para vos mismo antes de entregar el resultado —
   `git branch`/`git status`/`git diff --check`, cualquier paso de validación del propio
   editor/herramienta ("Checked X, no problems found"), verificar que solo tocaste tus
   propios archivos, decidir el nombre del próximo `EXEC-ID`, "voy a crear X con Y y
   después Z" — nada de eso es el resultado de la persona, es el equivalente a mostrarle
   los logs internos de un pipeline de CI en vez del changelog de la release: **es el
   mismo patrón de separación de audiencias ya citado más arriba**, aplicado a comandos,
   no solo a archivos.

   **Lo que sí es del resultado y no debe omitirse** (confirmado con feedback real —
   sacarlo por error rompe la regla tanto como mostrar de más): la historia de usuario,
   los gaps, la recomendación, y **la ruta completa y real del archivo donde quedó
   guardada la ejecución** (`records/<fuente>-<tarea>/<EXEC-ID>/evidence.md`, no solo el
   nombre `evidence.md` suelto) — la persona necesita esa ruta para poder abrir,
   compartir o auditar su propio resultado sin tener que pedirla. La distinción no es
   "mostrar menos", es "mostrar el destino, nunca el camino para llegar ahí".
4. **Si detectás algo real que el modelo debería corregir** (un gap, una inconsistencia,
   un archivo roto) — **no lo actúes ni lo reportes en la conversación de la tarea**.
   Es información para quien mantiene `MOA-AI-Engineering` vía
   [`contribution-guide.md`](contribution-guide.md), en un canal separado — no para la
   persona que solo quiere avanzar con su ticket.
5. **Respondé en el idioma en el que te escribe la persona, y hacelo correctamente.**
   Este proyecto y su comunidad de uso son de habla hispana — no cambies a inglés salvo
   que te lo pidan en inglés. Esto también es parte de "mostrale a la persona solo lo que
   le sirve" (regla 3): una respuesta en un idioma que la persona no pidió es fricción,
   no ayuda. **Incluye escribir español real, con tildes y demás signos** (`gestión`, no
   `gestion`; `Jesús`, no `Jesus`; `¿Qué...?`, no `Que...?`) — un archivo sin acentos no
   es un error menor de estilo, es el mismo tipo de defecto que un linter marcaría en
   cualquier otro artefacto de este repositorio.

## Si te dan solo una referencia de tarea, sin más indicación

**Comportamiento por defecto: actuá, no preguntes primero.** Si la persona te da
únicamente una referencia (`ARMOA277-XXX`, `MOA-XXXX`) sin decir qué necesita, y no hay
ninguna ejecución previa de esa misma tarea —**traé el detalle vía el Context Provider
correspondiente y aplicá CAP-002 (`user-story`) directamente**, sin preguntar antes "¿qué
querés hacer con esto?". No es una suposición nueva: es el patrón real que ya ocurrió en
las 5 ejecuciones reales anteriores de Connected Context — ninguna preguntó primero, y el
KO describe exactamente este comportamiento (*"Rovo Agent analiza el ticket al momento de
su creación, detecta ambigüedades y genera preguntas para el PO antes del
refinamiento"* — analiza y actúa, genera preguntas **sobre el contenido del ticket**, no
sobre la intención de la persona).

**Cuándo sí preguntar**: si el contenido real del ticket (tipo de issue, título,
descripción) sugiere claramente que CAP-002 no aplica (ej. es un bug de código, una tarea
de infraestructura, algo sin relación con requerimientos) — ahí preguntá qué necesita la
persona, porque la ambigüedad es real, no por precaución genérica. Si la persona
**pide algo distinto explícitamente** ("traeme el detalle nomás", "quiero implementar
código para esto"), seguí lo que pidió, no el default.

## Ejemplos reales que motivaron este contrato (ilustrativos, no la lista completa de casos)

| Qué hizo el agente | Por qué violaba el contrato | Regla que lo cubre |
|---|---|---|
| Abrió y citó `registry/INDEX.md` y ejecuciones de otro ticket | Contexto ajeno a la tarea, mostrado a la persona | Regla 1 y 3 |
| Reportó una carpeta faltante de otra tarea como hallazgo | Auditoría del modelo mostrada en la conversación de una persona | Regla 4 |
| Editó `registry/entries/*.md` para actualizar contadores globales | Escritura en Common Core desde una ejecución individual | Regla 2 |
| Editó `capabilities/skills/user-story/SKILL.md` (contador de ejecuciones) y respondió en inglés a una persona que escribió en español | El agente nunca había leído este contrato — no hay archivo de auto-descubrimiento (`AGENTS.md`) que lo forzara — y ninguna regla cubría el idioma todavía | Regla 2 (ya cubría `capabilities/`, faltaba que el agente la viera) y Regla 5 (nueva) |
| Narró `git branch --show-current`, `git status --short` y `git diff --check` en la conversación, y describió "voy a crear el registro, después voy a validar el diff" como si fuera parte del resultado | Housekeeping interno del agente (verificar que no tocó archivos ajenos, que no hay problemas de whitespace) mostrado como si fuera información para la persona | Regla 3 (aclarada con ejemplos concretos de comandos) |
| En la misma ejecución, dejó de mostrar la ruta del archivo donde quedó guardado el resultado (solo decía "quedó en `evidence.md`", sin la carpeta real), y escribió el archivo entero sin tildes (`gestion`, `Jesus`, `Analisis`) | Sobre-corrección de la regla 3 (se ocultó información que sí es del resultado) + violación nueva de la regla 5 (idioma incorrecto, no solo idioma equivocado) | Regla 3 (aclarada: la ruta del archivo no es housekeeping) y Regla 5 (ampliada a ortografía) |

Cualquier variante nueva que no esté en esta tabla sigue cubierta por las 5 reglas — no
hace falta agregar un caso más para que aplique. Ver [`../AGENTS.md`](../AGENTS.md) para
cómo se garantiza que un agente encuentre este contrato antes de empezar.

## Qué NO cambia

- La capability sigue siendo agnóstica del origen del contexto (Direct/Connected) — este
  contrato no toca esa separación.
- El mecanismo de `records/` task-centric sigue igual — este contrato solo aclara el
  alcance de lectura/escritura sobre él.
- Nada de esto reemplaza el Evidence/Evaluation/Measurement Contract
  ([`../architecture/evidence-evaluation-measurement.md`](../architecture/evidence-evaluation-measurement.md))
  — este documento gobierna el *proceso* del agente, no el *esquema* de los registros.
