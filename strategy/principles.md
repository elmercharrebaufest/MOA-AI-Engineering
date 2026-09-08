# Principios

**Origen:** master prompt / brief de la iniciativa (definido por el Arquitecto de
Soluciones responsable del Track 1). Clasificación: **PROPOSAL** — operan como principios
de trabajo de este repositorio hasta que sean ratificados formalmente por el gobierno de
MOA (ver pregunta abierta en [`roadmap.md`](roadmap.md)).

1. **AI augments people, it does not blindly replace them.**
2. **Human-in-the-loop** obligatorio cuando las acciones puedan afectar código crítico,
   infraestructura, seguridad, datos, producción o decisiones relevantes.
3. **Security by Design.**
4. **Evidence over assumptions** — no se afirman mejoras sin datos que las respalden.
5. **Measure real impact, not only AI usage** — adopción es una métrica, no el objetivo.
6. **Reuse before reinventing** — pero la reutilización de una capacidad de un equipo por
   otro nunca es automática: debe pasar por el pipeline de assessment de
   [`../assessment/README.md`](../assessment/README.md) (valor, riesgo, calidad,
   seguridad, resultados) antes de proponerse como REUSABLE.
7. **Team autonomy within governance** — cada equipo decide qué adoptar, dentro de los
   controles corporativos.
8. **Start small and scale progressively.**
9. **Crawl → Walk → Run** (ver [`maturity-model.md`](maturity-model.md)).
10. **Experimentation must lead to measurable learning.**
11. **Capabilities should be reusable whenever possible.**
12. **Governance must enable adoption, not unnecessarily block it.**

## Cómo se aplican estos principios en este repositorio

| Principio | Mecanismo concreto |
|---|---|
| Human-in-the-loop | Todo agente documentado en `governance/agent-governance.md` debe declarar su punto de validación humana (paso VALIDATION del pipeline). |
| Team autonomy within governance | Estructura de 3 capas: `governance/` (corporate), `templates/`+capacidades promovidas (reusable), `teams/<equipo>/` (team-specific). |
| Evidence over assumptions | Todo dato cuantitativo en `metrics/kpis.md` está marcado como medido (FACT) o proyectado (PROPOSAL), nunca se presenta como logro confirmado sin baseline. |
| Reuse before reinventing | `teams/README.md` referencia los repos reales de los equipos (DataAgro, Scato Logística, etc.) y las herramientas de Baufest (`moa-sdlc`, `moa-metrics`) en vez de duplicar su contenido. |
| Start small / Crawl-Walk-Run | Este repositorio arranca con estructura reducida (ver README) y crece por fases (ver `roadmap.md`). |
