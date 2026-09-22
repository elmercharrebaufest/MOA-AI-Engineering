# Instalar las capacidades como plugin de VS Code — Quick Start

**Para quién es**: cualquier persona de un equipo (developer, tech lead, arquitecto) que
quiere usar los `agents`/`skills` de este modelo en su propio trabajo, sin copiar archivos
a mano y sin depender de que un administrador configure nada. Patrón completo:
[`../integrations/agent-plugin-provider.md`](../integrations/agent-plugin-provider.md).

**No es esto si...** tu equipo quiere que el cambio le llegue automático a todo el mundo,
sin que cada developer instale nada por su cuenta — para eso está
[`capability-distribution-quickstart.md`](capability-distribution-quickstart.md) (requiere
un administrador de Azure DevOps).

**Estado**: `PROPOSAL` — la estructura está lista, **todavía nadie lo probó de verdad**.
Sos, muy probablemente, la primera persona en intentarlo — si algo no funciona como acá
dice, es información real y valiosa para corregir la guía, avisá igual.

## 1. Prerequisitos

- VS Code con GitHub Copilot Chat instalado.
- Acceso de lectura al repositorio `ai-engineering` en Azure DevOps (el mismo acceso que
  ya tenés para clonar cualquier otro repo de `molinosagro`).

## 2. Instalar (una sola vez)

1. Abrí la paleta de comandos (`Ctrl+Shift+P` / `Cmd+Shift+P`).
2. Escribí y elegí: **"Chat: Install Plugin From Source"**.
3. Pegá esta URL exacta:
   ```
   https://dev.azure.com/molinosagro/ai-engineering/_git/ai-engineering
   ```
4. VS Code va a mostrar un aviso de confianza la primera vez — revisalo y confirmá.
5. Si te pide autenticarte, usá las mismas credenciales que ya usás para Azure DevOps
   (Git Credential Manager). **Este paso es el que todavía no probamos con nadie real** —
   si falla o pide algo distinto, es el dato más importante que nos podés dar.

## 2b. Alternativa por línea de comandos (si preferís terminal a la UI de VS Code)

VS Code en sí no tiene un comando de instalación por terminal — pero **GitHub Copilot
CLI** (herramienta separada, comando `copilot`, se instala aparte de VS Code) sí lo
tiene, y acepta cualquier URL de Git, no solo GitHub (verificado en documentación oficial
2026-09-22):

```
copilot plugin install https://dev.azure.com/molinosagro/ai-engineering/_git/ai-engineering
```

VS Code detecta automáticamente los plugins instalados por esta vía. **Tampoco probado
todavía con nadie real** — si preferís este camino, contanos cómo salió, es el mismo tipo
de dato valioso que el paso 2.

## 3. Confirmar que funcionó

Abrí Copilot Chat en modo Agent, y preguntale qué agents/skills tiene disponibles — debería
reconocer los de este modelo (por ejemplo, `user-story`, `read-only-code-reviewer`).

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
