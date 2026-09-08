# G5 — Track 1 Finalization & Delivery Readiness

**Fase**: G5. **Estado**: PROPOSAL salvo citas FACT/EXTERNAL EVIDENCE explícitas.
Precondición: G4.6 CLOSED WITH CONDITIONS. Solo se modificó `MOA-AI-Engineering`. Sin
commit/push.

**Pregunta que gobierna este documento**: ¿`MOA-AI-Engineering` está suficientemente
construido para entregarse como modelo base de AI Engineering de MOA? **Respuesta:
sí, con condiciones explícitas** — ver sección 32.

---

## 1. Executive Summary

`MOA-AI-Engineering` implementa un modelo base de AI Engineering completo en su
estructura: Common Core, Team Adaptation, un Capability Model de 7 tipos + 3 cross-cutting
concerns, un Capability Registry con entradas evidenciadas (6 al día de esta corrección —
G5 cerró con 3, ampliado en G5.1), 1 Golden Path con 2 ejecuciones reales, contratos de
Evidence/Evaluation/Measurement aplicados dos veces, un Adoption Kit de 4 archivos, un
Contribution Model, y decisiones de gobierno explícitamente bloqueadas (no ocultas —
12 al día de esta corrección, `BLOCKED-DECISIONS.md`). Lo que **no** existe todavía es adopción
independiente real — ninguna ejecución fue hecha ni evaluada por una persona de MOA, solo
por el mismo agente que diseñó el modelo (G4.4, G4.6). Esta limitación está documentada,
no bloquea la entrega, y tiene un mecanismo definido para resolverse después (sección 27).

## 2. Track 1 Objective

> "Construir un modelo base de AI Engineering para MOA que permita a los distintos
> equipos y proyectos incorporar IA de manera sistemática, gobernada, reutilizable y
> medible dentro del SDLC, acelerando la evolución de los servicios actuales y
> contribuyendo a mejorar la productividad, calidad, seguridad, trazabilidad y mejora
> continua."

**Sin contradicción material detectada.** El modelo construido (secciones 6-19) cubre
cada cláusula del objetivo: sistemático (Adoption Model, 12 etapas), gobernado
(Governance, Lifecycle, Blocked Decisions explícitas en vez de decisiones implícitas —
12 al día de esta corrección, ver `BLOCKED-DECISIONS.md`),
reutilizable (Registry, Golden Path), medible (Measurement Contract, aplicado con
honestidad — `NOT MEASURED` cuando corresponde, no inventado). No se cambia el objetivo.

## 3. Product Definition

`MOA-AI-Engineering` es el modelo base de AI Engineering de MOA — no una colección de
documentos, prompts o agentes, ni una plataforma tecnológica, ni un framework idéntico
para todos los equipos. Es: **Common Core + capacidades reutilizables + Golden Paths +
governance + evaluation + measurement + mecanismos de adopción/contribución, con Team
Adaptation según la naturaleza de cada proyecto** (definición ya fijada en G4.5 §2, sin
cambios — repetida acá porque es el criterio contra el que se mide todo lo demás en G5).

## 4. Current State

| Fase | Qué produjo | Estado final |
|---|---|---|
| G3.1-G3.3 | Reference Model, evidencia interna completa, arquitectura de referencia (9 docs) | Consistente, sin contradicciones nuevas encontradas en G5 |
| G4.1-G4.2 | Product Architecture Baseline, Registry MVP (3 entradas), primer Golden Path | Vigente |
| G4.3 | Evidence/Evaluation/Measurement Contracts | Vigente, aplicado 2 veces |
| G4.4 | Primer controlled dry-run (MOA-1816) — no un piloto real independiente | CLOSED WITH CONDITIONS |
| G4.5 | Adoption Kit, Golden Path endurecido, Contribution Model, Product Test | CLOSED WITH CONDITIONS |
| G4.6 | Segundo controlled dry-run (MOA-1765), Independence Test (`NOT INDEPENDENTLY VALIDATED`), Product Value Test | CLOSED WITH CONDITIONS |
| **G5** | Esta consolidación — sin fase conceptual nueva, solo verificación y correcciones | Ver sección 32 |

**Blocked Decisions** siguen abiertas (`BLOCKED-DECISIONS.md` — 12 al día de esta
corrección, G5 cerró con 11, ampliado en G5.1) — ninguna se resolvió ni
se inventó su resolución en G5.

## 5. Architecture

`reference-architecture.md`, `operating-model.md` y `capability-model.md` siguen siendo
la base — no se rediseñaron. La revisión de G5 (sección 24) confirma que no hay
contradicción material entre estos documentos fundacionales y lo agregado en G4.1-G4.6.

## 6. Common Core

| Elemento | Capa | Evidencia |
|---|---|---|
| Principios (`strategy/principles.md`) | **COMMON** | 13 principios, sin excepción por equipo |
| Security baseline (`security-governance.md`) | **COMMON** | Least privilege, HITL, Data Classification (parcialmente `REQUIRES VALIDATION`, no ausente — ver sección 17) |
| Evidence / Evaluation / Measurement Contracts (`G4.3...md`) | **COMMON** | Mismo esquema usado en las 2 ejecuciones reales, sin variación por equipo |
| Lifecycle (`lifecycle.md`) | **COMMON** | Mismo modelo de 3 bloques para cualquier capacidad |
| Capability Registry (mecanismo, no el contenido de cada entrada) | **COMMON** | `registry/README.md`, `INDEX.md` |
| Golden Path (estructura de 4 pasos: historia→criterios→reglas→gaps) | **COMMON** | `golden-paths.md` §1, tabla explícita Common Core/Team Adaptation |
| Contribution Model (el flujo de 9 pasos) | **COMMON** | `adoption/contribution-guide.md` |
| Adoption Kit (el esqueleto de 4 archivos y sus 12 etapas) | **COMMON** | `adoption/` |

**No todo es obligatorio** — ver Team Adaptation (sección 7) para lo que cada equipo
decide libremente dentro de este esqueleto.

## 7. Team Adaptation

Documentado operativamente en `adoption/team-adaptation.md` (creado en G4.5, sin cambios
de fondo en G5). Un equipo puede adaptar libremente: domain instructions, domain Skills,
project Agents, workflows, knowledge/RAG, tools, integrations, prácticas específicas de su
stack tecnológico — **sin romper**: security baseline, governance, los 3 contratos
(Evidence/Evaluation/Measurement), el Lifecycle, y los campos obligatorios de metadata del
Registry. Confirmado con evidencia real en G4.6: el rol usado en `EXEC-20260908-001`
("operador de planta") es Team Adaptation legítima — contenido de dominio, no una
violación del Common Core.

## 8. SDLC Model

`architecture/ai-sdlc.md` mapea las capacidades de IA a las etapas del SDLC — sin cambios
de fondo. El Adoption Model de 12 etapas (sección 12) es el mecanismo operativo que un
equipo recorre para *consumir* ese modelo, no un SDLC alternativo.

## 9. Capability Model

Taxonomía de G3.3, sin alteración: **Pre-Artifact (Prompt)** + **7 Capabilities**
(Instruction, Skill, Workflow, Agent, Knowledge/RAG, Integration/API, MCP) + **3
Cross-Cutting Concerns** (Evaluation, Observability, Metrics — no son un 8vo tipo de
capability, son transversales a los 7). Los Registry entries actuales son consistentes
con esta taxonomía (6 al día de esta corrección — G5 cerró con 3, ampliado en G5.1):
CAP-001/CAP-002/CAP-006 = Skill, CAP-003 = Agent, CAP-004 = Workflow, CAP-005 =
Instruction. Ningún cross-cutting concern ni detalle de implementación (ej. "SheetJS",
"Given/When/Then") fue confundido con una capability nueva en ninguna fase, incluido
G4.6.

## 10. Capability Registry

Los entries (`registry/entries/*.md` — 6 al día de esta corrección, G5 cerró con 3,
ampliado en G5.1) mantienen los ~27 campos requeridos: ID, Name, Type, Purpose, Origin,
Originator, Owner, Maintainer, Team, Domain, Repository, Branch, Integration Status,
Configuration Status, Real Use Status, Lifecycle State, Corporate Standard, Version,
Risk, Data, Data Classification, Tools, Model, Autonomy, HITL, Evaluation/Evaluation
Reference, Observability, Metrics/Metric Reference, Adopters, Last Review, Evidence
Reference. **Ninguna entrada fue promovida sin evidencia** — todas siguen
`Corporate Standard: N`, y ninguna llegó a `Real Use Status: VERIFIED` (esa etiqueta
requiere ejecución independiente, que no existe todavía — sección 26).

## 11. Golden Paths

**AI-Assisted Requirements** (`golden-paths.md` §1) es el único Golden Path con evidencia
real: 2 ejecuciones (`EXEC-20260907-001` sobre MOA-1816, `EXEC-20260908-001` sobre
MOA-1765), ambas `PARTIAL`, ninguna independiente. Queda claro en el propio documento:
cuándo usarlo (refinar un requerimiento antes de desarrollo), cuándo no (no reemplaza
revisión humana, no es una herramienta de aprobación), input (ticket en lenguaje natural),
output (historia + criterios + reglas + gaps), Human Review (obligatorio, hoy
`PENDING/BLOCKED` por falta de canal), Evidence/Evaluation/Measurement (contratos
aplicados 2 veces), Feedback (mecanismo preparado, sin receptor confirmado), Improvement
(6 candidatos identificados en G4.6, clasificados, no todos implementados). Los otros 5
Golden Paths documentados (`golden-paths.md` §2-6) siguen siendo **PROPOSAL conceptual, sin
ejecución real** — aclarado explícitamente en G5 (ver edición de esta fase al inicio del
archivo) para que no se lean como "listos para usar". **No se creó ningún Golden Path
nuevo** — un camino completo es preferible a varios incompletos, instrucción respetada.

## 12. Adoption Model

12 etapas (Discover→Understand→Assess→Adopt→Adapt→Execute→Generate Evidence→Evaluate→
Measure→Feedback→Improve→Contribute), cada una con propósito, entrada, salida,
responsabilidad, evidencia esperada y criterio de completion — tabla completa en
`G4.5-Product-Hardening-and-Adoption-Model.md` §7, sin cambios de fondo en G5. Las etapas
que dependen de una decisión humana están identificadas explícitamente: **Evaluate**
(HITL real pendiente), **Feedback** (receptor sin confirmar, Blocked #1), **Contribute**
(Human Validation, Blocked #1). Ninguna de las 12 etapas quedó sin definir.

## 13. Evidence

El Evidence Contract (`G4.3-Evidence-Evaluation-Measurement.md` §6, 9 campos) permite
reconstruir WHAT/WHEN/WHO/WHERE/WITH WHAT/INPUT/OUTPUT — confirmado con 2 instancias
reales completas. `RESULT` (evaluación) y `MEASUREMENT` se mantienen en archivos
**separados** (`evaluation/`, `measurements/`), nunca mezclados con el Evidence Record —
verificado en ambas ejecuciones, sin excepción.

## 14. Evaluation

Criterios declarados **antes** de evaluar en ambas ejecuciones (tablas explícitas en
`evaluation/EXEC-20260907-001.md` y `evaluation/EXEC-20260908-001.md`). Método
diferenciado (`model-assisted`, nunca `human` todavía — declarado sin ambigüedad).
`hitl_required: true` en ambas, `hitl_confirmed_by`: ninguno — HITL real sigue pendiente,
nunca simulado. **Regresión posible**: el propio Evaluation Contract permite un resultado
`Evaluation → Design` (volver atrás) en `lifecycle.md` — el modelo no asume que toda
evaluación aprueba.

**EXTERNAL EVIDENCE (nueva en G5)**: la guía de Anthropic *"Demystifying evals for AI
agents"* recomienda combinar evals automatizados, monitoreo en producción y revisión
humana periódica para calibración, y advierte contra depender de un solo modo de
evaluación — el mismo principio que ya aplicaba este modelo al declarar
`model-assisted` explícitamente insuficiente sin HITL. Fuente:
[Anthropic — Demystifying evals for AI agents](https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents).

## 15. Measurement

Measurement Result Contract (`G4.3...md` §10) aplicado 2 veces, ambas `NOT MEASURED` con
razón explícita (sin baseline; en G4.6 además se evaluó y descartó si 2 puntos del mismo
actor bastan para una serie — no bastan). Ningún resultado fue inventado, ni convertido en
`0%` ni en una mejora estimada. `owner` del baseline: `REQUIRES VALIDATION` en ambos casos
— consistente con Blocked #1 (sin gobierno confirmado que pueda fijar un baseline
corporativo).

## 16. Governance

Risk-proportionate, no uniforme: CAP-003 (.NET Code Reviewer) tiene riesgo **bajo por
diseño estructural** (`tools` sin `edit`) y requiere menos control que una capacidad
hipotética con permisos de escritura. Gobernanza cubierta: promoción de capacidad
(`assessment-gate.md` + Lifecycle §Promote), autonomía de agentes (matrices ALWAYS/ASK
FIRST/NEVER donde existen, HITL explícito en CAP-003), acceso a tools/MCP (Blocked #4),
datos (Blocked #3), oversight humano (HITL en Evaluation Contract), lifecycle y retiro
(`lifecycle.md` §Deprecation), ownership (Blocked #1, la brecha de gobierno más
importante del modelo, sin resolver — declarada, no disimulada).

## 17. Security

- **Least privilege**: confirmado en CAP-003 (`tools: [execute, read, search]`, sin
  `edit`) — el control estructural más fuerte encontrado en todo el relevamiento.
- **Credenciales**: regla dura ya vigente en el agent `devops` (secretos nunca en YAML).
- **Datos sensibles**: `Data Classification` sigue `REQUIRES VALIDATION` en todas las
  entradas del Registry (6 al día de esta corrección) — política formal no existe
  (Blocked #3), declarado sin excepción.
- **Tool permissions**: declarados explícitamente por capacidad (`Tools` field del
  Registry).
- **Autonomía de agentes**: HITL explícito donde existe (CAP-003: *"DO NOT edit or modify
  any files"*), `REQUIRES VALIDATION` donde no (CAP-001, CAP-002).
- **Auditabilidad**: cada Evidence Record referencia commit hash de origen; el propio repo
  es git, con historial completo sin squash.
- **Aprobación humana**: HITL Contract, hoy sin confirmar quién lo ejerce (Blocked #1).
- **Integraciones externas / MCP**: **atención especial a Atlassian**, sin cambios de
  decisión desde G4.5 — el hallazgo de G4.5 sigue vigente: el **Rovo MCP Server de
  Atlassian usa OAuth 2.1 como mecanismo primario**, con API token solo si el admin lo
  habilita, y acceso acotado a los permisos del usuario y a controles de dominio del admin
  (EXTERNAL EVIDENCE, fuente:
  [Atlassian Support — Authentication and authorization](https://support.atlassian.com/atlassian-rovo-mcp-server/docs/authentication-and-authorization/)).
  El MCP `com.atlassian/atlassian-mcp-server` encontrado en Orquestador con scope `/*`
  **no está alineado con ese modelo oficial** — Blocked #4 sigue sin resolver, y **no se
  implementó ningún MCP** en G5, solo se documentó el estado (instrucción explícita
  respetada).

**EXTERNAL EVIDENCE (nueva en G5)**: la guía de seguridad para agentes de Anthropic (CISO's
guide to agentic AI) sostiene que el entorno donde corre un agente **nunca debería
contener una credencial que valga la pena robar** — principio directamente aplicable a por
qué CAP-003 fue diseñado sin `edit` y sin acceso a sistemas externos, y a por qué
`security-governance.md` prioriza limitar blast radius sobre confiar en instrucciones de
prosa. Fuente: [Anthropic — CISO's guide to agentic AI](https://claude.com/blog/ciso-guide-to-agentic-ai).

## 18. Lifecycle

El modelo de `lifecycle.md` (3 bloques: Capability Lifecycle secuencial → Adoption Status
paralelo → Deprecation secuencial) **no se rediseña en G5** — es más preciso que una
cadena única y ya fue corregido explícitamente en G3.3 Corrections (Idea sin trackear;
Common Core como flag, no paso). Mapeo contra la cadena de 13 pasos mencionada en el
encargo de G5, para confirmar que no hay contradicción:

| Cadena del encargo G5 | Dónde vive en el modelo ya construido | ¿Contradicción? |
|---|---|---|
| Idea | Pre-lifecycle, explícitamente no trackeado (decisión ya justificada) | No — es una precisión, no una omisión |
| Assessment | `Use Case` + `Value+Risk` (2 pasos, más granular) | No |
| Design | `Design` | No |
| Pilot | `Pilot` | No |
| Evidence | Artefacto transversal generado en Pilot/Evaluation/Measure (Evidence Contract), no un estado de fila propio | No — Evidence no es un momento único, se genera en cada paso con ejecución real |
| Evaluation | `Evaluation` | No |
| Measurement | `Measure` | No |
| Human Validation | `Human Validation` | No |
| Promotion | `Promote` (Governance Gate) | No |
| Adoption | `Adopt` (dentro de Adoption Status, **paralelo**, no siguiente en la fila) | No — mejora deliberada sobre un modelo puramente secuencial |
| Improvement | `Improve` (ídem, paralelo) | No |
| Deprecation | `Deprecate` | No |
| Retirement | `Retire` | No |

**Conclusión**: la cadena del encargo es compatible con el modelo ya construido; se
documenta el mapeo en vez de reescribir el modelo (instrucción de G5: no rehacer fases
anteriores).

## 19. Contribution Model

`Team-Specific → Candidate → Evidence → Assessment → Evaluation → Pilot → Measurement →
Human Validation → Reusable Capability → Common Core` (`G4.5...md` §15,
`adoption/contribution-guide.md`) — semánticamente equivalente a la cadena del encargo de
G5 (`Team Specific → Candidate → Assessment → Pilot → Evaluation → Measurement → Human
Validation → Reusable Capability → Common Core`); la única diferencia es de orden interno
entre Evidence/Assessment/Evaluation/Pilot, no de sustancia — ambas terminan en el mismo
Governance Gate. No se modifica.

## 20. Developer Experience

Las 10 preguntas del encargo, verificadas contra `adoption/README.md` (que ya las responde
explícitamente desde G4.5):

| Pregunta | ¿Respondida? | Dónde |
|---|---|---|
| ¿Qué es esto? | Sí | `adoption/README.md`, `getting-started.md` §1 |
| ¿Por dónde comienzo? | Sí | `getting-started.md`, 6 pasos numerados |
| ¿Qué puedo reutilizar? | Sí | `registry/INDEX.md` |
| ¿Cómo sé si aplica? | Sí | `getting-started.md` §3 |
| ¿Cómo lo adapto? | Sí | `team-adaptation.md` |
| ¿Qué tengo que entregar? | Sí | Evidence/Evaluation/Measurement Contracts, ejemplificados con 2 ejecuciones reales |
| ¿Cómo genero evidencia? | Sí | `getting-started.md` §4 |
| ¿Cómo evalúo? | Sí | `getting-started.md` §5 |
| ¿Cómo mido? | Sí | `getting-started.md` §6 |
| ¿Cómo doy feedback? | Sí | `contribution-guide.md`, con las 7 preguntas ya instanciadas en G4.6 §13 como ejemplo real |
| ¿Cómo contribuyo? | Sí | `contribution-guide.md`, 9 pasos |

**Sin brechas** en esta dimensión — la única limitación real es que nadie externo a esta
sesión probó todavía si estas respuestas son suficientes en la práctica (sección 26).

## 21. Multi-Team Applicability

El Capability Model (`capability-model.md`) define tipos por **función** (Instruction,
Skill, Workflow, Agent, Knowledge/RAG, Integration/API, MCP), no por herramienta — no
asume GitHub Copilot como único proveedor. Blocked #2 (`BLOCKED-DECISIONS.md`) ya señala
explícitamente que no hay evidencia de una "plataforma única" sancionada — el modelo se
diseñó *a partir de* esa ambigüedad, no ignorándola. El Registry ya evidencia heterogeneidad
real: `model: claude-opus-4.8` pineado en un agent de Scato Logística, `copilot-o3`/
`copilot-gpt-4.1` en otras plantillas, ningún `model` declarado en CAP-001/002/003 — el
modelo tolera esa variedad sin forzar convergencia prematura. Conceptualmente aplicable a
GitHub Copilot, Copilot Studio, Claude, u otros — la implementación concreta de cada
capacidad es Team Adaptation, no Common Core (sección 7).

## 22. Internal Evidence

Los 6 repos del workspace se usaron como fuente, nunca como destino de escritura (excepto
`MOA-AI-Engineering`). Evidencia real usada en G5: los mismos hallazgos ya consolidados en
G3.2/G3.2.5/G4.2-G4.6 (branches de Orquestador, autoría, patrones de DataAgro/Scato
Logística/Scato Puerto/MOA Operaciones) — **no se re-auditaron los 5 repos desde cero en
G5** (instrucción explícita: no rehacer fases). Se confirma, por curiosidad durante la
revisión de G5, que `lifecycle.md` (G3.3) ya mencionaba `MOA-1765` como caso real de
`moa-sdlc` sin cerrar — coincide, sin contradicción, con el ticket elegido
independientemente en G4.6 para el segundo piloto de CAP-002 (rutas de evidencia
distintas: `moa-sdlc`/harness SDD vs. skill `user-story` directa).

## 23. External Evidence

Nueva investigación de G5, clasificada explícitamente como EXTERNAL EVIDENCE (nunca como
decisión de MOA):

- **NIST AI RMF + Generative AI Profile (NIST.AI.600-1)**: framework de 4 funciones —
  Govern (transversal a toda la organización), Map, Measure, Manage (aplicadas por
  sistema) — con 12 categorías de riesgo específicas de IA generativa. Se usa para
  **validar, no copiar**, la separación ya existente en este modelo entre Governance
  (transversal), Assessment/Design (Map), Measurement (Measure) y Lifecycle/Deprecation
  (Manage) — la estructura converge de forma independiente con un framework externo
  reconocido, lo cual es una señal de solidez, no una obligación de adoptar su vocabulario.
  Fuente: [NIST AI RMF: Govern, Map, Measure, Manage Explained](https://blog.balancedsec.com/p/original-inside-the-nist-ai-risk).
- **Anthropic, "Demystifying evals for AI agents"**: valida el enfoque de Evaluation ya
  vigente (sección 14).
- **Anthropic, "CISO's guide to agentic AI"**: valida el enfoque de Security ya vigente,
  en particular el diseño sin `edit` de CAP-003 (sección 17).
- **DORA (AI Capabilities Model / Platform Engineering, ya citado en G4.5)**: sigue
  vigente — valida por qué Common Core no debe convertirse en "ivory tower".
- **Atlassian, documentación oficial de Rovo MCP (ya citada en G4.5)**: sigue vigente —
  informa Blocked #4, no lo resuelve.

No se realizó investigación nueva de Microsoft AI governance ni GitHub Copilot docs en
esta fase — se evaluó que las citas ya existentes (DORA, Atlassian, y las 2 nuevas de
Anthropic) cubren suficientemente las decisiones de diseño que requerían respaldo externo
en G5; no se agregó investigación por completitud performativa.

## 24. Gap Analysis

Ver tabla en la sección "Revisión de calidad final" más abajo, que incorpora tanto los
hallazgos propios de esta sesión como los de la auditoría de consistencia ejecutada como
parte de G5.

## 25. Delivery Readiness

| Capability | Current State | Evidence | Delivery Ready? | Condition | Future Validation |
|---|---|---|---|---|---|
| SDLC Model | Definido, sin ejecución independiente | `ai-sdlc.md` | Sí | — | — |
| Common Core | Definido, con 8 elementos explícitos | Sección 6 | Sí | — | — |
| Team Adaptation | Definido, confirmado con evidencia real (G4.6) | `team-adaptation.md`, `EXEC-20260908-001` | Sí | — | — |
| Capabilities (Registry entries) | 6 al día de esta corrección (G5 cerró con 3), ninguna `VERIFIED`/`Corporate Standard: Y` | `registry/entries/*.md` | Sí, con clasificación individual (Reusable Capability/Pattern/Common Core Candidate — no todas son Team-Specific) | No promover sin evidencia adicional | Ejecución independiente |
| Registry | Operativo, mecanismo MVP manual | `registry/INDEX.md` | Sí | — | Discovery a escala (Blocked #10) |
| Golden Paths | 1 hardened con 2 ejecuciones, 5 conceptuales | `golden-paths.md` | Sí, con el #1 como único consumible | Los #2-6 no deben usarse como si fueran operativos | Ejecuciones reales de los otros 5, si se justifican con evidencia |
| Adoption | Kit completo, 12 etapas definidas | `adoption/` | Sí | — | Prueba con un equipo real (sección 27) |
| Evidence | Contrato aplicado 2 veces | `evidence/*.md` | Sí | — | — |
| Evaluation | Contrato aplicado 2 veces, sin HITL humano | `evaluation/*.md` | Sí | HITL real pendiente para cualquier promoción | Evaluador humano confirmado (Blocked #1) |
| Measurement | Contrato aplicado 2 veces, `NOT MEASURED` en ambas | `measurements/*.md` | Sí | No inventar baseline nunca | Baseline real, con datos de un equipo |
| Governance | Decisiones bloqueadas, explícitas (12 al día de esta corrección, G5 cerró con 11) | `BLOCKED-DECISIONS.md` | Sí, como marco | Sin aprobador de Common Core, ninguna promoción es posible | Resolver Blocked #1 |
| Security | Baseline definido, MCP documentado no implementado | `security-governance.md` | Sí | Data Classification pendiente (Blocked #3) | Política formal de datos |
| Lifecycle | Modelo de 3 bloques, consistente | `lifecycle.md` | Sí | — | — |
| Contribution | Ruta de 9 pasos definida | `contribution-guide.md` | Sí | Sin receptor de feedback confirmado | Resolver Blocked #1 |
| Documentation | Conjunto de documentos y artefactos versionados, consistentes (ver sección 29) — no se fija un conteo estático, el repositorio sigue creciendo en fases posteriores | Todo el repo | Sí | — | — |
| Extensibility | Provider-agnostic conceptualmente | Sección 21 | Sí | — | — |

## 26. Real Adoption Status

**REAL INDEPENDENT ADOPTION = NOT YET VALIDATED.**

Esto **no bloquea** la entrega del modelo. Queda explícitamente como **POST-DELIVERY
VALIDATION** — parte de la evolución posterior, no una condición previa a poder entregar
el repositorio como modelo base. El modelo está construido, la limitación está
documentada con evidencia (G4.4, G4.6), y existe un mecanismo claro para resolverla
(sección 27).

## 27. Human Validation Plan

Plan breve para las pruebas reales que realizará **posteriormente el responsable de la
iniciativa** con los equipos correspondientes — sin nombres inventados, con placeholders
donde corresponde.

| Campo | Valor |
|---|---|
| Quién participa | `[placeholder — referente técnico/funcional real de un equipo de MOA, a definir por el responsable de la iniciativa]` |
| Qué equipo | Sugerido: DataAgro (ya tiene 2 ejecuciones de referencia para comparar) — no obligatorio, cualquier equipo con un requerimiento real sirve |
| Qué proyecto | El proyecto activo del equipo elegido al momento de la prueba |
| Qué actividad | Refinamiento de un requerimiento real, nuevo (no MOA-1816 ni MOA-1765, para no repetir el mismo material ya usado por esta sesión) |
| Qué capability | CAP-002 (`user-story`) — mismo Golden Path ya hardened, para poder comparar contra `EXEC-20260907-001`/`EXEC-20260908-001` |
| Qué evidencia | Evidence Record nuevo, mismo esquema (`G4.3...md` §6), con `actor` = la persona real, no Claude Code |
| Qué evaluación | Evaluation Record con `method: human`, `evaluator` = la persona real — primera vez que este campo deja de ser `model-assisted` |
| Qué métrica | Tiempo de refinamiento con y sin CAP-002, sobre 2+ requerimientos comparables — primer intento real de establecer el baseline que hoy falta |
| Qué feedback | Las 7 preguntas de `contribution-guide.md`, ya instanciadas como ejemplo en G4.6 §13 — reutilizables tal cual |
| Criterios de éxito | (a) la persona pudo seguir `getting-started.md` sin intervención del arquitecto; (b) generó su propio Evidence Record; (c) el Evaluation Record tiene `method: human`; (d) el Independence Test (`G4.6...md` §14) pasa a `PASS` o al menos `PARTIAL` |

## 28. Risks

- Que se lea "READY FOR DELIVERY WITH CONDITIONS" como "ya validado" — mitigado con el
  lenguaje explícito de las secciones 26-27.
- Que Blocked #1 se postergue indefinidamente porque el modelo "ya funciona" en dry-run —
  riesgo señalado desde G4.4, sigue vigente, sin mitigación posible desde este repo.
- Que los 5 Golden Paths conceptuales (`golden-paths.md` §2-6) se usen como si fueran
  operativos — mitigado con la aclaración agregada en G5 al inicio del archivo.

## 29. Decisions Required

Las 11 de `BLOCKED-DECISIONS.md`, sin cambios ni resoluciones inventadas. Ninguna decisión
arquitectónica nueva surgió de G5 — es una fase de consolidación, no de diseño.

## 30. Final Recommendations

1. Entregar el modelo tal como está, con las condiciones de la sección 32 explícitas en la
   entrega (no ocultas en un anexo).
2. Priorizar resolver Blocked #1 sobre agregar más pilotos del mismo actor — ya
   demostrado en G4.4/G4.6 que repetir la ejecución no resuelve la brecha de
   independencia.
3. Usar el Human Validation Plan (sección 27) como el primer paso posterior a la entrega,
   no como un "nice to have" — es la única vía real para que el Product Test/Independence
   Test dejen de estar en `PARTIAL`/`BLOCKED`.
4. No agregar Golden Paths nuevos ni capacidades nuevas hasta tener evidencia de que el
   único Golden Path actual funciona con un humano real.

## 31. Exit Criteria

| # | Criterio | ¿Cumplido? |
|---|---|---|
| 1 | Objetivo del Track 1 claramente implementado | Sí — sección 2 |
| 2 | Common Core definido | Sí — sección 6 |
| 3 | Team Adaptation definido | Sí — sección 7 |
| 4 | Capability Model definido | Sí — sección 9 |
| 5 | Registry utilizable | Sí — sección 10 |
| 6 | Al menos 1 Golden Path consumible | Sí — sección 11 |
| 7 | Adoption Model definido | Sí — sección 12 |
| 8 | Evidence Contract definido | Sí — sección 13 |
| 9 | Evaluation Contract definido | Sí — sección 14 |
| 10 | Measurement Contract definido | Sí — sección 15 |
| 11 | Governance definido | Sí — sección 16 |
| 12 | Security baseline definido | Sí — sección 17 |
| 13 | Lifecycle definido | Sí — sección 18 |
| 14 | Contribution Model definido | Sí — sección 19 |
| 15 | Developer Experience documentada | Sí — sección 20 |
| 16 | Multi-team applicability demostrada conceptualmente | Sí — sección 21 |
| 17 | Limitaciones de adopción real declaradas | Sí — sección 26 |
| 18 | Plan de validación humana posterior existe | Sí — sección 27 |
| 19 | Sin contradicciones críticas | Sí — ver revisión de calidad final |
| 20 | Repositorio entregable como modelo base, evolucionable con feedback real | Sí |

**20/20 cumplidos.**

## 32. Final Status

# **READY FOR DELIVERY WITH CONDITIONS**

**Condiciones explícitas de la entrega** (no defectos ocultos — se listan para que quien
reciba el modelo sepa exactamente qué validar después):

1. Ningún Golden Path, ninguna capability y ninguna medición cuenta todavía con evidencia
   independiente — todo lo ejecutado hasta ahora es CONTROLLED DRY-RUN del mismo agente.
2. Blocked #1 (gobierno del Common Core) es la condición estructural más importante — sin
   resolverla, ninguna capacidad puede avanzar más allá de `Pilot`/`PARTIAL`.
3. 5 de los 6 Golden Paths documentados son conceptuales, no operativos — no deben
   presentarse como listos para producción.
4. La validación real depende de un Human Validation Plan (sección 27) que **todavía no
   se ejecutó** — es explícitamente trabajo posterior a esta entrega, no parte de ella.

---

## Revisión de calidad final (Sección 29 del encargo)

Se ejecutó una auditoría dedicada de consistencia (agente de exploración de solo lectura,
sin permisos de escritura) sobre **los 50 archivos `.md` del repositorio** (corrección
respecto al recuento inicial de 42: el conteo real incluye el `architecture/` legado de G1
junto al `docs/architecture/` de G3.3+, y los pares evidence/evaluation/measurement de
ambas ejecuciones — sin contradicción, ambos "reference-architecture.md" están
explícitamente cruzados entre sí como supersesión intencional, ver hallazgo #7 abajo).
Complementada con verificación directa de los puntos de mayor riesgo conocido
(`BLOCKED-DECISIONS.md`, estructura del README raíz).

### Gap Analysis

| Gap | Severidad | Impacto | Riesgo | Dependencia | Acción recomendada | ¿Bloquea entrega? |
|---|---|---|---|---|---|---|
| `capability-registry.md` (documento canónico del schema, referenciado desde `registry/README.md`) seguía documentando la escala vieja de `Real Use Status` (`VERIFIED/PARTIAL/NOT FOUND/REQUIRES VALIDATION`) en vez de la escala unificada en G4.5 (`NOT FOUND/CONFIGURED/EXECUTED/VERIFIED`) — usada consistentemente en `registry/INDEX.md` y en las 3 entradas reales | **HIGH** | El documento que un adoptante nuevo leería como referencia del campo contradecía lo que el Registry realmente usa | Medio-alto — confunde a cualquiera que compare el schema documentado contra las entradas reales | Ninguna | **Corregido en esta fase** — `capability-registry.md` actualizado con la escala real y un ejemplo con los valores actuales de CAP-002 | No (ya corregido) |
| `docs/architecture/G4.2-Registry-MVP-and-Golden-Path.md` — documento significativo (introdujo el Registry MVP y el primer Golden Path) sin ningún link por nombre de archivo desde ningún otro documento del repo (solo mencionado narrativamente como "G4.2" en prosa) | MEDIUM | Baja discoverability — un lector navegando desde el README o desde otros docs de fase no llegaba a este documento | Bajo | Ninguna | **Corregido en esta fase** — agregada tabla "Fases y documentos" en `README.md` (raíz) con link explícito a las 8 fases (G3.3 a G5), incluido G4.2 | No (ya corregido) |
| Sin adopción/evaluación/medición independiente | **HIGH** | Es la brecha central del producto — sin esto, "adoptable" es una afirmación de diseño, no de uso | Medio-alto si se comunica como "ya validado" | Blocked #1 + acceso a un humano real | Ejecutar el Human Validation Plan (sección 27) | **No bloquea la entrega** — es la condición explícita de la entrega, no un defecto de construcción |
| Blocked #1 (gobierno del Common Core) sin resolver | **HIGH** | Bloquea toda promoción a Corporate Standard, toda evaluación humana, todo feedback recibido | Alto si se intenta promover algo sin esto | Decisión organizacional de MOA | Escalar a los 3 líderes del KO (Elmer Charre, Fernando Pagano, Tito Picón) | No bloquea la entrega del *modelo* — sí bloquea cualquier *promoción* futura |
| `Data Classification` sin política formal (Blocked #3) | MEDIUM | Limita qué tan lejos puede llegar el Registry en capacidades que toquen datos sensibles | Medio | Decisión de MOA sobre clasificación de datos | Definir política antes de registrar una capability que toque AFIP/SAP directamente | No — ninguna capability actual la requiere todavía |
| MCP Atlassian con scope `/*` sin gobierno confirmado (Blocked #4) | MEDIUM | Riesgo de sobre-alcance si esa integración está realmente en uso | Medio — depende de si está en uso real, sin confirmar | Confirmar con Orquestador/MOA si el MCP está activo | Auditar el uso real antes de cualquier expansión de MCP | No — ya documentado, no implementado, y fuera del alcance de G5 modificarlo |
| `adoption/getting-started.md` referenciaba solo `EXEC-20260907-001` en sus ejemplos, sin mencionar la segunda ejecución de G4.6 | LOW | Un adoptante nuevo no vería el ejemplo de generalización (2° ticket distinto) | Bajo | Ninguna | **Corregido en esta fase**, antes de que corriera la auditoría — verificado en el re-chequeo del propio agente auditor | No (ya corregido) |
| 5 de 6 Golden Paths sin un marcador de estado explícito por sección (dependían del estado global del documento) | LOW | Ambigüedad menor sobre qué Golden Paths son operativos | Bajo | Ninguna | **Corregido en esta fase** — nota agregada al inicio de `golden-paths.md`, verificada por el agente auditor como ya presente y correcta | No (ya corregido) |

**Sin hallazgos CRITICAL.** La auditoría revisó explícitamente y confirmó limpias las
siguientes categorías: enlaces internos rotos (98 links relativos resueltos, 0 rotos),
declaraciones de `Corporate Standard: Y` sin respaldo (ninguna encontrada), capacidades
marcadas `VERIFIED` sin evidencia (ninguna), métricas con porcentajes inventados (ninguna
— todas `NOT MEASURED`/`REQUIRES VALIDATION` donde corresponde), integridad de
`BLOCKED-DECISIONS.md` (11 ítems, ninguno contradicho silenciosamente en otro documento),
estructura del README raíz contra los directorios reales (coincide exactamente), y
duplicación de contenido (el único caso encontrado — los 2 `reference-architecture.md`,
uno de G1 y otro de G3.3 — es una supersesión intencional, ya cruzada explícitamente entre
sí, no un problema real).

### Cambios aplicados en esta revisión

- `docs/architecture/capability-registry.md` — corregida la escala documentada de `Real
  Use Status` para que coincida con la unificación real de G4.5 (hallazgo HIGH del
  auditor).
- `README.md` (raíz) — agregada tabla "Fases y documentos" con link explícito a las 8
  fases (G3.3-G5), resolviendo la falta de discoverability de `G4.2-*.md` (hallazgo MEDIUM
  del auditor); reescritas las secciones "Estado actual" (ahora refleja G5, no la
  "Fase Foundation" de G1) y "Cómo contribuir" (ahora apunta al Contribution Model real de
  9 pasos en vez del stub de 3 pasos de G1); agregadas secciones "Para quién es esto" y
  "Cómo adoptar".
- `adoption/getting-started.md` — pasos 4/5/6 actualizados para referenciar ambas
  ejecuciones reales (`EXEC-20260907-001`, `EXEC-20260908-001`), no solo la primera —
  corregido antes de la auditoría, verificado como correcto por el auditor.
- `docs/architecture/golden-paths.md` — nota agregada aclarando qué Golden Paths son
  operativos (#1) vs. conceptuales (#2-6) — corregido antes de la auditoría, verificado
  como correcto por el auditor.
