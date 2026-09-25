---
name: azure-devops-cli
description: Ejecutar operaciones de Azure DevOps (pipelines, builds, PRs, variable groups) vía `az` CLI, con verificación de entorno obligatoria antes de cualquier tarea, sin inventar sintaxis de memoria. Usar cuando se deba consultar o modificar pipelines, PRs, builds o work items con `az`.
---

# azure-devops-cli

**Idioma de la respuesta**: español neutro y formal: tratar a la persona de usted, sin
voseo ni regionalismos, aunque la persona escriba de otra forma.

**Capability Registry**: [`CAP-008`](../../../registry/entries/azure-devops-cli.md).
Se usa como capacidad de soporte dentro de cualquier flujo que necesite operar Azure
DevOps (por ejemplo, al abrir un PR como parte de un flujo de desarrollo asistido).

## Propósito

Evitar que un asistente de IA invente sintaxis de `az` de memoria — fuente frecuente de
comandos que fallan o que operan sobre el proyecto u organización equivocada — forzando
una verificación de entorno explícita antes de cualquier operación.

## Cuándo usarla

- El equipo usa Azure DevOps (pipelines, PRs, variable groups, work items) y se quiere
  que un asistente de IA opere sobre él vía CLI, en vez de solo sugerir pasos manuales.
- Hay riesgo real de que el asistente invente flags o subcomandos de `az` que no existen
  o cambiaron de versión.

## Cuándo NO usarla

- Si el equipo no usa Azure DevOps.
- Para operaciones destructivas o administrativas de alto impacto (borrar pipelines,
  cambiar permisos de organización) — quedan fuera de alcance de esta skill.

## Entradas

- La tarea concreta a realizar (ej. "crear un PR de esta rama a `develop`", "mostrar el
  estado del último build del pipeline X").
- Organización/proyecto de Azure DevOps ya configurados en el entorno — esta skill no
  gestiona credenciales.

## Salidas

El resultado real de la operación (ID de PR creado, estado de build, valor de una
variable), o un error explícito si la verificación de entorno falla — nunca una
respuesta inventada.

## Instrucciones

1. **Verificar el entorno siempre primero, sin excepción**:
   - `az --version` — confirmar que la CLI está instalada.
   - `az extension list` — confirmar que la extensión `azure-devops` está instalada.
   - `az account show` — confirmar la sesión autenticada.
   - `az devops configure --list` — confirmar organización y proyecto por defecto, y
     mostrarlos antes de operar.
2. Si algún paso falla, detenerse y reportar el error exacto — nunca continuar asumiendo
   un estado de entorno que no se verificó.
3. Recién después, ejecutar el subcomando de `az devops`/`az pipelines`/`az repos`
   necesario — consultar siempre la sintaxis real (`az <comando> --help`) ante cualquier
   duda, en vez de recordarla.
4. Reportar el resultado real de la ejecución, no una interpretación optimista.
5. **Antes de cualquier operación de escritura no familiar** (crear PR, actualizar un
   Work Item, cambiar una variable de pipeline), leer primero el estado actual del
   recurso — nunca escribir a ciegas sobre algo no leído.
6. **Después de escribir, verificar con una lectura real** (releer el PR/Work Item
   creado) y citar el resultado concreto (ID, URL) — no dar la escritura por exitosa solo
   porque el comando no devolvió error.
7. **Nunca escribir contenido de prueba/placeholder** (ej. "test", "prueba") en un
   recurso real de Azure DevOps para validar que la conectividad de escritura funciona —
   para eso, usar un comando de solo lectura (`az repos pr show`, `az boards work-item
   show`) antes de la escritura real. Patrón confirmado como buena práctica real por un
   cliente de Baufest (Camuzzi) — nunca contaminar un ticket o PR real con contenido de
   prueba.
8. **Cierre, siempre**: reportar el resultado real y su referencia concreta (ID, URL) —
   nunca terminar sin decir si la operación pedida quedó hecha, pendiente de otro paso, o
   requiere que la persona confirme algo antes de seguir.

## Dependencias

- Azure CLI (`az`) instalado, con la extensión `azure-devops`.
- Sesión autenticada contra la organización de Azure DevOps del equipo.

## Herramientas / permisos

Ejecución de shell (`az` como proceso externo). No requiere edición de código. El nivel
de permisos real depende de la cuenta con la que `az` está autenticado — esta skill no
define ni eleva permisos.

## Seguridad

- Nunca imprimir tokens, PATs, ni el contenido de variables marcadas como secretas.
- No ejecutar operaciones destructivas (borrar recursos, cambiar permisos) salvo pedido
  explícito y confirmado por un humano en la propia interacción.
- Riesgo base bajo — los pre-checks son de solo lectura; el riesgo real depende de qué
  subcomando se invoque después.

## Datos

No accede a datos de negocio — opera sobre metadata de Azure DevOps (pipelines, PRs,
builds, variables). No debe usarse sobre variable groups con secretos sin verificar antes
con el equipo si eso es aceptable en ese contexto.

## Revisión humana

Cualquier operación de escritura (crear un PR, modificar una variable) debe quedar
visible en la conversación para que una persona la confirme antes de considerar la tarea
cerrada.

## Ejemplos

**Correcto**:
```bash
1. az --version                        → confirma instalación
2. az extension list                   → confirma extensión azure-devops
3. az account show                     → confirma sesión
4. az devops configure --list          → confirma org/proyecto, se muestra al usuario
5. az repos pr create --source-branch feature/x --target-branch develop --title "..."
```

**Incorrecto** (lo que esta skill previene):
```
az devops pr create --branch feature/x   ← sintaxis inventada, el subcomando real es
                                            "az repos pr create" con flags distintos
```

## Criterios de calidad

- Los 4 pre-checks se ejecutan siempre, en orden, antes de cualquier operación.
- Ningún comando se ejecuta de memoria sin poder justificar la sintaxis con `--help` o
  documentación real.
- Los resultados reportados son la salida real del comando, no una paráfrasis optimista.

## Criterios de evaluación

- ¿Los pre-checks corrieron antes de la operación?
- ¿La operación reportada como exitosa realmente ocurrió en Azure DevOps?

## Compatibilidad / adaptación

Portable a cualquier equipo que use Azure DevOps, sin importar el stack de aplicación —
la skill opera sobre Azure DevOps, no sobre el código. No hay nada que adaptar por
dominio de negocio, solo confirmar que la organización/proyecto están configurados en el
entorno correspondiente.

## Relación con Context Acquisition & Resolution

Esta skill cubre operaciones generales de Azure DevOps (pipelines, PRs, builds, variable
groups) — los pre-checks son de lectura, algunos subcomandos posteriores (como crear un
PR) son de escritura. Resolver un Work Item hacia contexto para otra capability es un
patrón distinto — ver
[`azure-devops-context-provider`](../../../integrations/azure-devops-context-provider.md).
