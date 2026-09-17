---
name: spec-driven-development
description: Workflow de múltiples pasos con estado para llevar un requerimiento desde ticket hasta código verificado, con roles fijos y trazabilidad explícita.
---

# spec-driven-development

**Capability Registry**: [`CAP-004`](../../../registry/entries/spec-driven-development.md).
**Golden Path**: [`AI-Assisted Development`](../../../golden-paths/README.md#2-ai-assisted-development).

## Propósito

Formalizar el ciclo de vida de una feature (Plan → Execute → Verify) con trazabilidad
explícita desde el ticket hasta el código, evitando 2 fallas frecuentes: que un
asistente invente el contenido de un requerimiento en vez de leerlo de la fuente real, y
que "está terminado" se declare sin evidencia verificable (tests en verde, QA manual con
sign-off).

## Dos niveles de madurez — no los confundas

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

Un ticket real (Jira u otro sistema), nunca inventado ni parafraseado de memoria — el
requerimiento se lee de la fuente real antes de generar el spec.

## Salidas

- Un `requirements.md` en formato EARS, un `design.md`, un `tasks.md`.
- `research.md` (opcional, ver abajo).
- `contracts/` (opcional, ver abajo).
- Código implementado, con tests.
- Un registro de estado explícito.
- Un `feature.json` con trazabilidad (qué artefactos de código cubren qué requisito) y
  qué requiere sign-off humano, sin marcarlo cumplido hasta que ocurra.

## Artefactos opcionales — `research.md` y `contracts/`

- **`research.md`**: usalo cuando el Spec Author necesitó investigar, comparar
  alternativas o consultar material fuente antes de poder escribir `requirements.md` con
  confianza — no es obligatorio para features triviales. Contenido: opciones
  consideradas, por qué se eligió una, links o citas al material fuente real, nunca
  resumido de memoria.
- **`contracts/`**: usalo cuando la feature expone o consume una API o interfaz entre
  componentes (endpoint REST, contrato entre capas, DTO compartido) — el Spec Author o
  el Implementer declara la forma esperada (request/response, campos, tipos) antes de
  implementar, para que el Reviewer pueda verificar el código contra un contrato
  explícito. No lo confundas con los contratos JSON de entrada/salida entre roles del
  nivel Full — son conceptos distintos: uno es un contrato técnico (API), el otro es un
  contrato de proceso (handoff entre roles).

Ninguno de los 2 es obligatorio — son condicionales a que la feature real lo justifique.

## Instrucciones (nivel Lite — recomendado como punto de partida)

1. **Spec Author**: leé el ticket real (nunca inventes contenido); si hubo
   investigación o decisión real antes de poder escribir el spec, dejala en
   `research.md` (opcional); producí `requirements.md` en formato EARS; si la feature
   expone o consume una API, declará su forma esperada en `contracts/` (opcional) antes
   de pasar a Implementer.
2. **Implementer**: implementá contra el spec, generá tests, actualizá la trazabilidad
   con los archivos reales tocados por cada requisito.
3. **Reviewer**: verificá que el código cumple el spec y que los tests están en verde —
   nunca marques un requisito de tipo manual como cubierto sin sign-off humano real.
4. El estado de avance vive en un archivo de progreso no versionado (memoria de trabajo,
   no artefacto de producto) — nunca commitees el estado de sesión junto al código.

## Instrucciones adicionales (nivel Full — solo si se justifica escalar)

Sobre el nivel Lite, agregá: un rol `security-reviewer` con permiso de lectura sobre
configuración/secretos pero sin poder aprobar cambios con hallazgos críticos sin
corregir; un rol `human-approver` como gate final explícito antes de cerrar; contratos
JSON de entrada/salida por rol; y un log de auditoría estructurado. Ver
[`registry/entries/spec-driven-development.md`](../../../registry/entries/spec-driven-development.md)
para el detalle completo del esquema.

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
con acceso a secretos/configuración — tratá ese acceso con el mismo rigor que cualquier
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
