# Security & Governance

**Estado**: PROPOSAL, salvo citas FACT explícitas. Este documento
**sintetiza y extiende** [`../governance/ai-governance.md`](../governance/ai-governance.md)
y [`../governance/agent-governance.md`](../governance/agent-governance.md) — ambos
se mantienen (contienen detalle todavía válido: la matriz de autonomía con ejemplos reales
de DataAgro/Scato Logística/`moa-sdlc`, y el pipeline TRIGGER→CONTEXT→DECISION→ACTION→
VALIDATION→AUDIT). Este documento agrega el **modelo de riesgo proporcional** y el
**gobierno específico de MCP** que la evidencia de G3.2.5 volvió urgente.

## Principio rector

> Modelo proporcional al riesgo — no binario ("MCP permitido / prohibido"). La
> habilitación depende de: data sensitivity, identity, permissions, read/write, autonomy,
> external systems, business criticality, HITL, audit, observability, lifecycle.

## 1. Modelo de riesgo proporcional (no binario)

Reemplaza cualquier lectura previa de este proyecto como "MCP bloqueado hasta que exista
política de datos" (esa era una simplificación de una sesión anterior, ya corregida en
G3.1 review). El modelo correcto:

| Factor | Pregunta | Ejemplo de bajo riesgo | Ejemplo de alto riesgo |
|---|---|---|---|
| Data sensitivity | ¿Qué tan sensible es el dato accedido? | Lectura de tickets de Jira públicos del equipo | Datos AFIP/SAP, datos de clientes |
| Identity | ¿Con qué identidad opera la integración? | Cuenta de servicio dedicada, scope mínimo | Credencial personal, scope amplio |
| Permissions | ¿Qué puede hacer exactamente? | Solo lectura, endpoints específicos | Escritura, endpoints amplios/administrativos |
| Read/write | ¿Lee o modifica el sistema externo? | Read | Write |
| Autonomy | ¿Actúa sin intervención humana? | Sugiere, un humano confirma | Ejecuta y confirma sin HITL |
| External systems | ¿Cuántos sistemas toca, y cuán críticos son? | 1 sistema interno de bajo impacto | Sistemas regulatorios (AFIP) o financieros (SAP) |
| Business criticality | ¿Qué pasa si falla o se usa mal? | Bajo impacto operativo | Impacto regulatorio o financiero |
| HITL | ¿Dónde está el punto de validación humana? | Antes de cualquier efecto | No declarado |
| Audit | ¿Queda registro de qué se hizo? | Logging explícito | Sin logging |
| Observability | ¿Se puede reconstruir qué pasó? | Trazabilidad completa | Ninguna |
| Lifecycle | ¿En qué estado del ciclo está? (`lifecycle.md`) | Pilot, alcance acotado | "Producción" sin evidencia de los puntos anteriores |

**Regla de combinación**: mientras más factores caen en la columna de alto riesgo, mayor
el nivel de control exigido antes de habilitar/escalar. No se define un umbral numérico
(consistente con el principio de `assessment-gate.md`: no forzar un score sin evidencia
para calibrarlo).

## 1.5 READ vs. ACT — frontera de contrato

**Agregado al implementar Context Acquisition & Resolution** — formaliza la distinción ya
evaluada en [`../architecture/benchmark-to-target-model-decision-input.md`](../architecture/benchmark-to-target-model-decision-input.md)
(Decisión #3). Antes vivía disuelta dentro del factor "Read/write" de la sección 1; ahora
tiene contrato propio, campo `Action Type` en `capability-registry.md`.

**Action Type**: `READ` / `ACT` / `BOTH`.

- **READ**: recuperar contexto, consultar información, analizar — sin modificar estado
  externo.
- **ACT**: crear, actualizar, transicionar, disparar, notificar — modifica estado externo.

**Regla dura, sin excepción**: **READ no implica automáticamente bajo riesgo. ACT no
implica automáticamente alto riesgo.** La diferencia central no es "cuánto riesgo tiene
por naturaleza" — es **el impacto sobre estado externo**. Una lectura de datos AFIP/SAP
(alta sensibilidad) puede tener más riesgo que una escritura en un sistema interno de bajo
impacto. El modelo de riesgo proporcional de la sección 1 sigue aplicando igual sobre
ambos — esto no reemplaza esa sección, la complementa con una frontera de contrato.

| Dimensión | READ | ACT (agrega, sobre lo de READ) |
|---|---|---|
| Scope | Acotado al recurso consultado | Acotado a la operación exacta que puede ejecutar |
| Data sensitivity | Se evalúa igual que cualquier lectura (sección 1) | Ídem, más el dato que se escribe/modifica |
| Provenance | Registrar de dónde vino el contexto leído | Ídem, más quién/qué autorizó la acción |
| Audit | Deseable | **Obligatorio** |
| Risk | Evaluado por la sección 1, sin asumir "bajo" por defecto | Evaluado por la sección 1, sin asumir "alto" por defecto — pero con explicit risk documentado siempre |
| Authorization | No crítica si el dato no es sensible | **Crítica** — identidad/scope mínimo confirmados antes de habilitar |
| HITL | Opcional según sensibilidad del dato | **Obligatorio por default**, salvo excepción justificada y auditada — misma regla ya vigente para Evaluation de alto impacto (`../architecture/evidence-evaluation-measurement.md` §2), extendida acá a cualquier ACT |
| Evidence | Útil | Requerido — mismo `evidence_reference` sin excepción |
| Reversibility | Siempre reversible | No siempre — requiere estrategia explícita de failure handling |
| Failure handling | Reintentar es de bajo riesgo | Requiere estrategia explícita — un ACT fallido a medias puede dejar estado externo inconsistente |
| Excessive agency | Riesgo bajo por naturaleza | Riesgo real — ver el hallazgo de wildcard MCP más abajo, es exactamente este antipatrón |

**Regla aplicada a esta primera ola de Context Providers (sección 2 y
[`../integrations/`](../integrations/catalog.md))**: **la primera generación de Context
Integrations es READ-only, sin excepción.** Ningún Context Provider de esta versión
implementa ACT.

## 2. Gobierno específico de MCP

**No asumir, para ningún MCP, ninguno de los siguientes atributos sin evidencia
explícita**: read-only, ejecución, autenticación, permisos, estado de producción. Cada uno
se marca **VERIFIED** o **REQUIRES VALIDATION** por separado.

### Caso real: `com.atlassian/atlassian-mcp-server`

Encontrado en 2 agents de Orquestador (rama `feature/cardless4`, no integrada a `master`
— ver `capability-registry.md`, campo `Integration Status`).

| Atributo | Estado |
|---|---|
| La referencia a la tool existe en el archivo del agent | **VERIFIED** (leído completo en G3.2.5) |
| Está en la línea principal del repositorio | **NO** — está en una rama no integrada |
| Modo de acceso (read-only vs. read-write) | **REQUIRES VALIDATION** — el agent `product-owner` la declara con wildcard (`'com.atlassian/atlassian-mcp-server/*'`), lo cual **no acota el alcance a solo lectura** |
| Identidad/autenticación usada | **REQUIRES VALIDATION** |
| Si está desplegado y en ejecución real | **REQUIRES VALIDATION** — sin evidencia de invocación |
| Auditoría/logging | **REQUIRES VALIDATION** |

**Prioridad asignada**: alta — ver Blocked Decision #4. Este hallazgo debe escalarse para
revisión de seguridad independientemente del cronograma del resto de G3.3, precisamente
porque el wildcard de permisos (`/*`) es, por diseño del modelo de riesgo de la sección 1,
uno de los patrones de mayor riesgo posible (permissions amplios + identity/audit sin
confirmar).

### Hallazgos nuevos de G5.1 — 2 casos reales adicionales, más amplios que lo conocido hasta G4.6

El inventario profundo de G5.1 encontró evidencia real que **amplía** el alcance conocido
del riesgo de MCP en MOA — no reemplaza el hallazgo anterior de Orquestador, lo suma:

**1. `DataAgro/DataAgro/.vscode/mcp.json` — registro real de un servidor MCP remoto**
(no en una rama aislada, en el working tree principal):
```json
{
  "servers": {
    "ado-remote-mcp": { "url": "https://mcp.dev.azure.com/molinosagro", "type": "http" }
  },
  "inputs": []
}
```
| Atributo | Estado |
|---|---|
| El archivo de configuración existe y está commiteado | **VERIFIED** |
| Es un endpoint real (`mcp.dev.azure.com/molinosagro` — nombre de organización real de MOA) | **VERIFIED** |
| Modo de acceso (read-only vs. read-write) | **REQUIRES VALIDATION** — no declarado en el archivo |
| Identidad/autenticación usada | **REQUIRES VALIDATION** |
| Si está en uso real (no solo configurado) | **REQUIRES VALIDATION** — sin evidencia de invocación en el historial inspeccionado |
| Auditoría/logging | **REQUIRES VALIDATION** |

**Por qué es distinto y más urgente que el hallazgo de Orquestador**: este archivo vive en
el working tree principal de un repo real de un equipo de MOA (no en una rama sin
integrar), y referencia una organización de Azure DevOps real por nombre
(`molinosagro`) — es la evidencia más concreta de un MCP potencialmente activo encontrada
en todo el relevamiento G1-G5.1.

**2. Referencias a herramientas de Atlassian MCP en `tools:` de agentes — más amplio de lo
documentado hasta G4.6**: no solo Orquestador (ya conocido) — también **DataAgro**
(`qa-tester.agent.md`: `atlassian-mcp/getJiraIssue`, `atlassian-mcp/searchJiraIssuesUsingJql`,
`atlassian-mcp/addCommentToJiraIssue`; `release-manager.agent.md`:
`mcp_azuredevops_m_repo_pull_request`, `mcp_azuredevops_m_wit_work_item`) y **Scato
Logística** (`architect.agent.md`: `com.atlassian/atlassian-mcp-server/getJiraIssue`;
`product-owner.agent.md`: wildcard `'com.atlassian/atlassian-mcp-server/*'`, el mismo
patrón de scope amplio ya señalado como de alto riesgo en Orquestador). Ninguno de estos 3
repos tiene un `mcp.json`/config local que respalde estas referencias — **probablemente
configuradas a nivel de usuario/global, no de repositorio**, lo cual es en sí mismo un
hallazgo: el acceso a MCP puede estar más extendido de lo que cualquier archivo
commiteado revela, y por eso no es auditable solo leyendo el repo.

**Prioridad asignada**: la misma que Blocked #4 (alta) — este hallazgo se agrega **a**
esa decisión bloqueada, no crea una decisión nueva separada, porque la pregunta de fondo
es la misma ("¿hay MCP real en uso, gobernado, en MOA?") con más evidencia que antes
apuntando a que la respuesta podría ser "sí, más de lo que se pensaba" — ver
`BLOCKED-DECISIONS.md` #4, texto actualizado en G5.1.

### Hallazgo nuevo de G5.1 — validación de certificado SSL deshabilitada (no es MCP, es un riesgo de integridad de datos en tránsito)

`Scato Logistica/Scato%20Logistica/.github/skills/afip-cpe-ctg/SKILL.md` documenta, como
parte del comportamiento esperado del código real, que la validación de certificado SSL
está deliberadamente deshabilitada para las llamadas a los web services de AFIP:
```csharp
ServicePointManager.ServerCertificateValidationCallback = ((s, c, ch, e) => true);
```
con el comentario "no remover, AFIP no valida certificado en todos los ambientes". Esto
**no es un hallazgo de MCP** — es un riesgo de integridad de datos en tránsito
(vulnerable a un ataque man-in-the-middle) para comunicación con un sistema regulatorio
real. **No se modifica el código de Scato Logística desde este repositorio** (fuera de
alcance — es un repo de equipo, no `MOA-AI-Engineering`) — se documenta acá porque el
código lo declara explícitamente como intencional en un artefacto de IA Engineering (una
Skill), lo cual lo hace visible y evaluable de una forma que no lo sería si estuviera
enterrado en el código de aplicación sin documentar. **Recomendación, no una acción
tomada**: si la justificación real es "algunos ambientes de AFIP presentan certificados
inválidos", la práctica de mayor seguridad es acotar el bypass a esos ambientes
específicos por configuración, no deshabilitarlo incondicionalmente — evaluación que le
corresponde al equipo de Scato Logística, no a esta iniciativa.

### Cualquier MCP futuro

Antes de habilitar cualquier MCP nuevo (Jira, Confluence, Azure DevOps, SQL Server,
Playwright — todos PROPOSED según `../integrations/catalog.md`):

1. Completar la tabla de la sección 1 (modelo de riesgo).
2. Confirmar identidad/autenticación (cuenta de servicio, no personal — principio ya
   fijado en sesión previa sobre credenciales de `moa-metrics`).
3. Confirmar scope mínimo necesario, explícito (no wildcards salvo justificación).
4. Confirmar mecanismo de auditoría antes de la primera ejecución real, no después.
5. Registrar en `capability-registry.md` con `Integration Status` explícito.

## 3. Modelo de gobierno de agentes (heredado, vigente)

Sin cambios respecto a `../governance/agent-governance.md`: pipeline TRIGGER→CONTEXT→
DECISION→ACTION→VALIDATION→AUDIT obligatorio, matriz ALWAYS/ASK FIRST/NEVER declarada por
cada Agent. **Patrón destacado de G3.2.5** que refuerza este modelo con evidencia real:
el agent `.NET Code Reviewer` de Orquestador logra bajo riesgo *por diseño* — su lista de
`tools` no incluye `edit`, por lo que estructuralmente no puede escribir código, sin
necesidad de una regla NEVER declarada aparte. Esto es un patrón de gobierno a considerar
como candidato reusable (ver `assessment-gate.md`): **limitar `tools` es un control de
seguridad tan válido como declarar restricciones en prosa**.

## 4. Brechas críticas sin resolver (heredadas de G1-G2, sin cambios)

1. **Política de Responsible AI**: no existe. Blocked Decision — no hay borrador.
2. **Clasificación de datos**: no existe (Blocked Decision #3). Condiciona directamente la
   columna "Data sensitivity" de la sección 1 — sin esta política, cualquier evaluación de
   riesgo sobre datos AFIP/SAP se hace sin criterio objetivo, caso por caso.
3. **Modelo de credenciales de integración**: personal vs. cuenta de servicio — sin
   decisión formal (ya señalado en trabajo previo sobre `moa-metrics`).

## 5. Qué NO se hace en esta fase

No se configura ningún MCP, no se conecta Jira/Confluence/bases de datos, no se crea
infraestructura de seguridad — esto es exclusivamente el modelo conceptual (alcance
explícito de G3.3).
