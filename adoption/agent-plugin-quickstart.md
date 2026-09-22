# Instalar las capacidades como plugin de VS Code — Quick Start

**Para quién es**: cualquier persona de un equipo (developer, tech lead, arquitecto) que
quiere usar los `agents`/`skills` de este modelo en su propio trabajo, sin copiar archivos
a mano y sin depender de que un administrador configure nada. Patrón completo:
[`../integrations/agent-plugin-provider.md`](../integrations/agent-plugin-provider.md).

**No es esto si...** tu equipo quiere que el cambio le llegue automático a todo el mundo,
sin que cada developer instale nada por su cuenta — para eso está
[`capability-distribution-quickstart.md`](capability-distribution-quickstart.md) (requiere
un administrador de Azure DevOps).

**Estado**: `EXECUTED` (2026-09-22) — **primera instalación real ya ocurrió, vía GitHub
Copilot CLI, con éxito**. Salida real: *"Plugin 'ai-engineering' installed successfully.
Installed 10 skills."* Sigue habiendo 1 cosa importante sin confirmar (ver paso 3) y 1
aviso real a tener en cuenta (ver "Aviso importante" antes del paso 2b).

## 1. Prerequisitos

- VS Code con GitHub Copilot Chat instalado.
- Acceso de lectura al repositorio `ai-engineering` en Azure DevOps (el mismo acceso que
  ya tenés para clonar cualquier otro repo de `molinosagro`).

## 2. Instalar (una sola vez)

**No hace falta tener ningún repositorio propio abierto ni estar parado en ninguna
carpeta en particular** — se instala una sola vez por máquina, queda en una ubicación
global del usuario, y después aplica a cualquier proyecto que abras en VS Code.

**Camino confirmado — por terminal, con GitHub Copilot CLI** (esta es la forma que ya
funcionó de verdad):

```
copilot plugin install https://dev.azure.com/molinosagro/ai-engineering/_git/ai-engineering
```

Si no tenés instalada GitHub Copilot CLI, el propio comando te ofrece instalarla en el
momento (respondé `y`). La URL funciona **tal cual, sin agregarle `.git` al final** —
confirmado con una instalación real. No hace falta estar parado en ninguna carpeta en
particular — queda en una ubicación global del usuario (`~/.copilot/installed-plugins/...`)
y después aplica a cualquier proyecto que abras.

**Aviso importante (hallazgo real, 2026-09-22)**: al instalar vas a ver este mensaje:

> *"Warning: Direct plugin installs (repos, URLs, local paths) are deprecated. Only
> plugin@marketplace installs will be supported in a future release."*

El comando de arriba **funciona hoy**, pero GitHub lo va a discontinuar más adelante —
no hace falta hacer nada distinto por ahora, es solo para que no te sorprenda el aviso.
Detalle de cómo se resolverá esto cuando corresponda:
[`../integrations/agent-plugin-provider.md`](../integrations/agent-plugin-provider.md#aviso-de-deprecación-hallazgo-real-2026-09-22).

## 2b. Alternativa por la interfaz de VS Code (todavía sin confirmar)

Si preferís no usar la terminal: paleta de comandos (`Ctrl+Shift+P` / `Cmd+Shift+P`) →
**"Chat: Install Plugin From Source"** → pegar la misma URL de arriba. **Esta vía
todavía no la probó nadie real** (la que sí se confirmó fue la de terminal) — si la
probás, contanos si te pidió autenticarte y cómo.

## 3. Confirmar que funcionó — con un chequeo extra importante

Abrí Copilot Chat en modo Agent, y preguntale qué agents/skills tiene disponibles.

**Punto crítico a confirmar (la instalación real solo mencionó "10 skills", nada de
Agents)**: preguntale explícitamente por un **Agent**, no solo por Skills — por ejemplo
*"¿reconocés el agent `ticket-kickoff` o `workflow-documenter`?"*. Si Copilot Chat no los
reconoce, es información real importante — puede ser que solo se hayan instalado las
Skills y no los Agents, algo que todavía no confirmamos.

## 4. Actualizar

No hace falta hacer nada manualmente si tenés activado `extensions.autoUpdate` en VS Code
(se actualiza solo, cada 24 horas). Si preferís controlarlo vos:

1. Paleta de comandos → **"Extensions: Check for Extension Updates"**.

## 5. Alternativa: que te llegue recomendado sin configurar nada

Si tu equipo agrega esto al archivo `.github/copilot/settings.json` de su propio
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

Contanos exactamente en qué paso falló y qué mensaje mostró VS Code — no asumimos que el
mecanismo esté 100% probado, así que cualquier error real es información valiosa, no un
fracaso de la prueba.

## Ver también

- Patrón completo y justificación: [`../integrations/agent-plugin-provider.md`](../integrations/agent-plugin-provider.md).
- Alternativa para equipos (no individual): [`capability-distribution-quickstart.md`](capability-distribution-quickstart.md).
- Camino manual, para probar una sola capacidad sin instalar nada: [`../capabilities/README.md`](../capabilities/README.md).
