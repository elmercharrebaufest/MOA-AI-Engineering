# Agent Governance

> Este documento es la base de gobierno de agentes; el modelo de riesgo proporcional que
> condiciona *cuándo* un agente puede escalar autonomía está en
> [`../security/security-governance.md`](../security/security-governance.md).
> El patrón de agente de solo-lectura (`tools` sin `edit`, scope acotado al diff),
> materializado como capacidad reusable en
> [`../capabilities/agents/read-only-code-reviewer/`](../capabilities/agents/read-only-code-reviewer/AGENT.md),
> está documentado como candidato en
> [`../architecture/assessment-gate.md`](../architecture/assessment-gate.md).

## Modelo de pipeline para agentes (FACT — principios fundacionales de la iniciativa)

Todo agente debe poder describirse mediante este pipeline; si no se puede completar
alguno de estos pasos, el agente no debe implementarse todavía:

```text
TRIGGER → CONTEXT → DECISION → ACTION → VALIDATION → AUDIT
```

| Paso | Pregunta que debe responder el diseño del agente |
|---|---|
| TRIGGER | ¿Qué evento dispara al agente? (ej. push, apertura de ticket, alerta de monitoreo) |
| CONTEXT | ¿Qué información y con qué scope se le entrega? (MCP, skills, documentos) |
| DECISION | ¿Qué modelo/lógica decide la acción a tomar? |
| ACTION | ¿Qué acción concreta ejecuta? (crear PR, comentar, sugerir código) |
| VALIDATION | ¿Quién y cómo valida la salida antes de que tenga efecto? (human-in-the-loop) |
| AUDIT | ¿Qué se registra para trazabilidad y revisión posterior? |

## Principio rector (FACT — principios fundacionales de la iniciativa)

> "No crear agentes sólo porque técnicamente sea posible. Cada agente debe resolver un
> problema real."

## Matriz de autonomía — formato exigido por el Common Core (PROPOSAL)

El **formato** de 3 niveles (ALWAYS / ASK FIRST / NEVER) es una definición propia del
Common Core, no derivada de ningún repo puntual — cualquier equipo que implemente un
agente debe declarar su propia matriz en este formato, con contenido propio de su stack
y nivel de riesgo. **No existe una única matriz "de referencia" que otros deban copiar.**

Evidencia real encontrada, a modo de ejemplos paralelos (ninguno es "el patrón",
todos son candidatos a evaluar por igual — ver `assessment/relevamiento-capacidades.md`):

- **DataAgro** (`AGENTS.md`, equipo real de MOA): ALWAYS = generar tests, formatear con
  linter; ASK FIRST = instalar dependencias, migraciones EF, cambiar contratos de API,
  modificar tests; NEVER = commitear memoria de sesión local, marcar tareas sin test en
  verde, marcar requisito manual sin sign-off, desactivar seguridad/CORS/JWT.
- **Scato Logística** (`AGENTS.md`, equipo real de MOA): matriz propia integrada con sus
  agentes/skills por rol y sus instructions por capa (ver `assessment/relevamiento-capacidades.md`).
- **`moa-sdlc`** (herramienta de referencia de Baufest, **no un equipo de MOA**): ALWAYS =
  generar tests, actualizar trazabilidad, crear branches desde ticket real; ASK FIRST =
  instalar dependencias, migraciones, cambiar contratos de API; NEVER = `git push`/PR
  autónomo, deploy autónomo, desactivar validaciones de seguridad, exponer secretos.

**[REQUIRES VALIDATION]** Ninguna de estas 3 matrices se adopta como estándar sin pasar
por el pipeline de assessment. Cada equipo debe construir la propia, informada por estos
ejemplos pero no copiándolos literalmente.

## Roles de agente — patrones observados (FACT, evidencia múltiple, ninguna es "la referencia")

Se encontraron patrones de roles de agente en tres repos, con distinto origen y nivel de
integración — se documentan en paralelo, no en orden de preferencia:

- **`moa-sdlc`** (herramienta de referencia de Baufest, **no un equipo de MOA)**: harness
  de 6 roles con feedback loop (`AGENTS-HARNESS.md`, `AGENTS-CONTRACTS.md` — contrato JSON
  explícito, el más formal en cuanto a especificación):
  ```text
  spec-author → implementer → tester → reviewer → security-reviewer → human-approver
        ↑                                                       ↓
        └───────────────────── feedback loop / fix cycle ─────┘
  ```
- **DataAgro** (equipo real de MOA): 6 agentes por rol (`architect`, `dba-migraciones`,
  `kendo-grid-builder`, `product-owner`, `qa-tester`, `release-manager`), sin pipeline de
  feedback loop formalizado entre ellos.
- **Scato Logística** (equipo real de MOA): 13 agentes por rol (incluye especialistas de
  dominio como `afip-integration`, `wf-activity-refactor`, `xamlx-documenter`), con
  AGENTS.md que cruza referencias reales a cuándo invocar cada uno — el más integrado de
  los tres.

Ningún patrón está promovido a REUSABLE. Todos son candidatos a evaluar (ver
`assessment/relevamiento-capacidades.md` para el detalle completo con evidencia real y
niveles VERIFIED/REQUIRES VALIDATION por artefacto).

## Qué falta para declarar un agente "gobernado" (checklist)

- [ ] TRIGGER, CONTEXT, DECISION, ACTION, VALIDATION y AUDIT documentados.
- [ ] Matriz ALWAYS/ASK FIRST/NEVER específica del equipo/stack.
- [ ] Punto de validación humana explícito y no evitable para acciones de alto riesgo.
- [ ] Mecanismo de auditoría/logging identificado (no necesariamente implementado aún).
- [ ] Justificación del problema real que resuelve (no "porque es posible").
