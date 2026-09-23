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

**Recomendado, por terminal con GitHub Copilot CLI** ("terminal" es cualquier línea de
comandos — PowerShell, CMD, Git Bash, o la terminal integrada de VS Code — donde esté
disponible el comando `copilot`), en 2 pasos:

```
copilot plugin marketplace add https://dev.azure.com/molinosagro/ai-engineering/_git/ai-engineering
copilot plugin install ai-engineering@ai-engineering
```

El primer paso registra este repositorio como fuente; el segundo instala el plugin desde
ahí. Es el camino que va a seguir funcionando a futuro (ver punto 4, Actualizar).

**Alternativa, por la paleta de comandos** (`Ctrl+Shift+P` / `Cmd+Shift+P`) → **"Chat:
Install Plugin From Source"** → pegar esta URL:

```
https://dev.azure.com/molinosagro/ai-engineering/_git/ai-engineering
```

**Alternativa, instalación directa por terminal**:

```
copilot plugin install https://dev.azure.com/molinosagro/ai-engineering/_git/ai-engineering
```

Si GitHub Copilot CLI no está instalada, el propio comando ofrece instalarla. La URL va
tal cual, sin agregarle `.git` al final.

**Si ya se instaló antes por alguno de los 2 caminos alternativos**: no hace falta
desinstalarlo para probar el camino recomendado — pero quedan 2 copias del plugin
instaladas en paralelo (`copilot plugin list` las muestra por separado). Para no tener
duplicados, desinstalar la copia anterior siguiendo el punto 5 (Desinstalar) y quedarse
solo con la instalada vía marketplace.

## 3. Confirmar que funcionó

Abrir Copilot Chat en modo Agent y preguntarle si reconoce, por ejemplo, `ticket-kickoff`
o `workflow-documenter`.

**¿Y ahora qué se escribe?** [`how-to-use.md`](how-to-use.md) — describir la tarea real
en las propias palabras alcanza, sin necesitar nombrar ninguna capacidad por su ID.

## 4. Actualizar

`ai-engineering` no tiene un botón de "Update" en su panel de VS Code (a diferencia de
otras extensiones). Por terminal, `copilot plugin update ai-engineering@ai-engineering`
falla en Windows con un error del propio GitHub Copilot CLI, sea cual haya sido el camino
de instalación usado (marketplace o directo) — no es algo que se pueda corregir desde este
repositorio. Para traer los cambios más recientes:

1. Buscar `@agentPlugins` en la vista Extensions (ícono de la barra lateral).
2. Abrir `ai-engineering` → **"Uninstall"**.
3. Volver a instalarlo con el mismo comando o paso usado la primera vez (punto 2 de
   arriba).

También se actualiza solo, sin hacer nada, dentro de las próximas 24 horas, si
`extensions.autoUpdate` está activo en VS Code (valor por defecto).

## 5. Desinstalar

Buscar `@agentPlugins` en la vista Extensions → abrir `ai-engineering` → **"Uninstall"**.

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
