# Instalar las capacidades como plugin de Claude Code — Quick Start

**Para quién es**: cualquier persona que use **Claude Code** (no VS Code con GitHub
Copilot — para eso está
[`agent-plugin-quickstart.md`](agent-plugin-quickstart.md), un mecanismo distinto).
Patrón completo: [`../integrations/claude-code-plugin-provider.md`](../integrations/claude-code-plugin-provider.md).

**Estado**: `CONFIGURED` (2026-09-23) — estructura construida, sin instalación real
todavía. Si algo no funciona como está descrito acá, es información real y valiosa —
reportarlo.

## 1. Prerequisito

Claude Code instalado y autenticado.

## 2. Instalar (una sola vez)

```
/plugin marketplace add https://dev.azure.com/molinosagro/ai-engineering/_git/ai-engineering
/plugin install ai-engineering@ai-engineering
```

Si aparece el mensaje `Run /reload-plugins to activate.`, correr ese comando.

## 3. Confirmar que funcionó

Preguntarle a Claude Code, por ejemplo: *"¿reconocés el agent `ticket-kickoff` o
`workflow-documenter`?"*.

## 4. Actualizar

```
/plugin marketplace update ai-engineering
```

## 5. Desinstalar

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
