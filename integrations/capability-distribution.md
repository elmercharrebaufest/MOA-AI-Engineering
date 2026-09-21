# Capability Distribution (pattern) — sync por Pull Request

**No es una capability del Registry** — es infraestructura de distribución del propio
modelo, mismo tratamiento que
[Context Acquisition & Resolution](../architecture/context-acquisition-resolution.md): un
mecanismo transversal, no algo que un developer invoca por chat.

**Action Type**: **ACT, acotado** — crea rama + commit + Pull Request. **Nunca** hace push
directo a la rama principal de un repo de equipo, **nunca** aprueba ni mergea el PR que
abre.

**Estado**: `PROPOSAL` — sin ejecución real ni piloto de ningún equipo todavía.
`Real Use Status: NOT FOUND`.

## Origen de este patrón

**Existing Practice**: el mecanismo de escritura (`az repos pr create`) es el mismo que ya
usan en producción Scato Logística y Orquestador — ver
[CAP-008 `azure-devops-cli`](../registry/entries/azure-devops-cli.md). Este patrón no
introduce una forma nueva de escribir en Azure DevOps, reutiliza la que ya está probada.

**External Best Practice**: el problema de "mantener archivos compartidos actualizados en
muchos repos" es un patrón conocido en la industria — herramientas como
[`repo-file-sync-action`](https://github.com/BetaHuhn/repo-file-sync-action) o
[`actions-template-sync`](https://github.com/marketplace/actions/actions-template-sync)
implementan exactamente esta idea (repo fuente → comparación → PR automático en cada
destino) para GitHub. Ninguna tiene soporte nativo para Azure DevOps — este patrón adapta
la misma idea sobre la infraestructura real de MOA (Azure Pipelines + `az repos pr
create`), no copia ninguna herramienta puntual.

**Architectural Judgment**: se investigaron y descartaron 3 mecanismos nativos de
plataforma antes de proponer este (ver
[`../TRACK-1/analisis-camuzzi-agent-plugins.md`](../TRACK-1/analisis-camuzzi-agent-plugins.md)
para el detalle completo de la investigación):
1. Agent Plugins 1.0 de GitHub (repo especial `.github` de organización) — requiere que el
   repo del equipo tenga su remote en github.com bajo esa organización. Los repos reales de
   MOA están en Azure DevOps (`az repos pr create`, Work Items — ver CAP-008/CAP-002) — no
   aplica.
2. Copilot Code Review para Azure Repos (nativo de Azure DevOps, instrucciones a nivel
   organización/proyecto/repositorio) — real y aplicable directamente, pero **acotado
   exclusivamente a la revisión de Pull Requests**, no al resto del ciclo de desarrollo.
   Sigue siendo el camino recomendado para esa etapa puntual — no lo reemplaza este patrón.
3. Mecanismos de GitHub Enterprise atados a la identidad del developer (enterprise-managed
   settings/plugins) — confirmado en documentación oficial que son gobierno de políticas
   (qué plugins están aprobados), no distribución del contenido de agents/skills; y de
   todas formas requieren una cuenta Enterprise de GitHub, que MOA no tiene evidencia de
   poseer.

Con las 3 descartadas para el alcance completo del SDLC, la alternativa de menor esfuerzo
de ingeniería (repo compartido + VS Code multi-root workspace) se dejó como opción a
pilotear antes que este mecanismo si un equipo real lo prefiere — ver la nota de "Camino
más maduro" en [`../capabilities/README.md`](../capabilities/README.md). Este patrón es
para cuando se necesita que la distribución sea automática sin que el developer tenga que
adoptar un archivo de workspace.

## Propósito

Cuando cambia el contenido canónico de `capabilities/agents/` o `capabilities/skills/` en
`MOA-AI-Engineering`, abrir automáticamente un Pull Request en cada repo de equipo que
adoptó este mecanismo, con esos archivos actualizados — para que el equipo revise y decida
si lo adopta, sin tener que copiar nada a mano.

## Alcance — qué se propaga y qué no

| Contenido | Se propaga | Cómo |
|---|---|---|
| `capabilities/agents/<name>/AGENT.md` | Sí | Copia directa → `.github/agents/<name>.agent.md` (mismo mapeo ya documentado en `capabilities/README.md`) |
| `capabilities/skills/<name>/SKILL.md` | Sí | Copia directa → `.github/skills/<name>/SKILL.md` |
| `capabilities/instructions/<name>/INSTRUCTIONS.md` | Solo si el equipo **no** tiene ya un archivo propio en ese path | Es una plantilla de estructura, **100% Team Adaptation** (ver `capabilities/README.md`) — este mecanismo nunca sobreescribe contenido que un equipo ya completó con su propia matriz de autonomía |
| `capabilities/workflows/` | No | Describe roles/estado, no un archivo que un equipo instale — queda fuera de este mecanismo |
| Cualquier archivo de `architecture/`, `registry/`, `golden-paths/`, `governance/`, `strategy/` | **Nunca** | Es documentación del modelo en sí — ningún equipo necesita esto copiado en su propio repo |

## Flujo

```text
Cambio real en capabilities/agents/** o capabilities/skills/** (rama principal de MOA-AI-Engineering)
        ↓
Azure Pipeline disparado (filtro de path — no dispara por cambios de documentación)
        ↓
Para cada repo en capability-distribution-targets.json:
        ↓
   Clonar repo destino → copiar contenido mapeado → comparar contra lo que ya tiene
        ↓
   ¿Hay diferencias?  No → no hace nada, sigue con el próximo repo
        ↓ Sí
   Crear rama → commit → az repos pr create (mismo comando que ya usan Scato Logística/Orquestador)
        ↓
   El equipo dueño del repo revisa y decide aprobar — igual que cualquier otro PR
```

## Configuración — lista de repos destino

`scripts/capability-distribution-targets.json` — **lista explícita, mantenida a mano**, no
automática para cualquier repo nuevo. Un repo solo recibe estos PRs si alguien lo agregó a
esta lista deliberadamente — es una decisión de gobierno, no un efecto secundario de crear
un repositorio. Esta plantilla no incluye ningún repo real de MOA.

## Nunca hace (sin excepción)

- **Nunca push directo** a la rama principal de un repo destino — siempre rama nueva +
  Pull Request.
- **Nunca aprueba ni mergea** el PR que abre — eso lo decide el equipo dueño del repo.
- **Nunca sobreescribe** un archivo de `instructions/` que el equipo ya completó con
  contenido propio.
- **Nunca toca** código de negocio ni ningún archivo fuera de `.github/agents/` y
  `.github/skills/` (y, condicionalmente, `.github/instructions/`) del repo destino.
- **Nunca asume** credenciales — la autenticación contra cada repo destino depende del
  entorno de ejecución (Service Connection de Azure Pipelines), nunca un token hardcoded en
  este patrón.

## Errores

| Situación | Comportamiento |
|---|---|
| Repo destino no accesible / sin permisos | Se registra como fallo para ese repo, no interrumpe el resto de la lista |
| Rama objetivo del repo destino no existe | Se registra como fallo, no se infiere ni se crea una rama principal nueva |
| PR ya abierto por una sincronización anterior sin mergear | No se abre un PR duplicado — se actualiza la rama existente |

## Límites

- No resuelve conflictos — si el equipo modificó el archivo copiado, el PR puede quedar
  con conflicto de merge; lo resuelve el equipo, este mecanismo no fuerza el contenido.
- No versiona ni permite hacer rollback de una sincronización — cada PR es independiente,
  el historial de Pull Requests del repo destino es la única auditoría.
- No cubre plataformas de IA distintas a GitHub Copilot todavía — mismo alcance que el
  resto del modelo hoy (ver Blocked Decision #2).

## Evidencia

El mecanismo de escritura (`az repos pr create`) tiene evidencia real de uso en 2 repos de
equipos de MOA (CAP-008). **Este patrón específico (comparar contenido y abrir PR
automático) no tiene ejecución real todavía** — es un diseño, no una prueba realizada.

## Implementación ejecutable

- [`scripts/sync-capability-distribution.ps1`](scripts/sync-capability-distribution.ps1) —
  script real, usa `az` CLI (mismo mecanismo que CAP-008), sin credenciales hardcoded.
- [`scripts/capability-distribution-targets.json`](scripts/capability-distribution-targets.json)
  — plantilla de configuración, sin repos reales.
- [`scripts/capability-distribution-pipeline.yml`](scripts/capability-distribution-pipeline.yml)
  — definición de Azure Pipeline con el disparador por cambio de path.
- Quick Start paso a paso para un equipo que quiere adoptarlo:
  [`../adoption/capability-distribution-quickstart.md`](../adoption/capability-distribution-quickstart.md).

## Qué es Team Adaptation, explícitamente

- La lista de repos destino (`capability-distribution-targets.json`).
- La Service Connection / autenticación real usada por el pipeline.
- La rama principal de cada repo destino (`targetBranch` en la configuración).
- Cualquier contenido ya completado en `.github/instructions/` de un equipo — este
  mecanismo nunca lo reemplaza.
