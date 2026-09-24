---
name: ticket-update
description: Escribe en un ticket de Jira o un work item de Azure DevOps de forma segura — actualizar descripción y criterios, comentar, cargar horas, crear historias divididas, cambiar de estado — siempre mostrando el cambio y esperando confirmación antes de escribir, y verificando después. Usar cada vez que el asistente deba modificar un ticket.
---

# ticket-update

**Idioma de la respuesta**: español neutro y formal, sin voseo ni regionalismos, aunque la
persona escriba de otra forma.

**Capability Registry**: [`CAP-023`](../../../registry/entries/ticket-update.md).
**Estado**: `PROPOSAL` — sin ejecución real todavía. Es la primera capacidad del modelo
que escribe en un sistema externo; las condiciones del piloto están en
[`security/security-governance.md`](../../../security/security-governance.md), sección
"Escritura en tickets".

## Propósito

Que el asistente actualice el ticket a medida que avanza el SDLC — sin que la persona
tenga que copiar y pegar — sin perder el control: nada se escribe sin que la persona vea
el cambio exacto y lo confirme, y todo lo escrito queda identificado como generado con
asistencia.

## Cuándo usarla

Cada vez que otra capacidad o la persona pida modificar un ticket: la historia refinada,
las preguntas para el PO, el plan técnico, los casos de prueba, el vínculo al PR, la
carga de horas o el cierre.

## Cuándo NO usarla

- Para borrar tickets, comentarios u horas — nunca, en ningún caso.
- Para cambiar sprint, asignado, prioridad o permisos.
- Para cambios en varios tickets a la vez sin confirmar cada uno.
- Cuando la plataforma ya hace ese cambio sola (ver paso 2).

## Qué puede escribir cada rol

| Rol | Operaciones permitidas |
|---|---|
| Product Owner / refinamiento | Editar descripción y criterios; comentar; crear historias divididas y vincularlas a la original |
| Desarrollo | Comentar (plan técnico, vínculo al PR); cargar las horas propias |
| QA | Comentar (casos de prueba) |
| Validación de pruebas | Ninguna — solo lectura |
| Cierre | Comentar (resumen de cierre); cargar las horas propias; cambiar a "Done", solo si no lo hace la plataforma |

## Herramientas

**Jira** (servidor oficial Atlassian Rovo MCP —
[herramientas soportadas](https://developer.atlassian.com/cloud/rovo-mcp/guides/supported-tools/)):

| Operación | Herramienta |
|---|---|
| Leer el ticket, sus comentarios, sus horas, sus estados posibles | `getJiraIssue`, `listJiraIssueComments`, `listJiraIssueWorklogs`, `listJiraIssueTransitions` |
| Conocer los campos del tipo de ticket | `getJiraIssueTypeMetaWithFields` |
| Editar campos | `editJiraIssue` |
| Comentar | `addOrEditJiraIssueComment` |
| Cargar horas | `addOrEditJiraIssueWorklog` |
| Crear un ticket y vincularlo | `createJiraIssue`, `createJiraIssueLink` |
| Cambiar de estado | `transitionJiraIssue` — solo para estado; esta herramienta también puede mover a otro sprint, eso nunca se usa |

**Azure DevOps** (`az boards` —
[referencia oficial](https://learn.microsoft.com/en-us/cli/azure/boards/work-item?view=azure-cli-latest)):
leer con `az boards work-item show --id N`; comentar con
`az boards work-item update --id N --discussion "..."`; editar con `--description` o
`--fields "Campo=valor"`; cambiar de estado con `--state`.

## Instrucciones

### 1. Leer antes de escribir

Traer el estado actual del ticket: campos, comentarios existentes y, si corresponde,
estados posibles y horas ya cargadas. Nunca suponer un nombre de campo, un ID de estado ni
un campo personalizado — si no aparece en la lectura, preguntar.

### 2. Verificar si la plataforma ya lo hace

Antes de cambiar un estado, preguntar o verificar si ya existe una regla automática (por
ejemplo, una automatización de Jira que mueve el ticket al mergear el PR, o la opción de
Azure DevOps que completa los work items vinculados al mergear). Si existe, no se
escribe: se informa que la plataforma lo va a hacer.

### 3. Mostrar el cambio exacto

```text
✏️ Cambio propuesto en [CLAVE-123] — [operación]

Campo / comentario: [nombre]
Antes:   [valor actual, resumido si es largo]
Después: [valor nuevo, completo]

¿Confirmar? (sí / editar / cancelar)
```

Para horas: detalle por día, lo ya cargado y lo que se agregaría. Para varios tickets: un
bloque por ticket, cada uno con su confirmación.

### 4. Escribir solo con un "sí" explícito

"Editar" vuelve al paso 3 con el cambio corregido. "Cancelar" termina sin escribir. El
silencio o una respuesta ambigua no cuentan como confirmación.

### 5. Marcar lo escrito

Todo comentario o descripción escrita termina con una línea:

```text
— Generado con asistencia de ai-engineering y revisado por [persona que confirmó]. [ai-engineering:<operación>]
```

La marca permite, la próxima vez, **editar** el comentario anterior en lugar de agregar
uno repetido (buscar la marca con `listJiraIssueComments` antes de comentar). Para horas,
restar lo ya cargado por la persona ese día. Para listas (labels, componentes), agregar a
lo existente, nunca reemplazar la lista entera.

### 6. Verificar después de escribir

Volver a leer el ticket y comparar con lo confirmado. Si no coincide (texto cortado,
campo sin cambiar), informar el problema, reintentar una sola vez y, si vuelve a fallar,
detenerse. Nunca borrar lo que quedó a medias.

### 7. Dejar evidencia

Informar a la persona qué quedó escrito (clave del ticket, operación, ID del comentario o
del registro de horas, estado nuevo) — es la línea que va al registro de evidencia si el
equipo lo lleva.

### 8. Cierre, siempre

```text
✅ Actualizado [CLAVE-123]: [qué se escribió]. Verificado después de escribir.
```

o, si no se escribió, la razón (cancelado por la persona, la plataforma ya lo hace, falta
un permiso, error al escribir) y qué corresponde hacer.

## Identidad

Con Atlassian Rovo MCP, el asistente escribe **con la cuenta de la persona que lo usa** y
con sus mismos permisos de Jira: el historial del ticket la muestra como autora, porque
es quien confirmó cada cambio. La marca del paso 5 deja visible que el texto se generó
con asistencia. Si un equipo necesita que escriba una cuenta técnica compartida, es una
decisión de gobierno pendiente, no algo que esta skill resuelva
([`governance/BLOCKED-DECISIONS.md`](../../../governance/BLOCKED-DECISIONS.md) #4).

## Revisión humana

Obligatoria en cada escritura, sin excepción — es el paso 4.

## Seguridad

Riesgo **Medio**: escribe en un sistema que leen otras personas. Controles: confirmación
por cambio, verificación posterior, marca visible, lista cerrada de operaciones por rol y
sin herramientas de borrado ni de administración.

## Origen

**External Best Practice**: Atlassian recomienda para su servidor MCP "mínimo privilegio,
revisar los cambios de alto impacto antes de confirmar y monitorear los registros de
auditoría" ([documentación oficial](https://support.atlassian.com/security-and-access-policies/docs/understand-atlassian-rovo-mcp-server/)).
**Evidencia externa (Camuzzi)**: confirmación explícita antes de cargar horas o crear
casos de prueba, y verificación de cada escritura con una lectura posterior. Se descarta
a propósito su patrón de comentar y etiquetar sin mostrar antes el cambio.
**Architectural Judgment**: una sola skill de escritura, reutilizada por todos los roles,
en lugar de repetir las reglas en cada agente.

## Compatibilidad / adaptación

Jira (Rovo MCP) y Azure DevOps (`az boards`). Cada equipo confirma qué estados usa su
flujo y si tiene automatizaciones de cambio de estado ya configuradas.
