# Framework de métricas

## Categorías (FACT — master prompt de la iniciativa)

No se mide únicamente cantidad de usuarios, prompts, código generado o tokens. Se definen
7 categorías:

| Categoría | Pregunta que responde |
|---|---|
| Adoption | ¿Se utiliza? |
| Productivity | ¿Reduce esfuerzo o tiempo? |
| Quality | ¿Mejora calidad? |
| Delivery | ¿Mejora lead time / throughput / time-to-market? |
| Automation | ¿Reduce tareas manuales? |
| Developer Experience | ¿Reduce fricción y context switching? |
| Business Impact | ¿Genera valor real? |

## Ciclo obligatorio: Baseline → Pilot → Measure → Compare (FACT — master prompt)

Ningún porcentaje de mejora debe afirmarse sin este ciclo. Estado actual (REQUIRES
VALIDATION): no hay evidencia de que exista un **baseline medido** todavía; los números
del KO Interno son proyecciones (ver `kpis.md`).

## Los 8 indicadores ya implementados en código (FACT — `moa-metrics`)

`moa-metrics/ia-sdlc/indicators/` ya calcula 6 de los 8 indicadores propuestos en el KO,
con fórmulas y fuentes documentadas en
`moa-metrics/requerimientos-pipeline-indicadores-ia_v3.md`:

| # | Indicador | Módulo | Categoría de este framework |
|---|---|---|---|
| 1 | HU generadas/listas para desarrollar por sprint | *(cubierto por velocity.py, parcial)* | Productivity, Delivery |
| 2 | Código generado con IA y % del total | `code_generation.py` | Adoption, Automation |
| 3 | Aceptación de sugerencias de Copilot | `copilot_adoption.py` | Adoption |
| 4 | Cobertura de adopción (% DEVs con Copilot) | `copilot_adoption.py` | Adoption |
| 5 | Requerimientos/Mejoras por sprint (velocidad) | `velocity.py` | Delivery |
| 6 | Bugs detectados por mes | `bug_ratio.py` | Quality |
| 7 | Calidad de código (SonarQube) | `quality.py` | Quality |
| 8 | Lead time de features | `lead_time.py` | Delivery, Developer Experience |

Explícitamente **fuera de alcance** en `moa-metrics` (decisión ya tomada, FACT): tagging
manual "AI-assisted" en PRs/commits/HU; % código IA se calcula por proxy agregado (líneas
aceptadas por Copilot ÷ líneas mergeadas en Azure DevOps), no por atribución línea a línea.

## Qué falta para completar Business Impact y Developer Experience (REQUIRES VALIDATION)

El framework de `moa-metrics` cubre bien Adoption/Productivity/Quality/Delivery. No hay
indicador implementado ni propuesto en el KO para:

- **Developer Experience** puro (fricción, context switching) más allá del proxy indirecto
  de lead time/productividad.
- **Business Impact** directo (valor de negocio, no solo velocidad de entrega).

Estas dos categorías quedan como brecha explícita a definir con MOA, no se inventan
métricas para llenarlas.

## KPIs propuestos por el KO

Ver [`kpis.md`](kpis.md) para las metas concretas Q3/Q4 2026 (marcadas como proyección,
no baseline).
