# Changelog

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
