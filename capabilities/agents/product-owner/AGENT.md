---
name: product-owner
description: Refina requerimientos y tareas de usuario con una persona persistente de Product Owner, consultando el ticket real vía MCP Atlassian con alcance acotado. Usar cuando el equipo prefiere un rol de Agent en vez de invocar la skill directamente.
tools: ["com.atlassian/atlassian-mcp-server/getJiraIssue"]
---

> **`model` deliberadamente ausente del frontmatter.** Misma nota que en
> `read-only-code-reviewer` (CAP-012) — cada equipo agrega su propio `model:` real al
> adoptar este Agent.
>
> **`tools` deliberadamente acotado a una sola herramienta de lectura, nunca wildcard.**
> Este es el punto central de esta propuesta — ver "Origen de esta propuesta" abajo.

# product-owner

**Capability Registry**: [`CAP-004`](../../../registry/entries/product-owner.md).
**Golden Path**: [`AI-Assisted Requirements`](../../../golden-paths/README.md#1-ai-assisted-requirements)
y [`MCP / Integration Onboarding`](../../../golden-paths/README.md#6-mcp--integration-onboarding).
**Estado**: `PROPOSAL` — sin ejecución real ni piloto de ningún equipo todavía. Ver la
entrada del Registry para el detalle de evidencia.

## Propósito

Empaquetar como Agent la misma función que ya generaliza
[`user-story`](../../skills/user-story/SKILL.md) (CAP-001) — refinar un requerimiento
crudo en historia de usuario, criterios de aceptación, reglas de negocio y análisis de
gaps — para los equipos que prefieren un rol persistente de Product Owner en vez de
invocar la skill directamente, con acceso de solo lectura y acotado al ticket real vía MCP
Atlassian.

**No inventa una función nueva**: la lógica de refinamiento es exactamente la de CAP-001
— este Agent solo agrega la persona persistente y la consulta directa del ticket vía MCP,
con el scope de acceso corregido respecto a la instancia real observada.

## Cuándo usarlo

- El equipo ya usa un MCP de Atlassian configurado y prefiere invocar un rol de Agent con
  persona propia, en vez de pegar el contenido del ticket manualmente en la skill.

## Cuándo NO usarlo

- No le agregues un scope de MCP más amplio que `getJiraIssue` "para que también pueda
  comentar o cambiar el estado" — esto rompe el principio `READ` que es la razón de ser de
  este Agent, y reproduce exactamente el hallazgo de riesgo que motivó esta propuesta (ver
  abajo). Si se necesita esa función, es un Agent distinto, con su propia matriz de
  autonomía y revisión humana explícita.
- No lo uses como aprobador de que una historia está lista para Planning — la
  recomendación que produce es un insumo para que un humano decida, igual que CAP-001.

## Entradas

Una referencia real de ticket (ej. `MOA-1234`), resuelta directamente por este Agent vía
`getJiraIssue`.

## Salidas

Historia de usuario + criterios de aceptación + reglas de negocio + análisis de gaps +
recomendación de próximo paso si hay gaps bloqueantes — mismo formato y mismas reglas que
[`user-story`](../../skills/user-story/SKILL.md) (CAP-001), sin duplicar esa
documentación acá.

## Instrucciones

1. Recibí la referencia real del ticket.
2. Consultalo con `getJiraIssue` — nunca con una herramienta de escritura ni con un scope
   más amplio que el declarado en `tools`.
3. Aplicá exactamente las instrucciones de
   [`user-story`](../../skills/user-story/SKILL.md) (CAP-001) sobre el contenido real
   devuelto — estructura, formato, y la regla de priorizar siempre al `reporter` sobre el
   `assignee` en la recomendación.
4. Nunca discutas ni propongas implementación técnica — este Agent refina el
   requerimiento, no diseña la solución.
5. Presentá el resultado para revisión humana — nunca lo publiques como comentario del
   ticket ni cambies su estado.

## Dependencias

- MCP Atlassian configurado y autenticado por el desarrollador (mismo mecanismo ya
  documentado en [`adoption/context-providers-quickstart.md`](../../../adoption/context-providers-quickstart.md)
  §3a) — este Agent no define un mecanismo de autenticación propio.
- La lógica de refinamiento de [`user-story`](../../skills/user-story/SKILL.md) (CAP-001).

## Herramientas / permisos

`tools: ["com.atlassian/atlassian-mcp-server/getJiraIssue"]` — una sola herramienta, de
solo lectura, sin wildcard. Nunca ampliar sin una justificación documentada y una revisión
de seguridad explícita, siguiendo el modelo de riesgo de
[`security/security-governance.md`](../../../security/security-governance.md) §1.

## Seguridad

Riesgo bajo por diseño estructural: el scope de MCP está acotado a una sola operación de
lectura, no por una restricción declarada solo en prosa.

## Handoff

El patrón de handoff hacia un futuro Agent `architect` (visto en la instancia real de
Orquestador, en una rama no integrada, sin evidencia de ejecución) **no se implementa
todavía en esta propuesta** — queda `VALIDATE`, igual que en `architecture/capability-model.md`.
Este Agent está diseñado para admitirlo en una iteración futura, sin que eso implique
construirlo ahora sin evidencia de que un equipo real lo necesita.

## Revisión humana

Obligatoria, sin excepción — mismo criterio que CAP-001: un PO o referente funcional debe
validar el resultado antes de Planning/desarrollo.

## Origen de esta propuesta

**Existing Practice**: el agent `product-owner` de Orquestador/Scato Logística está en
uso real e intensivo para esta misma función (reunión con el equipo de Scato Logística,
2026-09-18) — pero fue evaluado y clasificado TEAM-SPECIFIC en
`docs/history/track-1/G5.1-Reusable-Capability-Library.md` por contenido específico de
dominio, no por la función en sí (que ya está generalizada en CAP-001). La misma
instancia real declara acceso MCP sin acotar (wildcard
`'com.atlassian/atlassian-mcp-server/*'`), a diferencia del patrón acotado
(`getJiraIssue`) que usa el agent `architect` del mismo repositorio —
hallazgo de riesgo real, escalado en
[`governance/BLOCKED-DECISIONS.md`](../../../governance/BLOCKED-DECISIONS.md) #4 y
detallado en `security/security-governance.md`. **External Best Practice**: acceso de
mínimo privilegio (nunca wildcard sin justificación) es el mismo principio ya aplicado por
CAP-012 (`read-only-code-reviewer`, sin `tools: edit`) y por CAP-003 (`jira-context`,
scope acotado). **Architectural Judgment**: esta propuesta no reabre la clasificación
TEAM-SPECIFIC del `product-owner` original — construye un Agent nuevo en el Common Core
que reutiliza la lógica ya validada de CAP-001 y corrige el scope de acceso desde el día
uno, en vez de generalizar el contenido específico de dominio de ningún equipo.

## Compatibilidad / adaptación

Portable a cualquier equipo con MCP Atlassian configurado — sin contenido específico de
dominio que adaptar, más allá de lo que ya requiere CAP-001 (tabla de roles reales).
