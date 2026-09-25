# ai-engineering

**Base común de AI Engineering para Molinos Agro (MOA).** Skills, agentes, instrucciones y
workflows para usar IA en cada etapa del SDLC con GitHub Copilot en VS Code, con revisión
humana en cada paso. Cada equipo adopta lo que le sirve; nada es obligatorio.

## Empezar

1. **Instalar** (una vez por máquina, incluye conectar Jira):
   [`adoption/agent-plugin-quickstart.md`](adoption/agent-plugin-quickstart.md).
2. **Usar** (qué escribir en el chat y cómo pasar de un rol al siguiente):
   [`adoption/how-to-use.md`](adoption/how-to-use.md).
3. **Qué hace cada capacidad**, explicado simple:
   [`capabilities/README.md`](capabilities/README.md#qué-hace-cada-capacidad-explicado-simple).

No hace falta copiar nada al repositorio del proyecto: el modelo se instala en la máquina
de cada persona y se actualiza con un comando.

## Qué ofrece a cada rol

| Rol | Qué ofrece |
|---|---|
| **Product Owner / analista** | Convertir un ticket largo o poco claro en una historia breve, con criterios verificables y las preguntas que bloquean; con confirmación, dejarla en el ticket de Jira |
| **Developer** | Investigar el ticket, armar un plan técnico e implementarlo después de la aprobación explícita de la persona, en un espacio de trabajo aislado; ayuda con Azure DevOps por CLI y con la descripción del Pull Request |
| **Revisor de código** | Una segunda mirada sobre el diff: seguridad, errores sin manejar, tests faltantes. Nunca modifica código ni reemplaza la revisión humana |
| **QA / Tester** | Casos de prueba derivados de los criterios de aceptación, qué conviene automatizar, tests en cada PR y una validación con evidencia antes del OK final |
| **Soporte / Operaciones** | Primer diagnóstico de causa raíz de un error de producción, citando evidencia real |

## Cobertura por etapa del SDLC

Las 11 etapas son las del KO de Track 1. **Real**: práctica que ya usa algún equipo de MOA,
generalizada. **Propuesta**: lista para usar, todavía sin piloto.

| # | Etapa | Capacidades | Estado |
|---|---|---|---|
| 1-2 | Recepción y refinamiento del requerimiento | `user-story`, `product-owner` | Real (`product-owner`: propuesta) |
| 3-4 | Planning y desarrollo | `spec-driven-development`, `azure-devops-cli`, `ticket-kickoff`, `git-worktree-setup`, `spec-review`, `spec-reader` | Real (desde `ticket-kickoff`: propuesta) |
| 5 | Apertura del PR | `pr-description` | Propuesta |
| 6 | Code review | `read-only-code-reviewer`, `stack-best-practices-template` | Real |
| 7 | Testing funcional (QA) | `qa-analyst`, `test-case-generation`, `test-validator` | Propuesta |
| 8 | Test de regresión | `regression-test-generation`, `test-pipeline-setup` | Propuesta (sin pruebas de interfaz en pipeline) |
| 9 | Cierre del ticket | `ticket-closure-assist`, `ticket-update` | Propuesta |
| 10 | Soporte productivo | `production-incident-investigation` | Propuesta (parcial) |
| 11 | Build & CI | `azure-devops-cli`, `test-pipeline-setup` | Real (`test-pipeline-setup`: propuesta) |

Detalle por etapa: [`architecture/ai-sdlc.md`](architecture/ai-sdlc.md).

## Estado actual

- **Validado con pruebas reales**:
  - instalación y actualización con `moa-ai.ps1`;
  - skills en VS Code;
  - agentes, subagentes, Instructions y Workflow en Copilot CLI;
  - `product-owner` leyendo tickets de Jira MOA y Jira Baufest en VS Code.

  Detalle: [`tools/copilot/VALIDATION.md`](tools/copilot/VALIDATION.md).
- **Pendiente**:
  - el resto de los agentes en VS Code;
  - la escritura en Jira;
  - la medición de valor con baseline.
- **Límites conocidos**:
  - un sitio de Jira por vez;
  - Jira no funciona desde Copilot CLI;
  - Integrations no se distribuyen con el plugin.

## Para quienes mantienen o gobiernan el modelo

| Qué se busca | Dónde |
|---|---|
| Catálogo técnico con evidencia | [`registry/INDEX.md`](registry/INDEX.md) |
| Arquitectura y modelo de capacidades | [`architecture/reference-architecture.md`](architecture/reference-architecture.md) · [`architecture/capability-model.md`](architecture/capability-model.md) |
| Adoptar, adaptar y contribuir | [`adoption/getting-started.md`](adoption/getting-started.md) · [`adoption/team-adaptation.md`](adoption/team-adaptation.md) · [`adoption/contribution-guide.md`](adoption/contribution-guide.md) |
| Evidencia, evaluación y medición | [`architecture/evidence-evaluation-measurement.md`](architecture/evidence-evaluation-measurement.md) · [`evidence/`](evidence/README.md) |
| Golden Paths | [`golden-paths/README.md`](golden-paths/README.md) |
| Gobierno, decisiones pendientes y seguridad | [`governance/BLOCKED-DECISIONS.md`](governance/BLOCKED-DECISIONS.md) · [`security/security-governance.md`](security/security-governance.md) |
| Estrategia e historial de construcción | [`strategy/`](strategy/) · [`docs/history/track-1/`](docs/history/track-1/) |
| Cambios por versión | [`CHANGELOG.md`](CHANGELOG.md) |
