# Agent Plugin Provider (pattern) — instalación vía VS Code Agent Plugins

**Específico de VS Code con GitHub Copilot.** Para Claude Code (herramienta separada, con
su propio sistema de plugins), ver
[`claude-code-plugin-provider.md`](claude-code-plugin-provider.md) — instalar este no
instala aquel (hallazgo real, 2026-09-23).

**No es una capability del Registry** — es la forma en que este repositorio se distribuye
él mismo, mismo tratamiento que [Capability Distribution](capability-distribution.md) y
[Context Acquisition & Resolution](../architecture/context-acquisition-resolution.md).

**Estado**: `EXECUTED` (actualizado 2026-09-23) — **instalación real confirmada por 2
caminos**: por terminal (GitHub Copilot CLI, 2026-09-22, salida real *"Plugin
'ai-engineering' installed successfully. Installed 10 skills."*) y por la interfaz de VS
Code (2026-09-23, comando **"Chat: Install Plugin From Source"**, plugin visible en el
panel "Extensions: Agent Plugins" con nombre y descripción reales). **Los Agents también
quedan instalados y reconocidos** (confirmado 2026-09-23, Copilot Chat reconoció
`ticket-kickoff` y `workflow-documenter` con su descripción real) — el mensaje de
instalación solo menciona Skills, pero no era el caso. Queda un hallazgo que afecta la
continuidad del método por terminal (ver "Aviso de deprecación").

## Origen de este patrón

**External Best Practice**: especificación oficial **Agent Plugins 1.0** de VS Code
([Agent Plugins in VS Code](https://code.visualstudio.com/docs/agent-customization/agent-plugins),
releída completa y verbatim 2026-09-22) — el mecanismo de "plugin marketplace" acepta URLs
HTTPS de Git como una de sus 4 categorías de formato soportado, **no exclusivo de
GitHub.com** en principio. **Corrección importante (2026-09-22)**: una consulta anterior a
esta página había devuelto un ejemplo con formato `https://dev.azure.com/org/project/_git/repo`
como si estuviera citado textualmente en la documentación — releída la página completa,
**ese ejemplo no existe ahí**, fue un dato agregado por el resumen automático de esa
consulta anterior, no contenido real de la página. Lo que sí dice la documentación real,
textual: el formato "HTTPS git remote" es *"una URL completa terminada en `.git`"* — la
URL real de MOA no termina así, y la página no aclara si es estricto ni menciona Azure
DevOps en ningún lado. Ver "Qué falta confirmar" abajo — este es ahora el punto más
importante sin resolver, no solo la autenticación. **Existing Practice (evidencia
externa)**: un cliente de Baufest con un setup de SDLC-IA más maduro en
distribución técnica ya usa este mismo mecanismo en forma de "plugin opt-in"
(`plugins/core-suite/plugin.json`), separado de su mecanismo de propagación automática por
organización — este patrón adopta esa misma idea (plugin explícito, opt-in), no la
propagación automática (que sigue sin aplicar a MOA por estar en Azure DevOps, ver
`capabilities/README.md`, sección "Camino más maduro").

## Qué instala, y qué deliberadamente no

| Contenido | Se empaqueta acá | Ruta |
|---|---|---|
| Skills (`capabilities/skills/`) | Sí | `skills/<name>/SKILL.md` |
| Agents (`capabilities/agents/`) | Sí | `com.github.copilot/agents/<name>.agent.md` |
| Instructions (`capabilities/instructions/`) | **No, a propósito** | Instructions son 100% Team Adaptation (matriz de autonomía propia de cada equipo) — un plugin instalado globalmente no debe traer contenido que cada equipo tiene que completar con lo suyo. Sigue siendo copia manual, ver `capabilities/README.md` |
| MCP servers (`mcp.json`) | No todavía | Ningún servidor MCP de MOA tiene gobierno de identidad/scope/auditoría confirmado (`governance/BLOCKED-DECISIONS.md` #4) — no se empaqueta configuración MCP sin eso resuelto |

## Cómo lo instala un developer

**URL real del repositorio** (ya migrado):
`https://dev.azure.com/molinosagro/ai-engineering/_git/ai-engineering`

1. Agregar esa URL como marketplace — en la configuración de usuario de VS Code
   (`chat.plugins.marketplaces`), o mejor, commiteada en el repo del equipo
   (`.github/copilot/settings.json`, sección `extraKnownMarketplaces`) para que cualquiera
   que abra ese repo la reciba recomendada, sin configurarla a mano.
2. **Recomendado**: instalar desde la paleta de comandos de VS Code con
   **"Chat: Install Plugin From Source"** (pegando esa URL directamente) — confirmado
   real, queda visible en el panel "Extensions: Agent Plugins". Alternativa por terminal
   con **GitHub Copilot CLI** (herramienta separada de VS Code): `copilot plugin install
   <URL>` — acepta cualquier URL de Git, no solo GitHub.
3. Aceptar el prompt de confianza (VS Code lo muestra siempre en la primera instalación de
   una fuente nueva).
4. **Actualizar**: **recomendado, desde la propia interfaz de VS Code** — automático
   cada 24 horas si `extensions.autoUpdate` está activo, o a mano con
   **"Extensions: Check for Extension Updates"**. Por terminal, `copilot plugin update
   ai-engineering` también funciona, pero en Windows puede fallar con *"Access is denied.
   (os error 5)"* — bug conocido de GitHub Copilot CLI, no de este repositorio
   ([#4095](https://github.com/github/copilot-cli/issues/4095)); cerrar VS Code por
   completo antes de correr el comando lo resuelve.
5. **Desinstalar**: **recomendado, desde VS Code** — vista **"Agent Plugins -
   Installed"**, clic derecho sobre el plugin → **"Uninstall"**. Por terminal,
   `copilot plugin uninstall ai-engineering` también funciona, con el mismo riesgo del
   bug de Windows del punto anterior.

## Qué falta confirmar (actualizado 2026-09-23)

- ~~El formato de la URL~~ — **resuelto**: la URL real sin sufijo `.git` funcionó tal
  cual, confirmado en la primera instalación real (vía GitHub Copilot CLI).
- ~~Autenticación contra el repositorio privado~~ — **resuelto en los 2 caminos**: por
  CLI no hizo falta ningún paso de autenticación manual. Por la interfaz de VS Code
  ("Chat: Install Plugin From Source", 2026-09-23) tampoco se observó ningún prompt de
  autenticación adicional al instalar.
- ~~¿Se instalaron los Agents, o solo las Skills?~~ — **resuelto (2026-09-23)**: la salida
  de instalación solo menciona *"Installed 10 skills"*, pero Copilot Chat reconoció
  correctamente `ticket-kickoff` y `workflow-documenter`, con su descripción real — los 7
  Agents también quedan instalados, el mensaje de resumen simplemente no los cuenta.
- ~~La estructura exacta de `com.github.copilot/agents/` (namespace reverse-domain)~~ —
  **resuelta por el mismo hallazgo de arriba**: si Copilot Chat reconoce los Agents con
  su descripción real, la estructura fue interpretada correctamente.
- **Instalar desde VS Code** (paso 2) ya está confirmado, sin el bug de Windows del CLI.
  **Sigue sin confirmar si Actualizar/Desinstalar desde VS Code también lo evitan** —
  falta que algún developer real lo pruebe y reporte si el error reaparece o no.

## Aviso de deprecación (hallazgo real, 2026-09-22)

La instalación real mostró esta advertencia textual: *"Direct plugin installs (repos,
URLs, local paths) are deprecated. Only plugin@marketplace installs will be supported in
a future release."* — el método que documentamos **funciona hoy, pero GitHub lo va a
retirar**. El reemplazo oficial (verificado en la documentación real de GitHub Copilot
CLI) es un flujo de 2 pasos:

```
copilot plugin marketplace add <fuente>
copilot plugin install <nombre-del-plugin>@<nombre-del-marketplace>
```

**No se implementa este cambio todavía, a propósito** — la documentación real distingue
entre un repositorio "marketplace" (una colección que lista varios plugins) y un
repositorio de "un solo plugin" (que es lo que es `ai-engineering` hoy, con `plugin.json`
en la raíz), y no queda claro si nuestro mismo repositorio puede servir como su propio
marketplace o si hace falta una estructura aparte. Es una pregunta real de diseño, no
algo para resolver adivinando — queda pendiente de investigar antes de migrar, sin
apuro porque el método actual sigue funcionando mientras tanto.

## Implementación

- Quick Start paso a paso para instalar (para cualquier persona, no solo developers):
  [`../adoption/agent-plugin-quickstart.md`](../adoption/agent-plugin-quickstart.md).
- [`../plugin.json`](../plugin.json) — manifiesto en la raíz del repositorio.
- [`../skills/`](../skills/) — espejo de `capabilities/skills/`, mantenido junto con la
  fuente (no reemplaza `capabilities/skills/` como fuente de verdad).
- [`../com.github.copilot/agents/`](../com.github.copilot/agents/) — espejo de
  `capabilities/agents/`, mismo criterio.

## Mantenimiento

Este espejo se actualiza a mano por ahora, junto con cada cambio real a
`capabilities/agents/` o `capabilities/skills/` — no hay automatización todavía. Si el
volumen de cambios lo justifica, se puede agregar un paso al mismo pipeline de
[Capability Distribution](capability-distribution.md) que también actualice este espejo —
evaluar después de la primera prueba real, no antes.
