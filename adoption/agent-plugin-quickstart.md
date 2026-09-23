# Instalar las capacidades como plugin de VS Code — Quick Start

**Para quién es**: cualquier persona que use **VS Code con GitHub Copilot** y quiera usar
los `agents`/`skills` de este modelo en su propio trabajo, sin copiar archivos a mano ni
depender de un administrador. Patrón completo:
[`../integrations/agent-plugin-provider.md`](../integrations/agent-plugin-provider.md).

**Con Claude Code en vez de GitHub Copilot, este Quick Start no aplica** — es una
herramienta separada, con su propio mecanismo de plugin. Ver
[`claude-code-plugin-quickstart.md`](claude-code-plugin-quickstart.md).

**No corresponde este camino si...** el equipo quiere que el cambio llegue automático a
todo el mundo, sin que cada developer instale nada por su cuenta — para eso está
[`capability-distribution-quickstart.md`](capability-distribution-quickstart.md) (requiere
un administrador de Azure DevOps).

## 1. Prerequisitos

- VS Code con GitHub Copilot Chat instalado.
- Acceso de lectura al repositorio `ai-engineering` en Azure DevOps.

## 2. Instalar (una sola vez)

Se instala una sola vez por máquina y aplica a cualquier proyecto que se abra en VS Code
— no hace falta tener ningún repositorio propio abierto.

**Por la paleta de comandos** (`Ctrl+Shift+P` / `Cmd+Shift+P`) → **"Chat: Install Plugin
From Source"** → pegar esta URL:

```
https://dev.azure.com/molinosagro/ai-engineering/_git/ai-engineering
```

**O por terminal, con GitHub Copilot CLI** ("terminal" es cualquier línea de comandos —
PowerShell, CMD, Git Bash, o la terminal integrada de VS Code — donde esté disponible el
comando `copilot`):

```
copilot plugin install https://dev.azure.com/molinosagro/ai-engineering/_git/ai-engineering
```

Si GitHub Copilot CLI no está instalada, el propio comando ofrece instalarla. La URL va
tal cual, sin agregarle `.git` al final.

## 3. Confirmar que funcionó

Abrir Copilot Chat en modo Agent y preguntarle si reconoce, por ejemplo, `ticket-kickoff`
o `workflow-documenter`.

**¿Y ahora qué se escribe?** [`how-to-use.md`](how-to-use.md) — describir la tarea real
en las propias palabras alcanza, sin necesitar nombrar ninguna capacidad por su ID.

## 4. Actualizar

Desde VS Code: paleta de comandos → **"Extensions: Check for Extension Updates"** (o
automático cada 24 horas, con `extensions.autoUpdate` activo).

## 5. Desinstalar

Desde VS Code: vista **"Agent Plugins - Installed"**, clic derecho sobre el plugin →
**"Uninstall"**.

## 6. Alternativa: que llegue recomendado sin configurar nada

Si el equipo agrega esto al archivo `.github/copilot/settings.json` de su propio
repositorio, cualquiera que lo abra recibe el plugin recomendado automáticamente:

```json
{
  "extraKnownMarketplaces": {
    "moa-ai-engineering": {
      "source": {
        "source": "git",
        "url": "https://dev.azure.com/molinosagro/ai-engineering/_git/ai-engineering"
      }
    }
  }
}
```

Cada developer igual tiene que aceptar la recomendación y el prompt de confianza — no se
instala solo.

## Ver también

- Patrón completo, justificación y hallazgos detallados: [`../integrations/agent-plugin-provider.md`](../integrations/agent-plugin-provider.md).
- Alternativa para equipos (no individual): [`capability-distribution-quickstart.md`](capability-distribution-quickstart.md).
- Camino manual, para probar una sola capacidad sin instalar nada: [`../capabilities/README.md`](../capabilities/README.md).
