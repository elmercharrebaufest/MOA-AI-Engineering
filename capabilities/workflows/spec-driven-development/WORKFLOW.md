---
name: spec-driven-development
description: Workflow de múltiples pasos con estado para llevar un requerimiento desde ticket hasta código verificado, con roles fijos y trazabilidad explícita.
---

# spec-driven-development

**Idioma de la respuesta**: español neutro y formal, sin voseo ni regionalismos, aunque la
persona escriba de otra forma.

**Capability Registry**: [`CAP-005`](../../../registry/entries/spec-driven-development.md).
**Golden Path**: [`AI-Assisted Development`](../../../golden-paths/README.md#2-ai-assisted-development).

## Propósito

Formalizar el ciclo de vida de una feature (Plan → Execute → Verify) con trazabilidad
explícita desde el ticket hasta el código, evitando 2 fallas frecuentes: que un
asistente invente el contenido de un requerimiento en vez de leerlo de la fuente real, y
que "está terminado" se declare sin evidencia verificable (tests en verde, QA manual con
sign-off).

## Dos niveles de madurez

| | **Nivel Lite** | **Nivel Full** |
|---|---|---|
| Roles | 3: spec-author → implementer → reviewer | 6: spec-author → implementer → tester → reviewer → security-reviewer → human-approver |
| Contrato entre roles | Informal (Markdown + checklist) | JSON explícito por rol (input/output, qué no puede cambiar, qué requiere confirmar antes) |
| Estado | Un archivo de progreso simple, no versionado | Máquina de estados con transiciones explícitas |
| Auditoría | Implícita en el historial de PRs | Log de auditoría estructurado (timestamp, rol, acción, evidencia, estado) |

Un equipo nuevo puede empezar por el nivel Lite, o adoptar las primeras etapas del nivel
Full si ya tiene la disciplina de contratos JSON. El tramo de aprobación del nivel Full
(reviewer como gate formal, security-reviewer, human-approver) requiere más inversión de
mantenimiento — no corresponde adoptarlo sin evaluar si realmente se necesita, o si el
nivel Lite con una revisión de seguridad humana informal ya cubre el riesgo real.

## Cuándo usarlo

Cuando la secuencia de pasos de una feature es conocida de antemano (spec → implementar
→ verificar) y no requiere que el sistema decida dinámicamente qué hacer. Si se necesita
razonamiento dinámico o selección de herramienta en tiempo real, no es un Workflow, es un
Agent.

## Cuándo NO usarlo

- Para cambios triviales (un typo, un ajuste de estilo) — el overhead de specs/estado no
  se justifica.
- Si el equipo no tiene disciplina de versionado de branches por ticket — el nivel Lite
  ya asume 1 ticket = 1 branch = 1 spec folder.

## Entradas

Un ticket real (Jira, Azure DevOps u otro sistema), nunca inventado ni parafraseado de
memoria — el requerimiento se lee de la fuente real antes de generar el spec. **Si la
tarea no tiene ticket en ningún sistema**, este Workflow completo puede no justificarse
(ver "Cuándo NO usarlo") — para una tarea chica sin ticket, alcanza con describirla
directamente y aplicar `repository-governance` (CAP-006) más la skill de dominio que
corresponda, sin el estado ni la trazabilidad completa de este Workflow.

## Salidas

- Un `requirements.md` en formato EARS, un `design.md`, un `tasks.md`.
- `research.md` (opcional, ver abajo).
- `contracts/` (opcional, ver abajo).
- Código implementado, con tests.
- Un registro de estado explícito.
- Un `feature.json` con trazabilidad (qué artefactos de código cubren qué requisito) y
  qué requiere sign-off humano, sin marcarlo cumplido hasta que ocurra.

## Artefactos opcionales — `research.md` y `contracts/`

- **`research.md`**: usarlo cuando el Spec Author necesitó investigar, comparar
  alternativas o consultar material fuente antes de poder escribir `requirements.md` con
  confianza — no es obligatorio para features triviales. Contenido: opciones
  consideradas, por qué se eligió una, links o citas al material fuente real, nunca
  resumido de memoria.
- **`contracts/`**: usarlo cuando la feature expone o consume una API o interfaz entre
  componentes (endpoint REST, contrato entre capas, DTO compartido) — el Spec Author o
  el Implementer declara la forma esperada (request/response, campos, tipos) antes de
  implementar, para que el Reviewer pueda verificar el código contra un contrato
  explícito. No confundirlo con los contratos JSON de entrada/salida entre roles del
  nivel Full — son conceptos distintos: uno es un contrato técnico (API), el otro es un
  contrato de proceso (handoff entre roles).

Ninguno de los 2 es obligatorio — son condicionales a que la feature real lo justifique.

## Instrucciones (nivel Lite — recomendado como punto de partida)

1. **Spec Author**: leer el ticket real (nunca inventar contenido); si hubo
   investigación o decisión real antes de poder escribir el spec, dejarla en
   `research.md` (opcional); producir `requirements.md` en formato EARS; si la feature
   expone o consume una API, declarar su forma esperada en `contracts/` (opcional) antes
   de pasar a Implementer.
2. **Implementer**: implementar contra el spec, generar tests, actualizar la
   trazabilidad con los archivos reales tocados por cada requisito.
3. **Reviewer**: verificar que el código cumple el spec y que los tests están en verde —
   nunca marcar un requisito de tipo manual como cubierto sin sign-off humano real.
4. El estado de avance vive en un archivo de progreso no versionado (memoria de trabajo,
   no artefacto de producto) — nunca commitear el estado de sesión junto al código.
5. **Cierre, siempre**: con el Reviewer aprobando, corresponde pedirle al asistente que
   redacte el título y la descripción del Pull Request a partir del diff real, y — una
   vez mergeado — que arme el borrador de cierre del ticket. Este Workflow no hace
   ninguna de las 2 cosas por sí mismo.

## Instrucciones adicionales (nivel Full — solo si se justifica escalar)

**Origen real (corregido 2026-09-22)**: esto ya no es un diseño conceptual — es la
generalización de la arquitectura real de `moa-sdlc`, en uso por DataAgro (ver
`registry/entries/spec-driven-development.md` para el detalle de evidencia).

Sobre el nivel Lite, agregar: un rol `security-reviewer` con permiso de lectura sobre
configuración/secretos pero sin poder aprobar cambios con hallazgos críticos sin
corregir; un rol `human-approver` como gate final explícito antes de cerrar; contratos
JSON de entrada/salida por rol; y un log de auditoría estructurado. Ver
[`registry/entries/spec-driven-development.md`](../../../registry/entries/spec-driven-development.md)
para el detalle completo del esquema.

**Máquina de estados real** (7 estados, no una lista abierta):
`draft → spec_ready → approved → in_progress → verified → reviewed → done`. Cada
transición requiere que el rol correspondiente confirme el criterio de salida de la etapa
anterior — nunca se salta un estado.

**2 Pull Requests por ticket, no uno solo**: un PR de spec (contra la rama de destino,
antes de implementar — permite revisar `requirements.md`/`design.md`/`tasks.md` sin
código de por medio) y un PR final de implementación — ambos con aprobación humana
explícita, nunca merge automático de ninguno de los 2.

**Contrato real de entrada/salida por rol** (condensado — el esquema completo con
ejemplos vive en `moa-sdlc/.github/AGENTS-CONTRACTS.md`, no se duplica acá):

- **Entrada**: identificador del ticket, rol, estado actual, rutas a los archivos de spec
  reales, contexto (branch/ambiente/stack), y `constraints` explícitos (`mustNotChange`:
  archivos que no se tocan sin aprobación aparte; `mustAskBefore`: acciones que requieren
  confirmación antes de ejecutarse — instalar un paquete nuevo, cambiar el modelo de
  datos, cambiar un contrato público).
- **Salida**: estado (`success`/`failed`/`blocked`), la transición de estado real
  (`from`/`to`), resumen, artefactos tocados, evidencia (tests ejecutados + resultados +
  validaciones manuales), riesgos detectados, y el próximo rol que sigue.

**Log de auditoría real, por cada ejecución**: `timestamp`, `featureId`, `agentRole`,
`actor` (agente o humano), qué se pidió, qué se hizo, qué se produjo, evidencia de
verificación, estado, errores/advertencias, y próximo paso — mismo campo por campo que ya
usa `moa-sdlc` en producción, no un diseño nuevo.

**Reintentos y reversión** (regla dura, no negociable): máximo 1-2 reintentos ante un
fallo claramente transitorio y reproducible — si persiste, se bloquea la transición y
vuelve al rol responsable, nunca se reintenta indefinidamente. Si un cambio rompe
compatibilidad o hay riesgo de seguridad detectado, se revierte o aísla antes de seguir —
nunca se avanza "para no perder el trabajo hecho".

## Dependencias

- Un sistema de tickets real (Jira u otro) — nunca operar sin una fuente de verdad
  externa para el contenido del requerimiento.
- Disciplina de 1 ticket = 1 branch, con nombres trazables.

## Herramientas / permisos

Ninguna especial en el nivel Lite (lectura del ticket, lectura/escritura de archivos de
spec y código, ejecución de tests). El nivel Full requiere además que el rol
`security-reviewer` tenga acceso de lectura a configuración/secretos — un permiso más
amplio que el resto de los roles, que debe gobernarse explícitamente si se adopta.

## Seguridad

Riesgo bajo en el nivel Lite (sin permisos especiales). El nivel Full introduce un rol
con acceso a secretos/configuración — tratar ese acceso con el mismo rigor que cualquier
otro acceso a datos sensibles.

## Datos

No aplica directamente — depende del dominio del ticket real que se procese.

## Revisión humana

Obligatoria en el nivel Lite: el sign-off de QA manual queda pendiente hasta que una
persona lo confirme — no se fuerza a "terminado" sin esa confirmación.

## Criterios de calidad

- El requerimiento se leyó de la fuente real, nunca inventado.
- La trazabilidad mapea cada requisito a artefactos de código reales, no genéricos.
- Ningún requisito manual se marca cubierto sin sign-off humano explícito.

## Compatibilidad / adaptación

El nivel Lite es portable a cualquier equipo con un sistema de tickets real y disciplina
de branching por ticket. El nivel Full requiere una inversión de mantenimiento
significativamente mayor — corresponde evaluar si el equipo realmente necesita el gate de
security-reviewer formal antes de adoptarlo.
