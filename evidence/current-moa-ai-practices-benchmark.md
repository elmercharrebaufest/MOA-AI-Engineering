# Current MOA AI Practices — Benchmark

**Rol de este documento**: entrada de evidencia para decisión arquitectónica del
Arquitecto Supervisor. **No es una propuesta final de arquitectura**, no redefine
`capability-model.md`, no modifica CAP-002, no implementa MCP, no crea integraciones ni
capacidades nuevas. Toda inspección de repos de equipo fue **READ-ONLY**.

**Fecha**: 2026-09-08 (misma sesión que el relevamiento fuente). **Ejecutor**: agente
investigador interno, bajo supervisión del Arquitecto.

## 0. Fuentes de evidencia usadas

Este benchmark **no repite desde cero** una inspección ya hecha — consolida y reconcilia
dos cuerpos de evidencia ya generados, citando siempre el origen concreto:

1. **Evidencia ya embebida en `MOA-AI-Engineering`** (fases G2 a G5.1, preservadas en
   [`../architecture/capability-model.md`](../architecture/capability-model.md),
   [`../registry/INDEX.md`](../registry/INDEX.md),
   [`../integrations/catalog.md`](../integrations/catalog.md),
   [`../security/security-governance.md`](../security/security-governance.md),
   [`../governance/BLOCKED-DECISIONS.md`](../governance/BLOCKED-DECISIONS.md)).
2. **Relevamiento fresco 2026-09-08**, ejecutado en la misma sesión, en un directorio de
   trabajo temporal **fuera de este repo** (`_ai-engineering-research/`, en
   `D:\PROYECTOS\MOLINOS\Aplicaciones\`, no versionado, no distribuido) — cruzó git local
   con evidencia autoritativa real de Azure DevOps (`az repos pr list --status all`,
   `az pipelines runs list`) para 5 repos, y confirmó/amplió varios hallazgos previos.
   Documentos citados: `repository-inventory.md`, `branch-analysis.md`,
   `ai-capability-inventory.md`, `integration-inventory.md`, `mcp-analysis.md`,
   `context-acquisition-analysis.md`, `architect-handoff.md`.

Donde ambas fuentes coinciden, se cita la más reciente. Donde solo una lo cubre, se marca
el origen explícitamente. Ningún hallazgo de este documento es nuevo respecto a esas dos
fuentes — es **síntesis y reclasificación** con el formato pedido para esta actividad.

---

## 1. Executive Summary

- **3 de 6 repos** analizados tienen capacidades de IA formalizadas y reales: **DataAgro**,
  **Scato Logística**, **Orquestador** — solo en su branch realmente vigente, no
  necesariamente el default de Azure DevOps. **3 no tienen ninguna**: **MoaOperaciones**,
  **ScatoPuerto**, y — como herramienta de referencia de Baufest, no equipo de MOA —
  **moa-sdlc** aporta un patrón de Workflow formal (`_sdd/` harness) sin evidencia de
  capacidades de tipo Agent/Skill propias.
- El mecanismo de adquisición de contexto **predominante y real hoy es copy/paste manual**
  a un chat. Existen 2 configuraciones reales de MCP (DataAgro→Azure DevOps,
  Orquestador→Atlassian) que representan la *intención* de automatizar esto — **ninguna
  tiene evidencia de haber sido invocada**.
- **CONFIGURED ≠ USED se cumple en el 100% de los MCP encontrados**: cero evidencia de
  ejecución real en ningún MCP relevado, en ningún repo.
- Un **patrón de riesgo de seguridad se repite de forma independiente en 2 proyectos**:
  agents `architect` acotan el scope de MCP a un método (`getJiraIssue`), agents
  `product-owner` piden wildcard (`atlassian-mcp-server/*`) — ya era Blocked Decision #4,
  este benchmark lo reconfirma como patrón replicado, no caso aislado.
- **3 capacidades ya registradas (CAP-001, CAP-002, CAP-005) tienen presencia en 3+ repos**
  con evidencia real — son las candidatas más sólidas a evaluación formal para Common Core,
  sin que este documento decida su promoción.
- **Ningún equipo relevado practica Evaluation u Observability formal** de sus propias
  capacidades de IA — brecha fundacional ya señalada en G3.1/G3.3, reconfirmada sin
  excepción en los 6 repos de este benchmark.
- Se encontró una **clase de capacidad nueva, fuera de la taxonomía actual**: un chatbot de
  producción real construido en **Microsoft Copilot Studio** (MoaOperaciones) — no encaja
  en ninguna de las 7 capacidades de `capability-model.md` (todas modelan herramientas para
  construir software, no productos de IA embebidos en la aplicación misma).
- El **patrón arquitectónico objetivo** (Context Acquisition → Direct/Connected Context →
  Capability → Agent/Model → Result → Human Review → Evidence → Evaluation/Measurement →
  Feedback) **ya existe como diseño conceptual dentro de `MOA-AI-Engineering` mismo**
  ([`../architecture/evidence-evaluation-measurement.md`](../architecture/evidence-evaluation-measurement.md)
  — el fork Evidence→Evaluation/Measurement es idéntico), pero **ningún equipo de MOA lo
  practica hoy de punta a punta** — es un modelo propio de esta iniciativa, todavía sin
  validar contra una ejecución real de un equipo externo. Ver sección 18.

## 2. Scope and Methodology

**Repos analizados** (mínimo pedido, los 6): DataAgro, Scato Logística, Orquestador,
MoaOperaciones, ScatoPuerto, moa-sdlc. **Repo de referencia**: MOA-AI-Engineering (para
terminología, taxonomía y estado previo — no se re-audita a sí mismo).

**Método**: lectura directa de archivos reales sobre el branch confirmado como vigente
(nunca el default de Azure DevOps sin verificar — ver sección 3), cruzado con evidencia
autoritativa de Azure DevOps vía `az` CLI donde estuvo disponible. **READ-ONLY estricto**:
ningún repo de equipo fue modificado, ni checked-out destructivamente, ni se hizo
merge/cherry-pick. Ningún secreto encontrado fue extraído — solo se registra su existencia
y ruta (regla ya vigente desde G5.1, ver sección 10).

**Clasificación aplicada a cada hallazgo — dos ejes independientes**:
- **Nivel de evidencia**: `FACT` (evidencia directa) / `INFERENCE` (conclusión razonable,
  no declarada explícitamente) / `PROPOSAL` (recomendación arquitectónica) /
  `REQUIRES VALIDATION` (no demostrable desde el repo).
- **Clasificación arquitectónica**: `A` COMMON CORE CANDIDATE / `B` REUSABLE PATTERN /
  `C` TEAM-SPECIFIC / `D` EXPERIMENTAL / `E` GAP / `F` RISK.

**Regla aplicada sin excepción**: `CONFIGURED ≠ USED`, `USED ≠ MATURE`,
`MATURE ≠ MEASURED`, `MEASURED ≠ PROVEN`. Ninguna métrica fue inventada — donde no existe
medición real, el campo dice `NOT MEASURED`, nunca `0`.

## 3. Repository Coverage

| Repo | Branch analizado | Confidence | Default ADO = vigente | Capacidades de IA | Fuente |
|---|---|---|---|---|---|
| DataAgro | `dev` | HIGH | Sí | 5 agents, 13 skills, 4+2 instructions, 3 prompts, 1 Workflow (`_sdd/` Lite) | `branch-analysis.md`, `ai-capability-inventory.md` |
| Scato Logística | `master` (+`develop`/`feature/cardless4` igualmente activas) | HIGH | Sí | 11 agents, 13 skills, 15 instructions, model-routing config | ídem |
| Orquestador | `master-logistica`→`feature/cardless4` | HIGH | **No** — default `master` desactualizado 4 meses | 4 agents, 6 skills, 8 instructions, 1 MCP real | ídem |
| MoaOperaciones | `master` (+`QaHuenei` con más actividad real) | HIGH | Sí (con matiz) | 0 capacidades AI Engineering; 1 producto conversacional (Copilot Studio) | ídem |
| ScatoPuerto | `master` | HIGH | Sí | 0 | ídem |
| moa-sdlc | `main` | HIGH | Sí | 0 agents/skills propios; 1 Workflow formal (harness 6 roles) — herramienta de referencia de Baufest, no equipo de MOA | ídem |

**Nota de gobierno, crítica para cualquier automatización futura**: en 2 de los 6 repos
(Orquestador, y `WebApiCoreAfip` fuera del alcance mínimo pero relevado en la fuente) el
branch configurado como default en Azure DevOps **no** es el branch realmente usado,
confirmado con PRs/pipelines reales, no solo por nombre. Ver `branch-analysis.md`.

## 4. Consolidated Capability Matrix

| Practice | Repository | Evidence | Classification | Maturity | Reusable | Risk | Improvement | Common Core Candidate |
|---|---|---|---|---|---|---|---|---|
| `azure-devops-cli` (Skill) | Scato Logística, Orquestador | CAP-001, `registry/entries/azure-devops-cli.md` | FACT | VERIFIED config / EXECUTED (commits reales) | Sí | Bajo | Reconciliar 2 versiones casi idénticas | A |
| `user-story` (Skill) | DataAgro, Scato Logística, Orquestador | CAP-002, `evidence/EXEC-*` (2 dry-runs) | FACT | VERIFIED (2/3) · PARTIAL (DataAgro) | Sí | Bajo | Adaptar contenido por dominio (no se modifica en esta actividad) | A |
| `.NET Code Reviewer` (Agent) | Orquestador, Scato Logística | CAP-003, `registry/entries/dotnet-code-reviewer.md` | FACT | CONFIGURED (patrón de diseño) | Sí (el diseño, no el contenido) | Bajo por diseño (`tools` sin `edit`) | Adaptar reglas a otro stack si se generaliza | B |
| `spec-driven-development` Lite (Workflow) | DataAgro (`_sdd/`) | CAP-004 | FACT | EXECUTED (MOA-1765, MOA-1816) | Parcial | Bajo | Requiere sistema de tickets real para adoptarse | B |
| `spec-driven-development` Full (Workflow) | moa-sdlc | CAP-004 | FACT (config) / REQUIRES VALIDATION (ejecución) | CONFIGURED, NOT FOUND ejecución independiente | No todavía | Medio (complejidad de mantener contratos JSON) | Decisión explícita antes de invertir | D |
| `repository-governance` (Instruction, ALWAYS/ASK FIRST/NEVER) | DataAgro, Scato Logística, Orquestador, moa-sdlc | CAP-005 | FACT | VERIFIED (4 instancias independientes) | Sí (estructura) | Bajo | Contenido de cada columna requiere completarse por equipo, no copiarse | A |
| `stack-best-practices-template` (Skill) | Scato Logística, Orquestador | CAP-006 | FACT | CONFIGURED (plantilla, sin contenido) | Sí (estructura) | Bajo | Requiere que cada equipo la complete | B |
| Model-routing / cost-tiering config | Scato Logística | `ai-capability-inventory.md` | FACT | CONFIGURED, instancia única | No todavía (1 solo repo) | Bajo | Validar en más equipos antes de generalizar | D |
| `Validate-CopilotConfig.ps1` (validador de config de IA) | Scato Logística | `architect-handoff.md` §B.3 | FACT | EXECUTED (script real y funcional) | Candidato fuerte | Bajo | Sin equivalente en otros repos — evaluar como capacidad de Observability-de-config | B |
| `docs/wiki` submodule (Knowledge/RAG) | Orquestador (poblado), Scato Logística (vacío) | `integration-inventory.md` | FACT | CONFIGURED, 1/2 poblado, sin consumo confirmado por ningún agent | Parcial | Medio (sin gobierno de contenido) | Confirmar consumo real antes de tratarlo como RAG funcional | E |
| Agents por rol (`architect`, `product-owner`, `qa-tester`, `release-manager`, `dba-migraciones`, etc.) | DataAgro, Scato Logística, Orquestador | `registry/INDEX.md` (ya evaluados y descartados en G5.1) | FACT | CONFIGURED | No (contenido no portable) | Bajo–Alto según scope MCP declarado | Ya excluidos deliberadamente del Registry — mantener así | C |
| `xamlx-documenter` + `Generate-WfDocs.ps1` (llamada directa a Copilot Chat API) | Scato Logística | `integration-inventory.md` | FACT | EXECUTED parcial (1/12 documentos reales, 11 con placeholder de fallo) | No todavía | Bajo–Medio (salida no revisada antes de commit) | Mejorar tasa de éxito antes de generalizar | D |
| Chatbot "Mola" (Microsoft Copilot Studio) | MoaOperaciones | `ai-capability-inventory.md` | FACT | EXECUTED (producción real) | No aplica a taxonomía actual | REQUIRES VALIDATION (gobierno, guardrails) | Determinar si es alcance de Track 1 (Blocked-style) | E |
| MCP Azure DevOps (`ado-remote-mcp`) | DataAgro | `mcp-analysis.md`, `.vscode/mcp.json` | FACT (config) / REQUIRES VALIDATION (uso) | CONFIGURED, sin invocación | No todavía | Medio (scope no declarado) | Gobernar antes de cualquier uso real (sección 10) | E |
| MCP Atlassian — scope acotado (`architect`) | Orquestador, Scato Logística, DataAgro (referencia) | `mcp-analysis.md` | FACT (config) / REQUIRES VALIDATION (uso) | CONFIGURED, sin invocación | Sí (patrón de diseño) | Bajo (por diseño scoped) | Usar como plantilla de scope para cualquier MCP futuro | B |
| MCP Atlassian — wildcard (`product-owner`) | Orquestador, Scato Logística | `mcp-analysis.md`, Blocked Decision #4 | FACT (config) / REQUIRES VALIDATION (uso) | CONFIGURED, sin invocación | No (antipatrón) | **Alto** | Eliminar wildcard; exigir justificación explícita y HITL | F |
| Playwright MCP | Orquestador | `mcp-analysis.md` | FACT | CONFIGURED, sin consumidor declarado | No | Bajo (pero sin dueño) | Confirmar propósito o remover del `mcp.json` | D |

## 5. Integration Matrix

| Source | Integration | Mechanism | READ | ACT | Agent/Capability | Evidence | Status | Recommendation |
|---|---|---|---|---|---|---|---|---|
| DataAgro | Azure DevOps | MCP (`ado-remote-mcp`) | REQUIRES VALIDATION (no declarado en config) | REQUIRES VALIDATION | `release-manager`, `release-notes`, `documentar-funcionalidad-wiki` | `.vscode/mcp.json` + frontmatter | CONFIGURED / NOT INVOKED | No habilitar uso real sin declarar scope explícito |
| DataAgro | Jira | MCP referenciado (sin `mcp.json` local) | Sí (`getJiraIssue`, `searchJiraIssuesUsingJql`) | **Sí** (`addCommentToJiraIssue`) | `qa-tester` agent | frontmatter del agent | REFERENCED / NOT CONFIGURED en repo | Confirmar si hay config a nivel usuario; el ACT declarado (comentar) requiere HITL explícito |
| Orquestador | Jira/Atlassian | MCP real (`.vscode/mcp.json`) | `architect`: `getJiraIssue` (acotado) | `product-owner`: wildcard `/*` (incluye escritura) | `architect`, `product-owner` | mcp.json + frontmatter | CONFIGURED / NOT INVOKED | Eliminar wildcard — ver Blocked #4 |
| Orquestador | Playwright | MCP (`.vscode/mcp.json`) | N/A | N/A | Ninguno declarado | mcp.json | CONFIGURED / NO CONSUMER | Confirmar propósito o remover |
| Scato Logística | Jira/Atlassian | Referenciado (sin `mcp.json` en repo) | `architect`: `getJiraIssue` | `product-owner`: wildcard `/*` | `architect`, `product-owner` | frontmatter | REFERENCED / NOT CONFIGURED en repo | Mismo riesgo repetido — ver Blocked #4 |
| Scato Logística | Azure DevOps | CLI directo (no MCP) | Sí | Sí (merges reales vía flujo de PR) | `devops`, `release-manager` | `Setup-AzureDevOpsCli.ps1` + git log real | EXECUTED | Patrón reusable — ya es CAP-001 |
| Scato Logística | Azure DevOps Wiki | git submodule | N/A (vacío) | N/A | `architect` (target declarado) | `.gitmodules` | CONFIGURED / NOT POPULATED | Confirmar si se va a usar antes de tratarlo como fuente |
| Scato Logística | GitHub Copilot Chat API | `gh copilot` directo vía script | N/A | **Sí** — genera y escribe documentación | `xamlx-documenter` | `Generate-WfDocs.ps1` | EXECUTED PARCIAL (1/12) | Agregar revisión humana antes de generalizar |
| Orquestador | Azure DevOps Wiki | git submodule | N/A | Sí (contenido real poblado) | `architect` | `.gitmodules` + contenido real | EXECUTED | Candidato a Knowledge/RAG matizado, no "NOT FOUND" |
| Orquestador | Azure DevOps | CLI directo | Sí | Sí (vía PR flow real) | `devops` (skill `azure-devops-cli`) | git log/PR reales | EXECUTED | Reusable — CAP-001 |
| MoaOperaciones | Microsoft Copilot Studio | Producto embebido (iframe) | N/A (no es dev-tooling) | N/A | Chatbot "Mola" — usuarios finales, no developers | `app.component.html`, permiso `CHATBOTMOLAVISIBLE` | EXECUTED (producción) | Requiere decisión de alcance — ¿es Track 1? |
| moa-metrics | Jira | REST API directa (conector Python) | Sí | No | `jobs/orchestrator.py` | `connectors/jira.py` + 14 tests | EXECUTED | Reusable, ya reconocido en `integrations/catalog.md` |
| moa-metrics | Azure DevOps Repos | REST API directa | Sí | No | `jobs/orchestrator.py` | `connectors/ado_repos.py` | EXECUTED | Reusable |
| moa-metrics | SonarQube | REST API directa | Sí | No | `jobs/orchestrator.py` | `connectors/sonarqube.py` | EXECUTED / REQUIRES VALIDATION (fuente real instalada — Blocked #7) | Confirmar instalación real antes de reportar como fuente de Quality |
| moa-sdlc | Azure DevOps / Jira | Ninguna real — mención conceptual contradictoria | N/A | N/A | Conceptual únicamente | `AGENTS.md` vs. `README.md`/`specs.md` inconsistentes | NOT FOUND | Resolver inconsistencia interna antes de usarlo como referencia de patrón |

## 6. Context Acquisition Matrix

| Context Source | Retrieval Mechanism | Identifier | Current Usage | Reusable Pattern | Gap |
|---|---|---|---|---|---|
| Usuario (copy/paste manual) | Ninguno — texto pegado directo en el chat | N/A | Predominante en los 3 repos con capacidades reales | Es el "Direct Context" real, sin formalizar | Sin trazabilidad de qué contexto se usó en cada ejecución |
| Jira (ticket) | MCP Atlassian (configurado en Orquestador; referenciado sin config local en DataAgro/Scato Logística) | `PROY-NNNN` (ej. `DAT-1274`) | CONFIGURADO, sin evidencia de invocación real | Sí — candidato a "Connected Context: Jira" | Ningún repo demuestra resolución automática de una referencia tipo `MOA-1234` |
| Azure DevOps Work Item | Referenciado (`release-manager`), en conflicto interno con `qa-tester` del mismo repo (DataAgro) | Work Item ID | Parcial | Sí, pero con conflicto interno no resuelto sobre cuál es "la fuente del ticket" | Inconsistencia Jira-vs-ADO como fuente de verdad, presente en 2 repos distintos (DataAgro, moa-sdlc) |
| Commit / diff (SHA, rango) | `git diff --staged`, `HEAD~1 HEAD` | SHA / rango de commits | Patrón consistente en 3 agents de code review (DataAgro, Scato Logística, Orquestador) | **Sí — el patrón más maduro encontrado**, ya materializado como CAP-003 | Ninguno relevante |
| PR ID (Azure DevOps) | CLI directo / MCP | Número de PR | `release-manager` (DataAgro, Scato Logística) | Parcial | Sin mecanismo común entre repos |
| Azure DevOps Wiki | git submodule | Path/página | Poblado en Orquestador, vacío en Scato Logística | Candidato a Knowledge/RAG matizado | Sin consumo confirmado por ningún agent todavía |
| Ninguna fuente de IA | — | — | MoaOperaciones (dev-tooling), ScatoPuerto, WebApiCoreAfip, PocScatoLogisticaAws, OrquestadorAkka, Intercomunicador | N/A | 8 de 12 repos relevados en la fuente sin ningún mecanismo de contexto de IA |

**Hallazgo central de esta sección (FACT)**: no existe hoy, en ningún repo, ninguna
abstracción común de "Context Provider" — cada equipo resolvió el problema (o no lo
resolvió) de forma completamente independiente. Ninguna evidencia respalda hoy la
resolución automática de una referencia como `MOA-1234` hacia contexto completo.

## 7. Automation / Action Matrix

| Action | System | Mechanism | Existing Evidence | Human Approval | Risk | Recommendation |
|---|---|---|---|---|---|---|
| Comentar en ticket Jira | Jira | MCP tool `addCommentToJiraIssue` (declarado en `qa-tester.agent.md`, DataAgro) | REQUIRES VALIDATION (sin evidencia de invocación) | No declarado explícitamente | Medio (ACT sin HITL documentado) | Declarar HITL explícito antes de habilitar uso real |
| Crear/editar/comentar en recursos Atlassian (wildcard) | Jira/Confluence/Atlassian | MCP wildcard `/*` (`product-owner`, 2 repos) | REQUIRES VALIDATION (sin evidencia de invocación) | No declarado | **Alto** (Blocked #4) | Eliminar wildcard; exigir scope explícito + HITL |
| Completar/mergear PR | Azure DevOps | CLI directo (Scato Logística, Orquestador) | EXECUTED (evidencia real en git log / historial de PR) | Sí (flujo de PR humano estándar de Azure DevOps) | Bajo — ya gobernado por el flujo nativo | Mantener como está |
| Generar documentación de Workflow | GitHub Copilot Chat API | Script `Generate-WfDocs.ps1` (`gh copilot`) | EXECUTED PARCIAL (1/12 real) | No declarado — sale directo a archivo | Bajo–Medio (contenido no revisado antes de commit) | Agregar paso de revisión humana antes de commitear salida generada |
| Ejecutar pipeline CI/CD | Azure DevOps Pipelines | Trigger nativo por push/PR | EXECUTED (real, pero es CI/CD estándar, no una acción de IA en sí) | Sí (gate de pipeline estándar) | Bajo | Fuera de alcance de AI Engineering propiamente dicho |
| Responder a usuario final | Microsoft Copilot Studio | Producto embebido en MoaOperaciones | EXECUTED (producción) | REQUIRES VALIDATION (¿guardrails/HITL declarados?) | REQUIRES VALIDATION | Determinar gobierno y alcance antes de tratarlo como parte de Track 1 |
| Crear rama / PR automáticamente | Jira → Azure DevOps | Mencionado conceptualmente en `moa-sdlc/AGENTS.md` ("MCP de Jira crea branches") | NOT FOUND (sin configuración real) | No aplica — no implementado | N/A (conceptual) | No usar como referencia de patrón hasta resolver la inconsistencia interna del propio repo |

**Frontera READ vs. ACT (FACT, consolidado de las 2 matrices anteriores)**: toda
integración real y en uso (Azure DevOps vía CLI, conectores de `moa-metrics`) es o bien
puramente READ, o ACT ya gobernado por un mecanismo humano nativo preexistente (flujo de
PR). **Toda integración con ACT declarado y sin gobierno nativo (comentar en Jira, wildcard
Atlassian) está en estado CONFIGURED sin evidencia de uso** — no hay, en ningún repo, un
caso real de ACT autónomo sin control humano ya ejecutándose.

## 8. Agent / Skill / Workflow Patterns

**Agents — responsabilidades y restricciones (FACT)**:
- El patrón mejor gobernado encontrado es `.NET Code Reviewer` (Orquestador, Scato
  Logística): `tools: [execute, read, search]` **sin `edit`** — no puede escribir código
  por diseño estructural, no por regla declarada en prosa. Scope acotado al diff
  (`git diff --staged`). Salida estructurada por severidad.
- **Handoffs entre agents**: `product-owner` → `architect` (Orquestador, rama
  `feature/cardless4`, no integrada a `master`) — **declarado en configuración, sin
  evidencia de ejecución real** (REQUIRES VALIDATION).
- **Coordinación**: no se encontró evidencia de orquestación multi-agent real (varios
  agents cooperando en una misma tarea con estado compartido) en ningún repo — los agents
  encontrados son invocables individualmente, no orquestados entre sí.
- **HITL declarado**: presente como diseño (constraints/personalidad en agents de
  Orquestador `feature/cardless4`) pero sin evidencia de que se haya ejercido realmente —
  ver sección 9.

**Skills — estructura y reutilización (FACT)**:
- Patrón consistente de 3 repos: Skill = referencia especializada cargada on-demand,
  declarada por un Agent (`dotnet-code-reviewer.agent.md`: *"Load and apply the following
  skills..."*).
- `copilot-project-setup` (Scato Logística): skill que enseña a construir el resto del
  árbol `.github/` del propio repo — meta-capacidad candidata, sin equivalente en otros
  repos.

**Workflows — estados, validaciones, aprobaciones, rollback (FACT + REQUIRES VALIDATION)**:
- **`_sdd/` Lite (DataAgro)**: estados `requirements → design → tasks → implementación`.
  Validación = QA manual, **sin sign-off registrado**. Rollback: **NOT FOUND** — no hay
  evidencia de un mecanismo de reversión de estado.
- **Harness Full de 6 roles (moa-sdlc)**: `spec-author → implementer → tester → reviewer →
  security-reviewer → human-approver`, con contrato JSON formal (`AGENTS-CONTRACTS.md`) —
  el ejemplo más formalizado de Workflow encontrado, con un rol `human-approver` explícito
  (aprobación declarada, no implícita). **Sin evidencia de ejecución real** más allá del
  mismo ticket (`MOA-1765`) que también aparece en DataAgro — **REQUIRES VALIDATION** si
  alguna vez corrió de punta a punta con los 6 roles reales.
- **Trazabilidad**: parcial únicamente (`feature.json` de `_sdd/` registra estado, pero de
  forma manual, no instrumentada automáticamente — ya señalado en
  `evaluation-observability.md`).

## 9. Evaluation / Measurement Practices

Ver el modelo completo ya definido en
[`../architecture/evidence-evaluation-measurement.md`](../architecture/evidence-evaluation-measurement.md)
y [`../architecture/evaluation-observability.md`](../architecture/evaluation-observability.md)
— este benchmark no lo redefine, confirma su vigencia contra la evidencia de los 6 repos:

- **Evaluation formal**: **NOT FOUND** en los 6 repos, sin excepción. Lo más cercano son
  roles de revisión humana manual (`reviewer`/`security-reviewer` en `moa-sdlc`, QA manual
  en `MOA-1765`) — ninguno con criterios de evaluación declarados de antemano ni resultado
  registrado con el Evaluation Contract de este repo.
- **Observability**: **NOT FOUND** — ninguna señal (ejecución, tool calls, errores,
  latencia, modelo, costo, trazabilidad) instrumentada en ningún repo de equipo.
- **Measurement**: **NOT FOUND a nivel de equipo** — `moa-metrics` (Baufest, no un equipo
  de MOA) implementa 8/8 indicadores propuestos por el KO con ETL real y tests, pero sin
  baseline real medido en producción confirmado (Blocked Decision #7 sigue abierta).
- **Los 2 únicos registros reales que aplican los 3 contratos de punta a punta**
  (`evidence/EXEC-20260907-001.md`, `evidence/EXEC-20260908-001.md`) fueron generados por
  el mismo agente que diseñó la capacidad — **no son ejecuciones independientes de un
  equipo de MOA** (ya documentado en `evidence/README.md`, no se reinterpreta acá).

**Conclusión de esta sección (FACT)**: el modelo Evidence/Evaluation/Measurement de
`MOA-AI-Engineering` es internamente consistente, pero **cero equipos de MOA lo practican
hoy con datos propios** — es un diseño de esta iniciativa, no una práctica ya validada
externamente.

## 10. Security / Governance Findings

Reconfirmación (no redescubrimiento) de lo ya documentado en
[`../security/security-governance.md`](../security/security-governance.md) y
[`../governance/BLOCKED-DECISIONS.md`](../governance/BLOCKED-DECISIONS.md), con evidencia
fresca donde aplica:

1. **Scope MCP wildcard** (`atlassian-mcp-server/*`) en `product-owner` agents —
   confirmado en **2 proyectos independientes** (Orquestador, Scato Logística) — Blocked
   Decision #4, riesgo **Alto** por el modelo de riesgo proporcional de
   `security-governance.md` §1 (permissions amplios + identity/audit sin confirmar).
2. **MCP de Playwright registrado sin consumidor** (Orquestador) — superficie de
   configuración sin propósito ni dueño claro.
3. **Credenciales en texto plano** en `DataAgro/WebDataAgro/Web.config` (SMTP, cuenta de
   servicio SAP, cuenta de servicio Windows) — hallazgo incidental, no es un artefacto de
   IA, **no extraído**, solo reportado con ruta (regla ya vigente desde G5.1).
4. **Bypass de validación de certificado SSL** documentado como intencional en la skill
   `afip-cpe-ctg` de Scato Logística (`ServicePointManager.ServerCertificateValidationCallback
   = ((s,c,ch,e) => true)`) — ya conocido (Blocked Decision #12), sin cambios.
5. **Fuga de estado efímero en `moa-sdlc`**: `_sdd/progress/current/MOA-1765.md`
   committeado pese a la regla explícita de no hacerlo — violación de gobierno documentada,
   no un riesgo de seguridad en sí.
6. **Anomalía de repositorio, no relacionada con IA** (hallada en el relevamiento fuente):
   `ScatoPuerto/scatopuerto` tiene el archivo `.git/index` ausente. Contenido real intacto
   en disco, sin evidencia de ninguna operación destructiva. No remediado — fuera del
   mandato read-only. Se reporta acá por transparencia, no requiere acción de esta
   iniciativa. Ver `_ai-engineering-research/architect-handoff.md` §G.1 para el detalle
   forense completo.
7. **MCP referenciado a nivel de agent sin config local commiteada** (DataAgro, Scato
   Logística) — el acceso a MCP puede estar más extendido de lo que cualquier archivo del
   repo revela (posiblemente configurado a nivel de usuario/organización), lo cual **no es
   auditable solo leyendo el repositorio**.

## 11. Cross-Project Patterns

Prácticas encontradas de forma **independiente en 2 o más repos** (criterio mínimo para
considerar que no es casualidad de un solo equipo):

| Patrón | Repos | Instancias |
|---|---|---|
| Agent de code review de solo lectura (`tools` sin `edit`) | DataAgro, Scato Logística, Orquestador | 3 |
| MCP scope acotado (`architect` agent, un solo método) | Orquestador, Scato Logística, DataAgro | 3 |
| MCP scope wildcard (`product-owner` agent) | Orquestador, Scato Logística | 2 — **patrón de riesgo**, no de reutilización positiva |
| `azure-devops-cli` (Skill) | Scato Logística, Orquestador | 2 |
| `user-story` (Skill) | DataAgro, Scato Logística, Orquestador | 3 |
| `repository-governance` (Instruction ALWAYS/ASK FIRST/NEVER) | DataAgro, Scato Logística, Orquestador, moa-sdlc | 4 |
| Conflicto interno "¿dónde vive el ticket?" (Jira vs. Azure DevOps) | DataAgro, moa-sdlc | 2 |
| Rama de contratista externo (Huenei) divergente de la línea in-house, sin capacidades de IA propias | Orquestador, MoaOperaciones | 2 |
| Branch configurado como default en ADO ≠ branch realmente usado | Orquestador, WebApiCoreAfip (fuera del alcance mínimo, relevado en la fuente) | 2 |

## 12. Candidate Common Core

Clasificación `A` de la sección 4 — **candidatas a evaluación formal**, no promovidas por
este documento:

- **CAP-001** (`azure-devops-cli`, Skill) — 2 repos, uso real (EXECUTED).
- **CAP-002** (`user-story`, Skill) — 3 repos, uso real (EXECUTED, 2 dry-runs) — **no se
  modifica en esta actividad**, por instrucción explícita.
- **CAP-005** (`repository-governance`, Instruction) — 4 repos, estructura común
  (ALWAYS/ASK FIRST/NEVER) VERIFIED en las 4 instancias.

Las 3 comparten el mismo patrón: **la estructura es común, el contenido es específico de
cada equipo** — cualquier promoción real requeriría decidir qué parte se estandariza
(estructura) vs. qué parte permanece adaptable (contenido), no una copia literal.

## 13. Reusable Patterns

Clasificación `B` — reutilizables, requieren evolución/validación antes de generalizarse:

- `.NET Code Reviewer` (CAP-003) — el patrón de diseño (`tools` sin `edit`), no el
  contenido específico de .NET Framework 4.7.2.
- `stack-best-practices-template` (CAP-006) — la estructura de 8 secciones, no el
  contenido (vacío por diseño, cada equipo lo completa).
- `spec-driven-development` Lite (CAP-004) — adoptable con poca fricción, requiere sistema
  de tickets real.
- `Validate-CopilotConfig.ps1` — candidato fuerte a nueva capacidad de Observability-de-
  configuración, sin equivalente en otros repos.
- Patrón de scope MCP acotado (`architect` agent) — usar como plantilla obligatoria para
  cualquier MCP futuro, en contraste explícito con el antipatrón wildcard.

## 14. Team-Specific Practices

Clasificación `C` — válidas para el equipo, **no deben homologarse**:

- La mayoría de los agents por rol (`architect`, `dba-migraciones`, `kendo-grid-builder`,
  `product-owner`, `qa-tester`, `release-manager`, `database-migration`, `devops`,
  `domain-validation-engineer`, `frontend-engineer`, `test-engineer`,
  `wf-activity-refactor`, `workflow-designer`, `xamlx-documenter`) — ya evaluados y
  descartados del Registry en G5.1, este benchmark no reabre esa decisión.
- Contenido real de `dotnet-best-practices`, `abm-mvc`, `afip-cpe-ctg`/`afip-integration` —
  mismo género que capacidades registradas, contenido 100% específico de stack/dominio.

## 15. Experimental Practices

Clasificación `D` — interesantes, insuficientemente validadas:

- Model-routing / cost-tiering (Scato Logística) — instancia única, sin validación
  cruzada entre equipos.
- `xamlx-documenter` + `Generate-WfDocs.ps1` (llamada directa a Copilot Chat API, no MCP)
  — tasa de éxito real de 1/12.
- `spec-driven-development` Full (moa-sdlc) — formalización rica, sin evidencia de
  ejecución independiente.
- Playwright MCP (Orquestador) — configurado, sin consumidor ni propósito confirmado.

## 16. Gaps

Clasificación `E` — capacidades necesarias para el modelo base, ausentes o insuficientes:

1. **Abstracción común de Context Provider** — ningún equipo la tiene; es condición
   necesaria para que la capability soporte tanto contexto manual como conectado (Modelo
   A/B pedido en el encuadre de esta actividad).
2. **Evaluation formal** — NOT FOUND en los 6 repos, brecha fundacional ya señalada,
   reconfirmada sin excepción.
3. **Observability de ejecución de IA** — NOT FOUND en los 6 repos.
4. **Producto conversacional de cara al usuario final** (Copilot Studio) — no tiene dónde
   vivir en la taxonomía actual de 7 capacidades.
5. **Knowledge/RAG matizado** — existe configuración real (submodule Wiki) en 2 repos,
   poblada en 1, sin consumo confirmado — el estado correcto ya no es "no existe", es
   "configurado, parcialmente poblado, sin consumo demostrado".
6. **Frontera READ/ACT explícita** — ningún repo de equipo declara formalmente dónde
   termina la lectura y empieza la acción con efecto — el único ACT gobernado que existe
   (merge de PR) lo hereda del flujo nativo de Azure DevOps, no de un diseño propio de IA
   Engineering.
7. **El patrón arquitectónico objetivo de esta actividad** (Context Acquisition → Direct/
   Connected Context → Capability → Agent/Model → Result → Human Review → Evidence →
   Evaluation/Measurement → Feedback) no tiene, hoy, ninguna instancia de equipo que lo
   recorra de punta a punta — existe solo dentro de `MOA-AI-Engineering` mismo. Ver
   sección 18.

## 17. Risks

Clasificación `F`:

1. **Scope MCP wildcard en `product-owner`** (2 proyectos) — Alto, Blocked Decision #4.
2. **Credenciales en texto plano** (DataAgro `Web.config`) — reportado, no extraído, no
   resuelto por esta iniciativa (fuera de su mandato).
3. **Bypass SSL en `afip-cpe-ctg`** — riesgo de integridad de datos en tránsito con un
   sistema regulatorio real.
4. **MCP referenciado sin config local auditable** (DataAgro, Scato Logística) — el
   acceso real puede exceder lo que el repo revela.
5. **Líneas de desarrollo de contratista externo sin capacidades de IA ni gobierno visible**
   (Huenei, Orquestador y MoaOperaciones) — REQUIRES VALIDATION si están dentro del radar
   de gobierno de esta iniciativa.
6. **Branch default de Azure DevOps ≠ branch vigente** — cualquier automatización futura
   que confíe en el default sin verificar producirá conclusiones falsas sobre qué
   capacidades existen.

## 18. Architectural Implications for MOA-AI-Engineering

**Sobre el patrón objetivo a validar (Context Acquisition → ... → Feedback)**:

- El **fork Evidence → Evaluation/Measurement → Feedback** ya está definido, con el mismo
  diseño (Evaluation y Measurement como consumidores independientes de una misma Evidence,
  no secuenciales) en
  [`../architecture/evidence-evaluation-measurement.md`](../architecture/evidence-evaluation-measurement.md).
  **No requiere cambios** a partir de la evidencia de este benchmark.
- La distinción **Human Review operativo ≠ Human Evaluation formal**, ya introducida en
  [`../adoption/execution-model.md`](../adoption/execution-model.md), es consistente con
  la evidencia: lo que los equipos practican hoy (QA manual sin sign-off, revisión humana
  de PR) es Human Review operativo — **ningún equipo practica Human Evaluation formal**
  todavía.
- **Lo que la evidencia NO respalda todavía**: el tramo *Context Acquisition/Resolution →
  Direct Context / Connected Context* como mecanismo unificado. Existe la intención
  (2 MCP configurados) y el patrón manual (copy/paste), pero **ninguna capability real
  demuestra hoy resolver automáticamente una referencia y producir "Resolved Context"**
  independientemente de si el origen fue manual o conectado. Esto es un **GAP**, no una
  contradicción del modelo — el modelo objetivo es más avanzado que la práctica real
  actual.
- **Capability ≠ Integration ya está correctamente separado** en
  [`../architecture/capability-model.md`](../architecture/capability-model.md) (Integration/API
  y MCP son capacidades propias, distintas de Skill/Agent/Workflow). La evidencia de este
  benchmark **confirma que esa separación es necesaria en la práctica**: `user-story`
  (CAP-002) ya se ejecuta hoy con contexto manual en los 3 repos, sin ninguna integración
  — validando que el modelo ya soporta el "Modelo A" (contexto manual) pedido en el
  encuadre de esta actividad. El "Modelo B" (contexto conectado) no tiene todavía ninguna
  instancia real que lo pruebe de punta a punta.

**Cambios mínimos sugeridos** (no implementados, ver sección 19):
1. Ninguno a `capability-model.md` — la taxonomía de 7 capacidades sigue siendo válida.
2. Ninguno a `evidence-evaluation-measurement.md` — el contrato ya está correcto.
3. Un GAP nuevo a registrar formalmente (no resolver): producto conversacional embebido
   (Copilot Studio) sin encaje en la taxonomía actual.

## 19. Recommendations

Recomendaciones para decisión del Arquitecto Supervisor — **ninguna implica implementar
nada todavía**:

1. Evaluar CAP-001, CAP-002 y CAP-005 contra `assessment-gate.md` como los candidatos más
   sólidos a Common Core, dado su presencia en 3+ repos con uso real.
2. Al evaluar o promover cualquier patrón de Agent, incluir explícitamente una regla de
   scope de MCP: nunca wildcard sin justificación documentada — seguir el patrón
   `architect` acotado, no el patrón `product-owner` wildcard (ya propuesto en
   `architect-handoff.md` PROPOSAL 1, reconfirmado acá con evidencia consolidada).
3. Considerar `Validate-CopilotConfig.ps1` como candidato real a evaluar para una futura
   capacidad de Observability de configuración de IA.
4. Registrar formalmente el gap del producto conversacional embebido (Copilot Studio) como
   punto de decisión de alcance — ¿es Track 1 o iniciativa separada? (estilo Blocked
   Decision, no se agrega a `BLOCKED-DECISIONS.md` desde este documento).
5. No tratar el branch default de Azure DevOps como el branch vigente en ningún
   relevamiento o automatización futura sin verificación cruzada (git + `az` CLI).
6. Antes de cualquier trabajo futuro de diseño de Context Provider, reconocer
   explícitamente que hoy **no existe ninguna instancia real** que lo valide — cualquier
   diseño sería PROPOSAL puro, no generalización de una práctica existente.
7. No convertir ninguna práctica de la sección 14 (Team-Specific) en Common Core sin nueva
   evidencia — esta actividad no encontró motivo para reabrir esas decisiones de G5.1.

## 20. REQUIRES VALIDATION

Consolidado de lo que este benchmark no puede demostrar por sí mismo (algunas ya listadas
en `BLOCKED-DECISIONS.md`, se referencian, no se duplican):

1. ¿Los MCP configurados están siendo invocados por desarrolladores fuera de lo que queda
   registrado en el repo? (config a nivel de usuario/organización no es visible desde acá)
   — ver Blocked Decision #4.
2. ¿El chatbot "Mola" (Copilot Studio) está gobernado por alguien, y cae dentro del alcance
   de Track 1? — gap nuevo de este benchmark, no una Blocked Decision previa.
3. ¿La actividad de Huenei es un engagement autorizado y gobernado, o una línea fuera del
   radar de gobierno de esta iniciativa?
4. ¿Existe realmente un `mcp.json` a nivel de usuario que respalde las referencias a
   Atlassian MCP en Scato Logística y DataAgro?
5. ¿El harness de 6 roles de `moa-sdlc` corrió alguna vez de punta a punta con los 6 roles
   reales, o solo con el ticket compartido `MOA-1765` documentado?
6. ¿Las credenciales en texto plano de `DataAgro/Web.config` son un riesgo ya conocido y
   aceptado por el equipo, o requieren escalamiento inmediato? — este benchmark no tiene
   autoridad para actuar, solo para reportar.
7. Ver también Blocked Decisions #1, #2, #3, #5, #7, #8, #9, #10, #11, #12 — vigentes sin
   cambios, no resueltas por este documento.

## 21. Evidence References

**Fuente primaria — relevamiento fresco 2026-09-08** (directorio temporal, no versionado,
fuera de este repo — `D:\PROYECTOS\MOLINOS\Aplicaciones\_ai-engineering-research\`):
`README.md`, `repository-inventory.md`, `branch-analysis.md`, `ai-capability-inventory.md`,
`integration-inventory.md`, `mcp-analysis.md`, `context-acquisition-analysis.md`,
`architect-handoff.md`.

**Fuente secundaria — evidencia ya embebida en este repo** (fases G2–G5.1):
[`../architecture/capability-model.md`](../architecture/capability-model.md),
[`../architecture/evidence-evaluation-measurement.md`](../architecture/evidence-evaluation-measurement.md),
[`../architecture/evaluation-observability.md`](../architecture/evaluation-observability.md),
[`../registry/INDEX.md`](../registry/INDEX.md),
[`../integrations/catalog.md`](../integrations/catalog.md),
[`../security/security-governance.md`](../security/security-governance.md),
[`../governance/BLOCKED-DECISIONS.md`](../governance/BLOCKED-DECISIONS.md),
[`../evidence/README.md`](../evidence/README.md).

**Archivos de equipo citados directamente** (repos de MOA, READ-ONLY, no distribuidos):
`DataAgro/DataAgro/.vscode/mcp.json`, `DataAgro/DataAgro/WebDataAgro/Web.config` (solo
ruta, no contenido), `Scato Logistica/Scato%20Logistica/.github/skills/afip-cpe-ctg/SKILL.md`,
`Scato Logistica/Scato%20Logistica/AiEnablement/Generate-WfDocs.ps1`,
`Scato Logistica/Scato%20Logistica/AiEnablement/Validate-CopilotConfig.ps1`,
`Orquestador/Orquestador/.vscode/mcp.json` (rama `master-logistica`),
`moa-sdlc/AGENTS.md`, `moa-sdlc/AGENTS-CONTRACTS.md`, `moa-sdlc/_sdd/progress/current/MOA-1765.md`.
