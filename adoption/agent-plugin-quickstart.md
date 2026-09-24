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

## 2. Revisar qué hay instalado (siempre, antes de instalar)

**Regla de MOA**: una sola instalación de `ai-engineering` por máquina — la que proviene
del marketplace `ai-engineering`. La plataforma no impide instalar otra copia; por eso se
revisa antes.

En una terminal (PowerShell, CMD, Git Bash, o la integrada de VS Code) donde esté
disponible el comando `copilot`:

```
copilot plugin list --json
```

| Qué aparece | Qué significa | Qué hacer |
|---|---|---|
| Ninguna entrada con `"name": "ai-engineering"` | No está instalado | Punto 3 |
| Una sola, con `"marketplace": "ai-engineering"` | Instalación correcta | Nada — **no volver a instalar**. Punto 4 |
| Una con `"marketplace": ""` | Instalación directa, no proviene del marketplace | Desinstalarla (punto 6), después punto 3 |
| Más de una | Duplicado — estado no soportado | Desinstalar todas salvo la de `"marketplace": "ai-engineering"` (punto 6) |

## 3. Instalar (solo si el punto 2 lo indica)

Se instala una sola vez por máquina y aplica a cualquier proyecto que se abra en VS Code
— no hace falta tener ningún repositorio propio abierto.

```
copilot plugin marketplace add https://dev.azure.com/molinosagro/ai-engineering/_git/ai-engineering
copilot plugin install ai-engineering@ai-engineering
```

El primer comando registra este repositorio como marketplace; el segundo instala el plugin
desde ahí. Es el mecanismo recomendado de distribución para MOA. Si GitHub Copilot CLI no
está instalada, el propio comando ofrece instalarla. La URL va tal cual, sin `.git` al
final.

Después, repetir `copilot plugin list --json` y confirmar que quedó **una sola** entrada
`ai-engineering`, con `"marketplace": "ai-engineering"`.

**No usar para MOA** "Chat: Install Plugin From Source" en VS Code ni `copilot plugin
install <URL>` directo: instalan desde el repositorio sin pasar por el marketplace
(quedan con `"marketplace": ""`), el CLI las marca como deprecadas, y si ya existe la
instalación correcta, suman una copia más.

## 4. Confirmar que funcionó

Abrir Copilot Chat en modo Agent y preguntarle si reconoce, por ejemplo, `ticket-kickoff`
o `workflow-documenter`.

**¿Y ahora qué se escribe?** [`how-to-use.md`](how-to-use.md) — describir la tarea real
en las propias palabras alcanza, sin necesitar nombrar ninguna capacidad por su ID.

## 5. Actualizar

```
copilot plugin update ai-engineering@ai-engineering
```

Después, `copilot plugin list --json`: confirmar la versión nueva y que sigue habiendo una
sola entrada. El panel de VS Code no muestra botón de actualizar para este plugin, y no hay
actualización automática confirmada — la actualización se pide con este comando.

En Windows, si falla con `Access is denied. (os error 5)`: punto 7.

## 6. Desinstalar

```
copilot plugin uninstall ai-engineering@ai-engineering
```

Para una instalación directa (`"marketplace": ""`), usar el nombre tal como lo muestra
`copilot plugin list`, sin `@...`. También se puede desde VS Code: `@agentPlugins` en la
vista Extensions → `ai-engineering` → **"Uninstall"**.

Después, `copilot plugin list --json` para confirmar que la copia ya no aparece. Si sigue
apareciendo, o el comando falla con `Access is denied. (os error 5)`: punto 7.

## 7. Windows: `Access is denied. (os error 5)`

Problema conocido de GitHub Copilot CLI en Windows, no de este repositorio
([github/copilot-cli#4095](https://github.com/github/copilot-cli/issues/4095)): mientras VS
Code está abierto, su extensión de Copilot mantiene tomada la carpeta del plugin instalado,
y Windows no permite reemplazarla ni borrarla. Puede afectar a instalar, actualizar y
desinstalar — incluido el "Uninstall" del panel de VS Code, que confirma pero deja el
plugin en su lugar.

1. Cerrar **todas** las ventanas de VS Code (con eso también se cierra su terminal
   integrada).
2. Abrir una terminal aparte (PowerShell, CMD o Git Bash) y repetir el mismo comando.
3. Confirmar con `copilot plugin list --json`.
4. Volver a abrir VS Code.

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
3, para no terminar con una instalación de otro marketplace; y aplica igual el punto 2
antes de aceptar.

## Ver también

- Patrón completo, justificación y hallazgos detallados: [`../integrations/agent-plugin-provider.md`](../integrations/agent-plugin-provider.md).
- Alternativa para equipos (no individual): [`capability-distribution-quickstart.md`](capability-distribution-quickstart.md).
- Camino manual, para probar una sola capacidad sin instalar nada: [`../capabilities/README.md`](../capabilities/README.md).
