---
name: test-case-generation
description: Deriva casos de prueba funcionales a partir de los criterios de aceptación de una historia de usuario. Usar antes de la validación de QA, nunca como sustituto de la revisión exploratoria.
---

# test-case-generation

**Idioma de la respuesta**: español neutro y formal: tratar a la persona de usted, sin
voseo ni regionalismos, aunque la persona escriba de otra forma.

## Propósito

Derivar casos de prueba funcionales a partir de los criterios de aceptación ya definidos
por [`user-story`](../../capabilities/skills/user-story/SKILL.md) (CAP-001), para que QA dedique el tiempo a
validación exploratoria y de negocio en vez de a redactar desde cero los casos que ya se
desprenden directamente de los criterios.

## Cuándo usarla

- Ya existe una historia de usuario con criterios de aceptación en formato Given/When/Then
  (CAP-001), y se necesita traducirlos a casos de prueba ejecutables por una persona.

## Cuándo NO usarla

- Como sustituto de la validación exploratoria — esta skill cubre los criterios ya
  escritos, no descubre casos que nadie pensó.
- Para generar tests automatizados de regresión — eso corresponde a un mecanismo de
  ejecución automática (ej. MCP Playwright), que hoy no existe en ningún repo de MOA y
  queda fuera del alcance de esta skill (ver `architecture/ai-sdlc.md`, etapa "Test de
  regresión", `REQUIRES VALIDATION`).

## Entradas

Una historia de usuario con criterios de aceptación reales (salida de CAP-001, o
equivalente si el equipo ya tiene sus propios criterios documentados).

## Salidas

Casos de prueba funcionales, uno por criterio de aceptación como mínimo, listos para
revisión de QA. Si la persona lo pide, se publican como comentario del ticket siguiendo
[`ticket-update`](../../capabilities/skills/ticket-update/SKILL.md), con confirmación.

## Instrucciones

### 1. Un caso de prueba por criterio de aceptación

```text
Caso [N]: [nombre descriptivo del escenario]
Precondición: [contexto del criterio Given]
Pasos:
  1. [acción del criterio When]
  2. [pasos intermedios necesarios, si el criterio los implica]
Resultado esperado: [el resultado del criterio Then, expresado de forma verificable]
```

### 2. Cobertura mínima

Cada criterio de aceptación de la historia debe tener al menos un caso — no traducir solo
el camino feliz. Si la historia ya distingue camino feliz / validación o error / caso
borde (formato de CAP-001), mantener esa misma distinción en los casos generados.

### 3. Casos no cubiertos por los criterios

Si al derivar los casos aparece un escenario que los criterios de aceptación no
contemplan, señalarlo como gap — no inventar un criterio nuevo para justificarlo:

```text
⚠️ Caso no cubierto por los criterios de aceptación: [descripción]. No se genera un caso
   de prueba para esto porque no hay un criterio que lo respalde — corresponde que QA o
   el PO lo revise antes de darlo por cerrado.
```

### 4. Cierre, siempre

```text
✅ Casos listos para revisión de QA. Si se quieren dejar en el ticket, puedo publicarlos
   como comentario con su confirmación. Con la validación de QA, corresponde pedirle al
   asistente que evalúe cuáles conviene automatizar y cuáles quedan como ejecución
   manual — esta skill no toma esa decisión por sí misma.
```

## Cómo pedirlo

### Entrada

```
Ticket:
MOA-XXXX

Criterios de aceptación:
[los criterios reales de CAP-001 para esta historia, sin parafrasear]
```

### Patrón de ejecución

```
Necesito los casos de prueba de esta historia a partir de sus criterios de aceptación:
[criterios reales, o la clave del ticket]
```

### Revisión humana

Obligatoria, sin excepción: QA debe validar los casos generados antes de considerarlos
parte de la cobertura oficial — la generación automática no reemplaza el criterio de QA.

## Dependencias

Reutiliza los criterios de aceptación producidos por
[`user-story`](../../registry/entries/user-story.md) (CAP-001) y, cuando el ticket se
resuelve automáticamente, el Resolved Context de CAP-002/CAP-003 — no define un mecanismo
de acceso a tickets propio.

## Herramientas / permisos

Ninguna propia — produce texto estructurado y no ejecuta ningún test. La publicación
como comentario la hace el asistente siguiendo `ticket-update`, con confirmación.

## Seguridad

Riesgo bajo — no toca sistemas externos ni ejecuta código; opera sobre texto ya generado
por otra capacidad del mismo Registry.

## Origen de esta propuesta

**Existing Practice**: cero evidencia real dentro de MOA (`architecture/ai-sdlc.md`, etapa
"Testing funcional (QA)", `PROPOSAL` conceptual únicamente) — el único precedente
adyacente es el agent `qa-tester` de DataAgro, ya evaluado y descartado como
TEAM-SPECIFIC (`docs/history/track-1/G5.1-Reusable-Capability-Library.md`).
**External Best Practice**: derivar casos de prueba desde criterios de aceptación
estructurados (Given/When/Then, BDD) es práctica estándar de la industria, la misma base
que usan frameworks BDD como Cucumber/SpecFlow. **Architectural Judgment**: en vez de
inventar un formato de criterios nuevo, esta skill consume directamente el output ya
validado de CAP-001 — reutiliza, no duplica.

## Compatibilidad / adaptación

Portable a cualquier equipo que ya use CAP-001 — sin contenido específico de dominio que
adaptar.
