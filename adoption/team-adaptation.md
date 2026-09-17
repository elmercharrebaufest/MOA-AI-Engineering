# Team Adaptation — qué se puede cambiar, qué no

**Estado: PROPOSAL.** Esta clasificación no está ratificada por un comité de gobierno
(depende de `../governance/BLOCKED-DECISIONS.md` #1) — es la mejor guía disponible
hoy, basada en cómo ya se comportan los equipos reales con evidencia (DataAgro, Scato
Logística, Orquestador). No es una regla rígida — si un caso no encaja claramente,
corresponde marcarlo `REQUIRES VALIDATION` y avanzar con la parte que sí es clara.

## Lo que no debería cambiarse sin pasar por el Common Core

| Elemento | Por qué |
|---|---|
| **Governance** — pipeline TRIGGER→CONTEXT→DECISION→ACTION→VALIDATION→AUDIT, matriz ALWAYS/ASK FIRST/NEVER como formato | Es el control mínimo de cualquier Agent, transversal a todo MOA (`../governance/agent-governance.md`) |
| **Evidence Contract, Evaluation Contract, Measurement Result Contract** (schema, no contenido) | Si cada equipo usa un formato distinto, nada es comparable ni auditable (`../architecture/evidence-evaluation-measurement.md`) |
| **Taxonomía de Metrics** (las 7 categorías de `../metrics/framework.md`) | Mismo motivo — "common measurement model" |
| **Security baseline** — modelo de riesgo proporcional, reglas de MCP | `../security/security-governance.md` |
| **Lifecycle** (los estados: Use Case→...→Promote, Adopt/Adapt/Improve, Deprecate/Retire) | Es cómo se lee el estado de cualquier capacidad en el Registry — cambiar los nombres rompe la comparabilidad |
| **Registry metadata** (los 27+ campos, no los valores) | Mismo motivo |

## Lo que sí puede adaptarse libremente

| Elemento | Ejemplo real ya evidenciado |
|---|---|
| **Domain instructions** | Las 8 instructions de Orquestador (`applyTo` por capa de su propia arquitectura de dispositivos) |
| **Domain Skills** | El contenido de `azure-devops-cli`/`user-story` — mismo formato, contenido 100% distinto por dominio (`../architecture/assessment-gate.md`) |
| **Project Agents** | `.NET Code Reviewer` de Orquestador — reglas específicas de .NET Framework 4.7.2 |
| **Tools/integrations propias** | Qué conectores/MCP usa cada equipo (siempre pasando por el modelo de riesgo de `security-governance.md`) |
| **Workflows particulares** | `_sdd/` de DataAgro es una elección de ese equipo, no obligatoria para otros |
| **Knowledge de dominio** | Glosarios, convenciones de negocio propias |
| **Prácticas específicas del stack** | .NET Framework 4.5.2 vs. 4.7.2 vs. .NET 8 requieren reglas distintas — ya visto en la comparación real de `dotnet-best-practices` entre repos |

## Regla de una línea

Si se está cambiando el formato o contrato (cómo se registra algo), corresponde
consultar primero. Si se está cambiando el contenido del propio dominio (qué dice una
Skill, Instruction o Agent), no hace falta consultar — es autonomía de cada equipo, ya
reconocida en `../architecture/operating-model.md`.
