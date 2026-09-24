# Changelog

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
