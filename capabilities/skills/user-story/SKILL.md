---
name: user-story
description: Plantillas para historias de usuario, criterios de aceptación (Given/When/Then), reglas de negocio (RN-XX) y análisis de gaps. Usar para definir o refinar requerimientos funcionales antes de que lleguen a desarrollo.
---

# user-story

**Capability Registry**: [`CAP-002`](../../../registry/entries/user-story.md).
**Golden Path**: [`AI-Assisted Requirements`](../../../golden-paths/README.md#1-ai-assisted-requirements)
— única capacidad que consume. Mecanismo probado de punta a punta durante la
construcción (Direct Context y Connected Context vía Context Provider); esas pruebas se
purgaron al pasar a adopción real — **sin ejecuciones reales registradas todavía**, ver
[`../../../evidence/README.md`](../../../evidence/README.md) para el estado vivo.
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
Si hay gaps bloqueantes, incluye además una recomendación de próximo paso (sección 5).

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

### 5. Recomendación (obligatoria cuando hay gaps bloqueantes)

**Agregado tras feedback real de developer** — completar el gap-analysis con **una
recomendación de próximo paso**, no solo la lista de preguntas. Esto no es una función
nueva: opera exactamente lo que el KO ya describe para esta etapa
(`TRACK-1/BAUFEST_...md`, etapa "Recepción del requerimiento"): *"Rovo Agent... detecta
ambigüedades y genera preguntas para el PO antes del refinamiento."* Acá se sintetiza esa
detección en una acción concreta:

```text
📌 Recomendación: [1 frase — la historia no está lista para Planning/desarrollo por
   [razón concreta, ej. "falta descripción y criterios de aceptación en el ticket de
   origen"]].
   Sugerencia: contactar a [nombre real del reporter, si el Resolved Context lo trae —
   ej. "Jesús Gutiérrez (reporter)"] para completar [qué falta exactamente] antes de
   continuar.
```

**`reporter`, no `assignee`, es el contacto por defecto — regla dura, con motivo**: el
`assignee` de un ticket es quien va a *implementarlo* (con frecuencia la misma persona
que está ejecutando esta capability en este momento); recomendarle "contactate con el
assignee" es circular y no aporta nada cuando el assignee es quien lee la recomendación.
El `reporter` es quien originó el requerimiento y, en ausencia de un campo explícito de
PO en el Resolved Context, es el proxy más cercano al *"PO"* que pide el KO para esta
etapa. Solo mencionar al `assignee` además del `reporter` si el Resolved Context trae un
campo de PO/responsable funcional distinto de ambos, o si el `reporter` no está
disponible — nunca como alternativa intercambiable "y/o".

**Regla dura, sin excepción — esto es texto, nunca una acción**: la recomendación es
parte del resultado que lee la persona, **no** dispara ningún comentario, notificación ni
cambio de estado en Jira/Azure DevOps. Sigue siendo `READ` — la única acción real es que
un humano, después de leer esto, decida contactar a alguien por su cuenta. Ver
[`../../../security/security-governance.md`](../../../security/security-governance.md)
§1.5 — automatizar el envío de esa notificación sería `ACT`, fuera de alcance de esta
capability.

**Nunca inventar un nombre** — si el Resolved Context no trae `reporter` real (campo
`metadata` vacío o ausente), la recomendación lo dice de forma explícita y le da a la
persona la acción concreta que falta, no una referencia vaga:

```text
   Sugerencia: no pude identificar quién reportó esta historia con el contexto que traje
   de Jira — revisá el campo "Reporter" del ticket directamente en Jira antes de
   contactar al PO real, para completar [qué falta exactamente].
```

**Por qué esta aclaración importa (feedback real de developer, 2 rondas)**: la primera
ronda mostró que decir solo "contactar al PO/referente" sin más deja a la persona sin
saber si el nombre no estaba disponible o si el agente lo omitió a propósito. La segunda
ronda (sobre `ARMOA277-194`) mostró un problema distinto: la recomendación decía
"contactar a Jesús Gutiérrez (reporter) **y/o** a Samoel Sarmiento Tello (assignee)" —
pero Samoel es el developer asignado a implementar la historia, no la fuente de la
información funcional que falta; recomendarle que se contacte a sí mismo (o a quien
ejecuta la tarea) no aporta nada. La regla, ya corregida arriba: **priorizar siempre
`reporter`** sobre `assignee` para completar gaps funcionales — la persona no necesita
entrar a Jira ella misma para el `reporter`, ese dato ya viajó en la ejecución de Context
Acquisition. Solo cuando el campo `reporter` viene vacío se le pide explícitamente a la
persona que lo busque en Jira — nunca como paso por defecto, y nunca reemplazado por
`assignee` sin aclarar el motivo.

## How to use this capability

Guía operativa — cómo llevar esta capability a tu proyecto real, con un asistente de IA.

### Input

```
Ticket:
MOA-XXXX

Requirement:
"[requerimiento real, en lenguaje natural o EARS — nunca inventado]"

Context:
"[contexto disponible: dominio, roles reales de tu equipo, restricciones conocidas]"
```

### Context Input

**Sin cambios en el contrato de entrada** — el campo `Context:` de arriba sigue
funcionando exactamente igual, con contexto manual. Lo que cambia es de dónde puede venir
ese texto, sin que esta capability necesite saberlo
([`../../../architecture/context-acquisition-resolution.md`](../../../architecture/context-acquisition-resolution.md)):

- **Direct Context** (como hasta ahora): alguien escribe el `Context:` directamente. Es el
  único modo con evidencia real de ejecución hoy (ver "Ejemplos" más abajo) y **sigue
  siendo el modo por defecto**.
- **Resolved Context** (nuevo, conceptual — sin ejecución real todavía): el `Context:` se
  completa con el `content` de un `Resolved Context` producido por un Context Provider
  (ej. [`azure-devops-context-provider`](../../../integrations/azure-devops-context-provider.md)
  o [`jira-context-provider`](../../../integrations/jira-context-provider.md)), a partir
  de una referencia como `MOA-1234` en vez de texto escrito a mano.

**Regla dura, sin excepción**: esta capability **no sabe ni le importa** si el `Context:`
vino de una persona o de un Context Provider — el formato de entrada es idéntico en ambos
casos. **No existe, ni existirá, una versión `user-story-jira` o `user-story-azuredevops`**
— sería exactamente el antipatrón que este modelo evita (ver
`context-acquisition-resolution.md`). La resolución de la referencia hacia contexto ocurre
**antes** de invocar esta capability, no dentro de ella.

### Execution prompt pattern

Ejemplo de instrucción que podés entregarle a Copilot/Claude/otro asistente. **Esto es
un patrón de ejecución, no un prompt obligatorio de proveedor** — adaptalo a la interfaz
real de tu herramienta:

```
Usa la capability CAP-002 user-story.

Analiza el siguiente requerimiento real.

Contexto:
[contexto real de tu dominio — rol, sistema, restricciones]

Requerimiento:
[el requerimiento real, sin parafrasear]

Genera:
1. Historia de usuario
2. Criterios de aceptación
3. Reglas de negocio
4. Análisis de gaps

No inventes reglas de negocio.
No conviertas decisiones técnicas ya documentadas en gaps.
Si falta información necesaria, declárala explícitamente como gap.

La salida debe quedar lista para Human Review.
```

### Expected result

```
### Historia de usuario
Como [rol real], quiero [objetivo], para [beneficio].

### Criterios de aceptación
1. Dado [contexto], cuando [acción], entonces [resultado].
   (camino feliz, validación/error, caso borde — al menos 3)

### Reglas de negocio
RN-01: [restricción real]

### Análisis de gaps
❓ [pregunta real que bloquea implementación, si existe alguna]

### Recomendación (solo si hay gaps bloqueantes)
📌 [1 frase de por qué no está lista + a quién contactar, si el Resolved Context trae un
   nombre real — nunca inventado]
```

### ¿Ya existe una ejecución para este ticket?

Si al darle la referencia del ticket a tu asistente, te dice que **ya existe un registro**
(`records/<fuente>-<tarea>/EXEC-*/`) para esa tarea — no es un error, es esperable (el
modelo no duplica trabajo). No sigas con "Execution prompt pattern" de arriba sin decidir
primero:

1. **No cambió nada** → no hay nada que hacer, ese registro ya es tu evidencia.
2. **Tu ticket cambió o el resultado tiene algo mal** → pedile una ejecución nueva,
   anidada en la misma carpeta de tarea (nunca sobrescribir el `EXEC-ID` viejo).
3. **Podés revisar si el resultado existente es correcto** — esta es tu oportunidad real
   de dar la validación humana que le falta a esta skill (ver "HITL" abajo: 0/6
   ejecuciones tienen HITL real todavía). Pedile al asistente que actualice
   `evaluation.md` de esa ejecución: `method: model-assisted` → `method: human`,
   `evaluator`/`hitl_confirmed_by` → tu nombre, y tu veredicto real.

Detalle completo de esta misma guía, sección "6.0. Antes de nada: ¿ya existe un registro
para tu tarea?": [`../../../adoption/getting-started.md`](../../../adoption/getting-started.md).

### Human review

**Obligatorio, sin excepción**: un PO o referente funcional debe revisar el resultado
**antes de Planning/desarrollo**. Una salida de IA no queda aprobada por generarse — ver
sección HITL más abajo.

### Evidence

Registrá la ejecución con
[`../../../adoption/templates/evidence-record.md`](../../../adoption/templates/evidence-record.md)
(contrato canónico en
[`../../../architecture/evidence-evaluation-measurement.md`](../../../architecture/evidence-evaluation-measurement.md#1-evidence)).

### Evaluation

Aplicá
[`../../../adoption/templates/evaluation-record.md`](../../../adoption/templates/evaluation-record.md)
— declará tus criterios antes de mirar el resultado.

### Measurement

Completá
[`../../../adoption/templates/measurement-record.md`](../../../adoption/templates/measurement-record.md)
— si no tenés baseline, `NOT MEASURED`, nunca inventado.

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
de pasar a Planning/desarrollo. El mecanismo fue probado durante la construcción sin
HITL real en ninguna prueba — esas pruebas se purgaron al pasar a adopción real. No
tratar una historia generada como aprobada sin esa revisión.

## Ejemplos

El mecanismo (Direct Context y Connected Context vía Context Provider, Jira/MCP y Azure
DevOps) quedó probado de punta a punta durante la construcción, sobre varios tipos de
issue reales — esas ejecuciones fueron pruebas del mecanismo, purgadas deliberadamente al
pasar a adopción real. Ver [`../../../evidence/README.md`](../../../evidence/README.md)
para la evidencia real de uso en curso.

## Criterios de calidad

- La historia sigue el formato Como/quiero/para, con objetivo observable y beneficio
  explícito.
- Cada criterio de aceptación traza 1:1 a un requisito de entrada.
- El análisis de gaps cubre las 5 categorías del checklist, no solo la primera que se
  encuentra.

## Criterios de evaluación

Ver Evaluation Contract (`../../../architecture/evidence-evaluation-measurement.md` §2):
estructura, claridad, criterios de aceptación verificables, ausencia de ambigüedad,
trazabilidad, consistencia con convenciones del proyecto, ajuste del rol al catálogo.

## Evidencia / origen

3 instancias reales de origen (DataAgro, Scato Logística, Orquestador — 2 originadores
distintos). El mecanismo de ejecución de punta a punta (Direct Context y Connected
Context) quedó probado durante la construcción — esas pruebas se purgaron al pasar a
adopción real, ver [`registry/entries/user-story.md`](../../../registry/entries/user-story.md)
para el estado vivo. Esta versión en `capabilities/` generaliza la estructura común a las
3 instancias, sin copiar el contenido de dominio de ninguna.

## Versión

`1.0-generalized` (G5.1).

## Owner / Maintainer

`REQUIRES VALIDATION` — sin gobierno del Common Core confirmado (`../../../governance/BLOCKED-DECISIONS.md`
#1).

## Compatibilidad / adaptación

Portable a cualquier equipo, cualquier dominio — la única adaptación obligatoria es la
tabla de roles reales del dominio (ver nota arriba); todo lo demás (formato Given/When/
Then, RN-XX, checklist de gaps) es Common Core y no debería reescribirse por equipo.
