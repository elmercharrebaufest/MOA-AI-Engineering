# Instalar las capacidades como plugin de VS Code — Quick Start

**Para quién es**: cualquier persona de un equipo (developer, tech lead, arquitecto) que
usa **VS Code con GitHub Copilot** y quiere usar los `agents`/`skills` de este modelo en
su propio trabajo, sin copiar archivos a mano y sin depender de que un administrador
configure nada. Patrón completo:
[`../integrations/agent-plugin-provider.md`](../integrations/agent-plugin-provider.md).

**Con Claude Code en vez de GitHub Copilot, este Quick Start no aplica** — es una
herramienta separada, con su propio mecanismo de plugin. Ver
[`claude-code-plugin-quickstart.md`](claude-code-plugin-quickstart.md).

**No corresponde este camino si...** el equipo quiere que el cambio llegue automático a
todo el mundo, sin que cada developer instale nada por su cuenta — para eso está
[`capability-distribution-quickstart.md`](capability-distribution-quickstart.md) (requiere
un administrador de Azure DevOps).

**Estado**: `EXECUTED` (2026-09-23) — **confirmado por 2 caminos reales**: por terminal
(GitHub Copilot CLI, 2026-09-22) y por la interfaz de VS Code (2026-09-23). Los Agents
también quedan instalados y reconocidos, no solo las Skills (ver paso 3). Queda 1 aviso
real a tener en cuenta (ver "Aviso importante" más abajo).

## 1. Prerequisitos

- VS Code con GitHub Copilot Chat instalado.
- Acceso de lectura al repositorio `ai-engineering` en Azure DevOps (el mismo acceso ya
  disponible para clonar cualquier otro repo de `molinosagro`).

## 2. Instalar (una sola vez)

**No hace falta tener ningún repositorio propio abierto ni estar en ninguna carpeta en
particular** — se instala una sola vez por máquina, queda en una ubicación global del
usuario, y después aplica a cualquier proyecto que se abra en VS Code.

**Recomendado — desde la propia interfaz de VS Code** (confirmado real, 2026-09-23):
paleta de comandos (`Ctrl+Shift+P` / `Cmd+Shift+P`) → **"Chat: Install Plugin From
Source"** → pegar esta URL:

```
https://dev.azure.com/molinosagro/ai-engineering/_git/ai-engineering
```

El plugin queda instalado y visible en el panel **"Extensions: Agent Plugins"**, con el
nombre y la descripción reales de `ai-engineering`.

**Alternativa — por terminal, con GitHub Copilot CLI** (confirmado real, 2026-09-22):

```
copilot plugin install https://dev.azure.com/molinosagro/ai-engineering/_git/ai-engineering
```

Si GitHub Copilot CLI no está instalada, el propio comando ofrece instalarla en el
momento (responder `y`). La URL funciona **tal cual, sin agregarle `.git` al final**.

**Aviso importante (hallazgo real, 2026-09-22)**: por terminal, al instalar, aparece este
mensaje:

> *"Warning: Direct plugin installs (repos, URLs, local paths) are deprecated. Only
> plugin@marketplace installs will be supported in a future release."*

El comando **funciona hoy**, pero GitHub lo va a discontinuar más adelante — no hace
falta hacer nada distinto por ahora. Detalle de cómo se resolverá esto cuando
corresponda:
[`../integrations/agent-plugin-provider.md`](../integrations/agent-plugin-provider.md#aviso-de-deprecación-hallazgo-real-2026-09-22).

## 3. Confirmar que funcionó

Abrir Copilot Chat en modo Agent y preguntarle qué agents/skills tiene disponibles — por
ejemplo, si reconoce `ticket-kickoff` o `workflow-documenter`.

**Confirmado real (2026-09-23)**: los Agents quedan instalados y reconocidos, con la
descripción real de cada uno — no solo las Skills, aunque el mensaje de instalación solo
mencione *"Installed 10 skills"*.

## 4. Actualizar

**Por terminal (GitHub Copilot CLI, camino confirmado en la documentación oficial)**:

```
copilot plugin update ai-engineering
```

Para actualizar todos los plugins instalados a la vez: `copilot plugin update --all`. Si
no se recuerda el nombre exacto instalado, `copilot plugin list` muestra todos.

**Hallazgo real (2026-09-22)**: en Windows, este comando puede fallar con *"Failed to
update plugin: Access is denied. (os error 5)"* — bug conocido de GitHub Copilot CLI,
no de este repositorio ([issue #4095](https://github.com/github/copilot-cli/issues/4095)).

**Recomendado**: actualizar desde la propia interfaz de VS Code en vez de la terminal
(paleta de comandos → **"Extensions: Check for Extension Updates"**, o automático cada 24
horas con `extensions.autoUpdate`) — evita el conflicto que causa el error.

Si de todas formas se prefiere la terminal: cerrar VS Code por completo antes de correr
el comando resuelve el error.

## 5. Desinstalar por completo

**Recomendado**: en la vista **"Agent Plugins - Installed"** de VS Code, clic derecho
sobre el plugin → **"Uninstall"**.

Por terminal también funciona: `copilot plugin uninstall ai-engineering`. Si da el mismo
error de Windows que "Actualizar" (*"Access is denied"*), cerrar VS Code por completo y
repetir el comando.

Con cualquiera de los 2 caminos no queda nada instalado — no hace falta borrar ningún
archivo a mano.

## 6. Alternativa: que llegue recomendado sin configurar nada

Si el equipo agrega esto al archivo `.github/copilot/settings.json` de su propio
repositorio (Portal de Créditos, por ejemplo), **cualquiera que abra ese repo lo recibe
recomendado automáticamente** — sin que cada developer tenga que pegar la URL a mano:

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

(Igual queda un paso manual: cada developer todavía tiene que aceptar la recomendación y
el prompt de confianza — no se instala solo.)

## Qué hacer si algo no funciona

Reportar exactamente en qué paso falló y qué mensaje mostró VS Code — no se asume que el
mecanismo esté 100% probado, así que cualquier error real es información valiosa, no un
fracaso de la prueba.

## Ver también

- Patrón completo y justificación: [`../integrations/agent-plugin-provider.md`](../integrations/agent-plugin-provider.md).
- Alternativa para equipos (no individual): [`capability-distribution-quickstart.md`](capability-distribution-quickstart.md).
- Camino manual, para probar una sola capacidad sin instalar nada: [`../capabilities/README.md`](../capabilities/README.md).
