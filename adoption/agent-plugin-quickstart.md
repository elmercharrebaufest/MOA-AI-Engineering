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

- VS Code con GitHub Copilot Chat, y GitHub Copilot CLI (`copilot --version`, 1.0.86 o
  superior; se actualiza con `copilot update`).
- Git, y acceso de lectura al repositorio `ai-engineering` en Azure DevOps.

## 2. Instalar

Una sola vez por máquina; aplica a todos los proyectos. No hace falta clonar nada.

1. Descargar el script: en Azure DevOps, **Repos → Files → `tools/moa-ai.ps1` →
   Download**.
2. Cerrar **todas** las ventanas de VS Code.
3. En PowerShell o Windows Terminal (no en la terminal de VS Code), desde la carpeta de la
   descarga:

```
powershell -ExecutionPolicy Bypass -File .\moa-ai.ps1 install
```

El script registra el marketplace de MOA, instala el plugin (si ya está instalado, no lo
repite; si hay copias duplicadas, pide confirmación para dejar una sola), configura las
Instructions en `~/.copilot/instructions/moa-ai-engineering.instructions.md` y termina
con `doctor`. Al final muestra el comando para actualizar, que ya apunta al script dentro
del plugin instalado: el archivo descargado se puede borrar.

## 3. Verificar

```
powershell -ExecutionPolicy Bypass -File "$HOME\.copilot\installed-plugins\ai-engineering\ai-engineering\tools\moa-ai.ps1" doctor
```

Cada componente sale como `OK`, `WARNING`, `ERROR` o `NOT_VALIDATED` (todavía no
demostrado con una prueba real, ver [`../tools/copilot/VALIDATION.md`](../tools/copilot/VALIDATION.md)).
`status` muestra el resumen. Después, abrir Copilot Chat en modo Agent y describir una
tarea real: [`how-to-use.md`](how-to-use.md).

## 4. Actualizar

Con VS Code cerrado, en una terminal aparte:

```
powershell -ExecutionPolicy Bypass -File "$HOME\.copilot\installed-plugins\ai-engineering\ai-engineering\tools\moa-ai.ps1" update
```

Actualiza solo si hay una versión nueva y muestra la versión anterior y la nueva. No hay
actualización automática.

## 5. Desinstalar

```
copilot plugin uninstall ai-engineering@ai-engineering
```

Borrar también `~/.copilot/instructions/moa-ai-engineering.instructions.md`.

## 6. Windows: `Access is denied. (os error 5)`

Problema conocido de GitHub Copilot CLI en Windows
([github/copilot-cli#4095](https://github.com/github/copilot-cli/issues/4095)): mientras VS
Code está abierto, su extensión de Copilot mantiene tomada la carpeta del plugin y Windows
no permite reemplazarla. Por eso el script exige VS Code cerrado y se niega a correr desde
su terminal. Si el error aparece igual: cerrar todas las ventanas de VS Code, repetir el
comando en una terminal aparte y verificar con `doctor`.

## 7. Sin script

Si la política de la máquina no permite ejecutar scripts de PowerShell, los pasos
equivalentes son `copilot plugin marketplace add
https://dev.azure.com/molinosagro/ai-engineering/_git/ai-engineering` y `copilot plugin
install ai-engineering@ai-engineering`, revisando antes con `copilot plugin list --json`
que no exista otra copia. Las Instructions quedan sin configurar.

## 8. Alternativa: que llegue recomendado sin configurar nada

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

- Patrón completo, justificación y hallazgos detallados: [`../integrations/agent-plugin-provider.md`](../integrations/agent-plugin-provider.md).
- Alternativa para equipos (no individual): [`capability-distribution-quickstart.md`](capability-distribution-quickstart.md).
- Camino manual, para probar una sola capacidad sin instalar nada: [`../capabilities/README.md`](../capabilities/README.md).
