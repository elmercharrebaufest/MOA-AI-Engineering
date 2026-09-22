# Agent Plugin Provider (pattern) — instalación vía VS Code Agent Plugins

**No es una capability del Registry** — es la forma en que este repositorio se distribuye
él mismo, mismo tratamiento que [Capability Distribution](capability-distribution.md) y
[Context Acquisition & Resolution](../architecture/context-acquisition-resolution.md).

**Estado**: `EXECUTED` (corregido 2026-09-22) — **primera instalación real confirmada**,
vía GitHub Copilot CLI, con la URL real de Azure DevOps sin modificar. Salida real:
*"Plugin 'ai-engineering' installed successfully. Installed 10 skills."* Queda un punto
importante sin verificar (¿se instalaron también los Agents, o solo los Skills? — ver
"Qué falta confirmar") y un hallazgo nuevo que afecta la continuidad del método (ver
"Aviso de deprecación").

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
2. Instalar desde la Extensions view (`@agentPlugins`), con el comando
   **"Chat: Install Plugin From Source"** (pegando esa URL directamente), o por terminal
   con **GitHub Copilot CLI** (herramienta separada de VS Code): `copilot plugin install
   <URL>` — acepta cualquier URL de Git, no solo GitHub. VS Code detecta automáticamente
   lo instalado por esta última vía.
3. Aceptar el prompt de confianza (VS Code lo muestra siempre en la primera instalación de
   una fuente nueva).
4. **Actualizar**: por terminal, `copilot plugin update ai-engineering` (o `--all` para
   todos los plugins instalados) — confirmado en la referencia oficial de comandos de
   GitHub Copilot CLI. Por VS Code: automático cada 24 horas si `extensions.autoUpdate`
   está activo, o a mano con **"Extensions: Check for Extension Updates"**.
5. **Desinstalar**: por terminal, `copilot plugin uninstall ai-engineering`. Por VS Code:
   en la vista **"Agent Plugins - Installed"**, clic derecho sobre el plugin →
   **"Uninstall"** — confirmado en la documentación oficial de Agent Plugins.

## Qué falta confirmar (actualizado 2026-09-22, primera prueba real ya ocurrió)

- ~~El formato de la URL~~ — **resuelto**: la URL real sin sufijo `.git` funcionó tal
  cual, confirmado en la primera instalación real (vía GitHub Copilot CLI).
- ~~Autenticación contra el repositorio privado~~ — **resuelto para el camino CLI**: no
  hizo falta ningún paso de autenticación manual — la CLI se instaló sola (con
  confirmación) y accedió al repositorio sin pedir credenciales aparte. Sigue sin
  confirmar si la vía de VS Code (Extensions view / "Install Plugin From Source") pide
  algo distinto — nadie la probó todavía, solo la vía CLI.
- **Nuevo, sin confirmar: ¿se instalaron los Agents, o solo los Skills?** La salida real
  dice *"Installed 10 skills"* — que coincide exactamente con la cantidad real de Skills
  de este repositorio, pero **no menciona nada de los 7 Agents ni del Workflow**. Puede
  ser que el mensaje de resumen solo cuente Skills aunque instaló todo, o puede ser que
  `com.github.copilot/agents/` no se haya reconocido como esperábamos. **Se confirma
  abriendo Copilot Chat en modo Agent y preguntando si reconoce, por ejemplo,
  `ticket-kickoff` o `workflow-documenter`** — no se asume ninguna de las 2 posibilidades
  sin esa prueba.
- La estructura exacta de `com.github.copilot/agents/` (namespace reverse-domain) sigue
  sin confirmación adicional más allá de la reconstrucción original — el punto de arriba
  es, en los hechos, la forma de confirmarla o refutarla.

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
