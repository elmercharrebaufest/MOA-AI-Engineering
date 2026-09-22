# Agent Plugin Provider (pattern) — instalación vía VS Code Agent Plugins

**No es una capability del Registry** — es la forma en que este repositorio se distribuye
él mismo, mismo tratamiento que [Capability Distribution](capability-distribution.md) y
[Context Acquisition & Resolution](../architecture/context-acquisition-resolution.md).

**Estado**: `PROPOSAL` — estructura construida, **sin instalación real probada todavía**.
Hay una parte concreta sin confirmar (ver "Qué falta confirmar" abajo) — no se afirma que
funcione de punta a punta hasta que alguien lo pruebe de verdad.

## Origen de este patrón

**External Best Practice**: especificación oficial **Agent Plugins 1.0** de VS Code
([Agent Plugins in VS Code](https://code.visualstudio.com/docs/agent-customization/agent-plugins),
verificado 2026-09-22) — confirmado que el mecanismo de "plugin marketplace" acepta
cualquier URL de repositorio Git por HTTPS, **no solo GitHub.com** (la propia documentación
lista explícitamente el formato `https://dev.azure.com/org/project/_git/repo`). **Existing
Practice (evidencia externa)**: un cliente de Baufest con un setup de SDLC-IA más maduro en
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
2. Instalar desde la Extensions view (`@agentPlugins`) o con el comando
   **"Chat: Install Plugin From Source"**, pegando esa URL directamente.
3. Aceptar el prompt de confianza (VS Code lo muestra siempre en la primera instalación de
   una fuente nueva).
4. **Actualizar**: automático cada 24 horas si `extensions.autoUpdate` está activo, o a
   mano con **"Extensions: Check for Extension Updates"**.

## Qué falta confirmar (sin especular, pendiente de prueba real)

- **Autenticación contra el repositorio privado de Azure DevOps**: la documentación oficial
  no especifica cómo VS Code resuelve las credenciales para un repositorio privado que no
  es GitHub. Es razonable esperar que reutilice las credenciales de git que el developer ya
  tiene configuradas contra Azure DevOps (Git Credential Manager) — pero es una inferencia,
  no un hecho confirmado. **Este es el primer punto a probar en la práctica.**
- La estructura exacta de `com.github.copilot/agents/` (namespace reverse-domain) está
  reconstruida a partir de la documentación oficial y un ejemplo de estructura de carpetas
  citado ahí — no hay una confirmación explícita adicional de que este sea el único formato
  válido. Se corrige si la instalación real muestra algo distinto.

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
