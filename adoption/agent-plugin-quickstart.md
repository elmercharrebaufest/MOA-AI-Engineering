# Instalar las capacidades como plugin de VS Code — Quick Start

Para **VS Code con GitHub Copilot**. Se instala una vez por máquina, sin copiar archivos a
los repositorios. El mismo modelo para Claude Code está en preparación, todavía sin validar.

## 1. Prerequisitos

- VS Code con GitHub Copilot Chat, y GitHub Copilot CLI (`copilot --version`, 1.0.86 o
  superior; se actualiza con `copilot update`).
- Git, y acceso de lectura al repositorio `ai-engineering` en Azure DevOps.
- Para Jira: permiso en el proyecto de Jira del equipo (el mismo que se usa en la web).

## 2. Instalar

Una sola vez por máquina; aplica a todos los proyectos. No hace falta clonar ni descargar
nada: el plugin trae el script `moa-ai.ps1`.

Cerrar **todas** las ventanas de VS Code y abrir PowerShell o Windows Terminal (no la
terminal de VS Code).

**Máquina sin el plugin:**

```
copilot plugin marketplace add https://dev.azure.com/molinosagro/ai-engineering/_git/ai-engineering
copilot plugin install ai-engineering@ai-engineering
powershell -ExecutionPolicy Bypass -File "$HOME\.copilot\installed-plugins\ai-engineering\ai-engineering\tools\moa-ai.ps1" install
```

**Máquina con una versión anterior a 0.5.0** (que todavía no trae el script):

```
copilot plugin update ai-engineering@ai-engineering
powershell -ExecutionPolicy Bypass -File "$HOME\.copilot\installed-plugins\ai-engineering\ai-engineering\tools\moa-ai.ps1" install
```

`install` no repite lo que ya está hecho: si el plugin está instalado en una versión
anterior, lo actualiza; si hay copias duplicadas, pide confirmación para dejar una sola.
Después configura las Instructions en
`~/.copilot/instructions/moa-ai-engineering.instructions.md` y termina con `doctor`.

## 3. Conectar Jira (una vez)

Los agentes leen y escriben en Jira con el servidor MCP oficial de Atlassian instalado en
VS Code, con la cuenta de cada persona. No se configura nada en los repositorios.

1. En VS Code, vista **Extensions**, buscar `@mcp atlassian` e instalar el servidor de
   Atlassian. Queda configurado como `com.atlassian/atlassian-mcp-server`.
2. En Copilot Chat, modo **Agent**, pedir: *"Usa getAccessibleAtlassianResources y lista
   los sitios a los que tengo acceso."* La primera vez se abre el navegador: iniciar sesión
   con la cuenta de Atlassian y, en **Use app on**, elegir el sitio del equipo (MOA:
   `molinosagro`; Baufest: `baufest`).
3. La respuesta debe mostrar ese sitio. `doctor` confirma que el servidor está configurado.

**Un sitio por vez.** La autorización de Atlassian cubre un solo sitio: autorizar otro lo
reemplaza. Para cambiar: **Cuentas** (abajo a la izquierda) → cerrar sesión de la cuenta del
MCP de Atlassian → `Ctrl+Shift+P` → **MCP: List Servers** →
`com.atlassian/atlassian-mcp-server` → **Restart** → elegir el otro sitio.

**Cómo pedir un ticket.** Con la URL completa, el agente usa ese sitio. Con solo la clave,
usa el sitio que indique el `AGENTS.md` del repo (por ejemplo, una línea
`- Jira: molinosagro.atlassian.net, proyecto SEFI`); si no lo indica, pregunta.

**Solo en VS Code.** Desde Copilot CLI, el login de Atlassian falla por un problema conocido
de GitHub ([github/copilot-cli#4901](https://github.com/github/copilot-cli/issues/4901)).

## 4. Verificar

```
powershell -ExecutionPolicy Bypass -File "$HOME\.copilot\installed-plugins\ai-engineering\ai-engineering\tools\moa-ai.ps1" doctor
```

El estado general debe ser `READY` o `READY (con advertencias)`. Cada componente sale como
`OK`, `WARNING`, `ERROR` o `NOT_SUPPORTED` (sin mecanismo en Copilot, es lo esperado para
Integrations). `status` muestra el resumen. Qué está probado:
[`../tools/copilot/VALIDATION.md`](../tools/copilot/VALIDATION.md).

Después, en VS Code, abrir Copilot Chat, elegir un agente en el selector de agentes (por
ejemplo, `product-owner`) y describir una tarea real: [`how-to-use.md`](how-to-use.md).

## 5. Actualizar

Con VS Code cerrado, en una terminal aparte:

```
powershell -ExecutionPolicy Bypass -File "$HOME\.copilot\installed-plugins\ai-engineering\ai-engineering\tools\moa-ai.ps1" update
```

Actualiza solo si hay una versión nueva y muestra la versión anterior y la nueva. No hay
actualización automática.

## 6. Desinstalar

```
copilot plugin uninstall ai-engineering@ai-engineering
```

Borrar también `~/.copilot/instructions/moa-ai-engineering.instructions.md`.

## 7. Windows: `Access is denied. (os error 5)`

Problema conocido de GitHub Copilot CLI en Windows
([github/copilot-cli#4095](https://github.com/github/copilot-cli/issues/4095)): mientras VS
Code está abierto, su extensión de Copilot mantiene tomada la carpeta del plugin y Windows
no permite reemplazarla. Por eso el script exige VS Code cerrado y se niega a correr desde
su terminal. Si el error aparece igual: cerrar todas las ventanas de VS Code, repetir el
comando en una terminal aparte y verificar con `doctor`.

## 8. Sin script

Si la política de la máquina no permite ejecutar scripts de PowerShell, los pasos
equivalentes son `copilot plugin marketplace add
https://dev.azure.com/molinosagro/ai-engineering/_git/ai-engineering` y `copilot plugin
install ai-engineering@ai-engineering`, revisando antes con `copilot plugin list --json`
que no exista otra copia. Las Instructions quedan sin configurar.

## 9. Alternativa: que llegue recomendado sin configurar nada

Si el equipo agrega esto al archivo `.github/copilot/settings.json` de su propio
repositorio, cualquiera que lo abra recibe el plugin recomendado automáticamente:

```json
{
  "extraKnownMarketplaces": {
    "ai-engineering": {
      "source": {
        "source": "git",
        "url": "https://dev.azure.com/molinosagro/ai-engineering/_git/ai-engineering"
      }
    }
  }
}
```

Cada developer igual tiene que aceptar la recomendación y el prompt de confianza — no se
instala solo. El nombre del marketplace (`ai-engineering`) tiene que ser el mismo del punto
2, para no terminar con una instalación de otro marketplace.

## Ver también

- Qué distribuye el plugin y por qué: [`../integrations/agent-plugin-provider.md`](../integrations/agent-plugin-provider.md).
- Alternativa para equipos (no individual): [`capability-distribution-quickstart.md`](capability-distribution-quickstart.md).
- Camino manual, para probar una sola capacidad sin instalar nada: [`../capabilities/README.md`](../capabilities/README.md).
