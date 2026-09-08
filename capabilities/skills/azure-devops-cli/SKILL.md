---
name: azure-devops-cli
description: Ejecutar operaciones de Azure DevOps (pipelines, builds, PRs, variable groups) vía `az` CLI, con verificación de entorno obligatoria antes de cualquier tarea, sin inventar sintaxis de memoria.
---

# azure-devops-cli

**Capability Registry**: [`CAP-001`](../../../registry/entries/azure-devops-cli.md).
**Golden Path**: ninguno todavía dedicado — se usa como capacidad de soporte dentro de
cualquier Golden Path que necesite operar Azure DevOps (ej. Golden Path #2, "AI-Assisted
Development", paso "abrir PR").
**Clasificación (G5.1)**: **REUSABLE CAPABILITY** — ADOPT. Origen: 2 instancias
independientes casi idénticas (Scato Logística, Orquestador), mismo día, mismo
originador — evidencia de patrón real, no de adopción cruzada entre equipos.

## Propósito

Evitar que un asistente de IA invente sintaxis de `az` de memoria (fuente frecuente de
comandos que fallan o que operan sobre el proyecto/organización equivocada) al ejecutar
tareas de Azure DevOps, forzando una verificación de entorno explícita antes de cualquier
operación.

## Cuándo usarla

- El equipo usa Azure DevOps (pipelines, PRs, variable groups, work items) y quiere que un
  asistente de IA opere sobre él vía CLI en vez de solo sugerir pasos manuales.
- Existe riesgo real de que el asistente "alucine" flags o subcomandos de `az` que no
  existen o cambiaron de versión.

## Cuándo NO usarla

- Si el equipo no usa Azure DevOps (usa GitHub, GitLab, Jira, etc. — esto es
  específico de la plataforma).
- Para operaciones destructivas o administrativas de alto impacto (borrar pipelines,
  cambiar permisos de organización) — esas quedan fuera de alcance de esta skill por
  diseño; no agregarlas sin pasar antes por `security-governance.md`.

## Entradas

- La tarea concreta a realizar (ej. "creá un PR de esta rama a `develop`", "mostrame el
  estado del último build del pipeline X").
- Contexto de organización/proyecto de Azure DevOps ya configurado en el entorno (no se
  gestionan credenciales desde la skill misma).

## Salidas

- El resultado de la operación de Azure DevOps ejecutada (ID de PR creado, estado de
  build, valor de una variable, etc.), o un error explícito si el pre-check de entorno
  falla — nunca una respuesta inventada.

## Instrucciones

1. **Verificación de entorno obligatoria, siempre primero, sin excepción**:
   - `az --version` — confirmar que la CLI está instalada.
   - Confirmar que la extensión `azure-devops` está instalada (`az extension list`).
   - `az account show` — confirmar sesión autenticada.
   - `az devops configure --list` — confirmar organización/proyecto por defecto
     configurados, y **mostrarlos antes de operar** (para que quien lee la sesión vea
     contra qué org/proyecto se está por operar).
2. Si cualquier pre-check falla, **detenerse y reportar el error exacto** — nunca
   continuar asumiendo un estado de entorno que no se verificó.
3. Recién después de (1)-(2), ejecutar el subcomando de `az devops`/`az pipelines`/
   `az repos` necesario — consultando siempre la sintaxis real (`az <comando> --help`) en
   vez de recordarla, si hay cualquier duda.
4. Reportar el resultado real de la ejecución, no una interpretación optimista.

## Dependencias

- Azure CLI (`az`) instalado, con la extensión `azure-devops`.
- Sesión autenticada contra la organización de Azure DevOps del equipo.

## Herramientas / permisos

- Ejecución de shell (`az` como proceso externo). No requiere `edit` de código.
- El nivel de permisos real depende de la cuenta/token con el que `az` está autenticado —
  **esta skill no define ni eleva permisos**, opera con los que ya existen en el entorno.

## Seguridad

- **Nunca** imprimir tokens, PATs, o el contenido de variables marcadas como secretas.
- No ejecutar operaciones destructivas (borrar recursos, cambiar permisos) salvo pedido
  explícito y confirmado por un humano en la propia interacción.
- Riesgo base: **Bajo** — los pre-checks son de solo lectura; el riesgo real depende de
  qué subcomando se invoque después, no de la skill en sí.

## Datos

No accede a datos de negocio — opera sobre metadata de Azure DevOps (pipelines, PRs,
builds, variables). No usar para operar sobre variable groups con secretos sin
verificar antes con el equipo si eso es aceptable en este contexto.

## HITL

No declarado como obligatorio dentro de la skill misma (es una skill, no un agent con
autonomía propia) — el HITL real depende del agent/flujo que la invoque. Recomendado:
cualquier operación de escritura (crear PR, modificar variable) debe quedar visible en la
conversación para que un humano la confirme antes de considerar la tarea cerrada.

## Ejemplos

**Correcto**:
```
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
- Ningún comando se ejecuta "de memoria" sin poder justificar la sintaxis con `--help` o
  documentación real.
- Los resultados reportados son la salida real del comando, no una paráfrasis optimista.

## Criterios de evaluación

- ¿Los pre-checks corrieron antes de la operación? (verificable en el log de la sesión)
- ¿La operación reportada como exitosa realmente ocurrió en Azure DevOps? (verificable
  consultando el recurso directamente)
- Sin evidencia de evaluación humana real todavía — ver Registry.

## Evidencia / origen

2 instancias reales encontradas de forma independiente: Scato Logística (commit
`8bff906e`, PR 5629, 2026-07-20) y Orquestador (commit `872911c`, PR 5633, 2026-07-20),
mismo originador (Manuel Davila), contenido casi idéntico entre ambas — ver
[`registry/entries/azure-devops-cli.md`](../../../registry/entries/azure-devops-cli.md)
para el detalle completo y la clasificación de evidencia. Esta versión en
`capabilities/` es una **generalización**, no una copia literal de ninguna de las 2
instancias — no incluye referencias a proyectos/paths específicos de ningún repo.

## Versión

`1.0-generalized` (G5.1). No reemplaza las 2 instancias reales — son evidencia
independiente, esta es la versión de referencia para adoptar en un equipo nuevo.

## Owner / Maintainer

`REQUIRES VALIDATION` — sin gobierno del Common Core confirmado (`BLOCKED-DECISIONS.md`
#1).

## Compatibilidad / adaptación

Portable a cualquier equipo de MOA que use Azure DevOps, sin importar el stack de
aplicación (la skill opera sobre Azure DevOps, no sobre el código). Nada que adaptar por
dominio de negocio — solo confirmar que la organización/proyecto de Azure DevOps están
configurados en el entorno del equipo que la adopta.
