# CAP-010 — test-case-generation

**Nota de clasificación**: misma categoría que CAP-009 — propuesta directa, no
generalización de una instancia real. Ver esa entrada para el criterio completo. Queda
`PROPOSAL` hasta que un equipo real la pilotee.

| Campo | Valor | Evidencia / clasificación |
|---|---|---|
| **ID** | CAP-010 | — |
| **Name** | test-case-generation | FACT (existe el archivo) |
| **Type** | Skill | FACT |
| **Purpose** | Derivar casos de prueba funcionales a partir de los criterios de aceptación de una historia de usuario (CAP-002) | FACT |
| **Owner** | REQUIRES VALIDATION | `governance/BLOCKED-DECISIONS.md` #1 |
| **Maintainer** | REQUIRES VALIDATION | Ídem |
| **Origin** | No aplica — no hay instancia real de ningún equipo. KO Interno pág. 25 (*"Copilot + Skills + MCP Jira/Confluence propone casos de prueba automáticamente en el ticket"*) | FACT (cita del KO) |
| **Originator** | No aplica | — |
| **Team** | Ninguno todavía | — |
| **Domain** | Transversal — sin contenido específico de dominio que adaptar | FACT |
| **Repository** | No aplica | — |
| **Branch** | No aplica | — |
| **Integration Status** | No integrada a ningún repo de equipo todavía | FACT |
| **Configuration Status** | VERIFIED — contenido completo escrito y revisado en esta sesión | FACT |
| **Real Use Status** | **CONFIGURED** — mecanismo documentado, cero ejecuciones reales, sin evidencia de equipo real todavía | FACT |
| **Lifecycle State** | Proposal | Sin ejecución real todavía |
| **Corporate Standard** | N | Sin evidencia de uso real |
| **Version** | Sin versionado semántico | — |
| **Risk** | Bajo | No ejecuta tests ni publica en Jira/Azure DevOps por sí misma; produce texto estructurado |
| **Data** | No toca datos sensibles directamente | INFERENCE |
| **Data Classification** | REQUIRES VALIDATION | Política no existe (`BLOCKED-DECISIONS.md` #3) |
| **Tools** | Ninguna declarada — contenido de referencia | FACT |
| **Model** | No declarado | FACT |
| **Autonomy** | No aplica directo (Skill) | — |
| **HITL** | Obligatoria: QA debe validar los casos generados antes de considerarlos parte de la cobertura oficial | FACT (declarado en `SKILL.md`) |
| **Evaluation** | NOT FOUND | — |
| **Observability** | NOT FOUND | — |
| **Metrics** | NOT FOUND | — |
| **Adopters** | Ninguno | — |
| **Last Review** | 2026-09-18 | — |
| **Evidence Reference** | Ninguna todavía | — |
| **Evaluation Reference** | Ninguna todavía | — |
| **Metric Reference** | Ninguna todavía | — |
| **Reusable Asset** | [`capabilities/skills/test-case-generation/SKILL.md`](../../capabilities/skills/test-case-generation/SKILL.md) | — |
| **Action Type** | READ (no ejecuta tests ni publica el comentario por sí misma) | Mismo principio que CAP-002/007/008/009 |
| **Context Requirements** | Criterios de aceptación de CAP-002 + opcionalmente Resolved Context (CAP-007/CAP-008) | Reutiliza mecanismos ya existentes |

## Nota de selección

Cubre la etapa "Testing funcional (QA)" del KO — la brecha que la propia
`architecture/ai-sdlc.md` señala como la más crítica frente al hallazgo de DORA sobre
desequilibrio entre desarrollo y testing acelerados de forma desigual. **La etapa "Test de
regresión" queda deliberadamente fuera de esta propuesta** — depende de un mecanismo de
ejecución automática (MCP Playwright) sin evidencia real en ningún repo de MOA; proponer
esa integración sin evidencia ni piloto violaría la regla dura del assessment
(`assessment/README.md`). Esa etapa permanece `REQUIRES VALIDATION`, con la validación de
un caso de uso real de MCP Playwright como su próximo paso, no como capacidad a construir
ahora.
