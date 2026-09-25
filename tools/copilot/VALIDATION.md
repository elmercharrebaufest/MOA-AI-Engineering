# Validación del adaptador de Copilot

Pruebas con `copilot --plugin-dir` sobre una copia del paquete 0.5.0, Copilot CLI 1.0.87,
Windows 11. Cada prueba abre una sesión real (un request) y se evalúa por la respuesta o
por los eventos de la sesión, no por el formato del archivo. Los IDs se usan en
[`core-manifest.json`](../../core-manifest.json).

| ID | Qué se probó | Resultado | Evidencia |
|---|---|---|---|
| T0-skills | Descubrimiento de skills del plugin | VALIDATED | `copilot skill list --json` lista las 12 con `source: plugin` |
| T1a-agent | Agente del plugin como agente principal (`--agent <plugin>:product-owner`) | VALIDATED | Respondió con su rol y ofreció el traspaso "Pasar a desarrollo" |
| T1b-subagent | Agente del plugin como subagente | VALIDATED | Eventos `subagent.started` / `subagent.completed` de `qa-analyst`, con sus herramientas declaradas |
| T2a / T2b | `com.github.copilot/rules/` (`.md` y `.instructions.md`) | No se aplica | La sesión ignoró ambas reglas de prueba |
| T2c-user-instr | `~/.copilot/instructions/*.instructions.md` | VALIDATED | La sesión aplicó la regla de prueba; `copilot instruction list` la muestra como `user` |
| T3-mcp | `mcp.json` en la raíz del plugin | VALIDATED hasta OAuth | La sesión inició `atlassian-mcp-server`, conectó con `mcp.atlassian.com` y pidió autenticación |
| T4-workflow | Workflow adaptado como agente | VALIDATED | Con un ticket de ejemplo: leyó el ticket real, generó `specs/DEMO-1/requirements.md` en EARS, creó la rama del ticket, dejó preguntas abiertas y se detuvo antes de implementar |
| T5a / T5b | `AGENTS.md` del repo, agente principal | VALIDATED | Lo leyó con y sin `include-custom-instructions` |
| T5d | `AGENTS.md` del repo, subagente | VALIDATED con la declaración | Sin `include-custom-instructions: true` respondió "NO-SE"; con la declaración leyó el dato |

## Pruebas del script `moa-ai.ps1`

En una terminal aparte, cerrando VS Code durante la prueba, con Copilot CLI 1.0.88.

| ID | Qué se probó | Resultado | Evidencia |
|---|---|---|---|
| S1-guard | `update` con VS Code abierto | VALIDATED | Avisó, esperó a que se cerrara VS Code y recién entonces siguió |
| S2-update | Actualización real 0.4.0 → 0.4.1 | VALIDATED | "Actualizado: 0.4.0 -> 0.4.1", sin `os error 5` |
| S3-duplicate | Instalación directa agregada a propósito junto a la del marketplace | VALIDATED | La CLI permite el duplicado. `install` lo detectó, pidió confirmación, desinstaló las 2 sin `os error 5` y dejó una sola desde el marketplace |
| S4-components | Instalación de componentes guiada por el manifest | VALIDATED | Con el paquete 0.5.0, las Instructions quedaron en `~/.copilot/instructions/` y Copilot las detectó; la segunda ejecución informó "al día" |

## Qué sigue NOT_VALIDATED

- Todo lo anterior en **VS Code**: las pruebas fueron en la CLI. Las skills en VS Code ya
  tienen ejecuciones reales (`EXEC-20260923-001`, `EXEC-20260924-001`).
- Uso de las herramientas de Jira desde los agentes: requiere que el developer autentique
  Atlassian.
- Detección de la versión disponible por etiqueta (`v*`): no hay etiquetas hasta publicar
  la 0.5.0.
- Integrations: sin mecanismo de carga en el plugin.

## Hallazgo lateral

`COPILOT_PLUGIN_DIR_ONLY=1` no excluyó el plugin instalado: en una prueba la CLI eligió el
agente del plugin instalado en lugar del de `--plugin-dir`. Las pruebas usan un nombre de
plugin distinto para no confundirlos.
