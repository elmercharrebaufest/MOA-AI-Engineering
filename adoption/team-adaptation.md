# Team Adaptation — qué podés cambiar, qué no

**Estado: PROPOSAL.** Esta clasificación no está ratificada por un comité de gobierno
(depende de `../governance/BLOCKED-DECISIONS.md` #1) — es la mejor guía disponible
hoy, basada en cómo ya se comportan los equipos reales con evidencia (DataAgro, Scato
Logística, Orquestador). No es una regla rígida — si tu caso no encaja claramente, marcalo
`REQUIRES VALIDATION` y seguí adelante con la parte que sí es clara.

## Lo que NO deberías cambiar sin pasar por el Common Core

| Elemento | Por qué |
|---|---|
| **Governance** — pipeline TRIGGER→CONTEXT→DECISION→ACTION→VALIDATION→AUDIT, matriz ALWAYS/ASK FIRST/NEVER como formato | Es el control mínimo de cualquier Agent, transversal a todo MOA (`../governance/agent-governance.md`) |
| **Evidence Contract, Evaluation Contract, Measurement Result Contract** (schema, no contenido) | Si cada equipo usa un formato distinto, nada es comparable ni auditable (`../architecture/evidence-evaluation-measurement.md`) |
| **Taxonomía de Metrics** (las 7 categorías de `../metrics/framework.md`) | Mismo motivo — "common measurement model" |
| **Security baseline** — modelo de riesgo proporcional, reglas de MCP | `../security/security-governance.md` |
| **Lifecycle** (los estados: Use Case→...→Promote, Adopt/Adapt/Improve, Deprecate/Retire) | Es cómo se lee el estado de cualquier capacidad en el Registry — cambiar los nombres rompe la comparabilidad |
| **Registry metadata** (los 27+ campos, no los valores) | Mismo motivo |

## Lo que SÍ podés adaptar libremente

| Elemento | Ejemplo real ya evidenciado |
|---|---|
| **Domain instructions** | Las 8 instructions de Orquestador (`applyTo` por capa de su propia arquitectura de dispositivos) |
| **Domain Skills** | El contenido de `azure-devops-cli`/`user-story` — mismo formato, contenido 100% distinto por dominio (`../architecture/assessment-gate.md`) |
| **Project Agents** | `.NET Code Reviewer` de Orquestador — reglas específicas de .NET Framework 4.7.2 |
| **Tools/integrations propias** | Qué conectores/MCP usa tu equipo (siempre pasando por el modelo de riesgo de `security-governance.md`) |
| **Workflows particulares** | `_sdd/` de DataAgro es una elección de ese equipo, no obligatoria para otros |
| **Knowledge de dominio** | Glosarios, convenciones de negocio propias |
| **Prácticas específicas de tu stack** | .NET Framework 4.5.2 vs. 4.7.2 vs. .NET 8 requieren reglas distintas — ya visto en la comparación real de `dotnet-best-practices` entre repos |

## Regla de una línea

Si estás cambiando **el formato/contrato** (cómo se registra algo), consultá primero. Si
estás cambiando **el contenido de tu dominio** (qué dice tu Skill/Instruction/Agent),
adelante — es tu autonomía, ya reconocida en `../architecture/operating-model.md`.
