# AI Governance

> El modelo de riesgo proporcional (no binario) y el gobierno específico de MCP —incluido
> el hallazgo real de `com.atlassian/atlassian-mcp-server` y del `mcp.json` de
> DataAgro— están en
> [`../security/security-governance.md`](../security/security-governance.md).
> Este documento conserva su contenido (niveles de gobierno, human-in-the-loop, patrones
> observados) como base — no se duplica, se referencia.

## Niveles de gobierno (PROPOSAL)

| Nivel | Contenido | Dónde vive |
|---|---|---|
| **CORPORATE** | Principios, seguridad, responsible AI, protección de datos, gobierno, métricas, human-in-the-loop | Este repositorio (`strategy/`, `governance/`, `metrics/`) |
| **REUSABLE** | Skills, agents, prompts, instructions, patrones MCP, templates, patrones de arquitectura | Este repositorio, una vez promovidos desde un equipo |
| **TEAM SPECIFIC** | Adaptaciones, casos de uso y flujos de cada equipo | Repos de cada equipo real de MOA (DataAgro, Scato Logística, MOA Operaciones, Scato Puerto, Orquestador — ver `teams/README.md`). `moa-sdlc`/`moa-metrics` son herramientas de referencia de Baufest para la iniciativa, no repos de un equipo de MOA. |

## Human-in-the-loop obligatorio (FACT — encuadre fundacional de la iniciativa + KO Interno pág. 14, 21)

Debe existir validación humana explícita cuando las acciones de IA puedan afectar:
código crítico, infraestructura, seguridad, datos, producción o decisiones relevantes.

KO Interno (pág. 14) lo formaliza como uno de los 4 pilares del Track 1: *"Mantener
enfoque human-in-the-loop — validación y corrección humana estricta antes de integrar
cualquier salida."* El KO también lo detalla como paso 3 de su enfoque de 5 pasos (pág.
21): *"Implementar un filtro humano estricto (Human-in-the-loop) que valide y corrija el
código propuesto antes de su integración."*

## Patrones de gobierno observados (FACT — evidencia múltiple, ver `governance/agent-governance.md`)

Se encontraron matrices de autonomía reales en `moa-sdlc` (herramienta de referencia de
Baufest, no un equipo de MOA), y en **DataAgro** y **Scato Logística** (equipos reales de
MOA, validado por lectura directa el 2026-09-04). Ninguna de las tres es "el" patrón de
referencia — se documentan en paralelo en
[`governance/agent-governance.md`](agent-governance.md), como candidatas a evaluar antes
de proponerse como REUSABLE. El formato de 3 niveles (ALWAYS/ASK FIRST/NEVER) sí es una
definición propia del Common Core, independiente de cualquier repo puntual.

Ver plantilla generalizada en [`../templates/agent-template.md`](../templates/agent-template.md).

## Seguridad (FACT — encuadre fundacional de la iniciativa)

Todo diseño de capacidad de IA debe considerar: least privilege, protección de datos,
gestión de secretos, control de acceso, auditabilidad, prompt injection, data leakage,
excessive agency, acciones no autorizadas, model risk, aprobación humana, logging y
trazabilidad.

## Responsible AI — estado (REQUIRES VALIDATION)

El KO Interno no detalla una política formal de Responsible AI (sesgo, transparencia,
explicabilidad) más allá de human-in-the-loop y seguridad. Este documento queda como
placeholder hasta que MOA defina lineamientos propios o adopte un marco corporativo
existente (ej. de Baufest o de un estándar de la industria).

## Protección de datos — estado (REQUIRES VALIDATION)

No hay evidencia en el KO de una clasificación de datos ni de reglas específicas de qué
datos pueden enviarse a modelos de IA (ej. datos de SAP, datos de clientes). Se marca como
brecha crítica a resolver antes de habilitar MCPs con acceso a bases de datos (ver
`integrations/catalog.md`, fila "Base de datos").
