# Instalar las capacidades como plugin de VS Code — Quick Start

**Para quién es**: cualquier persona de un equipo (developer, tech lead, arquitecto) que
quiere usar los `agents`/`skills` de este modelo en su propio trabajo, sin copiar archivos
a mano y sin depender de que un administrador configure nada. Patrón completo:
[`../integrations/agent-plugin-provider.md`](../integrations/agent-plugin-provider.md).

**No corresponde este camino si...** el equipo quiere que el cambio llegue automático a
todo el mundo, sin que cada developer instale nada por su cuenta — para eso está
[`capability-distribution-quickstart.md`](capability-distribution-quickstart.md) (requiere
un administrador de Azure DevOps).

**Estado**: `EXECUTED` (2026-09-22) — **primera instalación real ya ocurrió, vía GitHub
Copilot CLI, con éxito**. Salida real: *"Plugin 'ai-engineering' installed successfully.
Installed 10 skills."* Sigue habiendo 1 cosa importante sin confirmar (ver paso 3) y 1
aviso real a tener en cuenta (ver "Aviso importante" antes del paso 2b).

## 1. Prerequisitos

- VS Code con GitHub Copilot Chat instalado.
- Acceso de lectura al repositorio `ai-engineering` en Azure DevOps (el mismo acceso ya
  disponible para clonar cualquier otro repo de `molinosagro`).

## 2. Instalar (una sola vez)

**No hace falta tener ningún repositorio propio abierto ni estar en ninguna carpeta en
particular** — se instala una sola vez por máquina, queda en una ubicación global del
usuario, y después aplica a cualquier proyecto que se abra en VS Code.

**Camino confirmado — por terminal, con GitHub Copilot CLI** (esta es la forma que ya
funcionó de verdad):

```
copilot plugin install https://dev.azure.com/molinosagro/ai-engineering/_git/ai-engineering
```

Si GitHub Copilot CLI no está instalada, el propio comando ofrece instalarla en el
momento (responder `y`). La URL funciona **tal cual, sin agregarle `.git` al final** —
confirmado con una instalación real. No hace falta estar en ninguna carpeta en
particular — queda en una ubicación global del usuario (`~/.copilot/installed-plugins/...`)
y después aplica a cualquier proyecto que se abra.

**Aviso importante (hallazgo real, 2026-09-22)**: al instalar, aparece este mensaje:

> *"Warning: Direct plugin installs (repos, URLs, local paths) are deprecated. Only
> plugin@marketplace installs will be supported in a future release."*

El comando de arriba **funciona hoy**, pero GitHub lo va a discontinuar más adelante —
no hace falta hacer nada distinto por ahora, es solo para que el aviso no sorprenda.
Detalle de cómo se resolverá esto cuando corresponda:
[`../integrations/agent-plugin-provider.md`](../integrations/agent-plugin-provider.md#aviso-de-deprecación-hallazgo-real-2026-09-22).

## 2b. Alternativa por la interfaz de VS Code (todavía sin confirmar)

Si se prefiere no usar la terminal: paleta de comandos (`Ctrl+Shift+P` / `Cmd+Shift+P`) →
**"Chat: Install Plugin From Source"** → pegar la misma URL de arriba. **Esta vía
todavía no la probó nadie real** (la que sí se confirmó fue la de terminal) — si se
prueba, es útil reportar si pidió autenticarse y cómo.

## 3. Confirmar que funcionó — con un chequeo extra importante

Abrir Copilot Chat en modo Agent y preguntarle qué agents/skills tiene disponibles.

**Punto crítico a confirmar (la instalación real solo mencionó "10 skills", nada de
Agents)**: preguntarle explícitamente por un **Agent**, no solo por Skills — por ejemplo
*"¿reconocés el agent `ticket-kickoff` o `workflow-documenter`?"* (o su equivalente en
tercera persona: *"¿está disponible el agent...?"*). Si Copilot Chat no los reconoce, es
información real importante — puede ser que solo se hayan instalado las Skills y no los
Agents, algo que todavía no está confirmado.

## 4. Actualizar

**Por terminal (GitHub Copilot CLI, camino confirmado en la documentación oficial)**:

```
copilot plugin update ai-engineering
```

Para actualizar todos los plugins instalados a la vez: `copilot plugin update --all`. Si
no se recuerda el nombre exacto instalado, `copilot plugin list` muestra todos.

**Hallazgo real (2026-09-22)**: en Windows, este comando puede fallar con *"Failed to
update plugin: Access is denied. (os error 5)"*.

**Causa raíz — externa, no corregible desde este repositorio**: es un bug conocido de
GitHub Copilot CLI en Windows, reportado hoy mismo y todavía abierto, sin confirmación
oficial de GitHub ([issue #4095](https://github.com/github/copilot-cli/issues/4095),
[issue #4937](https://github.com/github/copilot-cli/issues/4937)). Mientras VS Code está
abierto, su extensión de Copilot mantiene handles de archivo sobre la carpeta de plugins
instalados; cuando el CLI (un proceso aparte) intenta reemplazar esa carpeta, Windows
deniega el acceso. El problema vive en la interacción entre 2 herramientas de GitHub/
Microsoft — no hay ningún cambio posible de nuestro lado que lo corrija.

**Solución que sí resuelve la causa (no un parche)**: cerrar todas las ventanas de VS
Code por completo antes de correr el comando — elimina la condición real que provoca el
error, confirmado por otros usuarios con el mismo bug. No es una alternativa "más
confiable", es la forma correcta de ejecutar este comando en Windows hasta que GitHub lo
corrija.

**Alternativa que evita el CLI por completo, si el bug se repite seguido**: administrar
el plugin desde la propia interfaz de VS Code (ver 2b más abajo) en vez de la terminal —
como ahí es VS Code el único proceso que toca esa carpeta, no compite consigo mismo por
el mismo archivo. Esta vía **todavía no la confirmó ningún developer real** — es la
siguiente prueba recomendada si el problema del CLI se vuelve frecuente. Por la interfaz
de VS Code: no hace falta hacer nada manualmente si `extensions.autoUpdate` está activo
(se actualiza solo, cada 24 horas); a mano, paleta de comandos →
**"Extensions: Check for Extension Updates"**.

**Alternativa para todo el equipo, sin depender del CLI ni de VS Code en absoluto**: si
el problema se vuelve recurrente para varias personas, considerar
[`capability-distribution-quickstart.md`](capability-distribution-quickstart.md) — el
contenido llega por Pull Request al repo del equipo, sin usar `copilot plugin` en ningún
paso, así que este bug no aplica ahí. Requiere un administrador de Azure DevOps, no es
autoservicio individual.

## 5. Desinstalar

**Por terminal (GitHub Copilot CLI, camino confirmado en la documentación oficial)**:

```
copilot plugin uninstall ai-engineering
```

**Por la interfaz de VS Code**: en la vista **"Agent Plugins - Installed"**, clic derecho
sobre el plugin → **"Uninstall"**.

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
