# Arquitectura de referencia (fase Foundation — G1)

> **Superseded por G3.3.** El modelo de arquitectura vigente es
> [`../docs/architecture/reference-architecture.md`](../docs/architecture/reference-architecture.md)
> (5 capas: Team / Team Adaptation / Assessment Gate / Common Core / AI Engineering
> Foundation), que reemplaza el modelo de 3 capas de esta página. Este archivo se
> conserva por su contenido FACT todavía válido (stack actual del KO, tabla de
> integraciones a incorporar) — no se duplica en el nuevo documento, se referencia desde
> ahí.

## Modelo de 3 capas de gobierno (histórico — ver nota arriba)

```
┌─────────────────────────────────────────────────────────┐
│ CORPORATE (este repositorio)                             │
│ principios · seguridad · responsible AI · data protection│
│ gobierno · métricas · human-in-the-loop                  │
└─────────────────────────────────────────────────────────┘
                          │ habilita, no reemplaza
                          ▼
┌─────────────────────────────────────────────────────────┐
│ REUSABLE (promovido desde equipos, catalogado aquí)       │
│ skills · agents · prompts · instructions · MCP patterns   │
│ templates · architecture patterns                        │
└─────────────────────────────────────────────────────────┘
                          │ cada equipo adapta
                          ▼
┌─────────────────────────────────────────────────────────┐
│ TEAM SPECIFIC (vive en el repo de cada equipo real de MOA)│
│ DataAgro · Scato Logística · MOA Operaciones ·             │
│ Scato Puerto · Orquestador · [otros equipos — a incorporar]│
│                                                             │
│ (moa-sdlc / moa-metrics: herramientas de referencia de     │
│  Baufest para la iniciativa, no repos de un equipo de MOA) │
└─────────────────────────────────────────────────────────┘
```

Una capacidad creada por un equipo (capa TEAM SPECIFIC) es únicamente una **candidata**
a REUSABLE. No se promueve por existir, ni por parecer útil, ni por estar bien
documentada — debe primero demostrar valor, calidad, seguridad, reutilización y
resultados a través del pipeline de assessment (ver
[`../assessment/README.md`](../assessment/README.md)): problema/proceso → caso de uso →
valor esperado + riesgo → assessment → selección de la capacidad adecuada → evaluación →
piloto → medición → gobierno → validación → recién ahí reutilización/escalamiento.

## Stack actual (FACT — KO Interno, pág. 10 y 15)

| Categoría | Herramientas |
|---|---|
| Repos de código | Azure DevOps |
| Base de datos | SQL Server |
| Requerimientos | Jira |
| Documentación | SharePoint (MOA) + Confluence (Baufest) |
| Coding | Visual Studio + VS Code con GitHub Copilot |
| Testing | NUnit (unitarios), Cypress (arrancando), JMeter (parcial), Playwright (pruebas) |
| Asistencia IA | GitHub Copilot, Copilot Code Review, Rovo |
| Automatización | Skills / instructions, agentes, integración Azure DevOps, tablero de métricas |

## Stack a incorporar (PROPOSAL — KO Interno, pág. 16, "a revisar como parte de innovación")

| Componente | Propósito |
|---|---|
| Servidores MCP | Acceso controlado a Jira, Confluence, Azure DevOps, SQL Server |
| Tablero Power BI | Visualizar métricas de adopción y productividad de IA |
| Application Insights | Centralizar logs de aplicación para alimentar agentes de soporte |
| SonarQube | Calidad de código bajo control + métricas relacionadas |

## Implementaciones existentes que validan este modelo (FACT)

- **`moa-sdlc`**: implementa la capa TEAM SPECIFIC para desarrollo .NET, con un patrón de
  gobierno de agentes (`AGENTS.md`) y SDD (`_sdd/specs/`). **Candidata a evaluar** (no
  candidata confirmada a promoción) — ver `assessment/relevamiento-capacidades.md` y
  `governance/agent-governance.md`.
- **`moa-metrics`**: implementa el conector real hacia GitHub Copilot API, Azure DevOps
  Repos API, Jira API y SonarQube API, con un pipeline ETL y cálculo de 8 de los 8
  indicadores propuestos en el KO. Es la base técnica real de `metrics/framework.md`.
- **`DataAgro/DataAgro`** y **`Scato Logística`** (repos de equipos reales, fuera de este
  workspace de Baufest): tienen patrones de gobierno de agentes (`AGENTS.md`, agentes por
  rol, skills) más maduros y formalizados que los de `moa-sdlc`. Son la evidencia más
  fuerte de capa TEAM SPECIFIC real en producción — igualmente **candidatos a evaluar**,
  no candidatos confirmados a REUSABLE. Ver `assessment/relevamiento-capacidades.md`.

## Qué NO está incluido aún (PROPOSAL — decisión de alcance)

- Diagramas formales (`architecture/diagrams/`) — se agregarán cuando haya al menos un
  flujo de agente real desplegado para diagramar, evitando diagramas especulativos.
- Catálogo de servidores MCP concretos — no se documentará ningún MCP server como
  "existente" sin verificarlo (ver `integrations/catalog.md`).
