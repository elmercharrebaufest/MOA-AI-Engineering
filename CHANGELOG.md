# Changelog

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
