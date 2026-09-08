# Template: Agent

> Completar únicamente si el caso de uso requiere un ciclo de decisión/acción, no una
> simple asistencia puntual (para eso, usar `skill-template.md`).

## Nombre del agente

## Problema real que resuelve

> Obligatorio justificar por qué NO alcanza con una skill o con Copilot asistiendo
> directamente. "No crear agentes sólo porque técnicamente sea posible."

## Pipeline (obligatorio completar los 6 pasos)

| Paso | Descripción |
|---|---|
| TRIGGER | |
| CONTEXT | |
| DECISION | |
| ACTION | |
| VALIDATION | |
| AUDIT | |

## Matriz de autonomía

(Ver formato exigido y ejemplos paralelos —DataAgro, Scato Logística, `moa-sdlc`— en `governance/agent-governance.md`; ninguno de esos ejemplos es el patrón obligatorio, cada equipo declara su propia matriz)

| Nivel | Acciones |
|---|---|
| ALWAYS | |
| ASK FIRST | |
| NEVER | |

## Rol(es) involucrados

(Ej. spec-author, implementer, tester, reviewer, security-reviewer, human-approver — o
roles propios del equipo)

## MCP / integraciones necesarias

(Ver `integrations/catalog.md` — declarar auth, scope y auditoría requeridos)

## Riesgos y mitigaciones

(seguridad, prompt injection, data leakage, excessive agency, model risk)

## Nivel de gobierno

- [ ] TEAM SPECIFIC
- [ ] REUSABLE (requiere generalización y validación en más de un equipo)

## Evidencia / origen
