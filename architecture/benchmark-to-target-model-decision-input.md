# Benchmark → Target Model: Decision Input

**Rol de este documento**: input formal para que el Arquitecto Supervisor apruebe (o
rechace) la evolución del Target Model del Track 1. **No es una decisión arquitectónica
definitiva.** No implementa nada, no modifica CAP-002, no modifica el Registry, no crea
capabilities ni Context Providers nuevos, no resuelve Blocked Decisions.

**Fecha**: 2026-09-08, misma sesión que
[`../evidence/current-moa-ai-practices-benchmark.md`](../evidence/current-moa-ai-practices-benchmark.md).
**Ejecutor**: agente investigador/documental interno, bajo supervisión del Arquitecto.

## 1. Executive Summary

El benchmark de prácticas reales de MOA confirma que **la taxonomía actual de 7
capacidades (`capability-model.md`) sigue siendo estructuralmente válida** — ningún
hallazgo del benchmark exige rediseñarla. Lo que el benchmark expone son **3 conceptos
transversales ausentes o insuficientemente explícitos** en el modelo actual:

1. **Context Acquisition & Resolution** no existe como concepto nombrado — hoy vive
   implícito y fragmentado (copy/paste manual en la práctica, 2 MCP configurados sin uso
   real). Es el gap más importante encontrado.
2. **La frontera READ vs. ACT** no tiene, hoy, ningún campo ni contrato propio — vive
   disuelta dentro de `Risk`/`Autonomy`. El benchmark muestra que es precisamente donde
   está el único riesgo de seguridad repetido entre proyectos (scope MCP wildcard).
3. **Copilot Studio/productos conversacionales** no encajan en ningún concepto existente
   — ni Capability, ni Integration, ni Golden Path los representa hoy.

En contraste, **el modelo de Evidence/Evaluation/Measurement ya está completo y correcto**
— el patrón objetivo evaluado en esta actividad para ese tramo coincide exactamente con lo
ya definido en `evidence-evaluation-measurement.md`. **No requiere cambios.**

**Ninguna práctica relevada se convierte automáticamente en estándar** — el pipeline
PRÁCTICA REAL → EVALUACIÓN CRÍTICA → MEJORA → HOMOLOGACIÓN → MODELO BASE se respeta en
cada una de las 10 decisiones de este documento: se recomienda evaluar, no adoptar por
default.

## 2. Decision Scope

Cubre las 10 Decisiones Arquitectónicas solicitadas: Context Acquisition & Resolution,
Capability vs. Integration, READ vs. ACT, Evaluation + Observability, Copilot Studio,
Taxonomía de capacidades, Knowledge/RAG, Automation & Autonomy, revisión del Common Core,
evolución del Registry. **No cubre**: decisiones de producto/tecnología, resolución de
Blocked Decisions, ni ninguna implementación técnica.

## 3. Evidence Baseline

Fuentes obligatorias leídas y usadas como base — ninguna fue reinterpretada por fuera de lo
que ya afirma:

- [`../evidence/current-moa-ai-practices-benchmark.md`](../evidence/current-moa-ai-practices-benchmark.md) — evidencia primaria de esta evolución.
- [`reference-architecture.md`](reference-architecture.md), [`capability-model.md`](capability-model.md), [`capability-registry.md`](capability-registry.md), [`evidence-evaluation-measurement.md`](evidence-evaluation-measurement.md), [`evaluation-observability.md`](evaluation-observability.md), [`lifecycle.md`](lifecycle.md), [`operating-model.md`](operating-model.md), [`assessment-gate.md`](assessment-gate.md).
- [`../governance/BLOCKED-DECISIONS.md`](../governance/BLOCKED-DECISIONS.md), [`../security/security-governance.md`](../security/security-governance.md), [`../integrations/catalog.md`](../integrations/catalog.md).
- [`../adoption/adoption-flow.md`](../adoption/adoption-flow.md), [`../adoption/execution-model.md`](../adoption/execution-model.md).
- `../registry/INDEX.md` (referenciado por `capability-registry.md` y el benchmark, no listado explícitamente en las fuentes obligatorias pero necesario para citar CAP-001…CAP-006 con precisión).

**No se volvió a investigar ningún repo de equipo desde cero** — donde hizo falta
verificar una afirmación puntual, se citó el archivo exacto ya referenciado por el
benchmark, no un hallazgo nuevo.

## 4. Current Architecture Assessment

El modelo actual (`reference-architecture.md`) tiene 5 capas (Team → Team Adaptation →
Assessment Gate → Common Core → Foundation) y un Common Core de 10 componentes (Standards,
Reusable Capabilities, Golden Paths, Governance, Security, Evaluation, Observability,
Metrics, Registry, Enablement). Es **provider-agnostic** y **no centraliza ejecución**
(`operating-model.md`, `evaluation-observability.md` §0). El benchmark no encontró ninguna
evidencia que contradiga estos principios rectores — los gaps encontrados son de
**cobertura conceptual** (algo que el modelo todavía no nombra), no de **corrección**
(algo que el modelo dice mal).

**Contradicción detectada entre documentos, no resuelta acá** (regla explícita: reportar,
no resolver silenciosamente): `assessment-gate.md` usa la clasificación
**ADOPT · ADAPT · TEAM-SPECIFIC · VALIDATE · REJECT/DISCARD**, mientras que esta actividad
usa la clasificación mandatada **ADOPT · ADOPT WITH MODIFICATION · TEAM-SPECIFIC · GAP ·
REQUIRES VALIDATION · DO NOT CHANGE**. Son parcialmente equivalentes (`ADAPT` ≈ `ADOPT
WITH MODIFICATION`, `VALIDATE` ≈ `REQUIRES VALIDATION`) pero no idénticas — `GAP` y
`DO NOT CHANGE` no tienen equivalente en `assessment-gate.md`, y `REJECT/DISCARD` no lo
tiene acá. **REQUIRES VALIDATION**: si el Arquitecto Supervisor quiere una sola taxonomía
de clasificación en todo el repo, o si ambas conviven con propósitos distintos
(`assessment-gate.md` clasifica candidatos a promoción; esta actividad clasifica
decisiones arquitectónicas sobre el modelo mismo).

## 5. Decision Matrix

| # | Topic | Current State | Evidence | Decision | Architectural Rationale | Impact | Validation Required |
|---|---|---|---|---|---|---|---|
| 1 | Context Acquisition como concepto nombrado | No existe en ningún documento de `architecture/` | Benchmark §6, §18 — copy/paste manual predominante, 0 evidencia de resolución automática de una referencia tipo `MOA-1234` | **GAP** | Es condición necesaria para que una capability soporte Modelo A (manual) y Modelo B (conectado) sin duplicarse por sistema origen | Alto — afecta `capability-model.md`, `reference-architecture.md`, `capability-registry.md` | Sí — cómo representarlo formalmente |
| 2 | Direct Context vs. Connected Context | Implícito, no nombrado | Benchmark §6 (Context Acquisition Matrix) | **GAP** | Sin esta distinción, "capability + context provider" no tiene vocabulario propio | Alto | Sí |
| 3 | Capability ≠ Integration | Ya definido y correcto (`capability-model.md`, 7 capacidades) | Benchmark §18 confirma que CAP-002 corre hoy sin integración (Modelo A validado en la práctica) | **DO NOT CHANGE** | El modelo ya soporta la separación pedida; no hay evidencia que la contradiga | Ninguno | No |
| 4 | Golden Paths no distinguen explícitamente "capability" de "fuente de contexto usada" | `golden-paths/README.md` no declara la fuente de contexto por paso | Benchmark §6, INFERENCE a partir de `execution-model.md` paso 4 | **GAP** (documental, no de modelo) | Mejora de claridad, no corrección de error | Bajo | No — mejora recomendada, no bloqueante |
| 5 | READ vs. ACT como frontera de contrato propia | Disuelto dentro de `Risk`/`Autonomy` (`security-governance.md` §1, factor "Read/write") | Benchmark §7 (Automation/Action Matrix) — único ACT sin gobierno nativo es MCP wildcard (Blocked #4) | **GAP** | El único riesgo repetido entre proyectos vive exactamente en esta frontera no explicitada | Alto | Sí — si merece campo propio en Registry (ver Decisión #10) |
| 6 | Modelo Evidence → Evaluation/Measurement → Feedback | Ya definido, fork correcto (`evidence-evaluation-measurement.md`) | Benchmark §9 confirma que el diseño coincide con el patrón objetivo evaluado acá | **DO NOT CHANGE** | Coincide exactamente con lo pedido — no hay brecha de diseño, solo de práctica real | Ninguno | No |
| 7 | Observability transversal (Context/Model/Agent/Tool/MCP/Action) | Ya modelada como lista de señales (`evaluation-observability.md` §2), sin agrupar por esas 6 categorías | Benchmark §9 | **ADOPT WITH MODIFICATION** | Reorganizar señales existentes bajo las 6 categorías del patrón objetivo mejora legibilidad sin cambiar sustancia | Bajo | No — es refinamiento editorial, no arquitectónico |
| 8 | Copilot Studio / productos conversacionales | Sin encaje en ninguna de las 7 capacidades | Benchmark §16 (gap 4) | **GAP** | Requiere un concepto arquitectónico nuevo (Channel/Interface), no una 8va capacidad | Medio–Alto (depende de si es alcance de Track 1) | Sí — alcance de gobierno, no solo arquitectura |
| 9 | Taxonomía de 7 capacidades (Instruction/Skill/Workflow/Agent/Knowledge-RAG/Integration-API/MCP) | Definida y con reglas de desambiguación (`capability-model.md`) | Benchmark §11 confirma consistencia cross-repo sin contradicciones nuevas | **DO NOT CHANGE** | Ningún hallazgo del benchmark exige redefinir Skill/Agent/Workflow | Ninguno | No |
| 10 | Skill reducido a un prompt genérico | Ya guardado explícitamente (`capability-model.md`: "un checklist genérico no es Skill") | Benchmark §11, sin contraejemplos nuevos | **DO NOT CHANGE** | La regla ya existe y la evidencia no la contradice | Ninguno | No |
| 11 | Knowledge/RAG — estado "NOT FOUND" | `capability-model.md` dice "NOT FOUND en la evidencia revisada" | Benchmark §16 (gap 5): existe config real (submodule Wiki), poblada en 1/2, sin consumo | **ADOPT WITH MODIFICATION** | El estado debe matizarse a "CONFIGURED, PARCIALMENTE POBLADO, SIN CONSUMO CONFIRMADO" — no implica implementar RAG | Bajo (corrección de precisión, no de diseño) | No |
| 12 | Automation — ASSIST/AUGMENT/AUTOMATE | No existe como taxonomía propia; el concepto más cercano es `Autonomy` (ALWAYS/ASK FIRST/NEVER, `agent-governance.md`) | Benchmark §11 (`Generate-WfDocs.ps1` = AUTOMATE sin HITL; `Human Review operativo` = AUGMENT) | **REQUIRES VALIDATION** | Riesgo real de duplicar taxonomía si ASSIST/AUGMENT/AUTOMATE no se reconcilia explícitamente con `Autonomy` existente | Medio | Sí — reconciliar nomenclatura antes de introducir un campo nuevo |
| 13 | Common Core — los 10 componentes actuales | Definidos en `operating-model.md`/`reference-architecture.md` | Benchmark no encontró evidencia que contradiga ninguno de los 10 | **DO NOT CHANGE** (estructura) | Los 10 componentes siguen cubriendo lo necesario; lo que falta es contenido dentro de ellos (Registry, Evaluation), no un componente nuevo | Ninguno | No |
| 14 | Registry — campos de contexto/integración/canal/read-write | No existen como campos propios (`capability-registry.md`) | Benchmark §14, §20; Decisiones #1, #3, #5 de este documento | **GAP** | Necesarios para que el Registry pueda representar los hallazgos del benchmark sin forzarlos en campos existentes | Alto (para una evolución futura del Registry) | Sí — el Registry no se modifica en esta actividad |
| 15 | CAP-001, CAP-002, CAP-005 como candidatas a Common Core | `registry/INDEX.md` ya las señala como más maduras (3+ repos, uso real) | Benchmark §12 | **REQUIRES VALIDATION** | Presencia en 3+ repos no promueve automáticamente (Principio #13) — requiere pasar el Assessment Gate | Medio | Sí — vía `assessment-gate.md`, no acá |
| 16 | Agents por rol (`architect`, `product-owner`, etc.) | Ya evaluados y descartados del Registry en G5.1 | Benchmark §14 reconfirma sin evidencia nueva | **TEAM-SPECIFIC** | Contenido no portable entre equipos — sin cambios respecto a G5.1 | Ninguno | No |

## 6. Context Acquisition & Resolution

**¿El modelo actual lo soporta suficientemente?** No. Ni `reference-architecture.md`
(5 capas) ni `capability-model.md` (7 capacidades) nombran "Context Acquisition" como
concepto propio — vive implícito dentro del paso "Preparar contexto" de
`execution-model.md` (paso 4), sin más estructura que una instrucción operativa.

**Qué falta**: un concepto transversal, análogo a Evaluation/Observability/Metrics
(`capability-model.md`, sección Cross-Cutting Concerns) — es decir, algo que **no se
elige** para resolver un caso de uso de negocio, sino que **opera antes** de cualquier
capability, resolviendo de dónde viene el input.

**Evidencia del benchmark que lo justifica**:
- El mecanismo real y predominante hoy es copy/paste manual (Direct Context de facto, sin
  formalizar) — benchmark §6.
- 2 MCP reales configurados (DataAgro→Azure DevOps, Orquestador→Atlassian) representan la
  *intención* de Connected Context — **cero evidencia de invocación real** (CONFIGURED ≠
  USED, sin excepción).
- Ningún repo demuestra resolver automáticamente una referencia tipo `MOA-1234` hacia
  contexto completo.
- `user-story` (CAP-002) ya corre hoy con contexto 100% manual en 3 repos — **prueba en la
  práctica que el Modelo A (manual) ya funciona sin ninguna integración**, validando que
  la capability y el mecanismo de adquisición de contexto son, en efecto, independientes.

**Cómo debe representarse arquitectónicamente (PROPOSAL, no implementado)**: como un
**Cross-Cutting Concern nuevo**, del mismo tipo que Evaluation/Observability/Metrics —
"Context Acquisition & Resolution" **no es una capability de negocio** (no se elige entre
Context Acquisition y Skill), es un mecanismo que opera **antes** de cualquier capability,
produciendo un "Resolved Context" con un contrato propio (análogo al Evidence Contract:
campos como `source_type` [`direct`/`connected`], `source_system`, `identifier`,
`resolved_at`, `content_reference`).

**¿Debe ser Common Core?** PROPOSAL: sí, como **concepto y contrato** (el schema de
"Resolved Context", el vocabulario Direct/Connected) — **no** como implementación técnica.
Es exactamente la misma lógica ya aplicada a Evaluation/Observability
(`evaluation-observability.md` §0): el Common Core define el contrato, la ejecución puede
seguir siendo local/manual.

**Qué NO debe implementarse todavía**: ningún Context Provider técnico, ningún MCP, ningún
mecanismo de resolución automática de `MOA-1234`. La regla explícita de esta actividad
("no crear Context Providers") es consistente con la propia evidencia: no hay ninguna
instancia real que un Context Provider pudiera generalizar todavía — cualquier
implementación hoy sería anticipación sin evidencia, contra el principio rector de
`assessment-gate.md`.

## 7. Capability vs Integration

Esta separación **ya existe y es correcta** en `capability-model.md` (Integration/API y
MCP son 2 de las 7 capacidades, distintas de Skill/Agent/Workflow) — **DO NOT CHANGE**.

**Cómo debería reflejarse en cada documento** (recomendación, no ejecutada en esta
actividad):

| Documento | Estado actual | Recomendación |
|---|---|---|
| `capability-model.md` | Ya separa correctamente Capability de Integration/MCP | DO NOT CHANGE |
| `reference-architecture.md` | No diagrama explícitamente la relación Capability↔Integration como opcional/desacoplada | GAP menor — agregar una nota explícita en la capa Team Adaptation de que las integraciones son opcionales y no redefinen la capability |
| `capability-registry.md` | El campo `Type` ya distingue Integration/API y MCP como tipos propios, pero no hay campo para "qué capabilities consumen qué integración" | GAP — ver Decisión #10 |
| `golden-paths/README.md` | No declara explícitamente qué parte de un Golden Path es capability vs. qué parte es fuente de contexto/integración | GAP menor, documental |
| `adoption/execution-model.md` | Paso 4 ("Preparar contexto") ya es agnóstico de proveedor — no asume Jira/ADO | DO NOT CHANGE — ya soporta Modelo A/B |

**Ejemplo correcto ya validado en la práctica** (benchmark §12): `user-story` (CAP-002)
funciona hoy sin integración — es la prueba de que "Capability + Context Provider" (cuando
exista el segundo) no requeriría fusionar ambos en una sola capability por sistema origen
(el antipatrón `user-story-jira` que el encuadre de esta actividad pide evitar).

## 8. READ vs ACT

**Estado actual**: no existe como frontera de contrato propia. El factor más cercano es
"Read/write" dentro del modelo de riesgo proporcional de `security-governance.md` §1 — es
**un factor entre once**, no una frontera arquitectónica con su propio contrato.

**Evidencia del benchmark**: toda integración real y en uso hoy (CLI de Azure DevOps,
conectores de `moa-metrics`) es o bien puramente READ, o ACT ya gobernado por un mecanismo
humano nativo preexistente (flujo de PR estándar). **El único ACT sin ese gobierno nativo**
es exactamente el hallazgo de mayor riesgo del benchmark: el scope MCP wildcard en agents
`product-owner` (Blocked Decision #4) — que declara acceso de escritura sin ningún HITL
explícito.

**Análisis pedido**:

| Dimensión | Estado en READ | Estado en ACT |
|---|---|---|
| Permisos | Alcance acotado, de bajo impacto por diseño | Requiere alcance mínimo explícito — el wildcard es el antipatrón encontrado |
| Least privilege | Ya se cumple en el patrón `architect` (scope acotado a `getJiraIssue`) | No se cumple en el patrón `product-owner` (`/*`) |
| Autorización | No crítica si el dato no es sensible | Crítica — sin evidencia de identidad/autenticación en ningún MCP relevado |
| Riesgo | Bajo por naturaleza (no modifica estado externo) | Alto por naturaleza (modifica estado externo) — el modelo de riesgo proporcional ya lo captura como factor, no como frontera |
| Audit | Deseable | **Obligatorio** — ninguno de los MCP relevados tiene auditoría confirmada |
| Evidence | Útil | Igual que Evaluation Contract — debería requerir `evidence_reference` sin excepción |
| HITL | Opcional según sensibilidad del dato | **Obligatorio por default**, salvo excepción justificada y auditada |
| Failure handling | Reintentar es de bajo riesgo | Requiere estrategia explícita — un ACT fallido a medias puede dejar estado externo inconsistente |
| Excessive agency | Riesgo bajo (no puede "hacer de más", solo leer de más) | Riesgo real — el wildcard es exactamente excessive agency sin mitigar |
| Prompt injection | Riesgo de fuga de información si el contenido leído se reinyecta sin sanitizar | Riesgo mayor — un ACT ejecutado a partir de contenido externo no confiable (ej. un comentario de Jira) podría ser manipulado |
| Reversibilidad | Siempre reversible (leer no cambia nada) | No siempre reversible (crear/actualizar/transicionar puede no tener rollback) |

**¿Deben tener contratos diferentes?** PROPOSAL: sí. READ puede seguir el patrón de
Evaluation actual (`method: automated` aceptable para señales de bajo riesgo). ACT debería
heredar la misma regla dura ya vigente para Evaluation de alto impacto
(`evidence-evaluation-measurement.md` §2: *"HITL es obligatorio cuando el resultado puede
habilitar una promoción real o cualquier acción con impacto en producción"*) — **extender
esa misma regla, ya existente, a cualquier ACT, no crear una regla nueva desde cero.**

**Qué NO se implementa acá**: ninguna acción real, ningún control técnico, ningún scope de
MCP. Esto es evaluación conceptual únicamente.

## 9. Evaluation & Observability

El patrón evaluado (`Execution → Evidence → [Evaluation, Measurement] → Feedback`, con
Observability transversal) **ya está completamente definido y es correcto** en
`evidence-evaluation-measurement.md` y `evaluation-observability.md` — coincide con el
fork exacto (Evaluation y Measurement como consumidores independientes de la misma
Evidence, no secuenciales). **DO NOT CHANGE.**

- **Qué debe ser Common Core**: los 3 contratos (Evidence, Evaluation, Measurement) y el
  modelo de ejecución local/común (`evaluation-observability.md` §0) — ya lo son.
- **Qué debe ser Team Adaptation**: la ejecución real de Evaluation/Observability — ya
  está definido así (no se centraliza).
- **Qué debe registrarse**: ya cubierto por `capability-registry.md`
  (`Evaluation Status`, `Observability Status`, `Metrics`).
- **Qué debe evaluarse / observarse**: sin cambios respecto a lo ya definido.
- **Único ajuste sugerido** (`ADOPT WITH MODIFICATION`, bajo impacto): reorganizar las
  señales ya listadas en `evaluation-observability.md` §2 (Execution, Tool calls, Errors,
  Latency, Model, Token/cost, State transitions, Traceability) bajo las 6 categorías del
  patrón evaluado (Context, Model, Agent, Tool, MCP, Action) — es un refinamiento de
  presentación, no un cambio de contenido ni de contrato.
- **Requiere validación**: nada nuevo — las brechas (Evaluation/Observability NOT FOUND en
  los 6 repos) ya estaban señaladas y siguen sin resolverse; esta actividad no inventa
  métricas ni resultados nuevos.

## 10. Conversational AI / Copilot Studio

**Análisis conceptual** (no se agrega una 8va capacidad, por instrucción explícita):

| Opción | ¿Encaja? | Por qué |
|---|---|---|
| Capability | No, completamente | Las 7 capacidades modelan herramientas para *construir* software; Copilot Studio es un producto que *responde al usuario final* |
| Channel/Interface | **Sí, parcialmente** | Es la superficie de entrega (embebido en la app, gateado por permiso) — un concepto de "por dónde llega la interacción" que hoy no existe en el modelo |
| Application | Sí, en el sentido de que es un producto con lógica propia, no un artefacto reusable | Pero "Application" ya es MoaOperaciones mismo (el Team Layer), no una capa nueva |
| Orchestration layer | No hay evidencia de orquestación multi-agent detrás de "Mola" | Sin evidencia — no se puede afirmar |
| **Combinación de capability + integration + interface** | **Es la lectura más precisa** | El chatbot es un **Channel** (Copilot Studio) que expone alguna lógica de respuesta (potencialmente una Capability, no confirmada) y puede consumir integraciones — pero el benchmark no tiene evidencia de qué hay "detrás" de la interfaz, solo que la interfaz existe y está en producción |

**Recomendación arquitectónica (PROPOSAL, no implementación)**: introducir **Channel /
Interface** como un concepto arquitectónico nuevo, **distinto de Capability**, que
representa la superficie por la cual un resultado llega a un usuario final (chat embebido,
CLI, IDE, etc.) — sin agregarlo como una 8va capacidad seleccionable. Copilot Studio sería
la primera instancia real de este concepto, no un caso especial.

**Qué NO se decide acá**: si "Mola" está dentro del alcance de gobierno de Track 1 — eso
es una decisión de gobierno (a quién le reporta, quién lo audita), no una decisión
arquitectónica, y queda **REQUIRES VALIDATION** (benchmark §16, gap 4).

## 11. Capability Taxonomy

**Determinación**: la taxonomía de 7 capacidades (Instruction, Skill, Workflow, Agent,
Knowledge/RAG, Integration/API, MCP) **debe mantenerse sin cambios** — `DO NOT CHANGE`.
Ningún hallazgo del benchmark exige redefinir ninguna de las 7, y las reglas de
desambiguación ya existentes siguen siendo suficientes:

- **Skill ≠ prompt**: ya guardado explícitamente en `capability-model.md` ("un checklist
  genérico sin contenido específico accionable" no cumple el estándar) — sin
  contraejemplos en el benchmark.
- **Skill vs. Agent**: ya diferenciado por "referencia estática cargada on-demand" vs.
  "razonamiento dinámico + selección de herramientas" — el benchmark confirma esta
  distinción en los 3 repos ricos, sin ambigüedad nueva.
- **Tool vs. Integration**: ya diferenciado (MCP = descubrimiento dinámico gobernado;
  Integration/API = conector de propósito específico) — el hallazgo de `moa-metrics` (5
  conectores Python directos, sin MCP) y los 2 MCP reales confirman que ambos patrones
  coexisten sin conflicto conceptual.
- **Workflow vs. Agent**: ya resuelto en G3.3 Corrections con el criterio de
  "secuencia fija conocida de antemano" (Workflow) vs. "el sistema decide dinámicamente"
  (Agent) — el benchmark no encontró ningún caso ambiguo nuevo.
- **Context vs. Capability**: **esta es la única separación que el modelo todavía no
  hace explícitamente** — ver Decisión #1/sección 6. No es una falla de la taxonomía de
  las 7 capacidades, es una capa que falta *antes* de ellas.

## 12. Knowledge / RAG

**Patrón evaluado**: `Source of Truth → Knowledge Access → Context → Capability`.

| Elemento | Evidencia real (benchmark) |
|---|---|
| Fuente documental | Azure DevOps Wiki (submodule `docs/wiki`) — poblada en Orquestador, vacía en Scato Logística. Confluence: sin conector ni evidencia técnica (Blocked #8). SharePoint: conector existe en `moa-metrics` pero marcado "opcional, solo enriquecimiento" |
| Mecanismo de acceso | Git submodule (mirror pasivo de archivos) — **no** es un mecanismo de acceso activo/consultable |
| Recuperación | **NOT FOUND** — ningún repo tiene indexación ni búsqueda semántica |
| Contexto (resultado) | Mismo concepto que "Resolved Context" de la Decisión #1 — no hay una instancia separada |
| Conocimiento persistente | **NOT FOUND** como base indexada — solo archivos estáticos |
| RAG | **NOT FOUND**, sin excepción, en los 6 repos |

**Determinación**: el modelo base **no necesita implementar RAG** todavía (sin evidencia
que lo justifique) — pero sí debe **corregir la precisión de su propia afirmación**: el
estado real ya no es "NOT FOUND en la evidencia revisada" (como dice hoy
`capability-model.md`), es más preciso decir **"CONFIGURADO (submodule), PARCIALMENTE
POBLADO (1 de 2 casos), SIN CONSUMO CONFIRMADO por ningún agent"** — clasificación
`ADOPT WITH MODIFICATION` para el texto del modelo, no para una implementación.

**No se implementa RAG** en esta actividad ni se recomienda hacerlo — es exactamente la
instrucción explícita del encuadre.

## 13. Automation & Autonomy

**Patrón evaluado**: ASSIST / AUGMENT / AUTOMATE.

**Evidencia real**:
- `Generate-WfDocs.ps1` (Scato Logística) — llama a la API de Copilot Chat y escribe el
  resultado directo a archivo, **sin HITL declarado antes del commit** → patrón AUTOMATE,
  hoy sin gobierno.
- `Human Review operativo` (paso 7 de `execution-model.md`) — un humano decide si el
  resultado sigue adelante → patrón AUGMENT, ya modelado (aunque no con este nombre).
- `user-story` (CAP-002) en los 2 dry-runs registrados — el humano usa el output como
  insumo, no como acción final → AUGMENT.
- Ningún caso real de ASSIST puro (sugerencia sin ninguna acción posterior) fue
  identificado como capability distinta — está implícito en cualquier interacción de chat.

**Riesgo de duplicación (a reportar, no resolver)**: el concepto ASSIST/AUGMENT/AUTOMATE
se superpone fuertemente con el campo `Autonomy` (ALWAYS/ASK FIRST/NEVER) ya definido en
`capability-registry.md` y `governance/agent-governance.md`. **No está claro si son el
mismo concepto con nombres distintos, o dos ejes diferentes** (uno sobre "cuánto decide la
IA sola" y otro sobre "qué tan automatizado está el flujo completo"). Clasificación:
`REQUIRES VALIDATION` — introducir ASSIST/AUGMENT/AUTOMATE sin reconciliar con `Autonomy`
arriesga una taxonomía duplicada, contra el principio de no crear categorías redundantes.

**Recomendación (PROPOSAL, sin implementar)**: antes de adoptar ASSIST/AUGMENT/AUTOMATE
como dimensión nueva, el Arquitecto Supervisor debería decidir si reemplaza, se mapea 1:1,
o coexiste explícitamente con `Autonomy`.

## 14. Common Core Evolution

Revisión de los 10 componentes (`operating-model.md`) contra la evidencia del benchmark:

| Componente | Decisión | Razón |
|---|---|---|
| Standards | **DO NOT CHANGE** | La taxonomía de 7 capacidades sigue siendo válida |
| Reusable Capabilities | **DEJAR COMO CANDIDATO** (CAP-001, CAP-002, CAP-005) | 3+ repos con uso real — no promovidas automáticamente (Principio #13), requieren Assessment Gate |
| Golden Paths | **DO NOT CHANGE** (estructura) | Mejora menor recomendada (Decisión #2), no urgente |
| Governance | **DO NOT CHANGE** (pipeline TRIGGER→CONTEXT→DECISION→ACTION→VALIDATION→AUDIT) | Sigue vigente; se sugiere una extensión futura de READ/ACT (Decisión #3), no un reemplazo |
| Security | **DO NOT CHANGE** (modelo de riesgo proporcional) | Sigue vigente; el factor Read/write ya existe, solo se sugiere que gane peso explícito |
| Evaluation | **DO NOT CHANGE** | Contrato ya correcto (sección 9) |
| Observability | **ADOPT WITH MODIFICATION** (menor) | Reagrupar señales por Context/Model/Agent/Tool/MCP/Action |
| Metrics | **DO NOT CHANGE** | `moa-metrics` sigue en STRONG CANDIDATE, sin cambios de estado |
| Registry | **GAP** (campos) | Ver Decisión #10 — no se modifica en esta actividad |
| Enablement | **DO NOT CHANGE** | El Adoption Kit (`adoption/`) ya evolucionó en la fase anterior de esta misma sesión — consistente con lo evaluado acá |

**Nada se elimina** — no se encontró evidencia de contradicción o duplicación que
justifique eliminar contenido existente (regla explícita del encuadre).

## 15. Registry Evolution

**Recomendación únicamente — el Registry no se modifica en esta actividad.**

Contraste entre lo que `capability-registry.md` ya representa y lo que esta evaluación
pide considerar:

| Dimensión pedida | ¿Ya existe en `capability-registry.md`? | Recomendación |
|---|---|---|
| Autonomy level | Sí (`Autonomy`) | DO NOT CHANGE |
| Risk | Sí (`Risk`) | DO NOT CHANGE |
| Observability | Sí (`Observability Status`) | DO NOT CHANGE |
| Evaluation | Sí (`Evaluation Status`) | DO NOT CHANGE |
| Ownership | Sí (`Owner`, `Maintainer`) | DO NOT CHANGE |
| Maturity | Sí (`Lifecycle State`, `Configuration Status`, `Real Use Status`) | DO NOT CHANGE |
| Approval requirement | Parcial (`HITL` existe, pero no un flag explícito "aprobación requerida: Y/N") | GAP menor |
| **Context providers** | No | **GAP** — campo nuevo candidato: `Context Source(s)` (Direct/Connected + sistema) |
| **Integrations** (como dependencia estructurada, no solo `Tools` genérico) | Parcial (`Tools` es texto libre) | **GAP** — campo nuevo candidato: `Integration Dependencies`, con Read/Act por dependencia |
| **Interfaces/channels** | No | **GAP** — campo nuevo candidato: `Channel/Interface` (ligado a la Decisión #5) |
| **Actions** (Read/Act explícito, no derivado de `Risk`) | No | **GAP** — campo nuevo candidato: `Action Type` (`read` / `act` / `both`) |

**4 campos candidatos identificados, ninguno implementado**: `Context Source(s)`,
`Integration Dependencies` (con Read/Act por entrada), `Channel/Interface`, `Action Type`.
Quedan como propuesta para una evolución futura del Registry, sujeta a aprobación.

## 16. Target Model Implications

El Target Model preliminar evaluado (Request → Context Acquisition → Direct/Connected
Context → Resolved Context → Capability → Skill/Workflow/Agent → Tools/APIs/MCP → Result →
Human Review/Approval → READ/ACT → Evidence → Evaluation/Measurement → Feedback →
Improvement, con Observability transversal) es **conceptualmente consistente** con el
modelo actual, con 3 ajustes necesarios:

1. **El tramo Request → Resolved Context** requiere el concepto nuevo de la Decisión #1
   — hoy no representado.
2. **El tramo Result → Human Review → READ/ACT** requiere el concepto nuevo de la
   Decisión #3 — hoy disuelto en `Risk`.
3. **El tramo Evidence → Evaluation/Measurement → Feedback** **ya existe tal cual** — es
   el único tramo del diagrama objetivo que no requiere ningún cambio.

**No se adopta este diagrama "tal cual"** (instrucción explícita del encuadre) — se usa
solo para confirmar qué partes del modelo actual ya lo soportan y cuáles no.

## 17. What Must NOT Change

- La taxonomía de 7 capacidades (`capability-model.md`).
- El modelo de Evidence/Evaluation/Measurement (`evidence-evaluation-measurement.md`).
- El modelo de ejecución local/común de Evaluation/Observability (`evaluation-observability.md` §0).
- Los 5 layers de `reference-architecture.md`.
- Los 10 componentes del Common Core (`operating-model.md`) como estructura.
- CAP-002 (`user-story`) — no tocado, por instrucción explícita.
- El Registry (`capability-registry.md`, `registry/INDEX.md`) — no tocado, por instrucción
  explícita.
- Ninguna Blocked Decision fue resuelta ni se avanzó en su resolución.

## 18. Gaps

Consolidado de esta actividad (no duplica el benchmark, referencia donde corresponde):

1. Context Acquisition & Resolution — sin representación arquitectónica (Decisión #1).
2. READ vs. ACT — sin contrato propio, disuelto en `Risk` (Decisión #3).
3. Copilot Studio / Channel-Interface — sin concepto que lo represente (Decisión #5).
4. Registry — sin campos para context sources, integration dependencies, channel,
   action type (Decisión #10).
5. Estado de Knowledge/RAG en `capability-model.md` — impreciso ("NOT FOUND" debería ser
   "CONFIGURED, parcialmente poblado, sin consumo") (Decisión #7).
6. Automation ASSIST/AUGMENT/AUTOMATE — riesgo de duplicar `Autonomy` si se introduce sin
   reconciliar (Decisión #8).

## 19. Risks

1. **Introducir ASSIST/AUGMENT/AUTOMATE sin reconciliar con `Autonomy`** generaría una
   taxonomía duplicada — riesgo de esta evolución, no del estado actual.
2. **Promover CAP-001/002/005 solo por aparecer en 3+ repos**, sin pasar el Assessment
   Gate — ya advertido por el propio modelo (Principio #13), se reitera acá porque el
   benchmark aumenta la tentación de hacerlo.
3. **Tratar el diagrama Target Model preliminar como ya aprobado** — el encuadre es
   explícito en que es solo objeto de evaluación; usarlo como si ya fuera arquitectura
   final sería un riesgo de gobierno, no técnico.
4. Los riesgos de seguridad ya identificados en el benchmark (MCP wildcard, credenciales
   en texto plano, bypass SSL) **siguen sin resolver** — esta actividad no los resuelve,
   solo confirma que el gap de READ/ACT es la causa raíz arquitectónica del más relevante
   de ellos.

## 20. REQUIRES VALIDATION

1. ¿Una sola taxonomía de clasificación (`ADOPT/ADAPT/...` vs. la de esta actividad) para
   todo el repo, o ambas coexisten con propósitos distintos? (sección 4).
2. ¿Cómo debe representarse formalmente Context Acquisition & Resolution — como
   Cross-Cutting Concern nuevo, o de otra forma? (Decisión #1).
3. ¿Copilot Studio/"Mola" está dentro del alcance de gobierno de Track 1? (Decisión #5,
   ya señalado en el benchmark §16/§20).
4. ¿ASSIST/AUGMENT/AUTOMATE reemplaza, se mapea 1:1, o coexiste con `Autonomy`? (Decisión
   #8).
5. ¿Quién aprueba formalmente estas evoluciones? — sigue condicionado por Blocked
   Decision #1, no resuelta acá.
6. Todas las REQUIRES VALIDATION ya listadas en el benchmark
   (`../evidence/current-moa-ai-practices-benchmark.md`, sección 20) siguen vigentes sin
   cambios.

## 21. Recommended Next Implementation Step

**Una sola recomendación, no una lista de tareas** (para no invitar a implementar de más):
llevar la Decisión #1 (Context Acquisition & Resolution) al Assessment Gate como
**Use Case** formal (`lifecycle.md`, primer estado del Capability Lifecycle) — es el gap
de mayor impacto encontrado, el único que bloquea que el modelo soporte explícitamente
Modelo A y Modelo B sin duplicar capabilities por sistema origen. Las demás decisiones
(READ/ACT, Copilot Studio, Registry) pueden esperar a que esta primera se resuelva, porque
varias dependen conceptualmente de ella (el campo `Context Source(s)` del Registry, por
ejemplo, no tiene sentido definirlo antes de que exista el concepto que representa).

## 22. Traceability to Benchmark

| Sección de este documento | Sección del benchmark que la origina |
|---|---|
| Decisión #1 (Context Acquisition) | Benchmark §6, §16 (gap 1, 7), §18 |
| Decisión #2 (Capability vs Integration) | Benchmark §18 |
| Decisión #3 (READ vs ACT) | Benchmark §7, §16 (gap 6), §17 |
| Decisión #4 (Evaluation/Observability) | Benchmark §9 |
| Decisión #5 (Copilot Studio) | Benchmark §16 (gap 4), §4 (fila Copilot Studio) |
| Decisión #6 (Taxonomía) | Benchmark §11 |
| Decisión #7 (Knowledge/RAG) | Benchmark §16 (gap 5) |
| Decisión #8 (Automation/Autonomy) | Benchmark §4 (fila `xamlx-documenter`), §7 |
| Decisión #9 (Common Core) | Benchmark §12, §13, §14 |
| Decisión #10 (Registry) | Benchmark §14, §20 |
