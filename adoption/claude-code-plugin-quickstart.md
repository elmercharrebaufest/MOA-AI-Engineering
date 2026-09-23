# Instalar las capacidades como plugin de Claude Code — Quick Start

**Para quién es**: cualquier persona que use **Claude Code** (no VS Code con GitHub
Copilot — para eso está
[`agent-plugin-quickstart.md`](agent-plugin-quickstart.md), un mecanismo distinto).
Patrón completo: [`../integrations/claude-code-plugin-provider.md`](../integrations/claude-code-plugin-provider.md).

**Los pasos son distintos según dónde se use Claude Code** — la CLI de terminal y la
extensión de VS Code no comparten los mismos comandos:

- **"Por terminal"** más abajo significa cualquier línea de comandos (PowerShell, CMD,
  Git Bash, o la terminal integrada de VS Code) donde se ejecuta `claude` — el programa
  de línea de comandos, no algo atado a una terminal en particular.
- **"Extensión de VS Code"** es el panel de chat de Claude Code dentro de VS Code — una
  interfaz gráfica, no una terminal, con sus propios comandos (`/plugins`, no `/plugin`).

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

**Si falla** — con el error `EPERM` / "Failed to finalize marketplace cache", o en
silencio (termina en "No plugins available" y la pestaña Marketplaces queda vacía): es un
bug conocido de Claude Code en Windows, no de este repositorio. Probar en este orden:

1. Borrar restos de intentos anteriores (el error es determinístico si la carpeta destino
   ya existe — reintentar o excluir el antivirus no alcanza en ese caso):
   ```powershell
   Remove-Item -Recurse -Force "$env:USERPROFILE\.claude\plugins\marketplaces\ai-engineering" -ErrorAction SilentlyContinue
   Remove-Item -Recurse -Force "$env:USERPROFILE\.claude\plugins\marketplaces\temp_*" -ErrorAction SilentlyContinue
   ```
   y reintentar agregar el marketplace.
2. Si persiste, excluir la carpeta de Windows Defender (puede no alcanzar si el antivirus
   real del equipo es otro, no Defender):
   ```powershell
   Add-MpPreference -ExclusionPath "$env:USERPROFILE\.claude\plugins"
   ```
3. Si sigue fallando, clonar el repositorio a mano y agregar esa carpeta local en vez de
   la URL — evita por completo el paso de Claude Code que falla:
   ```powershell
   git clone https://dev.azure.com/molinosagro/ai-engineering/_git/ai-engineering "$env:USERPROFILE\.local-marketplaces\ai-engineering"
   ```
   y agregar como marketplace esa ruta local
   (`C:\Users\<usuario>\.local-marketplaces\ai-engineering`) en vez de la URL. No se
   actualiza sola — hay que hacer `git pull` ahí y después
   `/plugin marketplace update ai-engineering` a mano.

## 3. Confirmar que funcionó

Preguntarle a Claude Code, por ejemplo: *"¿reconoce el agent `ticket-kickoff` o
`workflow-documenter`?"*.

**¿Y ahora qué se escribe?** [`how-to-use.md`](how-to-use.md) — describir la tarea real
en las propias palabras alcanza, sin necesitar nombrar ninguna capacidad por su ID.

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
