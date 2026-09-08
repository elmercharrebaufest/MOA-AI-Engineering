---
name: repository-governance
description: Plantilla para la estructura de gobierno de un repositorio con asistentes de IA — un AGENTS.md con matriz de autonomía + instructions por capa + skills on-demand + agents por rol. Es una convención de estructura, no contenido de dominio.
---

# repository-governance

**Capability Registry**: [`CAP-005`](../../../registry/entries/repository-governance.md).
**Golden Path**: transversal — precondición implícita de todos los Golden Paths (ningún
Golden Path declara HITL/autonomía de forma útil sin esto).
**Clasificación (corregida en G5.2)**: **Reusable Governance Pattern / Common Core
Candidate** — no Common Core aprobado. `Corporate Standard: N` en
[`registry/entries/repository-governance.md`](../../../registry/entries/repository-governance.md),
sin excepción. Progresión conceptual que le falta recorrer, sin atajos:

```
Reusable Capability
      ↓
Common Core Candidate   ← CAP-005 está acá
      ↓
Assessment / Human Governance   ← REQUIRES VALIDATION, Blocked #1
      ↓
Corporate Standard
```

La convención de 4 capas ya fue evaluada como "ADOPT como convención" en
`docs/architecture/assessment-gate.md` (G3.3) — eso significa que es un buen candidato
con evidencia fuerte de convergencia independiente (4 instancias), **no** que un
gobierno humano ya la haya aprobado como estándar corporativo. Team Adaptation sigue
siendo obligatoria en el contenido de cada capa, sin importar qué tan candidata a Common
Core sea la estructura.

## Propósito

Dar a cualquier equipo que empieza a usar asistentes de IA una estructura con evidencia
real de convergencia independiente (no una única opinión) para declarar, en un solo lugar predecible, **qué puede hacer un asistente sin pedir
permiso, qué debe confirmar antes, y qué nunca debe hacer** — en vez de que cada equipo
reinvente su propio formato o, peor, no lo declare en ningún lado.

## Evidencia que motiva esta plantilla

**4 instancias reales e independientes** de esta convención de 4 capas
(`copilot-instructions.md` + `.github/instructions/*.instructions.md` + `.github/skills/*`
+ `.github/agents/*.agent.md`) encontradas con distinto nivel de completitud: DataAgro (6
instructions, 9+ skills, 5 agents), Scato Logística (14 instructions, 13 skills, 13
agents — la más integrada), Orquestador (8 instructions, ~6 skills, 4 agents, solo en
rama `master-logistica`), y `moa-sdlc` (8 instructions, 1 skill, **sin** `.github/agents/`
pese a que su propio `README.md` lo menciona — brecha real entre lo documentado y lo
existente, señalada acá para no repetirla). **Ninguna de las 4 es "la" referencia** — se
generaliza la estructura común, no el contenido de ninguna.

## Cuándo usarla

Al empezar cualquier proyecto nuevo (o formalizar uno existente) donde un asistente de IA
va a operar con algún grado de autonomía sobre el código.

## Cuándo NO usarla

Para un repo donde la IA se usa solo en modo chat/autocomplete sin ningún flujo agentic
— ahí la sobrecarga de esta estructura no se justifica todavía (empezar simple, escalar
cuando haya evidencia — Principio ya vigente en `strategy/principles.md`).

## Entradas

Ninguna en tiempo de ejecución — es una estructura de repositorio que se completa una vez
y se mantiene junto al código.

## Salidas

- 1 `AGENTS.md` (o `copilot-instructions.md` según convención del proveedor) con la
  matriz de autonomía.
- N archivos en `.github/instructions/*.instructions.md`, uno por capa/convención que
  deba aplicarse siempre que se toque esa ruta.
- Skills y Agents, agregados solo cuando haya un caso de uso real que los justifique (no
  por defecto).

## Instrucciones — plantilla del `AGENTS.md`

```markdown
# AGENTS.md — <nombre del proyecto>

## Antes de empezar
- <dónde vive el contexto del proyecto: mapa de capas, convenciones, glosario>
- <cómo se referencian tickets/requerimientos reales — nunca inventar contenido>

## Matriz de autonomía

### ALWAYS (sin pedir confirmación)
- <acciones de bajo riesgo, reversibles, sin efecto en producción>
- Ej.: generar tests, formatear con el linter del proyecto.

### ASK FIRST (confirmar antes de ejecutar)
- <acciones con efecto real pero no destructivo>
- Ej.: instalar dependencias nuevas, migraciones de base de datos, cambiar contratos de
  API/interfaces públicas.

### NEVER (nunca, sin excepción)
- <acciones destructivas, de seguridad, o que rompen trazabilidad>
- Ej.: desactivar validaciones de seguridad/CORS/autorización; commitear secretos o
  memoria de sesión local; marcar un requisito manual como cubierto sin sign-off humano;
  hacer push/merge directo a la rama principal sin revisión.
```

**No copiar el contenido ilustrativo de "Ej." tal cual** — son ejemplos reales tomados de
2+ instancias distintas (DataAgro, `moa-sdlc`) para mostrar el nivel de especificidad
esperado, no una matriz lista para usar. Cada equipo debe declarar la suya, informada por
estos ejemplos pero con su propio riesgo real.

## Dependencias

Ninguna técnica. Depende de que el equipo tenga claridad sobre qué es realmente
irreversible/riesgoso en su propio contexto (no se puede completar de forma genérica).

## Herramientas / permisos

No aplica — es documentación de gobierno, no un artefacto ejecutable.

## Seguridad

Esta plantilla **es en sí misma** un control de seguridad — su ausencia es el riesgo. La
sección NEVER debe incluir, como mínimo: no desactivar seguridad/CORS/autorización, no
commitear secretos, no hacer push/merge autónomo a rama principal.

## Datos

No aplica directamente — si el proyecto toca datos sensibles, agregar una regla NEVER
explícita al respecto (ver `docs/architecture/security-governance.md` §4, clasificación
de datos todavía `REQUIRES VALIDATION` a nivel MOA).

## HITL

Es, en sí misma, el mecanismo por el cual un equipo declara dónde exige HITL (columna ASK
FIRST) y dónde lo prohíbe completamente sin más (columna NEVER).

## Ejemplos

Ver `governance/agent-governance.md` para las 3 matrices reales completas (DataAgro,
Scato Logística, `moa-sdlc`) documentadas en paralelo, sin promoción de ninguna como
referencia.

## Criterios de calidad

- Las 3 columnas (ALWAYS/ASK FIRST/NEVER) están completas, no solo 1 o 2.
- NEVER incluye explícitamente: seguridad/CORS/autorización, secretos, push/merge
  autónomo a rama principal.
- El contenido es específico del proyecto real, no genérico copiado de otra instancia.

## Criterios de evaluación

`NOT FOUND` de forma sistemática — ninguna de las 4 instancias reales tiene evidencia de
que su matriz haya sido efectivamente auditada contra el comportamiento real de un
asistente a lo largo del tiempo.

## Evidencia / origen

Ver "Evidencia que motiva esta plantilla" arriba, y
`assessment/relevamiento-capacidades.md` para el detalle completo por repo.

## Versión

`1.0-generalized` (G5.1).

## Owner / Maintainer

`REQUIRES VALIDATION` — sin gobierno del Common Core confirmado (`BLOCKED-DECISIONS.md`
#1).

## Compatibilidad / adaptación

La estructura de 3 columnas es la parte candidata a Common Core (no aprobada todavía —
ver "Clasificación" arriba). El contenido de cada columna es Team Adaptation obligatoria
en cualquier caso — no existe una matriz universal correcta para todos los
proyectos, distintos niveles de riesgo real requieren distintas reglas.
