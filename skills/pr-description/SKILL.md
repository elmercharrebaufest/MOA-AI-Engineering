---
name: pr-description
description: Genera título, descripción y sugerencia de revisores de un Pull Request a partir del ticket de origen y el diff local. Usar al abrir un PR, no como sustituto de la revisión del código.
---

# pr-description

**Idioma de la respuesta**: español neutro y formal: tratar a la persona de usted, sin
voseo ni regionalismos, aunque la persona escriba de otra forma.

## Propósito

Redactar el título y la descripción de un Pull Request a partir del ticket de origen y el
diff real de los cambios, y sugerir revisores cuando el contexto los trae — reduciendo el
tiempo entre terminar el desarrollo y abrir el PR, sin reemplazar la descripción de lo que
el cambio hace realmente.

## Cuándo usarla

- Al terminar el desarrollo de una historia de usuario o fix, antes de abrir el PR.
- Cuando el ticket de origen ya está resuelto (vía Context Acquisition & Resolution,
  CAP-002/CAP-003) y el diff local existe.

## Cuándo NO usarla

- Para escribir la descripción de un PR que mezcla varios cambios no relacionados — en ese
  caso corresponde dividir el PR primero, no forzar una descripción que abarque todo.
- Como sustituto de que un revisor humano lea el diff — esta skill describe el cambio, no
  lo evalúa.

## Entradas

El ticket de origen (Resolved Context de CAP-002/CAP-003, o descripción manual) y el diff
real de los cambios (`git diff` contra la rama base).

## Salidas

Título del PR, descripción estructurada (qué cambia, por qué, cómo probarlo) y, si el
Resolved Context trae reviewers habituales o el CODEOWNERS del repo los define, una
sugerencia de revisores — nunca inventada si no hay esa información disponible.

## Instrucciones

### 1. Título

Formato `[TICKET-ID] Resumen breve del cambio` si hay ticket de origen; sin ticket, un
resumen breve y específico del cambio real (no genérico como "fix bug" o "update code").

### 2. Descripción

```text
## Qué cambia
[resumen del cambio real, derivado del diff — no del ticket, que describe la intención,
no necesariamente lo que el código termina haciendo]

## Por qué
[el motivo, tomado del ticket de origen — Ticket:/Requirement: del Resolved Context]

## Cómo probarlo
[pasos concretos para validar el cambio, derivados de los criterios de aceptación del
ticket si existen, o de los tests agregados/modificados en el diff]
```

### 3. Revisores sugeridos (solo si hay información real disponible)

Si el Resolved Context trae reviewers habituales del ticket, o el repo tiene un
`CODEOWNERS` para los archivos del diff, sugerirlos por nombre. Si no hay esa información,
declararlo explícitamente en vez de omitir la sección:

```text
No fue posible determinar revisores sugeridos con el contexto disponible — asignar
según el criterio habitual del equipo.
```

**Nunca inventar un nombre de revisor.**

### 4. Checklist de cierre

Agregar siempre, al final de la descripción, un checklist genérico para que quien abre el
PR lo complete antes de pedir revisión — no asumir que algo se cumplió:

```text
## Checklist
- [ ] El código compila sin errores
- [ ] Se ejecutaron las pruebas correspondientes
- [ ] No se incluyen credenciales ni datos sensibles
- [ ] La descripción de arriba corresponde al diff real (no a lo que el ticket pedía
      originalmente, si hubo cambios de alcance)
```

### 5. Verificar si ya existe un PR abierto para la misma rama

Antes de redactar contenido nuevo, si hay forma de consultarlo (CLI/integración ya
configurada por el equipo), verificar si ya existe un PR abierto para esa rama. Si existe,
señalarlo y mostrar su referencia en vez de proponer uno nuevo — evita duplicados.

## Cómo pedirlo

### Entrada

```
Ticket:
MOA-XXXX

Requirement:
"[el mismo Resolved Context ya usado por CAP-001, sin modificar]"

Diff:
[salida real de git diff contra la rama base]
```

### Patrón de ejecución

```
Necesito el título y la descripción del Pull Request de esta rama.

Ticket de origen:
[Ticket:/Requirement: del Resolved Context, si existe]

Diff real:
[el diff completo, sin resumir]

Genera:
1. Título del PR
2. Descripción (Qué cambia / Por qué / Cómo probarlo)
3. Revisores sugeridos, solo si hay información real disponible

No inventar revisores ni funcionalidad que el diff no muestra.
Si el diff no coincide con lo que describe el ticket, señalarlo como una discrepancia,
sin ocultarla.
```

### Revisión humana

Obligatoria: quien abre el PR debe revisar que la descripción generada corresponda al
diff real antes de publicarla — esta skill redacta, no certifica el cambio.

## Dependencias

Reutiliza el Resolved Context ya producido por
[`azure-devops-context`](../../registry/entries/azure-devops-context.md) (CAP-002) o
[`jira-context`](../../registry/entries/jira-context.md) (CAP-003) — no define un
mecanismo de acceso a tickets propio.

## Herramientas / permisos

Ninguna propia — lee el diff local (`git diff`) y el Resolved Context ya resuelto; no
accede a Azure DevOps/Jira por sí misma, ni abre el PR (esa acción sigue siendo del
desarrollador o de una integración `ACT` separada, fuera del alcance de esta skill).

## Seguridad

Riesgo bajo — solo lectura del diff y del ticket ya resuelto; no ejecuta ninguna acción
sobre Azure DevOps/Jira.

## Origen de esta propuesta

**Existing Practice**: ninguna instancia real en MOA todavía — el KO Interno (pág. 24)
describe la apertura automática del PR como objetivo Q4 2026, sin evidencia de
implementación en ningún repo relevado (`architecture/ai-sdlc.md`, etapa "Apertura del
PR", `NOT FOUND`). **External Best Practice**: la generación de descripción de PR a partir
del diff es una función ya estándar de GitHub Copilot ([Copilot pull request
summaries](https://docs.github.com/en/copilot/how-tos/agents/copilot-coding-agent/create-a-pr-description)).
**Architectural Judgment**: en vez de crear una integración nueva hacia Azure DevOps/Jira,
esta skill reutiliza el Resolved Context que CAP-002/CAP-003 ya resuelven — evita duplicar
lógica de adquisición de contexto. El checklist de cierre y la verificación de PR duplicado
(pasos 4 y 5) se agregaron tras contrastar contra una instancia real de un cliente de
Baufest (Camuzzi, skill `create-pull-request`, reunión 2026-09-18) — evidencia externa, no
de un equipo de MOA, generalizada sin copiar contenido específico de ese cliente (nombres de
repo, convención de ramas).

## Compatibilidad / adaptación

Portable a cualquier equipo que ya use Context Acquisition & Resolution (CAP-002/CAP-003)
— sin contenido específico de dominio que adaptar, a diferencia de CAP-001.
