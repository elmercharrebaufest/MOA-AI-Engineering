# CAP-015 — regression-test-generation

**Nota de clasificación**: propuesta directa con evidencia externa (Camuzzi/Baufest) — mismo
tratamiento que el resto de las propuestas nuevas del Registry. Queda `PROPOSAL` hasta que
un equipo real de MOA lo pilotee. **Cubre solo generación de código de test, no su
ejecución automática en pipeline** — ver `Purpose`.

| Campo | Valor | Evidencia / clasificación |
|---|---|---|
| **ID** | CAP-015 | — |
| **Name** | regression-test-generation | FACT (existe el archivo) |
| **Type** | Skill | FACT |
| **Purpose** | Clasificar si un caso de prueba conviene automatizar (fórmula de ROI) y generar el código del test si conviene — sin ejecutarlo en un pipeline real | FACT |
| **Owner** | REQUIRES VALIDATION | `governance/BLOCKED-DECISIONS.md` #1 |
| **Maintainer** | REQUIRES VALIDATION | Ídem |
| **Origin** | No hay instancia real de ningún equipo de MOA. Evidencia externa: skills reales de Camuzzi/Baufest (`testrail-desde-jira` + `playwright-desde-testrail`, reunión 2026-09-18) — se adoptó la fórmula de ROI y el patrón de generación, no el mecanismo TestRail/Playwright específico de ese cliente | FACT (evidencia externa) |
| **Originator** | No aplica a la instancia de MOA | — |
| **Team** | Ninguno todavía | FACT |
| **Domain** | Transversal — la fórmula de ROI y el patrón de generación son independientes del stack | FACT |
| **Repository** | No aplica | — |
| **Branch** | No aplica | — |
| **Integration Status** | No integrada a ningún repo de equipo todavía | FACT |
| **Configuration Status** | VERIFIED — contenido completo escrito y revisado en esta sesión | FACT |
| **Real Use Status** | **CONFIGURED** — mecanismo documentado, cero ejecuciones reales | FACT |
| **Lifecycle State** | Proposal | Sin ejecución real todavía |
| **Corporate Standard** | N | Sin evidencia de uso real |
| **Version** | Sin versionado semántico | — |
| **Risk** | Bajo | Genera código de test, no lo despliega ni ejecuta contra ambiente productivo; no accede a ningún MCP de automatización ni pipeline de CI/CD |
| **Data** | No toca datos de producción | INFERENCE |
| **Data Classification** | REQUIRES VALIDATION | `BLOCKED-DECISIONS.md` #3 |
| **Tools** | Lectura de estructura del repo; ejecución opcional del test generado para verificarlo, si el entorno lo permite | FACT |
| **Model** | No declarado | FACT |
| **Autonomy** | Explícito: nunca genera código sin mostrar el plan primero; máximo 3 reintentos ante fallo antes de escalar | FACT |
| **HITL** | Obligatoria: revisión humana del código generado antes de agregarlo al repo, y ejecución real al menos una vez antes de confiar en el resultado | FACT (declarado en `SKILL.md`) |
| **Evaluation** | NOT FOUND | — |
| **Observability** | NOT FOUND | — |
| **Metrics** | NOT FOUND | — |
| **Adopters** | Ninguno | — |
| **Last Review** | 2026-09-21 | — |
| **Evidence Reference** | Ninguna todavía | — |
| **Evaluation Reference** | Ninguna todavía | — |
| **Metric Reference** | Ninguna todavía | — |
| **Reusable Asset** | [`capabilities/skills/regression-test-generation/SKILL.md`](../../capabilities/skills/regression-test-generation/SKILL.md) | — |
| **Action Type** | READ + generación de código local (nunca ejecuta en pipeline ni accede a MCP de automatización) | Deliberadamente acotado — ver "Alcance" en `SKILL.md` |
| **Context Requirements** | Caso de prueba de CAP-014 + estructura real de automatización del repo (si existe) | Reutiliza CAP-014, no define un formato de caso de prueba propio |

## Nota de selección

Cierra la parte de la etapa "Test de regresión" del KO que puede justificarse hoy sin
evidencia de MCP Playwright (generar el código) — deja explícitamente fuera de alcance la
parte que sí requeriría esa integración (ejecución automática en pipeline), evitando
inventar gobierno de MCP que no existe (`assessment/README.md`, regla dura).
