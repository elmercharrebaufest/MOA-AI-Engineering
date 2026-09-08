---
name: user-story
description: Plantillas para historias de usuario, criterios de aceptación (Given/When/Then), reglas de negocio (RN-XX) y análisis de gaps. Usar para definir o refinar requerimientos funcionales antes de que lleguen a desarrollo.
---

# user-story

**Capability Registry**: [`CAP-002`](../../../registry/entries/user-story.md).
**Golden Path**: [`AI-Assisted Requirements`](../../../golden-paths/README.md#1-ai-assisted-requirements)
— única capacidad que consume, con **2 ejecuciones reales** (`EXEC-20260907-001`,
`EXEC-20260908-001`).
**Clasificación (G5.1)**: **REUSABLE CAPABILITY** — ADAPT. La **estructura** (Historia/
Criterios/Reglas/Gaps) es Common Core; el **contenido** (roles, ejemplos, dominio) es
Team Adaptation obligatoria, no opcional — ver nota de roles más abajo.

## Propósito

Estructurar un requerimiento crudo (ticket, idea de negocio en lenguaje natural) en una
historia de usuario con criterios de aceptación verificables, reglas de negocio
explícitas, y un análisis de gaps que expone ambigüedades **antes** de que lleguen a
desarrollo — no después, como retrabajo.

## Cuándo usarla

- Un requerimiento existe en lenguaje natural o formato EARS pero todavía no está listo
  para Planning/desarrollo.
- Se quiere una revisión sistemática de ambigüedades antes de estimar o desarrollar.

## Cuándo NO usarla

- El requerimiento ya es una historia de usuario completa y refinada — no reprocesar por
  reprocesar.
- Para documentar decisiones ya tomadas de arquitectura/diseño técnico — eso no es una
  historia de usuario, es una Instruction o un documento de diseño.

## Entradas

Un requerimiento en lenguaje natural, o ya en formato EARS ("Cuando X, el sistema debe
Y"), con o sin ticket asociado.

## Salidas

Historia de usuario + criterios de aceptación + reglas de negocio + análisis de gaps —
lista para revisión humana (Human Review), no para desarrollo directo sin esa revisión.

## Instrucciones

### 1. Historia de usuario

```text
Como [rol],
quiero [objetivo],
para [beneficio].
```

**Sobre el rol — obligatorio adaptar, no usar un catálogo fijo**: la versión original de
esta skill (DataAgro) traía una tabla cerrada de 4 roles comerciales (Comercial, Corredor,
Administrativo, Administrador del sistema). La ejecución real `EXEC-20260908-001`
(G4.6, sobre un ticket de operación de planta) encontró que ese catálogo **no cubría
roles operativos reales del mismo dominio** ("operador de planta") — un hallazgo de
brecha de la capability misma, no del requerimiento. Por eso esta versión generalizada
**no trae un catálogo de roles fijo**: el equipo que adopta debe completar su propia
tabla de roles reales de su dominio antes de usarla, y revisarla cuando aparezca un rol
real que no esté cubierto (no forzar un rol existente si no encaja).

**Objetivo**: acción observable, no implementación técnica.
**Beneficio**: valor de negocio explícito y medible.

Ejemplo correcto (genérico, reemplazar por el dominio real):
```text
Como [rol real de tu dominio],
quiero [acción observable, no un método o botón específico],
para [beneficio de negocio explícito].
```

Ejemplo incorrecto (evitar):
```text
Como usuario,
quiero que el sistema llame al método ActualizarX,
para que funcione el botón.
```

### 2. Criterios de aceptación

Dado/Cuando/Entonces, un escenario por criterio. Cubrir siempre: camino feliz, validación/
error esperado, y al menos un caso borde relevante.

```text
Dado que [contexto/precondición],
cuando [acción],
entonces [resultado verificable y observable].
```

### 3. Reglas de negocio

```text
RN-01: [restricción expresada como afirmación]
RN-02: [restricción]
```

> Los ejemplos de reglas de negocio de cualquier instancia de esta skill son ilustrativos
> del formato, no reglas certificadas contra el código — validar cada regla contra la
> implementación real antes de dar una historia por cerrada.

### 4. Análisis de gaps

Revisar siempre, antes de cerrar el requerimiento:

- **Ambigüedades**: ¿hay términos con doble interpretación?
- **Escenarios faltantes**: ¿qué pasa si una integración externa no responde? ¿si un dato
  requerido viene vacío o corrupto?
- **Conflictos entre reglas**: ¿alguna RN contradice otra?
- **Condiciones de borde**: ¿qué pasa con valores en 0, listas vacías, o el caso "sin
  resultado previo" (acción disparada antes de que exista un estado base)?
- **Preguntas abiertas**: listar explícitamente qué bloquea la implementación.
- **Integraciones**: ¿depende de un sistema externo? ¿cómo se comporta si falla?

```text
❓ [Pregunta que bloquea la implementación]
   Contexto: [por qué es importante]
   Opciones: A) ... | B) ...
   Impacto si no se resuelve: [alto / medio / bajo]
```

**Antes de reportar un gap, verificar** contra documentación técnica existente del propio
requerimiento (planes técnicos, decisiones ya tomadas) — `EXEC-20260908-001` encontró y
descartó correctamente un falso positivo así; no reportar como ambigüedad algo que ya fue
decidido y documentado en otro lugar.

## Dependencias

Ninguna técnica — es contenido de referencia, no requiere `tools` ni acceso a sistemas
externos.

## Herramientas / permisos

Ninguna — produce texto estructurado, no ejecuta código ni accede a datos.

## Seguridad

Riesgo bajo — no toca sistemas externos ni datos sensibles directamente. Si el
requerimiento de entrada contiene datos sensibles de ejemplo (números de cliente, montos
reales), no reproducirlos textualmente en la historia generada sin necesidad.

## Datos

No requiere acceso a datos de producción — opera sobre el texto del requerimiento que se
le pasa como entrada.

## HITL

**Obligatorio, sin excepción**: un PO/referente de negocio debe validar la historia antes
de pasar a Planning/desarrollo. Ninguna ejecución de esta skill hasta ahora (2/2) tuvo
HITL real — ambas fueron autoevaluadas por el mismo actor que las generó (ver Evaluation
Records referenciados abajo). No tratar una historia generada como aprobada sin esa
revisión.

## Ejemplos

Ver 2 ejecuciones reales completas, con historia + criterios + reglas + gaps genuinos:
[`evidence/EXEC-20260907-001.md`](../../../evidence/EXEC-20260907-001.md) (MOA-1816,
DataAgro) y [`evidence/EXEC-20260908-001.md`](../../../evidence/EXEC-20260908-001.md)
(MOA-1765, DataAgro).

## Criterios de calidad

- La historia sigue el formato Como/quiero/para, con objetivo observable y beneficio
  explícito.
- Cada criterio de aceptación traza 1:1 a un requisito de entrada.
- El análisis de gaps cubre las 5 categorías del checklist, no solo la primera que se
  encuentra.

## Criterios de evaluación

Ver Evaluation Contract (`../../../architecture/evidence-evaluation-measurement.md` §2).
Criterios ya aplicados 2 veces: estructura, claridad, criterios de aceptación
verificables, ausencia de ambigüedad, trazabilidad, consistencia con convenciones del
proyecto, ajuste del rol al catálogo (agregado en G4.6, ver nota de rol arriba).

## Evidencia / origen

3 instancias reales de origen (DataAgro, Scato Logística, Orquestador — 2 originadores
distintos) y 2 ejecuciones reales completas de punta a punta (G4.4, G4.6), ambas
`PARTIAL`, ninguna independiente — ver
[`registry/entries/user-story.md`](../../../registry/entries/user-story.md). Esta versión
en `capabilities/` generaliza la estructura común a las 3 instancias, sin copiar el
contenido de dominio de ninguna.

## Versión

`1.0-generalized` (G5.1).

## Owner / Maintainer

`REQUIRES VALIDATION` — sin gobierno del Common Core confirmado (`BLOCKED-DECISIONS.md`
#1).

## Compatibilidad / adaptación

Portable a cualquier equipo, cualquier dominio — la única adaptación obligatoria es la
tabla de roles reales del dominio (ver nota arriba); todo lo demás (formato Given/When/
Then, RN-XX, checklist de gaps) es Common Core y no debería reescribirse por equipo.
