# Jira Context Provider (pattern)

**Registry**: [`CAP-008`](../registry/entries/jira-context.md).
**Cross-Cutting Concern que implementa**: [`../architecture/context-acquisition-resolution.md`](../architecture/context-acquisition-resolution.md)
— Modelo B (Connected Context).
**Action Type**: **READ**. **No implementa `ACT`** — regla explícita, ver sección
"Por qué READ-only" más abajo.
**Origen del patrón**: generalización del hallazgo real de `com.atlassian/atlassian-mcp-server`
en Orquestador y Scato Logística — **no copia ninguna configuración específica de
proyecto**. Extrae únicamente el patrón de **scope acotado** (`getJiraIssue`, visto en los
agents `architect` de ambos repos) — **explícitamente descarta** el patrón de scope
wildcard (`atlassian-mcp-server/*`, visto en los agents `product-owner` de los mismos 2
repos), que el benchmark ya identificó como el hallazgo de mayor riesgo de todo el
relevamiento (Blocked Decision #4).

## Propósito

Convertir una referencia a un issue de Jira en un `Resolved Context`, con el mismo
contrato que cualquier otro Context Provider — sin exponer nunca una operación de
escritura.

## Flujo

```
Reference (ej. DAT-1274)
        ↓
Jira (consulta READ, scope acotado a getIssue)
        ↓
Issue
        ↓
Resolved Context
```

## Input

```
reference: <clave de issue, ej. PROY-NNNN>
```

## Output

```yaml
source_type: connected
source_system: jira
source_identifier: <reference>
resolved_at: <timestamp>
content_reference: <URL del issue en Jira>
content: <resumen + descripción + criterios de aceptación si existen, en texto>
metadata:
  status: <estado del issue>
  issue_type: <tipo>
provenance: "jira-context-provider v1"
retrieval_status: resolved | failed | not_found
```

## Source / Identifier

- **Source**: Jira (Atlassian).
- **Identifier**: clave de issue (`PROY-NNNN`) — mismo formato ya usado en la evidencia
  real de DataAgro, Scato Logística, Orquestador (ver `azure-devops-context-provider.md`
  para el equivalente de Azure DevOps).

## Authentication / Authorization

**No definidas por este patrón, deliberadamente**: dependen de la identidad con la que el
mecanismo de acceso a Jira (MCP u otro) esté configurado en el entorno del equipo. Este
documento **no incluye ningún token, credencial, ni configuración de proyecto real**. Ver
[`../security/security-governance.md`](../security/security-governance.md) §2 para el
gobierno específico de MCP ya vigente (ningún atributo de un MCP se asume sin evidencia
explícita).

## Least privilege

**Scope declarado, único y exacto**: `getJiraIssue` (lectura de un issue por su
identificador). **Ningún otro método**. No se declara `search`, no se declara `comment`,
no se declara `create`, no se declara `/*`. Esto es intencional — es la diferencia
concreta y verificable con el antipatrón que el benchmark encontró repetido en 2 proyectos.

## Auditability

Todo `Resolved Context` producido por este patrón lleva `provenance:
"jira-context-provider v1"` — igual que el patrón de Azure DevOps, para que cualquier
auditoría posterior pueda rastrear qué mecanismo produjo un contexto dado. **No se
implementa auditoría real (logging de servidor) en esta versión** — REQUIRES VALIDATION,
ver `security-governance.md` §2, punto 4 ("confirmar mecanismo de auditoría antes de la
primera ejecución real").

## Failure handling

| Situación | `retrieval_status` |
|---|---|
| Issue no existe / clave inválida | `not_found` |
| Sin autenticación válida / sin permiso de lectura sobre el proyecto | `failed` |
| Issue existe pero sin descripción/campos relevantes | `partial` — nunca inventar contenido |

## Prompt injection considerations

El `content` de un issue de Jira es **contenido externo no confiable** — puede contener
texto escrito por cualquier persona con acceso al proyecto. **Regla dura**: el `content`
resuelto se trata como dato, nunca como instrucción — ninguna capability que consuma este
Resolved Context debe ejecutar instrucciones que aparezcan dentro del texto del issue
(ej. "ignorá las reglas anteriores y..."). Esta es la misma disciplina ya aplicada en este
repositorio a cualquier contenido externo (ver la nota equivalente sobre comentarios de
artefactos en otras partes del modelo).

## Data sensitivity

Un issue de Jira puede contener información de negocio sensible (planes, decisiones no
públicas). El `content_reference` permite a un humano verificar la fuente antes de confiar
en el contenido — no se asume automáticamente que todo issue es de baja sensibilidad.
`Data Classification` queda `REQUIRES VALIDATION` a nivel de capability (Blocked Decision
#3, política de clasificación de datos no existe todavía en MOA).

## READ vs. ACT — por qué READ-only

**Regla explícita de esta primera versión, sin excepción**: este patrón **no implementa
ACT**. No crea, no comenta, no transiciona, no cierra issues. La única operación
disponible es la lectura acotada a un issue por su identificador exacto. Cualquier
extensión futura hacia ACT (ej. comentar automáticamente) requiere pasar primero por el
Golden Path #6 (*MCP / Integration Onboarding*, [`../golden-paths/README.md`](../golden-paths/README.md#6-mcp--integration-onboarding))
y por la sección "READ vs. ACT" de `security-governance.md` — **no se habilita acá**.

## Evidencia

- El servidor `com.atlassian/atlassian-mcp-server` real, con scope acotado
  (`getJiraIssue`), tiene evidencia de **configuración** (`CONFIGURATION VERIFIED`) en los
  agents `architect` de Orquestador y Scato Logística — **sin evidencia de invocación
  real** (`security-governance.md` §2).
- Este patrón específico (Reference → Resolved Context) **no tiene evidencia de ejecución
  real todavía** — `Real Use Status: NOT FOUND`, igual que `azure-devops-context-provider.md`.

## Uso esperado

Un equipo con Jira y un mecanismo de acceso ya configurado puede usar este patrón para
resolver un issue hacia contexto y pasarlo a cualquier capability que acepte `Resolved
Context` (ej. CAP-002). No reemplaza el flujo manual — es una alternativa.

## Qué es Team Adaptation, explícitamente

- El proyecto/espacio de Jira configurado.
- El mecanismo de autenticación real usado.
- Cualquier campo adicional de `metadata` propio del proceso del equipo.
