---
name: stack-best-practices-template
description: Plantilla para documentar las buenas prácticas específicas del stack tecnológico de un equipo, para que un Agent de code review (o cualquier asistente) las cargue on-demand. No es una skill de buenas prácticas en sí — es el patrón para escribir una.
---

# stack-best-practices-template

**Capability Registry**: [`CAP-006`](../../../registry/entries/stack-best-practices-template.md).
**Golden Path**: [`AI Code Review`](../../../golden-paths/README.md#4-ai-code-review)
— es la skill que un Agent de code review (ver
[`capabilities/agents/read-only-code-reviewer/`](../../agents/read-only-code-reviewer/AGENT.md))
carga para aplicar reglas concretas por stack.
**Clasificación (G5.1)**: **REUSABLE PATTERN** — el *género* (estructura del documento) es
reusable; el *contenido* (reglas concretas) es 100% específico de cada stack/versión y no
debe copiarse entre equipos.

## Propósito

Evitar 2 fallas opuestas encontradas en la evidencia real: (a) un Agent de code review sin
ninguna skill de buenas prácticas cargada, que solo aplica criterios genéricos sin
contexto del stack real; (b) copiar literalmente las reglas de otro equipo con un stack
distinto, que produce hallazgos incorrectos (ej. aplicar reglas de EF6/async a un proyecto
EF5 sin soporte async real).

## Evidencia que motiva esta plantilla

Se encontraron **2 instancias reales e independientes** de una skill `dotnet-best-practices`
— una en Scato Logística (target: .NET Framework 4.5.2, EF5, WCF, Ninject 3.0, ASP.NET
MVC4, NUnit 2.6.3+Moq) y otra en Orquestador (target: .NET Framework 4.7.2, EF6, WCF,
Ninject, ASP.NET MVC 5, NUnit3+Moq). Mismo género de documento (arquitectura por capas,
manejo de errores, acceso a datos, DI/scoping, reglas de async, SOLID, convenciones de
testing), **contenido específico y no intercambiable** entre ambas — confirmando la
clasificación ya anticipada en `../../../architecture/assessment-gate.md`: TEAM-SPECIFIC en
contenido, candidato a plantilla en género. Ninguna de las 2 instancias reales se
promueve ni se copia acá — esta plantilla es una generalización de su **estructura**.

## Cuándo usarla

Cuando un equipo quiere que su Agent de code review (o cualquier asistente) tenga en
cuenta las convenciones reales de su stack — no genéricas — sin tener que reescribir esa
skill desde cero cada vez.

## Cuándo NO usarla

- No copiar el contenido de la skill de otro equipo con un stack distinto, aunque el
  género de tecnología sea similar (ej. .NET Framework 4.5.2 vs. 4.7.2 difieren en soporte
  async real — una regla copiada mal puede generar falsos positivos o negativos).
- No crear esta skill si el Agent de code review ya cubre lo necesario con reglas
  genéricas (OWASP, SOLID) y el equipo no tiene convenciones de stack propias que valga
  la pena formalizar todavía.

## Entradas

Ninguna en tiempo de ejecución — es un documento de referencia que se completa una vez
por equipo/stack y se versiona junto al código.

## Salidas

Un archivo `SKILL.md` real, con contenido específico del stack del equipo, cargable por
cualquier Agent que declare `Load and apply skill: <nombre>`.

## Estructura recomendada (secciones, sin contenido — completar por equipo)

1. **Frontmatter**: `name`, `description` que declare explícitamente la versión exacta
   del stack (no solo "dotnet" — la versión importa, ver evidencia arriba).
2. **Arquitectura/capas**: mapa real de las capas del proyecto y qué convención sigue cada
   una.
3. **Manejo de errores**: patrón real usado (excepciones vs. result objects vs. códigos de
   error) — no asumir un patrón genérico si el proyecto ya tiene uno propio.
4. **Acceso a datos**: reglas específicas de la versión del ORM/ODM real (ej. patrones de
   N+1, tracking vs. no-tracking, versión soportada).
5. **Concurrencia/async**: reglas específicas de lo que la versión del framework soporta
   realmente — **no asumir que async/await está disponible o es seguro sin confirmar la
   versión real del runtime**.
6. **Inyección de dependencias / scoping**: patrón y contenedor reales, con las reglas de
   scope específicas del framework de hosting real (ej. WCF vs. ASP.NET Core difieren).
7. **Testing**: framework y versión reales, convenciones de mocking.
8. **Checklist de revisión**: lista corta y verificable, no una repetición de las
   secciones anteriores en otro formato.

## Dependencias

Ninguna técnica. Depende de que el equipo conozca y documente honestamente su stack real
(no la versión "ideal" o planeada).

## Herramientas / permisos

Ninguna — es contenido de referencia.

## Seguridad

Riesgo bajo. Único riesgo real: que el contenido quede desactualizado respecto al código
real y genere recomendaciones incorrectas — mitigar con `Last Review` explícito y
revisión cuando el stack cambie de versión.

## Datos

No aplica.

## HITL

No requiere HITL en sí (es contenido de referencia) — el HITL real ocurre cuando el Agent
que la carga produce un hallazgo (ver `capabilities/agents/read-only-code-reviewer/`).

## Ejemplos

No se incluye contenido de ejemplo específico de stack en esta plantilla, deliberadamente
— cualquier ejemplo concreto (reglas de EF5 vs. EF6, WF4.5, etc.) pertenece a la
instancia real de cada equipo, no a la plantilla genérica. Ver
`registry/entries/stack-best-practices-template.md` para la referencia a las 2 instancias
reales encontradas (sin reproducir su contenido acá).

## Criterios de calidad

- Declara la versión exacta del stack, no un nombre genérico de tecnología.
- Cada regla es específica y accionable, no un principio genérico repetible en cualquier
  stack (eso ya lo cubre el Agent de code review con criterios OWASP/SOLID genéricos).

## Criterios de evaluación

`NOT FOUND` — ninguna de las 2 instancias reales tiene evidencia de evaluación formal de
si sus reglas efectivamente mejoran los hallazgos del Agent que las carga.

## Evidencia / origen

Ver sección "Evidencia que motiva esta plantilla" arriba y
`registry/entries/stack-best-practices-template.md`.

## Versión

`1.0-generalized` (G5.1) — plantilla de estructura únicamente, sin contenido de stack.

## Owner / Maintainer

`REQUIRES VALIDATION` — cada equipo que la adopte es dueño de su propia instancia
completada; no hay un owner único de "la" skill de buenas prácticas (por diseño, no
debería haber una sola).

## Compatibilidad / adaptación

Esta plantilla existe **precisamente para** ser adaptada — no hay una versión "neutral"
usable sin completar. Team Adaptation obligatoria en el 100% del contenido; solo la
estructura de 8 secciones es Common Core.
