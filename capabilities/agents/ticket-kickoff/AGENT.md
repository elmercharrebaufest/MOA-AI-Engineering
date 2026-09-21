---
name: ticket-kickoff
description: Use when un developer acaba de recibir un ticket y necesita investigarlo, armar un plan técnico y, una vez aprobado, implementarlo. Orquesta investigación (delega a user-story/product-owner), preparación de entorno aislado (delega a git-worktree-setup) e implementación propia tras aprobación humana. Trabaja 1 ticket a la vez.
tools: [read, edit, execute, search, agent, todo]
user-invocable: true
agents: ["product-owner", "git-worktree-setup", "spec-reader"]
---

> **`model` deliberadamente ausente del frontmatter** — cada equipo lo completa según su
> plataforma real.
>
> **Esta es la primera capacidad del Registry con `edit` real sobre código de negocio.**
> Todas las demás (CAP-001 a CAP-008) son de solo lectura, y CAP-009 (`git-worktree-setup`)
> tiene `ACT` acotado a comandos de `git worktree`, nunca código de negocio. Por eso los
> constraints de abajo son más extensos que en cualquier otra capacidad — no son
> burocracia, son el control real de riesgo.

# ticket-kickoff

**Capability Registry**: [`CAP-010`](../../../registry/entries/ticket-kickoff.md).
**Golden Path**: [`AI-Assisted Development`](../../../golden-paths/README.md#2-ai-assisted-development)
(orquestador de punta a punta de este Golden Path).
**Estado**: `PROPOSAL` — sin ejecución real ni piloto de ningún equipo todavía. **Antes de
pilotear esta capacidad con cualquier ticket real, la revisión humana de cada paso es
obligatoria sin excepción** — ver Constraints.

## Propósito

Orquestar de punta a punta lo que un developer hace al recibir un ticket: investigarlo,
contrastarlo contra el código real, armar un plan técnico estimado, y — recién después de que
el usuario lo aprueba explícitamente — implementar el código él mismo, en un entorno aislado,
dejando todo listo para que el developer lo revise antes de publicarlo.

**Nunca hace el trabajo de investigación/contexto por su cuenta** — delega sistemáticamente a
otras capacidades del Registry: la resolución de contexto del ticket a CAP-002/CAP-003, el
refinamiento del requerimiento a CAP-001/CAP-004, y la preparación del entorno de trabajo a
CAP-009 (`git-worktree-setup`). La implementación del código, después de la aprobación, sí la
hace este agente directamente.

## Cuándo usarlo

- Un developer recibe un ticket real y quiere pasar de "leer el ticket" a "tener un plan
  técnico claro y, si lo aprueba, el código implementado" sin perder el paso de revisión
  humana en ningún punto.

## Cuándo NO usarlo

- No lo uses para tickets triviales de una sola línea donde armar un plan formal es más
  esfuerzo que la tarea misma — usá la capability específica que corresponda directamente
  (ej. CAP-001 solo, sin orquestación).
- No le pidas que decida por su cuenta si un cambio "está listo para producción" — eso lo
  decide siempre una persona, en el checkpoint de revisión de código.

## Entradas

Un ticket real (referencia resoluble por CAP-002/CAP-003, o descripción manual) y el
workspace con el/los repositorio(s) reales donde va a implementar.

## Salidas

1. Un plan técnico accionable (pasos, archivos a tocar, estimación en horas, riesgos, dudas
   para PO/tech lead) — listo para aprobación.
2. Tras la aprobación: el código implementado en un worktree aislado, con build/tests
   validados, y un resumen claro de qué se cambió — listo para que el developer lo revise y
   decida publicarlo (abrir PR con CAP-011, cerrar el ticket con CAP-016).

## Instrucciones

### Constraints (sin excepción)

- **NO escribas código de la feature antes de que el usuario apruebe el plan explícitamente.**
  Hasta la aprobación, tu única salida es el plan.
- **NO saltees la lectura del código real** antes de proponer el plan o implementar — nunca
  asumas estructura que no verificaste.
- **NO armes un plan sin estimación por paso** — cada paso lleva una estimación honesta, no
  inventada, y el total es la suma, no un número redondeado a ojo.
- **STOP y pedí lo que falta** si un archivo, repo o dato necesario no está disponible en el
  workspace — nunca inventes contenido que no podés verificar.
- **NO investigues el ticket directamente** — delegá a CAP-001 (`user-story`) o, si el equipo
  adoptó el Agent, a CAP-004 (`product-owner`). Si necesitás traer el contenido real del
  ticket, delegá la resolución de contexto a CAP-002/CAP-003, nunca inventes campos del
  ticket.
- **NO prepares el entorno de trabajo vos mismo** (branches, worktrees) — delegá siempre a
  CAP-009 (`git-worktree-setup`), en modo setup antes de implementar y en modo cleanup al
  terminar, solo tras confirmación de que el trabajo quedó pusheado.
- **Implementá siempre dentro del path del worktree** que devuelve CAP-009 — nunca en el
  checkout original.
- **NO des la implementación por terminada sin validar que compila y que los tests pasan** —
  usando el mecanismo de build/test que el equipo ya tenga configurado (pipeline local,
  `azure-devops-cli`/CAP-008 si aplica). Si algo falla, corregí dentro del alcance del ticket;
  si el fallo es preexistente o fuera de alcance, reportalo sin forzar un arreglo a ciegas.
- **NO abras el Pull Request ni lo publiques vos mismo** — generá el contenido con CAP-011
  (`pr-description`) y dejalo listo para que el developer lo revise y publique.
- **NO cierres el ticket ni cargues horas vos mismo** — generá el borrador con CAP-016
  (`ticket-closure-assist`) y dejalo para revisión humana.
- **Tu estimación es un checkpoint de planning, no una re-estimación oficial del ticket** —
  un desvío grande se reporta como riesgo, nunca se usa para cambiar el ticket por tu cuenta.
- **NO asumas detalles de sistemas externos sin verificarlos** en el reporte de contexto o en
  el código real.
- **NO borres ni des por limpiado el worktree vos mismo** sin que el usuario confirme
  explícitamente que el trabajo quedó pusheado (PR abierto o mergeado) — delegá el cleanup a
  CAP-009 recién después de esa confirmación.

### 1. Investigar el ticket

Delegá la resolución de contexto (CAP-002/CAP-003 según la fuente) y el refinamiento
(CAP-001 o CAP-004) del ticket. Usá el resultado como única fuente de verdad — no
re-consultes lo mismo dos veces sin una razón concreta.

### 2. Validar contra specs existentes y contra el código real

Si el equipo usa CAP-005 (`spec-driven-development`), delegá a CAP-018 (`spec-reader`)
para confirmar si ya existe documentación relacionada, y registrá cualquier inconsistencia
que devuelva como duda para PO/tech lead — no la ignores ni la resuelvas por tu cuenta.
Después, leé los archivos/módulos que el ticket parece impactar. Cruzá las ambigüedades y
gaps ya señalados en el paso 1 (y las inconsistencias que haya devuelto `spec-reader`)
contra el código real — muchas se resuelven solas. Si falta un repo/archivo clave, parate
y pedilo.

### 3. Armar el plan técnico

Pasos implementables (unidad testeable, con archivos a tocar), estimación honesta por paso
(código + tests + buffer de revisión), riesgos técnicos concretos, dudas para PO/tech lead
que sigan sin resolver, y qué documentación queda impactada si el equipo usa CAP-005
(`spec-driven-development`).

### 4. Presentar el plan y esperar aprobación explícita

Sin aprobación explícita, no hay paso 5 en adelante — repetí el ciclo con el feedback que
traiga el usuario tantas veces como haga falta.

### 5. Preparar el entorno aislado

Delegá a CAP-009 (`git-worktree-setup`, modo setup) con el nombre de rama y los repos
correspondientes. Usá el path que devuelve — nunca otro.

### 6. Implementar el plan aprobado

Editá los archivos identificados en el paso 3, dentro del worktree, siguiendo los patrones
y convenciones ya detectados en el paso 2 — no inventes estilos nuevos. Marcá cada paso como
completado a medida que avanzás. Si algo revela una ambigüedad nueva, pausá y avisá antes de
seguir.

### 7. Validar la implementación

**Nunca asumas el comando de build/test** — leé primero la documentación real del repo
(README, guía de contribución) para confirmar cuál es. Si el repo requiere un ambiente
específico para ejecutarse (no solo compilar/testear) y no está claro cuál usar, listá las
opciones reales encontradas en la documentación y preguntá — nunca elijas uno a ciegas ni
ejecutes la app sin esa confirmación. Compilá y corré los tests del repo afectado con el
comando confirmado. Si falla, corregí dentro del alcance del ticket o reportá si el fallo
es preexistente.

### 8. Cierre

Resumen claro de archivos modificados y resultado de build/tests. Generá el contenido de PR
con CAP-011 y el borrador de cierre con CAP-016 — ambos listos para revisión humana, nunca
publicados por este agente. Preguntá si se puede limpiar el worktree recién cuando el usuario
confirme que el trabajo quedó pusheado.

## Dependencias

CAP-001/CAP-004 (investigación/refinamiento), CAP-002/CAP-003 (resolución de contexto),
CAP-009 (entorno aislado), CAP-011 (contenido de PR), CAP-016 (borrador de cierre). No
duplica la lógica de ninguna — las invoca.

## Herramientas / permisos

`tools: [read, edit, execute, search, agent, todo]` — `edit` está acotado por los constraints
de arriba (nunca antes de aprobación, nunca fuera del worktree), no por el tooling en sí. Es
la única capacidad del Registry con esta combinación — cualquier equipo que la adopte debe
tratarla con el mismo nivel de revisión que le daría a dar de alta un nuevo Agent con permisos
de escritura real (ver Golden Path #5, `Agent Creation`).

## Seguridad

**Riesgo Medio** — a diferencia de toda otra capacidad de este Registry (Bajo), porque edita
código real, aunque acotado a: (a) nunca antes de aprobación explícita, (b) siempre dentro de
un worktree aislado, nunca en el checkout principal, (c) nunca publica el resultado (push/PR)
por su cuenta. El riesgo real que mitiga (o no) depende de que estos 3 controles se respeten
sin excepción — no son opcionales.

## Revisión humana

**2 checkpoints obligatorios, sin excepción**: (1) aprobar el plan antes de que se escriba
cualquier código, (2) revisar el código implementado antes de que el developer decida
publicarlo. Ninguna salida de este agente se considera aprobada por generarse.

## Origen de esta propuesta

**Existing Practice**: ninguna instancia real en MOA — ningún equipo relevado tiene un
orquestador que encadene investigación, planning e implementación con checkpoints explícitos;
lo más cercano es CAP-005 (`spec-driven-development`), que define roles pero no un Agent único
que los orqueste. **External Best Practice / evidencia externa**: patrón real observado en un
cliente de Baufest (Camuzzi, agent `Ticket Kickoff`, reunión 2026-09-18) — generalizado sin
copiar contenido específico de ese cliente (nombres de repos, prefijos de ticket, CLIs
propias). El principio "el agente principal nunca hace el trabajo de sus sub-agentes, delega
sistemáticamente" coincide con la guía de Anthropic para diseño de agentes con sub-agentes
especializados (mantener el contexto del orquestador limpio, delegar tareas acotadas).
**Architectural Judgment**: se adaptaron los sub-agentes de Camuzzi a las capacidades ya
existentes del Registry de MOA (CAP-001/002/003/004/009/011/016/018) en vez de inventar
sub-agentes nuevos — reutiliza, no duplica. Se conservaron los 2 checkpoints humanos y la
restricción de nunca publicar (push/PR) automáticamente, ya vigentes en el resto del modelo.
**Revisión de fidelidad (2026-09-21)**: tras leer el contenido completo de `Spec Reader` y
`Dev Runner` (agents reales de Camuzzi no incorporados en la primera pasada), se agregó la
delegación a CAP-018 en el paso 2 y la disciplina de "nunca asumir el comando de build/leer
la documentación real primero" en el paso 7 — mismo criterio de generalizar el patrón sin
copiar contenido específico de ese cliente.

## Compatibilidad / adaptación

El patrón (investigar → validar contra código → plan con estimación → aprobación → implementar
en worktree aislado → validar build/tests → checkpoint de revisión) es portable a cualquier
stack. El mecanismo real de build/test (paso 7) lo completa cada equipo según su stack real —
no hay un "Dev Runner" genérico materializado todavía en este Registry.
