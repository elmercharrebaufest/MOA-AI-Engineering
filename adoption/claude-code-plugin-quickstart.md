# Instalar las capacidades como plugin de Claude Code — Quick Start

**Para quién es**: cualquier persona que use **Claude Code** (no VS Code con GitHub
Copilot — para eso está
[`agent-plugin-quickstart.md`](agent-plugin-quickstart.md), un mecanismo distinto).
Patrón completo: [`../integrations/claude-code-plugin-provider.md`](../integrations/claude-code-plugin-provider.md).

**Estado**: `CONFIGURED` (2026-09-23) — estructura construida, sin instalación real
todavía. Si algo no funciona como está descrito acá, es información real y valiosa —
reportarlo.

**Hallazgo real (2026-09-23)**: `/plugin marketplace add ...` es un comando de la CLI de
terminal — dentro de la **extensión de Claude Code para VS Code** devuelve *"/plugin
isn't available in this environment"*. Los pasos de abajo distinguen los 2 casos.

## 1. Prerequisito

Claude Code instalado y autenticado — por terminal, o como extensión de VS Code.

## 2. Instalar (una sola vez)

**Extensión de Claude Code en VS Code — recomendado, un clic**: abrir este enlace
(pegarlo en la barra de direcciones del navegador, o directamente en VS Code):

```
vscode://anthropic.claude-code/install-plugin?plugin=ai-engineering&marketplace=https://dev.azure.com/molinosagro/ai-engineering/_git/ai-engineering
```

Abre VS Code, el panel de Claude Code, y el diálogo de instalación ya listo — solo falta
elegir el alcance (para mí / para este proyecto / solo acá).

**Extensión de VS Code — alternativa manual**: escribir `/plugins` en el cuadro de
mensaje de Claude Code → pestaña **Marketplaces** → agregar esta URL:
`https://dev.azure.com/molinosagro/ai-engineering/_git/ai-engineering` → pestaña
**Plugins** → buscar `ai-engineering` → **Install**.

**Por terminal**:

```
/plugin marketplace add https://dev.azure.com/molinosagro/ai-engineering/_git/ai-engineering
/plugin install ai-engineering@ai-engineering
```

Si aparece el mensaje `Run /reload-plugins to activate.`, correr ese comando.

## 3. Confirmar que funcionó

Preguntarle a Claude Code, por ejemplo: *"¿reconoce el agent `ticket-kickoff` o
`workflow-documenter`?"*.

## 4. Actualizar

**Extensión de VS Code**: `/plugins` → pestaña **Marketplaces** → ícono de actualizar
sobre `ai-engineering`.

**Por terminal**:

```
/plugin marketplace update ai-engineering
```

## 5. Desinstalar

**Extensión de VS Code**: `/plugins` → pestaña **Plugins** → desactivar el interruptor
de `ai-engineering`, o quitarlo desde la pestaña **Marketplaces** con el ícono de
papelera.

**Por terminal**:

```
/plugin uninstall ai-engineering@ai-engineering
```

## Qué hacer si algo no funciona

Reportar exactamente en qué paso falló y qué mensaje mostró Claude Code — esta guía
todavía no tiene ninguna instalación real confirmada, así que cualquier resultado real es
información valiosa.

## Ver también

- Patrón completo y justificación: [`../integrations/claude-code-plugin-provider.md`](../integrations/claude-code-plugin-provider.md).
- Mismo mecanismo para VS Code / GitHub Copilot (herramienta distinta):
  [`agent-plugin-quickstart.md`](agent-plugin-quickstart.md).
- Camino manual, para probar una sola capacidad sin instalar nada: [`../capabilities/README.md`](../capabilities/README.md).
