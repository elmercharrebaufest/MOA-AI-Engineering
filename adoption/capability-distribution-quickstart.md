# Capability Distribution — Quick Start

**Para quién es**: cualquier persona de un equipo (developer, tech lead, arquitecto) que
quiere que `capabilities/agents/` y `capabilities/skills/` de `ai-engineering` lleguen
a su propio repositorio automáticamente, sin que alguien tenga que copiarlos a mano cada
vez que cambian. Patrón completo: [`../integrations/capability-distribution.md`](../integrations/capability-distribution.md).

**No corresponde este camino si...** solo se quiere probar una capacidad una vez sobre un ticket real — para
eso, la copia manual vía agente (Paso 1 de
[`../capabilities/README.md`](../capabilities/README.md#cómo-usar-una-capacidad--ejemplo-concreto-de-punta-a-punta))
sigue siendo el camino más simple, sin pedirle nada a nadie.

**Estado**: `PROPOSAL`, sin ejecución real ni piloto de ningún equipo todavía —
`Real Use Status: NOT FOUND`.

## 1. Prerequisites

- Alguien con permisos de administración de tu proyecto/organización en Azure DevOps, para
  crear o ajustar la Service Connection del pipeline (una sola vez).
- Azure CLI (`az`) con la extensión `azure-devops` — mismo prerequisito ya vigente para
  CAP-008 (`azure-devops-cli`).
- Acceso de escritura (crear ramas y Pull Requests, **nunca** push directo a tu rama
  principal) desde esa Service Connection hacia tu repo.

## 2. Decisión de gobierno — agregar tu repo a la lista

Nada llega a tu repo hasta que alguien lo pide explícitamente. Abrir un Pull Request a
`ai-engineering` agregando tu repo en
[`../integrations/scripts/capability-distribution-targets.json`](../integrations/scripts/capability-distribution-targets.json):

```json
{
  "project": "<tu proyecto real de Azure DevOps>",
  "repository": "<tu repositorio real>",
  "targetBranch": "<tu rama principal real, ej. master>",
  "syncAgents": true,
  "syncSkills": true,
  "syncInstructionsIfMissing": true
}
```

`syncInstructionsIfMissing: true` solo crea el archivo de `instructions/` si tu repo
**no** tiene ya uno propio — nunca sobreescribe una matriz de autonomía que tu equipo ya
completó.

## 3. Configurar el pipeline (una sola vez)

Quien administre el Azure DevOps del equipo completa la plantilla
[`../integrations/scripts/capability-distribution-pipeline.yml`](../integrations/scripts/capability-distribution-pipeline.yml)
con el nombre real de la rama principal del equipo y el nombre real de la Service
Connection. Este pipeline corre en `ai-engineering` (o donde la organización decida
alojarlo) — no es algo que se instala en el propio repo del equipo.

## 4. Primera prueba, en modo seguro

Antes de dejarlo correr solo, alguien lo ejecuta una vez a mano con `-WhatIf` — muestra qué
cambiaría en tu repo, sin crear rama ni PR:

```powershell
./integrations/scripts/sync-capability-distribution.ps1 `
  -TargetsFile ./integrations/scripts/capability-distribution-targets.json `
  -WhatIf
```

Revisar la salida. Si el resultado tiene sentido, continuar con el paso 5.

## 5. Primer Pull Request real

Se corre sin `-WhatIf` (a mano, o dejando que el pipeline dispare la próxima vez que
cambie `capabilities/agents/` o `capabilities/skills/`). Te llega un Pull Request a tu
repo con el contenido actualizado.

## 6. Revisar y decidir, como cualquier otro PR

Tu equipo lo revisa, pide cambios o lo aprueba — nadie lo mergea automáticamente. Una vez
mergeado, no hay que instalar nada más: los archivos ya están en `.github/agents/` y
`.github/skills/` de tu repo, y Copilot Chat los detecta solo.

## 7. De ahí en adelante

Cada cambio real en `capabilities/agents/` o `capabilities/skills/` de
`ai-engineering` te genera un PR nuevo, solo. No hay que acordarse de nada — solo
revisar el PR cuando aparece.

## Qué NO hace este mecanismo

- No sobreescribe el `instructions/` del equipo si ya existe uno propio.
- No toca código de negocio ni ningún archivo fuera de `.github/agents/` y
  `.github/skills/` (y, condicionalmente, `.github/instructions/`).
- No mergea nada por su cuenta.
- No te agrega a la lista sin que alguien lo haya pedido en el paso 2.

## Ver también

- Patrón completo y justificación: [`../integrations/capability-distribution.md`](../integrations/capability-distribution.md).
- Camino manual, para uso puntual: [`../capabilities/README.md`](../capabilities/README.md).
- Mecanismo nativo de Azure DevOps para Code Review (etapa distinta, no reemplaza esto):
  referenciado en `../capabilities/README.md`, sección "Camino más maduro".
