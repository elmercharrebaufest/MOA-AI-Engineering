---
name: spec-driven-development
description: Workflow de múltiples pasos con estado para llevar un requerimiento desde ticket hasta código verificado, con roles fijos (no razonamiento dinámico) y trazabilidad explícita. El patrón de Workflow más formalizado encontrado en todo el relevamiento de MOA.
---

# spec-driven-development

**Capability Registry**: [`CAP-004`](../../../registry/entries/spec-driven-development.md).
**Golden Path**: [`AI-Assisted Development`](../../../golden-paths/README.md#2-ai-assisted-development)
— este Workflow es la capacidad central de ese Golden Path, antes solo mencionada, ahora
materializada.
**Clasificación (G5.1)**: **REUSABLE PATTERN** — 2 niveles de madurez distintos, no
confundir (ver sección "Dos niveles" abajo).

## Propósito

Formalizar el ciclo de vida de una feature (Plan → Execute → Verify) con trazabilidad
explícita desde el ticket hasta el código, evitando 2 fallas observadas en el resto del
relevamiento: (a) que un asistente de IA invente el contenido de un requerimiento en vez
de leerlo de la fuente real; (b) que "está terminado" se declare sin evidencia
verificable (tests en verde, QA manual con sign-off).

## Dos niveles de madurez — no confundir (regla dura de esta capability)

| | **Nivel Lite** (evidencia real) | **Nivel Full** (evidencia real parcial — corregido 2026-09-09) |
|---|---|---|
| Roles | 3: spec-author → implementer → reviewer | 6: spec-author → implementer → tester → reviewer → **security-reviewer** → **human-approver** |
| Contrato entre roles | Informal (Markdown + checklist) | JSON explícito por rol (input/output, `mustNotChange`, `mustAskBefore`) |
| Estado | `_sdd/progress/current/<TICKET>.md`, no versionado (gitignored) | Máquina de estados de 7 estados con `allowedTransitions` explícitas |
| Auditoría | Implícita en el historial de PRs | Log de auditoría estructurado (timestamp, rol, acción, evidencia, estado) — esquema definido; sin evidencia de que se use el log en sí, pero sí de las 3 primeras etapas del ciclo |
| Evidencia real | **Sí** — 2 tickets reales de DataAgro (`MOA-1765`, `MOA-1816`), ambos procesados por este ciclo, ninguno con sign-off de QA manual todavía | **Parcial** — `moa-sdlc/_sdd/specs/MOA-1765-DistribuidorCupos/` (mismo ticket `MOA-1765`) tiene ejecución real de `spec-author`+`implementer`+`tester`: requirements/tasks reales, build verde, suite NUnit 1228/1228 verde, bugs reales encontrados y corregidos. **No** llega a `reviewer`/`security-reviewer`/`human-approver`/`done`: `feature.json.estado` sigue `"draft"`, `qaManualPending` con `signOff: null` en los 4 requisitos manuales, sin `_sdd/progress/history/MOA-1765.md`. Persiste además la brecha entre lo que el propio `README.md` de `moa-sdlc` describe (`.github/agents/`, `CODEOWNERS`) y lo que realmente existe en el repo |
| Clasificación | **REUSABLE PATTERN, con evidencia real de uso** | **PILOT** — 3 de 6 roles con evidencia real de ejecución end-to-end; los 3 restantes siguen `EXPERIMENTAL` sin evidencia |

**Por qué esto importa**: el nivel Full no es solo "mejor especificado" — ahora tiene
evidencia real de que sus primeras 3 etapas (`spec-author`, `implementer`, `tester`)
funcionan end-to-end sobre un ticket real, con tests reales en verde. Lo que sigue sin
probarse es específicamente el tramo de aprobación/gate (`reviewer` en su forma de gate
formal, `security-reviewer`, `human-approver`) — ese es el gap real a cerrar, no el
workflow completo. Un equipo nuevo puede empezar por el nivel Lite, o adoptar las 3
primeras etapas del nivel Full si ya tiene la disciplina de contratos JSON — pero debe
tratar el tramo de aprobación del nivel Full como no verificado todavía.

## Cuándo usarlo

Cuando la secuencia de pasos de una feature es conocida de antemano (spec → implementar →
verificar) y no requiere que el sistema decida dinámicamente qué hacer — si necesitás
razonamiento dinámico o selección de herramienta en tiempo real, no es un Workflow, es un
Agent (`capability-model.md`, criterio de desambiguación).

## Cuándo NO usarlo

- Para cambios triviales (un typo, un ajuste de estilo) — el overhead de specs/estado no
  se justifica.
- Si el equipo no tiene disciplina de versionado de branches por ticket — el nivel Lite ya
  asume 1 ticket = 1 branch = 1 spec folder.

## Entradas

Un ticket real (Jira u otro sistema), **nunca inventado ni parafraseado de memoria** — el
requerimiento debe leerse de la fuente real antes de generar el spec.

## Salidas

- Un `requirements.md` en formato EARS, un `design.md`, un `tasks.md`.
- Código implementado, con tests.
- Un registro de estado explícito (`draft → spec_ready → approved → in_progress →
  verified → reviewed → done` en el nivel Full; más simple en el nivel Lite).
- Un `feature.json` con `traceability` (qué artefactos de código cubren qué requisito) y
  `qaManualPending` (qué requiere sign-off humano, con `signOff: null` hasta que ocurra).

## Instrucciones (nivel Lite — recomendado como punto de partida)

1. **Spec Author**: leer el ticket real (nunca inventar contenido), producir
   `requirements.md` en formato EARS (Cuando X, el sistema debe Y).
2. **Implementer**: implementar contra el spec, generar tests, actualizar
   `traceability` en `feature.json` con los archivos reales tocados por cada requisito.
3. **Reviewer**: verificar que el código cumple el spec y que los tests están en verde —
   **no marcar un requisito de tipo manual como cubierto sin sign-off humano real**
   (`qaManualPending`, `signOff` permanece `null` hasta que una persona lo confirme).
4. El estado de avance vive en un archivo de progreso **no versionado** (memoria de
   trabajo, no artefacto de producto) — nunca commitear el estado de sesión junto al
   código.

## Instrucciones adicionales (nivel Full — solo si se justifica escalar)

Agregar, sobre el nivel Lite: un rol `security-reviewer` con permiso de lectura sobre
configuración/secretos pero **prohibido de aprobar cambios con hallazgos críticos sin
corregir**; un rol `human-approver` como gate final explícito antes de `done`; contratos
JSON de entrada/salida por rol; y un log de auditoría estructurado. Ver
`registry/entries/spec-driven-development.md` para el detalle completo del esquema
encontrado (no reproducido acá para no invitar a copiarlo sin entender el costo de
mantenerlo).

## Dependencias

- Un sistema de tickets real (Jira u otro) — nunca operar sin una fuente de verdad
  externa para el contenido del requerimiento.
- Disciplina de 1 ticket = 1 branch, con nombres trazables.

## Herramientas / permisos

Ninguna especial en el nivel Lite (lectura del ticket, lectura/escritura de archivos de
spec y código, ejecución de tests). El nivel Full requiere, además, que el rol
`security-reviewer` tenga acceso de lectura a configuración/secretos — un permiso más
amplio que el resto de los roles, que debe gobernarse explícitamente si se adopta.

## Seguridad

Riesgo bajo en el nivel Lite (sin permisos especiales). El nivel Full introduce un rol con
acceso a secretos/configuración — cualquier equipo que lo adopte debe tratar ese acceso
con el mismo rigor que cualquier otro acceso a datos sensibles
(`../../../security/security-governance.md`).

## Datos

No aplica directamente — depende del dominio del ticket real que se procese.

## HITL

**Obligatorio y ya verificado como punto real de fricción**: en el nivel Lite, el
`signOff` de QA manual queda `null` hasta que una persona lo confirme — en los 2 casos
reales encontrados (`MOA-1765`, `MOA-1816`), **ninguno tiene sign-off todavía**, lo cual
es honesto (no se fuerza a "done" sin esa confirmación), no una falla del workflow.

## Ejemplos

2 casos reales completos: `MOA-1765-DistribuidorCupos` y `MOA-1816-CambiosFormulario`
(DataAgro, `_sdd/specs/`) — usados también como input real de los pilotos de G4.4/G4.6
para la capability `user-story` (Golden Path #1), lo cual muestra que ambos Golden Paths
(#1 Requirements y #2 Development) pueden compartir la misma fuente real de
requerimientos sin conflicto.

## Criterios de calidad

- El requerimiento se leyó de la fuente real, nunca inventado.
- `traceability` mapea cada requisito a artefactos de código reales, no genéricos.
- Ningún requisito manual se marca cubierto sin `signOff` humano explícito.

## Criterios de evaluación

`NOT FOUND` de forma sistemática en el nivel Lite (sin evidencia de evaluación formal del
proceso en sí, más allá de que produjo specs reales). En el nivel Full, `EXECUTED` para
las etapas `spec-author`/`implementer`/`tester` (build y suite de tests reales en verde,
corrección real de 2 clases de bugs) — pero `NOT FOUND` para el tramo de aprobación
(`reviewer`/`security-reviewer`/`human-approver`), agravado por la brecha ya documentada
entre el README de `moa-sdlc` y su contenido real.

## Evidencia / origen

Nivel Lite: DataAgro, `_sdd/docs/specs.md` (harness real, 3 roles) + 2 casos reales.
Nivel Full: `moa-sdlc`, `.github/AGENTS-CONTRACTS.md` + `.github/AGENTS-HARNESS.md` (461 +
159 líneas, contrato JSON explícito, 6 roles, máquina de estados de 7 estados — el
Workflow más formalizado de todo el relevamiento) — ver
`registry/entries/spec-driven-development.md` para el detalle completo con la
clasificación de evidencia por nivel.

## Versión

`1.0-generalized` (G5.1).

## Owner / Maintainer

`REQUIRES VALIDATION` — sin gobierno del Common Core confirmado (`../../../governance/BLOCKED-DECISIONS.md`
#1).

## Compatibilidad / adaptación

El nivel Lite es portable a cualquier equipo con un sistema de tickets real y disciplina
de branching por ticket. El nivel Full requiere una inversión de mantenimiento
significativamente mayor (contratos JSON por rol, máquina de estados) — no adoptar sin
evaluar si el equipo realmente necesita el gate de `security-reviewer` formal, o si el
nivel Lite con una revisión de seguridad humana informal ya cubre el riesgo real.
