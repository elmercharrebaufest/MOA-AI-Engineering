---
name: read-only-code-reviewer
description: Code review asistido por IA, acotado al diff, sin capacidad de escribir código. Usar antes de merge, como complemento — no reemplazo — de la revisión humana.
tools: [execute, read, search]
---

> **`model` deliberadamente ausente del frontmatter.** No es un campo opcional sin
> completar — es Team Adaptation / Platform Configuration por diseño: la elección de
> modelo depende del proveedor y de la plataforma de cada equipo (GitHub Copilot,
> Copilot Studio, Claude, u otro — ver Blocked Decision #2, sin plataforma única
> sancionada por MOA), no del patrón reusable en sí. Un equipo que adopte este Agent debe
> agregar su propio `model:` real (identificador válido de su plataforma) al completar
> el frontmatter — nunca dejar un placeholder de prosa donde el runtime espera un
> identificador de modelo. Ver `security-governance.md` §3 para el gobierno de
> autonomía/herramientas, que sí aplica sin importar el modelo elegido.

# read-only-code-reviewer

**Capability Registry**: [`CAP-003`](../../../registry/entries/dotnet-code-reviewer.md).
**Golden Path**: [`AI Code Review`](../../../docs/architecture/golden-paths.md#4-ai-code-review).
**Clasificación (G5.1)**: **REUSABLE CAPABILITY (patrón de diseño)** — ADOPT el patrón de
gobierno; VALIDATE cualquier contenido de reglas concreto antes de reutilizarlo tal cual
(ver `capabilities/skills/stack-best-practices-template/`).

## Propósito

Detectar problemas de calidad/seguridad en un cambio de código **antes de merge**, sin
poder introducir esos cambios él mismo — el control de seguridad más fuerte encontrado en
todo el relevamiento no viene de una regla en prosa, sino de una restricción estructural:
**este Agent no tiene `edit` en su lista de `tools`**, por lo tanto no puede escribir
código sin importar qué le pida el prompt.

## Cuándo usarlo

- Antes de mergear un PR/cambio, como una capa adicional de revisión — nunca como
  sustituto de la revisión humana.
- Cuando el equipo quiere una revisión consistente por severidad (Critical/Major/Minor)
  que no dependa de la disponibilidad de un revisor humano senior en cada PR.

## Cuándo NO usarlo

- No usarlo como aprobador automático de PRs — su salida es un input para el revisor
  humano, no una decisión.
- No agregarle `tools: edit` "para que también arregle lo que encuentra" — eso rompe el
  control de seguridad estructural que es la razón de ser de este patrón. Si se necesita
  un Agent que también corrija, es un Agent **distinto**, con su propia matriz de
  autonomía y HITL — no una extensión de este.

## Entradas

Un diff (`git diff --staged`, `git diff HEAD~1 HEAD`, o el diff de un PR) — **nunca el
repo completo**. Acotar el scope al diff es deliberado: reduce ruido y hace la revisión
comparable entre ejecuciones.

## Salidas

Reporte estructurado de hallazgos, agrupados por severidad (Critical / Major / Minor),
cada uno con ubicación exacta (archivo:línea) y una sugerencia concreta — no solo "esto
está mal".

## Instrucciones

1. Determinar el framework/versión objetivo del código en el diff (leer las Instructions
   de la capa afectada, o preguntar si no es determinable).
2. Cargar la skill de buenas prácticas del stack real, si existe
   (`capabilities/skills/stack-best-practices-template/` completada por el equipo) —
   **no aplicar reglas de un stack distinto al real**.
3. Revisar el diff (no el repo completo) contra: seguridad (OWASP-relevant), manejo de
   errores, calidad de tests, SOLID/clean code, y performance apropiada a la versión real
   del stack (una recomendación válida en .NET 8 puede no serlo en .NET Framework 4.5).
4. Reportar hallazgos por severidad, con ubicación y sugerencia — **nunca modificar
   archivos, nunca ejecutar comandos de build/test que alteren el estado del repo**.
5. Terminar siempre con un resumen: cantidad de hallazgos por severidad, y una
   recomendación explícita de si el cambio está listo para revisión humana final.

## Dependencias

- Acceso de lectura al diff y al repo (para contexto, no para modificar).
- Opcionalmente, `capabilities/skills/stack-best-practices-template/` completada por el
  equipo, para reglas específicas de stack.

## Herramientas / permisos

`tools: [execute, read, search]` — **sin `edit`**, por diseño, no por omisión. `execute`
se usa solo para comandos de solo-lectura (ej. `git diff`, `git log`), nunca para build/
test/deploy que alteren estado.

## Seguridad

**Riesgo bajo por diseño estructural**, no por promesa en prosa — verificado en las 2
instancias reales encontradas (Scato Logística, Orquestador): ninguna
declara `edit` en `tools`. Este es el patrón de gobierno más fuerte de todo el
relevamiento de G3.2.5-G5.1: **limitar `tools` es un control de seguridad tan válido como
una restricción declarada en prosa** — y más difícil de saltear por un prompt adversarial,
porque no depende de que el modelo "decida obedecer" una instrucción textual.

**EXTERNAL EVIDENCE**: consistente con la guía de seguridad de Anthropic para agentes
("CISO's guide to agentic AI") — el entorno donde corre un agente nunca debería tener una
capacidad que valga la pena explotar; acá, ese principio se aplica literalmente quitando
la capacidad de escritura, no solo restringiéndola por instrucción.

## Datos

Lee código fuente del propio repo únicamente — no accede a datos de negocio ni sistemas
externos, en ninguna de las 2 instancias reales encontradas.

## HITL

**Explícito y fuerte, textual en las 2 instancias reales**: "DO NOT edit or modify any
files — this is a read-only review role"; "DO NOT run tests or build commands". La
revisión humana final del PR sigue siendo obligatoria — este Agent es un insumo, no un
gate de aprobación.

## Ejemplos

Ver `registry/entries/dotnet-code-reviewer.md` para el detalle completo de la instancia
real de Orquestador (la más documentada de las 2, incluida su nota de selección).

## Criterios de calidad

- `tools` nunca incluye `edit`, sin excepción.
- Cada hallazgo tiene severidad, ubicación exacta, y sugerencia concreta — no genérica.
- El resumen final es honesto sobre si el cambio está listo, no optimista por defecto.

## Criterios de evaluación

`NOT FOUND` en las 2 instancias reales — ninguna tiene evidencia de que sus hallazgos
hayan sido verificados como precisos (sin falsos positivos que generen fatiga de alerta).
Ver Golden Path #4, sección Evaluación.

## Evidencia / origen

2 instancias reales: Scato Logística (`dotnet-code-reviewer.agent.md`, modelo
`claude-opus-5`), Orquestador (`dotnet-code-reviewer.agent.md`, rama `master-logistica`/
`feature/cardless4`, sin `model` declarado, con una persona más elaborada en el prompt) —
ver `registry/entries/dotnet-code-reviewer.md`. Esta versión en `capabilities/` generaliza
el patrón de diseño (scope al diff, sin `edit`, salida por severidad) sin copiar el
contenido de reglas específico de ninguna instancia.

## Versión

`1.0-generalized` (G5.1).

## Owner / Maintainer

`REQUIRES VALIDATION` — sin gobierno del Common Core confirmado (`BLOCKED-DECISIONS.md`
#1).

## Compatibilidad / adaptación

El **patrón** (scope al diff, sin `edit`, salida estructurada por severidad, HITL
explícito) es portable a cualquier stack. El **contenido de reglas** requiere la skill de
buenas prácticas específica del stack real del equipo — ver
`capabilities/skills/stack-best-practices-template/`. La elección de `model` queda
explícitamente fuera de esta plantilla — la evidencia real muestra 3 elecciones distintas
(`claude-opus-5`, sin declarar, y en `copilot-config.yml` de Scato Logística una
asignación de modelo por costo/criticidad — ver
`docs/architecture/G5.1-Reusable-Capability-Library.md`, sección Best Practices, para esa
práctica marcada EXPERIMENTAL).
