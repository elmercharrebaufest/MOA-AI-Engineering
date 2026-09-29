# Changelog

## [0.7.4] — 2026-09-28

**Corregido** (análisis comparativo capacidad por capacidad — bug real encontrado en
`test-validator`)
- `test-validator` (CAP-025): el `handoffs` declaraba `agent: agent`, un nombre que no
  corresponde a ningún Agent real del Registry — quedó como placeholder sin completar. El
  paso siguiente real ("Preparar cierre") es la skill `ticket-closure-assist` (CAP-016), y
  un traspaso de VS Code solo puede apuntar a un Agent, nunca a una Skill. Se quitó el
  `handoffs` inválido; el cierre ahora indica el paso siguiente en lenguaje natural.

**Verificado sin cambios** (análisis comparativo contra evidencia real, sin brecha
encontrada): `pr-description`, `test-case-generation`, `regression-test-generation`,
`ticket-closure-assist`, `ticket-update`, `test-pipeline-setup`, `documentation-style`.

## [0.7.3] — 2026-09-28

**Corregido** (evidencia real de piloto: el developer vio los botones de traspaso
"Revisar el código"/"Generar pruebas" ya visibles mientras el plan todavía esperaba
aprobación, antes de que existiera código implementado)
- `ticket-kickoff`, paso 4: cierra siempre aclarando explícitamente que esos botones
  (pensados para el paso 8, después de implementar) todavía no aplican en ese punto.
  Verificado contra documentación oficial de VS Code: los botones de `handoffs` se
  muestran después de cada respuesta del agente, sin condicionarse al paso interno en el
  que esté — es la única capacidad del Registry con 2 traspasos pensados para 2 momentos
  distintos de la misma conversación.

## [0.7.2] — 2026-09-28

**Corregido** (análisis comparativo directo contra el archivo real de Camuzzi, no solo
contra su nombre y propósito general)
- `spec-review` (CAP-007): se agregaron 2 checks reales que faltaban y sí aplican a
  nuestro formato — contexto de negocio insuficiente en `requirements.md`, y dependencia
  entre tareas de `tasks.md` que referencia una tarea inexistente. No se copiaron los
  checks atados a secciones fijas de la estructura de Camuzzi que nuestro formato
  (EARS, generalizado de DataAgro) no exige.

## [0.7.1] — 2026-09-28

**Agregado**
- `ticket-kickoff` persiste el plan aprobado en `.ticket-kickoff-plan.md`, dentro del
  worktree que prepara `git-worktree-setup` — memoria de trabajo local, nunca comiteada
  (excluida vía `.git/info/exclude`, el mismo mecanismo que ya excluye `.worktrees/`), para
  poder retomar una sesión larga sin depender de que la persona la redescriba. Decisión
  verificada contra 4 fuentes reales (moa-sdlc, GitHub Spec Kit, Camuzzi, y el propio
  incidente de sesión larga ya documentado) — se eligió el extremo más conservador (nunca
  comitear), coincidente con moa-sdlc y GitHub Spec Kit.

## [0.7.0] — 2026-09-28

**Agregado**
- Nueva capacidad **`release-manager`** (CAP-027, Agent): consolida los cambios reales de
  una release completa (no un ticket) — trae los PRs/commits reales, detecta cambios de
  base de datos como riesgo a revisar, clasifica cada cambio y redacta el borrador del
  `CHANGELOG.md` y de las release notes para el PO. Nunca hace push, tag ni dispara un
  pipeline sin confirmación explícita. Generalizado a partir de 2 instancias reales
  independientes (DataAgro y Scato Logística), sin copiar contenido de ningún equipo.
- `adoption/how-to-use.md`: nueva sección "Qué agente elegir, según la etapa" — los 10
  agentes del modelo explicados en lenguaje natural, agrupados por Planning, Desarrollo,
  Testing, Cierre/release y Soporte.

**Corregido**
- `ticket-kickoff` y `spec-driven-development` (Implementer): nueva salvaguarda explícita
  — nunca ejecutar una migración de base de datos destructiva sin mostrar el script real
  y esperar confirmación explícita puntual, aunque el plan general ya esté aprobado.
  Evidencia externa real (agent `database-migration` de Scato Logística).

## [0.6.11] — 2026-09-28

**Corregido** (siguió una duda real del piloto sobre cómo `ticket-kickoff` recuerda las
preguntas abiertas de un requerimiento pegado a mano, sin ticket)
- `ticket-kickoff`, paso 1: la delegación a `product-owner` y el chequeo de supuestos o
  preguntas "❓ Bloqueante" sin confirmar ahora aplican igual si el contenido viene de un
  ticket real o de texto pegado en la misma conversación — antes solo estaban escritos en
  términos de leer un ticket de Jira/Azure DevOps.
- `product-owner`, "Cuándo usarlo"/"Cuándo NO usarlo": se aclara que como agente de nivel
  superior corresponde a un PO/analista funcional (que nunca debe tener permiso de editar
  código), o a un developer que prefiere una pasada de refinamiento aislada — no es un
  paso obligatorio antes de `ticket-kickoff` para todo developer con una tarea nueva, ya
  que `ticket-kickoff` ya lo invoca por detrás, en la misma conversación, cuando hace falta.
- `adoption/how-to-use.md`: aclara el punto de entrada según el rol — un developer con una
  tarea (ticket o pegada) puede empezar directo por `ticket-kickoff`.
- Corregido además un arrastre de la versión anterior: `com.github.copilot/agents/product-owner.agent.md`
  todavía tenía el texto viejo "Pasar a desarrollo" en el paso 7, sin actualizar al nombre
  vigente desde 0.6.10.

## [0.6.10] — 2026-09-28

**Corregido** (pregunta real del piloto: el developer entendió que el botón
"Pasar a desarrollo" iba a implementar directamente, sin ver antes qué se va a cambiar ni
qué pasa con las preguntas abiertas que no había respondido)
- El botón de traspaso `product-owner` → `ticket-kickoff` se renombra a **"Armar el plan
  de desarrollo"**: el nombre anterior sonaba a que ya se iba a codificar. Cambiado en el
  frontmatter `handoffs` (fuente y copia de Copilot) y en toda mención de prosa
  (`product-owner`, `user-story`, `golden-paths/README.md`, `adoption/how-to-use.md`).

## [0.6.9] — 2026-09-28

**Corregido** (pregunta real del piloto: el developer no tenía claro si el botón "Pasar a
desarrollo" implementa directamente, sin ver antes qué se va a modificar)
- El cierre de `user-story` dice ahora explícito, en el mismo lugar donde aparece el
  botón: pasar a `ticket-kickoff` no implementa nada — primero investiga el código y
  presenta un plan técnico para revisar, y solo con esa segunda aprobación explícita
  empieza a escribir código.

## [0.6.8] — 2026-09-28

**Corregido** (pregunta real del piloto: con 2 historias en la misma respuesta, el botón
"Pasar a desarrollo" pre-carga un texto genérico — "la historia de arriba" — ambiguo
sobre cuál implementar)
- El texto fijo del traspaso `product-owner` → `ticket-kickoff` ahora pide aclarar cuál
  historia corresponde cuando hay más de una, en vez de asumir "la de arriba".
- El cierre ✂️ de `user-story` lo dice explícito: el botón trae el texto para revisar y
  completar antes de enviar, no para enviarlo tal cual cuando hay 2 historias.

## [0.6.7] — 2026-09-28

**Corregido** (pregunta real: "¿estos 5 son todos los agentes?")
- `adoption/how-to-use.md` aclara que los 5 roles del flujo principal de desarrollo no
  son todos los agentes del modelo — enlaza a cada uno su "Cuándo usarlo / Cuándo NO
  usarlo" real, y explica dónde están los otros 4 (2 se delegan automáticamente, 1 es
  otro flujo, 1 es opcional).

## [0.6.6] — 2026-09-28

**Corregido** (incidente real de piloto: un pedido de "implementar", escrito en la misma
conversación donde se venía refinando, terminó editando código real y corriendo builds
sin plan ni aprobación — verificado contra la documentación oficial de VS Code y contra
el video real de un cliente de Baufest con SDLC-IA maduro)
- La causa no era el modelo, era `adoption/how-to-use.md`: decía "elegir un agente... o
  usar el modo Agent" y "no hace falta nombrarlas" como si fueran equivalentes. Corregido:
  el modo genérico Agent no tiene ninguna restricción ni checkpoint de este modelo; para
  refinar o implementar hay que elegir el agente explícito en el selector.
- `user-story` agrega un límite duro, sin importar qué herramientas estén disponibles en
  la sesión: nunca escribir ni ejecutar código bajo ningún pedido ("implementar", "dale",
  cualquier sinónimo de aprobación) — el trabajo de la skill termina en producir la
  historia.
- Los 3 cierres de `user-story` (✅/🟡, ✂️, ⛔) pasan de una frase pasiva ("corresponde
  pedirle al asistente que...") a la acción concreta: abrir una conversación nueva con
  `ticket-kickoff` seleccionado, nunca escribir "implementar" en la conversación de
  refinamiento.
- Ni `ticket-kickoff` ni `product-owner` cambian: el video confirma que el patrón ya
  diseñado (plan → aprobación → implementación, dentro del mismo agente) es el correcto.

## [0.6.5] — 2026-09-28

**Agregado** (una ejecución real de refinamiento no encontró un traspaso entre módulos que
otra ejecución anterior sí había encontrado — variabilidad esperada, no un error a
corregir en el refinamiento; el diseño ya reserva el mapeo completo de impacto para
Planning, y ahí no tenía todavía una técnica explícita)
- `ticket-kickoff` (paso 2) suma un mapeo de impacto completo: buscar todos los usos o
  referencias de la entidad, campo o pantalla que la historia modifica, no solo lo que el
  pedido nombra, para encontrar consumidores que el refinamiento no vio (otras pantallas,
  traspasos, reportes, integraciones). A diferencia del refinamiento, en esta etapa sí
  corresponde una búsqueda amplia — es el mapeo que el KO le asigna a Planning
  ("sugerir dependencias/componentes afectados"), y no hay una etapa siguiente que lo
  compense si se omite acá.

## [0.6.4] — 2026-09-28

**Agregado** (pregunta real del piloto: cómo se crea el ticket de un requerimiento
manual, sin ninguno de origen)
- `ticket-update`/`product-owner` distinguen "crear el primer ticket" (el pedido llegó
  pegado, no desde un ticket existente) del resto de las operaciones, que asumían una
  descripción para reemplazar, un reporter a quien comentar o un ticket original al cual
  vincular — ninguno de los 3 existe todavía en este caso. Antes de crear, preguntan el
  sitio de Jira, el proyecto y el tipo de ticket: ninguno se infiere, porque crear en el
  lugar equivocado no se puede deshacer sin intervención manual.

## [0.6.3] — 2026-09-28

**Agregado** (pregunta real del piloto: qué pasa si se crea el ticket sin responder las
preguntas bloqueantes)
- `ticket-kickoff` define qué cuenta como "el ticket necesita refinarse": una pregunta
  marcada "❓ Bloqueante" sin respuesta posterior del responsable. En ese caso, no arma el
  plan sobre esa parte — la informa y espera la respuesta, o delega a `product-owner`.

## [0.6.2] — 2026-09-28

**Cambiado** (2 ejecuciones reales confirmaron la misma causa: un proceso relacionado con
la pantalla del pedido — antes solo se cubría exportación/reporte — vive en un archivo con
otro nombre, que la búsqueda por ruta de la pantalla no encuentra)
- `user-story` generaliza la verificación de procesos relacionados (exportación, reporte,
  **traspaso automático entre pantallas, integración**) a cualquiera con nombre distinto al
  de la pantalla — se ubican buscando el texto de negocio que la pantalla muestra dentro
  del backend u otros módulos, no una palabra genérica del dominio. Si esa búsqueda no
  encuentra nada, no se sigue ampliando: se declara como impacto a confirmar en Planning.

## [0.6.1] — 2026-09-28

**Agregado** (2 ejecuciones reales del mismo requerimiento mostraron el mismo patrón:
una pantalla con una versión de exportación/reporte nombrada distinto, cubierta en una
corrida y perdida en la otra, y viceversa)
- `user-story` verifica también la versión de exportación o reporte (PDF, Excel, email)
  de la pantalla que el pedido nombra, ubicándola por el concepto de negocio — no asume
  que comparte carpeta ni nombre con la pantalla.
- El cierre de la historia exige confirmar los supuestos uno por uno, no darlos por
  aceptados al aprobar la historia en general.
- `ticket-kickoff` trata los supuestos sin confirmación posterior del PO como duda
  pendiente para el plan, nunca como hecho ya validado.

## [0.6.0] — 2026-09-28

**Agregado** (evidencia externa real de Camuzzi — `spec-writer`, paso 3, "Clarificar
ambigüedades ANTES de escribir")
- `user-story`/`product-owner` se detienen a preguntar, en una ronda corta (2 a 4 preguntas
  cerradas, con opciones y recomendación), antes de redactar cualquier parte de la
  historia, cuando ninguno de los 3 datos base (objetivo, a quién afecta, cómo se sabe que
  está resuelto) surge del pedido — en vez de redactar siempre una historia completa
  alrededor de supuestos. Si la persona prefiere no responder ("decidí vos"), se propone la
  opción más razonable como supuesto y recién ahí se redacta.

## [0.5.9] — 2026-09-28

**Cambiado** (generalización, no ligada a un caso puntual — el modelo sirve a múltiples
equipos con tareas de forma y adjuntos distintos)
- `user-story` ubica lo que verifica con una escalera de especificidad: usar lo que el
  pedido ya da directo, ubicar por ruta cuando nombra una pantalla, buscar por el término
  más distintivo cuando el pedido es genérico (sin pantalla puntual), y solo al final una
  búsqueda de contenido acotada — nunca el repositorio completo.
- Agrega una regla de intake: el pedido puede llegar como imagen, PDF, Word, texto plano o
  ticket con adjuntos; se extraen los hechos con la misma disciplina que del código (cita
  de origen, sin inventar); si un adjunto no se puede leer, se pregunta en vez de suponer.

## [0.5.8] — 2026-09-28

**Corregido** (con una ejecución real de `user-story` en VS Code)
- `user-story` ubica lo que el pedido nombra por **ruta de archivo o carpeta** (nombre de
  la pantalla convertido a la convención del repo), no por búsqueda de texto en el código:
  una búsqueda de contenido por una palabra común del dominio devuelve cientos de
  resultados en cualquier repo real, mientras que la ruta encuentra los archivos exactos
  en un paso. Solo si ninguna ruta coincide, cae a una búsqueda de contenido acotada a la
  carpeta más probable.
- Prohíbe explícitamente buscar el rol en archivos de convenciones de stack (`skills.md`,
  guías de buenas prácticas) — no tienen roles de negocio; la ejecución real lo había
  intentado ahí sin éxito.

## [0.5.7] — 2026-09-28

**Corregido**
- El quickstart de instalación transcribía el mensaje de error real de PowerShell al
  ejecutarse en el Símbolo del sistema — reemplazado por la instrucción simple de usar
  Windows PowerShell.
- Varias capacidades y entradas del Registry narraban su propia corrección ("Corregido
  (0.5.5)", fechas y números de versión dentro de la prosa) en vez de describir solo el
  estado correcto actual — limpiado en `user-story`, `ticket-kickoff`,
  `ticket-closure-assist`, `production-incident-investigation`,
  `regression-test-generation`, `test-validator`, `repository-governance`,
  `azure-devops-cli`, `test-case-generation`.
- `documentation-style` (CAP-022) agrega la regla explícita: la documentación describe el
  estado correcto, no su propio historial de correcciones; ningún mensaje de error real
  queda como contenido permanente.

## [0.5.6] — 2026-09-28

**Corregido** (auditoría real de las 26 capacidades del Registry contra sus precedentes
reales de MOA/Camuzzi y contra el KO — 3 auditorías independientes, sin especular)
- `repository-governance` (CAP-006): el Registry afirmaba convergencia independiente de la
  matriz ALWAYS/ASK FIRST/NEVER en 3 repos; verificado archivo por archivo, solo está en
  DataAgro. Corregido `Origin`, `Configuration Status`, `Adopters` y la clasificación.
- `test-validator` (CAP-025): citaba una regla de DataAgro sobre tests que no existe en su
  repo real (verificado archivo por archivo). Retirada la cita.
- `azure-devops-cli` (CAP-008): la generalización había perdido los 455 líneas de sintaxis
  `az` verificada que comparten Scato Logística y Orquestador — recuperadas completas
  (`references/pipelines-and-builds.md`, `references/variables-and-agents.md`), ya
  genéricas, sin datos de ninguna organización real.
- `read-only-code-reviewer` (CAP-012): agrega la nota positiva obligatoria que exigen los 2
  precedentes reales (Scato Logística, Orquestador) y que la generalización había perdido.
- `spec-driven-development` (CAP-005): el patrón de 2 Pull Requests por ticket (spec +
  implementación) pasa al nivel Lite — ya es práctica real de DataAgro, no exclusiva del
  nivel Full.
- `ticket-kickoff` (CAP-010): matiza la cita de la guía de Anthropic sobre contexto limpio
  (su footprint de Jira es menor al de Camuzzi, no una desviación); documenta como brecha
  explícita en el Registry la falta de una capacidad que actualice specs impactadas.
- `production-incident-investigation` (CAP-017): retira la cita a una skill que se
  autoidentifica como de otro proyecto ("MAE"), no de Camuzzi.
- `regression-test-generation` y `ticket-closure-assist`: declaran con precisión qué se
  adoptó literal de Camuzzi (fórmula de ROI, umbrales de horas), en vez de presentarlo como
  criterio de industria genérico.
- 2 citas del KO en el Registry (`test-case-generation`, `ticket-closure-assist`) que
  aparecían entre comillas como texto textual eran en realidad paráfrasis — corregidas a
  la cita real.
- `git-worktree-setup`: agrega el fallback ante fallo de escritura en `.git/info/exclude`
  (no bloqueante), presente en el precedente real de Camuzzi.
- `integrations/agent-plugin-provider.md`: agrega el 3er paso de instalación
  (`moa-ai.ps1 install`) que faltaba desde el fix de PowerShell del quickstart.
- 3 referencias a un documento de análisis interno (nunca parte del modelo entregable, y
  que nombra al cliente en cada línea) quedaban rotas al no existir en el repo activo —
  reemplazadas por una descripción sin esa dependencia
  (`integrations/capability-distribution.md`, `capabilities/README.md`,
  `registry/entries/ticket-kickoff.md`).

## [0.5.5] — 2026-09-28

**Cambiado** (realineación con el KO y con DataAgro/Scato Logística/Orquestador/Camuzzi,
sin ejecución real todavía; reemplaza el enfoque de 0.5.4)
- `user-story` y `product-owner` verifican el código con un propósito acotado — confirmar
  lo que el pedido nombra, no mapear su impacto — en vez de una lista de pasos a seguir.
  El mapeo de pantallas, reportes, traspasos e integraciones afectados es de Planning
  (`ticket-kickoff`, CAP-010): la etapa de refinamiento lo declara como "Impacto técnico a
  confirmar en Planning", sin investigarlo, y `ticket-kickoff` lo retoma como punto de
  partida.
- `user-story` suma un análisis de gaps en lenguaje de negocio (ambigüedades, escenarios
  faltantes, conflictos entre reglas, bordes, integraciones), generalizado de las skills
  reales de DataAgro y Scato Logística sin sus ejemplos de dominio.
- `user-story` suma una pasada final antes de responder (criterios verificables, sin
  palabras vagas, origen de cada afirmación), tomada del auditor `spec-review` de Camuzzi.

## [0.5.4] — 2026-09-28

**Corregido** (con una ejecución real de `user-story` en VS Code)
- `user-story` y `product-owner` revisan el código acotado al pedido: ubican lo que el
  pedido nombra, leen esa sección y siguen una dependencia solo si puede cambiar los
  criterios, los datos o la estimación. Sin recorrer el repositorio completo ni buscar
  términos genéricos.

## [0.5.3] — 2026-09-28

**Corregido** (con una ejecución real de `user-story` en VS Code)
- `user-story` y `product-owner` toman el rol del ticket o de una línea de roles del
  `AGENTS.md` del repositorio (`- Roles: ...`); si no figura, lo declaran como supuesto sin
  buscarlo en el código. La "tabla de roles" que citaban no existía.
- Al dividir una historia, la parte que avanza tiene que aportar valor por sí sola; si no
  logra el beneficio del pedido, se dice y el PO decide.
- Una historia bloqueada lleva solo la historia, el contexto, los datos, las preguntas y
  los supuestos: los criterios se escriben cuando haya respuestas.

**Cambiado**
- Todas las capacidades y las Instructions piden responder en lenguaje natural, que se
  entienda sin conocer el modelo, sin jerga ni identificadores internos innecesarios.
- El quickstart indica Windows PowerShell para los comandos (fallan en el Símbolo del
  sistema).

## [0.5.2] — 2026-09-25

**Cambiado**
- Jira se conecta con el servidor MCP de Atlassian instalado una vez en VS Code
  (`com.atlassian/atlassian-mcp-server`), el mismo que ya usan los equipos. Se quita el
  `mcp.json` del plugin, que creaba un segundo servidor que los agentes no usaban.
- `product-owner`, `ticket-kickoff`, `qa-analyst` y `ticket-update` toman el sitio de Jira
  de la URL del ticket (o del `AGENTS.md` del repo) y, si la sesión está autorizada para otro
  sitio, explican cómo cambiarlo.
- `doctor` verifica que el servidor de Atlassian esté configurado en VS Code.
- Quickstart con la sección "Conectar Jira (una vez)"; los demás documentos la enlazan.

**Corregido** (revisión completa antes de las pruebas reales)
- `ticket-kickoff` y el Workflow adaptado pueden leer el ticket de Jira (`getJiraIssue`).
- Todas las capacidades piden tratar a la persona de usted; sin voseo, tuteo ni "acá".
- Los ejemplos de pedido usan palabras simples, sin IDs internos.
- Las copias que se entregan (`skills/`, `com.github.copilot/agents/`, `agents/`) se
  generan desde `capabilities/`: enlaces que funcionan y sin las líneas internas del
  Registry.
- README con "Empezar" en la primera pantalla: instalar, usar y qué hace cada capacidad.

## [0.5.1] — 2026-09-25

**Cambiado**
- `install` actualiza el plugin si lo encuentra en una versión anterior: el mismo comando
  sirve para la primera instalación y para quien viene de una versión previa.
- El quickstart ya no pide descargar el script desde Azure DevOps: llega con el plugin
  (`plugin install` o `plugin update`, y después `moa-ai.ps1 install`).

## [0.5.0] — 2026-09-25

**Agregado**
- `tools/moa-ai.ps1`: `install`, `update`, `status` y `doctor`. Una sola instalación por
  máquina, sin clonar; exige VS Code cerrado antes de modificar el plugin.
- `core-manifest.json`: contrato de distribución. Por cada componente: tipo, fuente,
  mecanismo de entrega, alcance, verificación y estado. El script instala y verifica según
  el manifest. La versión sigue en `plugin.json`.
- Workflow `spec-driven-development` disponible en Copilot como agente adaptado.
- `mcp.json` con el servidor de Atlassian Rovo.
- Instructions generales de MOA a nivel de usuario, instaladas por el script.

**Corregido**
- Los agentes de Copilot declaran `include-custom-instructions: true`: sin eso, un agente
  invocado por otro no lee el `AGENTS.md` del repo (probado).
- Voseo y tuteo en `spec-driven-development`.

## [0.4.1] — 2026-09-24

**Corregido** (a partir de la segunda ejecución real, Portal de Créditos)
- Todas las capacidades del plugin fijan el idioma de la respuesta: español neutro y
  formal, sin voseo. La regla existía como Instruction, pero las Instructions no viajan en
  el plugin, y la ejecución real cerró con voseo.
- `user-story`: el formato de salida y el cierre pasan al principio del archivo (el
  asistente leyó solo hasta la línea 200 y el cierre quedó cortado); el archivo se acortó.
- `user-story`: si una parte de la historia está lista y otra bloqueada, el veredicto es
  dividir, para que la parte lista avance.
- `user-story`: sin ticket, el responsable de las preguntas es quien hizo el pedido; lo
  deducido del código se declara siempre en "Supuestos y cambios respecto del pedido".
- `product-owner`: lectura del repo (`read`, `search`) para detectar el impacto real del
  cambio antes de estimar.

## [0.4.0] — 2026-09-24

**Agregado**
- Agentes `qa-analyst` (rol de QA) y `test-validator` (verifica con evidencia que todo
  está probado antes del OK final).
- Skill `ticket-update`: escritura segura en Jira y Azure DevOps, con confirmación por
  cambio, verificación posterior y marca visible.
- Skill `test-pipeline-setup`: tests automáticos en cada PR de Azure DevOps.
- Traspasos guiados entre roles: PO → desarrollo → revisión de código → QA → validación
  → cierre. La persona decide cada paso.

**Cambiado**
- `user-story` reescrita contra el estándar de historias de usuario: 30-40 líneas, 3 a 7
  criterios verificables, fuera de alcance, datos, preguntas bloqueantes, regla de
  división, veredicto de preparación y modo "revisar un ticket existente".
- `product-owner`, `ticket-kickoff`, `ticket-closure-assist` y `test-case-generation`
  escriben en el ticket lo que corresponde a su rol, siempre con confirmación.
- `ticket-kickoff` informa el resultado exacto de los tests y puede crear el PR tras el
  push del developer, con confirmación.

## [0.3.1] — 2026-09-23

**Corregido**
- 7 de los cierres agregados en `0.3.0` nombraban la capacidad siguiente por su ID o
  nombre técnico (`spec-driven-development`, `CAP-005`, `pr-description`, `CAP-011`,
  etc.) — hallazgo real: ese mismo lenguaje es justo lo que `how-to-use.md` ya evita.
  Se reescriben en lenguaje natural ("pedirle al asistente que...").

Versión del plugin (`plugin.json` y `.claude-plugin/plugin.json`) — sigue
[SemVer](https://semver.org/lang/es/): `MAJOR.MINOR.PATCH`. Se sube la versión cada vez
que cambia el contenido empaquetado (`skills/`, `com.github.copilot/agents/`, `agents/`,
`workflows/`) de forma real — nunca por cambios de documentación pura (`adoption/`,
`architecture/`, etc.), para no generar ruido de actualización sin motivo real.

## [0.3.0] — 2026-09-23

**Agregado**
- CAP-022 (`documentation-style`) — no se empaqueta en el plugin (las Instructions no se
  distribuyen), pero rige el contenido de las capacidades que sí.
- Mecanismo de distribución para Claude Code (`.claude-plugin/marketplace.json`,
  `agents/*.md`) — plataforma nueva, en paralelo a la de VS Code/GitHub Copilot.

**Cambiado**
- 11 capacidades empaquetadas (7 Skills/Agents + 1 Workflow) corregidas para cerrar
  siempre con el próximo paso explícito, en vez de terminar sin decir qué corresponde
  hacer — hallazgo real de un developer de Portal de Créditos.

**Evidencia**
- Primera ejecución real registrada del mecanismo de distribución: CAP-001
  (`user-story`), Portal de Créditos, 2026-09-23 — ver
  [`records/armoa277-1-campos-propios/EXEC-20260923-001/evidence.md`](records/armoa277-1-campos-propios/EXEC-20260923-001/evidence.md).

## [0.2.0] — 2026-09-22

**Agregado**
- Estructura completa de Agent Plugins 1.0 (`plugin.json`, `skills/`,
  `com.github.copilot/agents/`, `workflows/`) para instalación vía VS Code/GitHub
  Copilot.
- URL real del repositorio, tras la migración a Azure DevOps.

## [0.1.0] — 2026-09-22

**Agregado**
- Primera versión del manifiesto del plugin.
