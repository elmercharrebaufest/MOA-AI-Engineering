# CAP-020 — dotnet-modernization-guide

**Nota de clasificación**: no construye ninguna herramienta propia — guía de uso de un
agente oficial de Microsoft (Copilot upgrade), con las restricciones reales de MOA ya
incorporadas.

| Campo | Valor | Evidencia / clasificación |
|---|---|---|
| **ID** | CAP-020 | — |
| **Name** | dotnet-modernization-guide | FACT |
| **Type** | Skill | FACT |
| **Purpose** | Guiar el uso del agente oficial de modernización de GitHub Copilot para .NET, con las restricciones reales de MOA (excluir WF4.5 del alcance automático) | FACT |
| **Owner** | REQUIRES VALIDATION | `governance/BLOCKED-DECISIONS.md` #1 |
| **Maintainer** | REQUIRES VALIDATION | Ídem |
| **Origin** | Existing Practice de MOA (4 de 6 equipos ya modernizando por su cuenta, ver `teams/README.md`) + External Best Practice (agente oficial de Microsoft, documentación real citada) | FACT (evidencia origen) / PROPOSAL (la guía en sí) |
| **Originator** | No aplica — guía derivada, no autoría de equipo | — |
| **Team** | Aplicable a DataAgro, MOA Operaciones, Orquestador, Scato Logística, Scato Puerto (todos con legacy .NET Framework real confirmado) | FACT |
| **Domain** | Transversal a cualquier proyecto .NET Framework real de MOA | FACT |
| **Repository** | No aplica | — |
| **Branch** | No aplica | — |
| **Integration Status** | No integrado a ningún repo de equipo todavía | FACT |
| **Configuration Status** | VERIFIED — contenido completo escrito y revisado en esta sesión | FACT |
| **Real Use Status** | CONFIGURED — mecanismo documentado, cero ejecuciones reales | FACT |
| **Lifecycle State** | Proposal | Sin ejecución real todavía |
| **Corporate Standard** | N | Sin evidencia de uso real |
| **Version** | Sin versionado semántico | — |
| **Risk** | Bajo | No ejecuta ninguna modernización por sí misma — guía el uso de una herramienta externa ya gobernada por Microsoft, con revisión humana obligatoria en cada checkpoint |
| **Data** | No aplica directamente | — |
| **Data Classification** | REQUIRES VALIDATION | `BLOCKED-DECISIONS.md` #3 |
| **Tools** | Ninguna propia — referencia el agente oficial de GitHub Copilot | FACT |
| **Model** | No aplica | — |
| **Autonomy** | No aplica directo (Skill) | — |
| **HITL** | Obligatoria en cada checkpoint del flujo oficial (assessment/plan/tasks) — ya definido por Microsoft, esta guía no lo relaja | FACT |
| **Evaluation** | NOT FOUND | — |
| **Observability** | NOT FOUND | — |
| **Metrics** | NOT FOUND | — |
| **Adopters** | Ninguno | — |
| **Last Review** | 2026-09-22 | — |
| **Evidence Reference** | Ninguna todavía | — |
| **Evaluation Reference** | Ninguna todavía | — |
| **Metric Reference** | Ninguna todavía | — |
| **Reusable Asset** | [`capabilities/skills/dotnet-modernization-guide/SKILL.md`](../../capabilities/skills/dotnet-modernization-guide/SKILL.md) | — |
| **Action Type** | READ — guía, no ejecuta ninguna modernización por sí misma | Mismo principio del resto del Registry |
| **Context Requirements** | Ninguno propio — usa el flujo del agente oficial de Copilot | — |

## Nota de selección

Cubre la etapa "Desarrollo del código" del KO desde un ángulo nuevo: no generar código
nuevo, sino modernizar el existente — con evidencia real de que 4 de 6 equipos de MOA ya
lo necesitan y ya empezaron por su cuenta (`teams/README.md`). Decisión deliberada de no
construir una herramienta propia cuando ya existe una oficial y vigente — la disciplina de
token-optimización y de "no inventar lo que ya existe" (`capabilities/best-practices.md`)
aplicada directamente.
