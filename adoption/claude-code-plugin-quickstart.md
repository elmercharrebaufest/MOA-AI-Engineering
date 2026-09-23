# Instalar las capacidades como plugin de Claude Code — Quick Start

**Para quién es**: cualquier persona que use **Claude Code** (no VS Code con GitHub
Copilot — para eso está
[`agent-plugin-quickstart.md`](agent-plugin-quickstart.md), un mecanismo distinto).
Patrón completo: [`../integrations/claude-code-plugin-provider.md`](../integrations/claude-code-plugin-provider.md).

**Los pasos son distintos según dónde se use Claude Code** — la CLI de terminal y la
extensión de VS Code no comparten los mismos comandos.

## 1. Prerequisito

Claude Code instalado y autenticado — por terminal, o como extensión de VS Code.

## 2. Instalar (una sola vez)

**Extensión de Claude Code en VS Code**: abrir este enlace (pegarlo en la barra de
direcciones del navegador, o directamente en VS Code):

```
vscode://anthropic.claude-code/install-plugin?plugin=ai-engineering&marketplace=https://dev.azure.com/molinosagro/ai-engineering/_git/ai-engineering
```

Abre VS Code, el panel de Claude Code, y el diálogo de instalación — solo falta elegir el
alcance (para mí / para este proyecto / solo acá). Alternativa manual, sin el enlace:
escribir `/plugins` → pestaña **Marketplaces** → agregar la URL
`https://dev.azure.com/molinosagro/ai-engineering/_git/ai-engineering` → pestaña
**Plugins** → buscar `ai-engineering` → **Install**.

**Por terminal**:

```
/plugin marketplace add https://dev.azure.com/molinosagro/ai-engineering/_git/ai-engineering
/plugin install ai-engineering@ai-engineering
```

Si aparece el mensaje `Run /reload-plugins to activate.`, correr ese comando.

**Si falla con `EPERM` / "Failed to finalize marketplace cache"**: es un bug conocido de
Claude Code en Windows (Windows Defender bloquea unos segundos la carpeta recién
clonada). Reintentar el "Add" suele alcanzar. Si persiste:

```powershell
Add-MpPreference -ExclusionPath "$env:USERPROFILE\.claude\plugins"
```

## 3. Confirmar que funcionó

Preguntarle a Claude Code, por ejemplo: *"¿reconoce el agent `ticket-kickoff` o
`workflow-documenter`?"*.

## 4. Actualizar

**Extensión de VS Code**: `/plugins` → pestaña **Marketplaces** → ícono de actualizar
sobre `ai-engineering`.

**Por terminal**: `/plugin marketplace update ai-engineering`.

## 5. Desinstalar

**Extensión de VS Code**: `/plugins` → pestaña **Plugins** → desactivar el interruptor de
`ai-engineering`, o quitarlo desde la pestaña **Marketplaces**.

**Por terminal**: `/plugin uninstall ai-engineering@ai-engineering`.

## Ver también

- Patrón completo y justificación: [`../integrations/claude-code-plugin-provider.md`](../integrations/claude-code-plugin-provider.md).
- Mismo mecanismo para VS Code / GitHub Copilot (herramienta distinta):
  [`agent-plugin-quickstart.md`](agent-plugin-quickstart.md).
- Camino manual, para probar una sola capacidad sin instalar nada: [`../capabilities/README.md`](../capabilities/README.md).
