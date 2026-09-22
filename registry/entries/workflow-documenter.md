# CAP-019 — workflow-documenter

**Nota de clasificación**: capacidad **opt-in, no transversal** — a diferencia de la
mayoría del Registry, no aplica a todo equipo de MOA, solo a proyectos reales con Windows
Workflow Foundation 4.5. Ver [[moa_capability_design_principles]] (principio 1: no todo lo
que un proyecto tiene se generaliza igual al resto).

| Campo | Valor | Evidencia / clasificación |
|---|---|---|
| **ID** | CAP-019 | — |
| **Name** | workflow-documenter | FACT |
| **Type** | Agent | FACT |
| **Purpose** | Documentar workflows WF4.5 (`.xamlx`) en Markdown legible + diagrama, detectar problemas estructurales, y ayudar a diagnosticar workflows `Faulted` | FACT |
| **Owner** | REQUIRES VALIDATION | `governance/BLOCKED-DECISIONS.md` #1 |
| **Maintainer** | REQUIRES VALIDATION | Ídem |
| **Origin** | Generalización de 2 agents reales de Scato Logística (`xamlx-documenter`, `workflow-designer`) — evidencia interna de MOA, con ejecución real verificada (12 documentos generados contra `.xamlx` reales) | FACT (evidencia origen) / PROPOSAL (el patrón generalizado) |
| **Originator** | Scato Logística | FACT |
| **Team** | Scato Logística (origen); aplicable también a Scato Puerto (mismo patrón `Workflow`/`WfEditor` confirmado en el stack real, ver `teams/README.md`) | FACT |
| **Domain** | Acotado — solo proyectos con WF4.5 real, no transversal | FACT |
| **Repository** | `Scato Logistica/Scato%20Logistica` (origen) | FACT |
| **Branch** | Rama principal del repo de origen | FACT |
| **Integration Status** | No integrado como capacidad generalizada todavía — la instancia original sí está integrada y en uso en su repo de origen | FACT |
| **Configuration Status** | VERIFIED — contenido completo escrito y revisado en esta sesión | FACT |
| **Real Use Status** | **CONFIGURED** — mecanismo documentado, generalizado desde una instancia con ejecución real, sin ejecución propia de esta versión generalizada todavía | FACT |
| **Lifecycle State** | Proposal | Sin ejecución real de la versión generalizada |
| **Corporate Standard** | N | Sin evidencia de uso real de la versión generalizada |
| **Version** | Sin versionado semántico | — |
| **Risk** | Bajo | Sin `edit`; `execute` acotado a correr el parser sobre archivos existentes, nunca modificar el `.xamlx` original |
| **Data** | No toca datos de negocio — opera sobre la estructura del workflow, no sobre datos en tránsito | INFERENCE |
| **Data Classification** | REQUIRES VALIDATION | Política no existe (`BLOCKED-DECISIONS.md` #3) |
| **Tools** | `[read, execute, search, todo]` — sin `edit` | FACT |
| **Model** | No declarado | FACT |
| **Autonomy** | Sin `edit`; la descripción de negocio de cada workflow queda explícitamente pendiente si no hay evidencia suficiente, nunca se completa con contenido inventado | FACT |
| **HITL** | Obligatoria para la descripción de negocio de cada workflow documentado | FACT |
| **Evaluation** | NOT FOUND | — |
| **Observability** | NOT FOUND | — |
| **Metrics** | NOT FOUND | — |
| **Adopters** | Ninguno de la versión generalizada — la instancia original tiene 1 adopter real (Scato Logística) | FACT |
| **Last Review** | 2026-09-22 | — |
| **Evidence Reference** | Ninguna todavía de la versión generalizada | — |
| **Evaluation Reference** | Ninguna todavía | — |
| **Metric Reference** | Ninguna todavía | — |
| **Reusable Asset** | [`capabilities/agents/workflow-documenter/AGENT.md`](../../capabilities/agents/workflow-documenter/AGENT.md) | Generalización sin glosario de negocio ni rutas/namespaces reales del equipo de origen |
| **Action Type** | READ — genera documentación nueva, nunca modifica el workflow original | Mismo principio que el resto del Registry |
| **Context Requirements** | Un archivo `.xamlx` real, o el error real de un workflow `Faulted` | No requiere ninguna integración externa |

## Nota de selección

No cubre una etapa nueva del KO — refuerza "Desarrollo del código" (documentación/
mantenibilidad de un tipo de artefacto legacy real) y complementa a CAP-017 (mismo
principio de diagnóstico basado en evidencia, aplicado a un caso más específico:
workflows `Faulted`). Se incluye en el Registry, no como capacidad transversal, sino como
ejemplo documentado de cómo este modelo adopta una práctica real y valiosa de un equipo
sin forzarla al resto — ver [[moa_capability_design_principles]].
