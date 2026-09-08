# CAP-006 — stack-best-practices-template

| Campo | Valor | Evidencia / clasificación |
|---|---|---|
| **ID** | CAP-006 | — |
| **Name** | stack-best-practices-template | FACT |
| **Type** | Skill | FACT — referencia especializada cargada on-demand por un Agent de code review |
| **Purpose** | Plantilla de estructura para documentar buenas prácticas específicas del stack de un equipo, cargable por un Agent de code review — el género es reusable, el contenido no | FACT |
| **Owner** | REQUIRES VALIDATION | `BLOCKED-DECISIONS.md` #1 |
| **Maintainer** | REQUIRES VALIDATION | Ídem |
| **Origin** | 2 instancias reales e independientes de `dotnet-best-practices`: Scato Logística (.NET Framework 4.5.2/EF5/MVC4/NUnit 2.6.3) y Orquestador (.NET Framework 4.7.2/EF6/MVC5/NUnit3), rama `master-logistica`/`feature/cardless4` | FACT — contenido completo leído en ambas, confirmado no intercambiable |
| **Originator** | REQUIRES VALIDATION por instancia — no verificado individualmente en G5.1 | — |
| **Team** | Scato Logística, Orquestador | FACT |
| **Domain** | Contenido 100% específico por versión de stack — mismo género (arquitectura por capas, manejo de errores, acceso a datos, DI/scoping, async, testing), contenido no intercambiable | FACT — ya anticipado en `../../architecture/assessment-gate.md`, confirmado con contenido real posteriormente |
| **Repository** | `Scato Logistica/Scato%20Logistica`; `Orquestador/Orquestador` | FACT |
| **Branch** | Scato Logística: working tree. Orquestador: `master-logistica`/`feature/cardless4` | FACT |
| **Integration Status** | Integrada en ambos, cargada explícitamente por sus respectivos Agents `dotnet-code-reviewer` (`Load and apply the following skills: dotnet-best-practices, dotnet-performance-fx472`) | FACT |
| **Configuration Status** | VERIFIED en ambas — contenido completo leído (283 líneas Scato Logística, 177 líneas Orquestador) | Inventario G5.1 |
| **Real Use Status** | **CONFIGURED** — existe, bien formada, cargada por el Agent de code review real; sin Evidence Record de una ejecución puntual donde se haya confirmado que efectivamente cambió un hallazgo del Agent | Escala unificada G4.5 |
| **Lifecycle State** | Pilot | Sin Evaluation/Measure documentados |
| **Corporate Standard** | N | Contenido explícitamente TEAM-SPECIFIC — no candidato a Corporate Standard, solo el género (la plantilla) lo es |
| **Version** | Sin versionado semántico en ninguna instancia real. Generalización: `1.0-generalized` (G5.1), plantilla de estructura sin contenido de stack | FACT |
| **Risk** | Bajo — es contenido de referencia, no código ejecutable. Riesgo real: quedar desactualizada respecto al stack real y generar recomendaciones incorrectas | INFERENCE |
| **Data** | No aplica | — |
| **Data Classification** | REQUIRES VALIDATION | `BLOCKED-DECISIONS.md` #3 |
| **Tools** | Ninguna — contenido de referencia | FACT |
| **Model** | No aplica | — |
| **Autonomy** | No aplica directo (Skill) | — |
| **HITL** | No declarado dentro de la skill misma — el HITL real ocurre en el Agent que la carga (`CAP-003`) | PARTIAL |
| **Evaluation** | NOT FOUND | Sin evidencia de que su contenido haya sido validado contra el código real más allá de la revisión de quien la escribió |
| **Observability** | NOT FOUND | — |
| **Metrics** | NOT FOUND | — |
| **Adopters** | Scato Logística, Orquestador — 2 instancias, sin evidencia de adopción cruzada (contenido no compartible por diseño, versiones de stack distintas) | FACT |
| **Last Review** | 2026-09-08 | G5.1 |
| **Reusable Asset** *(nuevo en G5.1)* | [`capabilities/skills/stack-best-practices-template/SKILL.md`](../../capabilities/skills/stack-best-practices-template/SKILL.md) | Plantilla de 8 secciones, deliberadamente sin contenido de ejemplo de stack — ver la propia plantilla para la justificación de por qué no incluir un ejemplo |
| **Evidence Reference** | No aplica — sin Evidence Record puntual; evidencia son las 2 instancias reales citadas en `Origin` | Distinción explícita, no una omisión |
