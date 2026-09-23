# Claude Code Plugin Provider (pattern) — instalación vía el plugin system de Claude Code

**No es una capability del Registry** — es una segunda forma en que este repositorio se
distribuye él mismo, en paralelo a
[Agent Plugin Provider (VS Code / GitHub Copilot)](agent-plugin-provider.md). Son 2
ecosistemas separados: instalar uno no instala el otro (hallazgo real, 2026-09-23 — ver
"Por qué existe este documento").

**Estado**: `BLOCKED — PLATFORM LIMITATION` (2026-09-23). La estructura de este repositorio
está construida y verificada contra la documentación oficial de Claude Code — el bloqueo
**no es de este repositorio**: es un bug real y externo de Claude Code en Windows (ver
"Hallazgo real" más abajo), confirmado contra 2 issues reales de `anthropics/claude-code`,
ambos cerrados "not planned" por Anthropic. `BLOCKED` no significa que la capacidad se
descarte — significa que esta ruta puntual de distribución no se puede completar hoy por
una causa fuera de nuestro control, mientras la misma capacidad sí funciona por la ruta de
VS Code/GitHub Copilot ([`agent-plugin-provider.md`](agent-plugin-provider.md), `EXECUTED`).
Ver "Qué falta confirmar".

## Por qué existe este documento

Un developer instaló este repositorio como Agent Plugin de VS Code (GitHub Copilot) y
confirmó que los agents/skills funcionan ahí. Al abrir una sesión de **Claude Code**
(herramienta separada, con su propio sistema de extensiones) y preguntarle por los mismos
agents, no los reconoció — comportamiento esperado, no un bug: Claude Code no lee
`com.github.copilot/agents/` ni el `plugin.json` de la raíz, que son específicos del
formato Agent Plugins 1.0 de VS Code.

## Origen de este patrón

**External Best Practice**: sistema de plugins oficial y real de Claude Code
([Create plugins](https://code.claude.com/docs/en/plugins),
[Discover and install plugins](https://code.claude.com/docs/en/discover-plugins),
[Create a plugin marketplace](https://code.claude.com/docs/en/plugin-marketplaces),
releídos completos 2026-09-23) — estructuralmente muy cercano a lo que ya teníamos:
`skills/<nombre>/SKILL.md` es **la misma convención exacta** que ya usa
[`agent-plugin-provider.md`](agent-plugin-provider.md) para VS Code.

## Qué instala, y qué deliberadamente no

| Contenido | Se empaqueta acá | Ruta |
|---|---|---|
| Skills (`capabilities/skills/`) | Sí, reutiliza el mismo espejo `skills/` que ya usa VS Code | `skills/<name>/SKILL.md` |
| Agents (`capabilities/agents/`) | Sí, espejo nuevo — formato distinto al de VS Code | `agents/<name>.md` |
| Instructions (`capabilities/instructions/`) | **No, a propósito** — mismo criterio que en VS Code: son 100% Team Adaptation | Sigue siendo copia manual |
| MCP servers | No todavía — mismo motivo que en VS Code (`governance/BLOCKED-DECISIONS.md` #4) | — |

## Diferencias reales con el formato de VS Code (no cosméticas)

- **Manifiesto**: `.claude-plugin/plugin.json` (Claude Code) vs. `plugin.json` en la raíz
  (VS Code) — carpetas y ubicaciones distintas, no intercambiables.
- **Marketplace obligatorio**: a diferencia de VS Code (que hasta ahora permitía instalar
  un plugin directo desde una URL, y lo está deprecando), Claude Code **siempre** instala
  a través de un marketplace — nunca de un plugin suelto. Por eso este repositorio
  también tiene `.claude-plugin/marketplace.json`, con una sola entrada que apunta a la
  raíz del propio repositorio (`"source": "./"`) — confirmado como patrón válido en la
  documentación oficial.
- **Formato de Agents**: Claude Code espera archivos planos en `agents/<nombre>.md`
  (frontmatter `name`/`description`/`tools`/`model`, sin carpeta por agente), con nombres
  de herramienta propios (`Read`, `Edit`, `Write`, `Bash`, `Grep`, `Glob`, `TodoWrite`,
  `WebFetch`, `Task`) — distintos de los nombres genéricos que usa la fuente canónica
  (`capabilities/agents/<nombre>/AGENT.md`). Cada archivo en `agents/` documenta, en un
  aviso al inicio, cómo se tradujo desde la fuente.
- **`product-owner` es un caso especial**: los subagentes de plugin de Claude Code no
  admiten declarar `mcpServers` en su propio frontmatter (restricción real de la
  plataforma). Su `tools` en `agents/product-owner.md` queda en `Read` como valor seguro
  por defecto, con una nota explícita de que hay que reemplazarlo por el nombre real de
  la herramienta MCP acotada (`mcp__<servidor>__<herramienta>`) antes de usarlo — no se
  puede empaquetar ya resuelto, a diferencia del resto de los Agents.

## Cómo lo instala un developer

**URL real del repositorio** (misma que VS Code, confirmado que Claude Code reconoce el
formato de Azure DevOps sin el sufijo `.git`):
`https://dev.azure.com/molinosagro/ai-engineering/_git/ai-engineering`

**2 entornos distintos, con comandos distintos (hallazgo real, 2026-09-23)**: los
comandos `/plugin marketplace add`/`/plugin install` son de la **CLI de terminal** — en
la **extensión de Claude Code para VS Code** devuelven *"/plugin isn't available in this
environment"*. Ahí corresponde usar el diálogo gráfico (`/plugins`) o el enlace de un
solo clic — ver el detalle paso a paso en
[`../adoption/claude-code-plugin-quickstart.md`](../adoption/claude-code-plugin-quickstart.md).

**Por terminal**:
1. `/plugin marketplace add https://dev.azure.com/molinosagro/ai-engineering/_git/ai-engineering`
2. `/plugin install ai-engineering@ai-engineering`
3. Si Claude Code pide `/reload-plugins` para activarlo, correrlo.

**Extensión de VS Code**: enlace de un clic
(`vscode://anthropic.claude-code/install-plugin?plugin=ai-engineering&marketplace=<URL>`),
o `/plugins` → pestaña Marketplaces → agregar la URL → pestaña Plugins → Install.

**Actualizar/Desinstalar**: mismo patrón de 2 entornos — ver el Quick Start para el
detalle de cada uno.

**Hallazgo real (2026-09-23) — bug de Windows al agregar el marketplace**: usando el
camino correcto (extensión de VS Code, diálogo "Manage Plugins" → Marketplaces → Add), la
instalación falló con:

> *"Failed to add marketplace: Failed to finalize marketplace cache. [...] EPERM:
> operation not permitted, rename 'temp_git_...' -> '...\ai-engineering'"*

Es un bug conocido de Claude Code en Windows, no de este repositorio — confirmado en
varios issues reales del repo `anthropics/claude-code`
([#58241](https://github.com/anthropics/claude-code/issues/58241),
[#54053](https://github.com/anthropics/claude-code/issues/54053)). Causa: al terminar el
`git clone`, Windows Defender (y a veces el indexador de búsqueda) mantiene el archivo
recién escrito bloqueado unos segundos, y el `rename` que sigue choca con ese bloqueo —
una condición de carrera, no un fallo determinístico. Workaround confirmado por un
reportero real: excluir `~/.claude/plugins` de Windows Defender
(`Add-MpPreference -ExclusionPath "$env:USERPROFILE\.claude\plugins"`) resuelve el
problema de forma consistente; reintentar el "Add" también puede alcanzar, al ser una
carrera de timing.

**Segundo intento, mismo bug pero silencioso**: usando el enlace de un clic, el flujo
llegó hasta "Adding marketplace..." y terminó en "No plugins available", con la pestaña
Marketplaces vacía ("No marketplaces configured") — el agregado del marketplace no llegó
a persistir, mismo bug de arriba, esta vez sin mostrar el texto de error en pantalla. Esto
descarta que el problema sea la estructura de `marketplace.json`/`plugin.json` de este
repositorio — con `strict` en su valor por defecto (`true`), `.claude-plugin/plugin.json`
en la raíz es la autoridad y no requiere declarar `skills`/`agents` dentro de
`marketplace.json`, verificado contra la documentación oficial de "Strict mode".

**Tercer intento, la exclusión de Defender tampoco alcanzó**: hay una segunda variante del
mismo bug, distinta de la carrera de timing, documentada en
[#52435](https://github.com/anthropics/claude-code/issues/52435) (también cerrado "not
planned"): en Windows, `fs.rename()` falla con `EPERM` de forma **determinística**
(siempre, no a veces) cuando la carpeta destino ya existe de un intento anterior fallido —
excluir el antivirus no ayuda en ese caso, porque la causa no es un bloqueo de archivo
sino un directorio que ya está ahí. El propio mensaje de error ya lo indica ("Please
manually delete the directory... if it exists"). El mismo issue #58241 documenta un
workaround real, verificado por otro usuario, que evita el paso de Claude Code que falla:
clonar el repositorio a mano y agregar esa carpeta local como marketplace, en vez de la
URL remota — sin clone-then-rename interno, no hay nada que pueda fallar con EPERM. Ver
el detalle paso a paso en
[`../adoption/claude-code-plugin-quickstart.md`](../adoption/claude-code-plugin-quickstart.md).

## Qué falta confirmar

- **Instalación real completa, sin el error de Windows** — todavía no se logró en
  ninguno de los 2 entornos. Es el paso siguiente antes de subir el `Estado` de este
  documento.
- **Si `skills/` (ya compartido con VS Code) funciona sin cambios en Claude Code** — la
  estructura de carpetas coincide, pero el frontmatter real de nuestros `SKILL.md`
  incluye un campo `name` que los ejemplos de la documentación de Claude Code no
  muestran (solo `description`). Es muy probable que un campo extra se ignore sin
  problema, pero no está confirmado con una instalación real.
- **Los 7 Agents traducidos** (`agents/*.md`) — la traducción de nombres de herramienta
  es la mejor interpretación posible contra la documentación oficial, pero ningún
  developer los probó todavía dentro de Claude Code.

## Implementación

- [`../.claude-plugin/plugin.json`](../.claude-plugin/plugin.json) — manifiesto del
  plugin.
- [`../.claude-plugin/marketplace.json`](../.claude-plugin/marketplace.json) — catálogo
  de marketplace, con una única entrada que apunta a la raíz del propio repositorio.
- [`../agents/`](../agents/) — espejo de `capabilities/agents/`, en el formato real de
  Claude Code (distinto del espejo `com.github.copilot/agents/` que usa VS Code).
- [`../skills/`](../skills/) — mismo espejo que ya usa VS Code, reutilizado tal cual.

## Mantenimiento

Igual que [`agent-plugin-provider.md`](agent-plugin-provider.md): estos espejos se
actualizan a mano junto con cada cambio real a `capabilities/agents/` — no hay
automatización todavía.

**Versionado**: mismo `version` y mismo [`CHANGELOG.md`](../CHANGELOG.md) que
`plugin.json` — `.claude-plugin/plugin.json` sube de versión junto con el otro, nunca por
separado, para que ambas plataformas queden siempre en el mismo número.
