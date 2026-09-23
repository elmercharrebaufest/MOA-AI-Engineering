# Agent Plugin Provider (pattern) — instalación vía VS Code Agent Plugins

**Específico de VS Code con GitHub Copilot.** Para Claude Code (herramienta separada, con
su propio sistema de plugins), ver
[`claude-code-plugin-provider.md`](claude-code-plugin-provider.md) — instalar este no
instala aquel.

**No es una capability del Registry** — es la forma en que este repositorio se distribuye
él mismo, mismo tratamiento que [Capability Distribution](capability-distribution.md) y
[Context Acquisition & Resolution](../architecture/context-acquisition-resolution.md).

**Estado**: `EXECUTED` — instalación real confirmada por 3 caminos (terminal directo,
interfaz de VS Code, terminal vía marketplace). Los Agents quedan instalados y
reconocidos igual que las Skills, aunque el mensaje de instalación solo mencione Skills.

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

**Recomendado — vía marketplace, por terminal con GitHub Copilot CLI**, 2 pasos:

```
copilot plugin marketplace add https://dev.azure.com/molinosagro/ai-engineering/_git/ai-engineering
copilot plugin install ai-engineering@ai-engineering
```

El repositorio no necesita ningún archivo adicional para funcionar como marketplace de un
solo plugin — el primer comando ya lo registra como tal.

**Alternativas, funcionan hoy pero GitHub las tiene marcadas para discontinuar** (el CLI
muestra el aviso *"Direct plugin installs ... are deprecated"* al usarlas):

1. Por la paleta de comandos de VS Code con **"Chat: Install Plugin From Source"**
   (pegando la URL directamente) — queda visible en el panel "Extensions: Agent Plugins".
2. Por terminal, instalación directa: `copilot plugin install <URL>` — acepta cualquier
   URL de Git, no solo GitHub.

En cualquiera de los 3 caminos, VS Code muestra el prompt de confianza en la primera
instalación de una fuente nueva — aceptar.

**Actualizar**: desde VS Code — automático cada 24 horas si `extensions.autoUpdate` está
activo, o a mano con **"Extensions: Check for Extension Updates"**. Por terminal
(`copilot plugin update`), en Windows falla con *"Access is denied. (os error 5)"* — bug
conocido de GitHub Copilot CLI, no de este repositorio, afecta a los 3 caminos de
instalación por igual — usar VS Code en su lugar.

**Desinstalar**: desde VS Code — vista **"Agent Plugins - Installed"**, clic derecho sobre
el plugin → **"Uninstall"**. Por terminal (`copilot plugin uninstall`), mismo error de
Windows que Actualizar — usar VS Code en su lugar.

**Instalar por más de un camino deja copias separadas del plugin** — `copilot plugin
list` las distingue por su origen (`ai-engineering` vs. `ai-engineering@ai-engineering`).
Conviene desinstalar cualquier copia anterior al migrar al camino recomendado, para no
tener duplicados ni confundirse sobre cuál versión está activa (cada instalación queda
fija en la versión con la que se instaló — no se actualiza sola).

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

**Versionado**: cada vez que el contenido empaquetado (`skills/`, `com.github.copilot/agents/`,
`workflows/`) cambia de verdad, corresponde subir el campo `version` de `plugin.json`
(SemVer) y agregar la entrada al [`CHANGELOG.md`](../CHANGELOG.md) — es lo que permite que
VS Code detecte que hay una actualización real disponible. Nunca subir la versión por
cambios de documentación pura.
