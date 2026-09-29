# CAP-027 — release-manager

**Nota de clasificación**: `release-manager` fue relevado como parte de los 5 agentes por
rol de DataAgro en G5.1 y clasificado `TEAM-SPECIFIC` (contenido específico del dominio
DataAgro, no materializado). Esta entrada **no reabre esa clasificación sin evidencia
nueva**: se materializa recién ahora porque apareció una segunda instancia real e
independiente, en Scato Logística (no relevada en G5.1), confirmando convergencia entre 2
equipos — mismo criterio que ya usó este Registry para `dotnet-best-practices` →
`stack-best-practices-template` (CAP-013): el contenido de cada equipo sigue sin copiarse,
se generaliza el patrón portable.

| Campo | Valor | Evidencia / clasificación |
|---|---|---|
| **ID** | CAP-027 | — |
| **Name** | release-manager | FACT (existe el archivo) |
| **Type** | Agent | FACT |
| **Purpose** | Consolidar los cambios reales de una release (versión completa, no un ticket), detectar riesgo de datos y redactar CHANGELOG/release notes para revisión | FACT |
| **Owner** | REQUIRES VALIDATION | `governance/BLOCKED-DECISIONS.md` #1 |
| **Maintainer** | REQUIRES VALIDATION | Ídem |
| **Origin** | 2 instancias reales independientes: DataAgro (`release-manager`, relevado en G5.1, `TEAM-SPECIFIC`) y Scato Logística (`release-manager` real, `.github/agents/release-manager.agent.md`, con `handoffs` hacia `product-owner` y `devops`, confirmado con historial real de merges `release/*` vía Azure DevOps) | FACT (2 instancias verificadas por lectura directa) |
| **Originator** | No aplica a la instancia generalizada | — |
| **Team** | Ninguno todavía adoptó la versión generalizada | FACT |
| **Domain** | Transversal — el patrón (consolidar cambios reales por versión) es independiente del stack | FACT |
| **Repository** | No aplica | — |
| **Branch** | No aplica | — |
| **Integration Status** | No integrado a ningún repo de equipo todavía | FACT |
| **Configuration Status** | VERIFIED — contenido completo escrito y revisado en esta sesión | FACT |
| **Real Use Status** | **CONFIGURED** — mecanismo documentado, generalizado sin contenido de dominio; las 2 instancias de origen sí tienen uso real, pero no está confirmado que hayan sido operadas por un asistente de IA en cada corrida (el historial de merges confirma el proceso de release, no quién redactó el CHANGELOG) | FACT + INFERENCE (distinción explícita) |
| **Lifecycle State** | Proposal | Sin ejecución real de la versión generalizada todavía |
| **Corporate Standard** | N | Sin evidencia de evaluación/medición formal |
| **Version** | Sin versionado semántico | — |
| **Risk** | Bajo | `edit` acotado a `CHANGELOG.md` y release notes, nunca código de negocio; nunca push/tag/pipeline sin confirmación explícita |
| **Data** | No toca datos de negocio en producción — solo lee historial de PRs/commits y detecta (sin ejecutar) migraciones de base de datos | INFERENCE (por `tools` y constraints declarados) |
| **Data Classification** | REQUIRES VALIDATION | `BLOCKED-DECISIONS.md` #3 |
| **Tools** | `[read, execute, search, edit, todo]` — `execute` acotado a comandos de lectura (`git log`/`diff`, `az repos pr list`/`show`); `edit` acotado a 2 archivos de documentación | FACT |
| **Model** | No declarado | FACT |
| **Autonomy** | Acotada por 5 constraints textuales (ver `AGENT.md`) — nunca push/tag/pipeline, nunca ejecuta ni aprueba migraciones de datos, nunca inventa qué cambió, nunca reescribe el historial ya publicado, nunca clasifica sin evidencia | FACT |
| **HITL** | Obligatorio: los 2 borradores se muestran completos antes de escribirse; push/tag/pipeline requieren su propia confirmación explícita, aparte | FACT (declarado en `AGENT.md`) |
| **Evaluation** | NOT FOUND | — |
| **Observability** | NOT FOUND | — |
| **Metrics** | NOT FOUND | — |
| **Adopters** | Ninguno todavía (versión generalizada) | — |
| **Last Review** | 2026-09-28 | — |
| **Evidence Reference** | Historial real de merges `release/2026.35.x` en el repositorio de Scato Logística (`Merged PR 6186: Merge release/2026.35.7 into master`) | FACT |
| **Evaluation Reference** | Ninguna todavía | — |
| **Metric Reference** | Ninguna todavía | — |
| **Reusable Asset** | [`capabilities/agents/release-manager/AGENT.md`](../../capabilities/agents/release-manager/AGENT.md) | — |
| **Action Type** | ACT acotado — `edit` real solo sobre `CHANGELOG.md`/release notes, nunca sobre código de negocio; nunca push/tag/pipeline sin confirmación | Mismo patrón de scope acotado que CAP-011 (`pr-description`) y CAP-016 (`ticket-closure-assist`) |
| **Context Requirements** | Referencia real de la release anterior (tag/rama/rango de commits) + `azure-devops-cli` (CAP-008) u otra CLI real para traer PRs/commits | Reutiliza CAP-008, no define un mecanismo de acceso propio |

## Nota de selección

Cierra un gap real de granularidad: las 11 etapas del KO que ya tienen capacidad o
propuesta (`README.md#cobertura-por-etapa-del-sdlc`) están pensadas a nivel de **ticket**
— ninguna consolida varios tickets/PRs al nivel de una **release** completa. No reemplaza
ninguna capacidad existente: `ticket-closure-assist` (CAP-016) sigue siendo el cierre por
ticket; esta es la consolidación por versión, un nivel arriba.
