---
name: stack-best-practices-template
description: Plantilla para documentar las buenas prácticas específicas del stack tecnológico de un equipo, para que un Agent de code review (o cualquier asistente) las cargue on-demand. No es una skill de buenas prácticas en sí — es el patrón para escribir una.
---

# stack-best-practices-template

**Capability Registry**: [`CAP-013`](../../../registry/entries/stack-best-practices-template.md).
**Golden Path**: [`AI Code Review`](../../../golden-paths/README.md#4-ai-code-review) —
es la skill que un Agent de code review (ver
[`capabilities/agents/read-only-code-reviewer/`](../../agents/read-only-code-reviewer/AGENT.md))
carga para aplicar reglas concretas por stack.

## Propósito

Que un Agent de code review aplique las convenciones reales del stack del equipo — no
criterios genéricos — sin que cada equipo tenga que reescribir esa skill desde cero. La
estructura del documento es común; el contenido (reglas concretas) es específico de cada
stack y versión, y no debe copiarse entre equipos con stacks distintos.

## Cuándo usarla

Cuando se quiere que el Agent de code review (o cualquier asistente) tenga en cuenta las
convenciones reales del stack propio.

## Cuándo NO usarla

- No debe copiarse el contenido de la skill de otro equipo con un stack distinto, aunque
  la tecnología sea similar — una versión distinta del mismo framework puede tener
  diferencias reales (ej. soporte de async) que vuelven una regla copiada incorrecta.
- No corresponde crearla si el Agent de code review ya cubre lo necesario con reglas
  genéricas (OWASP, SOLID) y todavía no existen convenciones de stack propias que valga
  la pena formalizar.

## Entradas

Ninguna en tiempo de ejecución — es un documento de referencia que se completa una vez
por equipo/stack y se versiona junto al código.

## Salidas

Un archivo `SKILL.md` real, con contenido específico del stack del equipo, cargable por
cualquier Agent que declare `Load and apply skill: <nombre>`.

## Estructura recomendada (secciones, sin contenido — completar por equipo)

1. **Frontmatter**: `name`, `description` que declare la versión exacta del stack — no
   solo el nombre de la tecnología, la versión importa.
2. **Arquitectura/capas**: mapa real de las capas del proyecto y qué convención sigue
   cada una.
3. **Manejo de errores**: patrón real usado (excepciones, result objects, códigos de
   error) — no asumas un patrón genérico si el proyecto ya tiene uno propio.
4. **Acceso a datos**: reglas específicas de la versión real del ORM/ODM (patrones de
   N+1, tracking vs. no-tracking, versión soportada).
5. **Concurrencia/async**: reglas específicas de lo que la versión del framework soporta
   realmente — no asumas que async/await está disponible sin confirmar la versión del
   runtime.
6. **Inyección de dependencias / scoping**: patrón y contenedor reales, con las reglas de
   scope específicas del framework de hosting real.
7. **Testing**: framework y versión reales, convenciones de mocking.
8. **Checklist de revisión**: lista corta y verificable, no una repetición de las
   secciones anteriores en otro formato.

## Dependencias

Ninguna técnica. Depende de que el equipo documente honestamente su stack real, no la
versión ideal o planeada.

## Herramientas / permisos

Ninguna — es contenido de referencia.

## Seguridad

Riesgo bajo. El riesgo real es que el contenido quede desactualizado respecto al código y
genere recomendaciones incorrectas — revisalo cuando el stack cambie de versión.

## Datos

No aplica.

## Revisión humana

No requiere revisión en sí misma — la revisión ocurre cuando el Agent que la carga
produce un hallazgo real sobre código (ver
`capabilities/agents/read-only-code-reviewer/`).

## Ejemplos

Esta plantilla no incluye contenido de ejemplo específico de stack, a propósito —
cualquier ejemplo concreto (reglas de una versión específica de un ORM, de un framework
de testing, etc.) pertenece a la instancia real de cada equipo.

## Referencias oficiales para los stacks reales confirmados de MOA (2026-09-22)

**Excepción deliberada a la regla de arriba**: no es contenido a copiar tal cual — es el
punto de partida oficial para que cada equipo complete su propia sección 5
(Concurrencia/async), a diferencia de dejarlo librado a que la IA improvise una regla
distinta cada sesión (motivo explícito de esta sección: sin una regla clara declarada,
un asistente de IA resuelve cada caso de forma distinta e inconsistente).

- **Angular** (MOA tiene 3 versiones reales — 10.1.4, 20.3.7, 21.2.14, ver
  `teams/README.md`): para proyectos en Angular moderno (20+), la guía oficial
  ([angular.dev/guide/signals](https://angular.dev/guide/signals), verificado
  2026-09-22) presenta `signal()`/`computed()`/`effect()` como el sistema de
  reactividad recomendado para código nuevo — **no lo declara obligatorio de forma
  absoluta** (RxJS sigue soportado vía interop), así que cada equipo declara
  explícitamente en su propia skill si exige Signals para código nuevo o no, en vez de
  dejarlo ambiguo. Para el proyecto en 10.1.4 (Scato Logística/Scato Puerto), Signals no
  aplica — es una versión anterior a esa API.
- **.NET Framework → .NET moderno**: ver
  [`../dotnet-modernization-guide/SKILL.md`](../dotnet-modernization-guide/SKILL.md)
  (CAP-020) — guía completa de modernización, no duplicada acá.

## Criterios de calidad

- Declara la versión exacta del stack, no un nombre genérico de tecnología.
- Cada regla es específica y accionable, no un principio genérico repetible en
  cualquier stack.

## Compatibilidad / adaptación

Esta plantilla existe para ser adaptada — no hay una versión neutral usable sin
completar. Solo la estructura de 8 secciones se mantiene igual entre equipos; el
contenido es 100% de cada uno.
