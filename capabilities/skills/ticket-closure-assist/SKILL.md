---
name: ticket-closure-assist
description: Verifica el cumplimiento de los criterios de aceptación de un ticket y redacta un borrador de comentario de cierre. Usar al terminar una historia, nunca para cambiar el estado del ticket automáticamente.
---

# ticket-closure-assist

**Capability Registry**: [`CAP-011`](../../../registry/entries/ticket-closure-assist.md).
**Golden Path**: [`AI-Assisted Development`](../../../golden-paths/README.md#2-ai-assisted-development)
(extensión — ver nota en ese Golden Path).
**Estado**: `PROPOSAL` — sin ejecución real ni piloto de ningún equipo todavía. Ver la
entrada del Registry para el detalle de evidencia.

## Propósito

Al terminar una historia de usuario, verificar cuáles de sus criterios de aceptación
quedaron efectivamente cumplidos y redactar un borrador de comentario de cierre —
reduciendo el registro manual propenso a omisión que describe el KO para esta etapa, sin
cambiar el estado del ticket por sí misma.

## Cuándo usarla

- La historia está desarrollada (y, si corresponde, revisada) y se necesita un resumen de
  cierre antes de mover el ticket a "Done"/"Cerrado".

## Cuándo NO usarla

- Para cambiar el estado del ticket automáticamente — esta skill redacta un borrador, la
  acción de cerrar el ticket la toma siempre una persona.
- Cuando los criterios de aceptación no están definidos — sin ellos no hay contra qué
  verificar cumplimiento; corresponde primero completar CAP-002.

## Entradas

Los criterios de aceptación de la historia (CAP-002) y evidencia real de que se
cumplieron (tests pasando, PR mergeado, validación de QA) — nunca una suposición de que
"probablemente" se cumplieron.

## Salidas

Un borrador de comentario de cierre: qué criterios se verificaron cumplidos, cuáles no
(si los hay), y un recordatorio de registro de horas si el equipo lo requiere.

## Instrucciones

### 1. Verificación de criterios

Por cada criterio de aceptación de la historia, señalar si hay evidencia real de
cumplimiento (test asociado, validación de QA registrada) o no:

```text
✅ [criterio] — verificado por [evidencia real: test/PR/validación de QA]
❌ [criterio] — sin evidencia de cumplimiento verificada
```

**Nunca marcar un criterio como cumplido sin una evidencia real citada.** Si no hay forma
de verificarlo con el contexto disponible, declararlo explícitamente:

```text
❓ [criterio] — no fue posible verificar cumplimiento con el contexto disponible;
   corresponde que [PO/QA] lo confirme antes de cerrar el ticket.
```

### 2. Borrador de comentario de cierre

```text
Resumen de cierre

Criterios verificados: [N de M]
[detalle de la verificación del paso 1]

Registro de horas: [recordatorio si el equipo lo requiere — nunca inventar un valor]
```

### 3. Recomendación si hay criterios sin verificar

Si algún criterio queda `❌` o `❓`, la skill no recomienda cerrar el ticket todavía —
debe decirlo explícitamente, igual que la Recomendación de CAP-002 ante gaps bloqueantes.

## Cómo usar esta capability

### Entrada

```
Ticket:
MOA-XXXX

Criterios de aceptación:
[los mismos criterios reales de CAP-002]

Evidencia de cumplimiento:
[tests, PR, validación de QA disponibles — real, no inventada]
```

### Patrón de ejecución

```
Usa la capability CAP-011 ticket-closure-assist.

Criterios de aceptación reales:
[los criterios]

Evidencia de cumplimiento disponible:
[la evidencia real]

Verificá cada criterio contra la evidencia y redactá el borrador de comentario de cierre.

No marques como cumplido ningún criterio sin evidencia real citada.
No cambies el estado del ticket — esto es solo un borrador para que una persona lo revise
y publique.
```

### Revisión humana

Obligatoria: la persona que cierra el ticket debe confirmar el borrador antes de
publicarlo y cambiar el estado — esta skill nunca actúa sobre Jira/Azure DevOps por sí
misma.

### Evidencia / Evaluación / Medición

Mismo mecanismo que el resto del Registry —
[Evidence Record](../../../adoption/templates/evidence-record.md),
[Evaluation Record](../../../adoption/templates/evaluation-record.md),
[Measurement Record](../../../adoption/templates/measurement-record.md).

## Dependencias

Reutiliza los criterios de aceptación de CAP-002 y, cuando aplica, el Resolved Context de
CAP-007/CAP-008 — no define un mecanismo de acceso a tickets propio.

## Herramientas / permisos

Ninguna — produce texto estructurado; no cambia el estado del ticket ni publica el
comentario por sí misma.

## Seguridad

Riesgo bajo — solo lectura de criterios y evidencia ya existente; ninguna acción sobre
sistemas externos.

## Origen de esta propuesta

**Existing Practice**: ninguna instancia real en MOA. La propia
`architecture/ai-sdlc.md` no incluía esta etapa en su tabla de cobertura real — se agregó
la fila faltante como parte de este mismo trabajo (`architecture/ai-sdlc.md`, etapa
"Cierre del ticket"). KO Interno pág. 26 (*"Copilot + Skills + MCP Jira sugiere registro
de horas y actualiza estado automáticamente"*) — nótese que el KO propone incluso la
actualización automática de estado; esta propuesta es deliberadamente más conservadora
(solo borrador, nunca acción directa), por el mismo principio `READ` antes que `ACT` que
ya rige CAP-002/007/008. **External Best Practice**: verificar criterios de aceptación
contra evidencia real antes de cerrar un ticket es una práctica estándar de Definition of
Done en metodologías ágiles. **Architectural Judgment**: reutiliza los criterios ya
producidos por CAP-002, evita construir un mecanismo de verificación nuevo.

## Compatibilidad / adaptación

Portable a cualquier equipo que ya use CAP-002 — sin contenido específico de dominio que
adaptar. El recordatorio de registro de horas es opcional, según si el equipo lo requiere.
