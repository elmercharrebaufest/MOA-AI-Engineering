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

**Instalación directa — la plataforma la soporta, pero no se usa para MOA**: queda con
`"marketplace": ""`, suma una copia si ya existe la instalación del marketplace, y el CLI
muestra el aviso *"Direct plugin installs ... are deprecated"* al usarla:

1. Por la paleta de comandos de VS Code con **"Chat: Install Plugin From Source"**
   (pegando la URL directamente) — queda visible en el panel "Extensions: Agent Plugins".
2. Por terminal, instalación directa: `copilot plugin install <URL>` — acepta cualquier
   URL de Git, no solo GitHub.

En cualquiera de los 3 caminos, VS Code muestra el prompt de confianza en la primera
instalación de una fuente nueva — aceptar.

**Una sola instalación por máquina** — regla operativa de MOA, no una restricción de la
plataforma: el CLI permite que convivan varias copias del mismo plugin (confirmado:
coexistieron `ai-engineering` con `"marketplace": ""` y `ai-engineering@ai-engineering`,
cada una fija en la versión con la que se instaló). Por eso el Quick Start empieza siempre
con `copilot plugin list --json` y una tabla de decisión, antes de instalar nada. No hay
script de verificación automática: la revisión es un solo comando de solo lectura, y un
script sumaría mantenimiento sobre un formato de salida del CLI que solo se observó una
vez.

**Actualizar**: `copilot plugin update ai-engineering@ai-engineering`. El panel "Extensions:
Agent Plugins" no muestra botón de actualización para este plugin. No hay evidencia de que
`extensions.autoUpdate` ni **"Extensions: Check for Extension Updates"** apliquen a Agent
Plugins — son mecanismos de las Extensions estándar de VS Code; `REQUIRES VALIDATION`.

**Desinstalar**: `copilot plugin uninstall ai-engineering@ai-engineering`, o desde VS Code
(vista **"Agent Plugins - Installed"** → **"Uninstall"**). Para una instalación directa,
el nombre sin `@...` tal como lo muestra `copilot plugin list` — `REQUIRES VALIDATION`,
esa variante no se probó.

### Windows: `Access is denied. (os error 5)`

Limitación de la plataforma, no de este repositorio — issue abierto
[github/copilot-cli#4095](https://github.com/github/copilot-cli/issues/4095). Causa, según
el diagnóstico del propio issue: la extensión de Copilot de VS Code mantiene handles de
observación de archivos sobre `~\.copilot\installed-plugins\...`, y Windows no permite
renombrar ni reemplazar una carpeta con esos handles abiertos.

| Qué | Nivel de evidencia |
|---|---|
| `update` falla con VS Code abierto | Confirmado en MOA |
| `install` y `uninstall` fallan igual | Confirmado por otros usuarios en el issue; no probado en MOA |
| Depende del tamaño del plugin (los chicos terminan antes de que el observador reaccione) | Confirmado en el issue — explica que la instalación de `ai-engineering` sí funcionó |
| El "Uninstall" del panel de VS Code puede confirmar sin borrar | Observado en MOA, consistente con la misma causa; no confirmado como tal |
| Cerrar VS Code y repetir el mismo comando funciona | Confirmado en el issue; no probado en MOA |

Workaround documentado en el Quick Start: cerrar todas las ventanas de VS Code, repetir el
comando desde una terminal aparte, verificar con `copilot plugin list --json`. El issue
también describe un workaround manual (copiar la carpeta del plugin desde la caché interna
del CLI); no se adopta, porque modifica estado interno del CLI que no está documentado ni
soportado.

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
