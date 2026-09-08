# KPIs propuestos (KO Interno)

> **Advertencia de origen (FACT, cita literal del KO, pág. 19):** *"Esta propuesta de
> métricas son una estrategia inicial que consideramos de valor, pero que se deberán
> refinar en base a las necesidades de MOA y la disponibilidad de la información en los
> sistemas de gestión actuales."* y *"Porcentajes proyectados sobre una media de las
> métricas actuales del primer Half - 2026."*
>
> Es decir: **estas son metas propuestas por Baufest en el KO, no compromisos medidos ni
> ratificados por MOA.** Clasificación: **PROPOSAL**.

## Indicadores de adopción, productividad y velocidad (FACT — KO Interno, pág. 18)

- % Team con Copilot (GitHub + M365) — *adopción*
- # HU refinadas por sprint/mes (HU completas y listas para desarrollar) — *productividad y velocidad*
- % Aceptación de sugerencias de Copilot (presentadas vs. aceptadas) — *adopción*
- # Requerimientos/Mejoras por sprint/mes — *productividad y velocidad*
- Lead time de features (HU → producción) — *productividad y velocidad*

## Indicadores de impacto y calidad (FACT — KO Interno, pág. 18)

- # Bugs detectados por sprint/mes (QA & PROD)
- Calidad de código — SonarQube (Reliability Grade, Vulnerabilities, Code Coverage)

Consolidación propuesta: Dashboard Ejecutivo (datos de GitHub y Jira) + SonarQube directo.

## Metas por objetivo, Q3 y Q4 2026 (PROPOSAL — proyecciones del KO, pág. 19)

### + Productividad y Velocidad

| Métrica | Q3 2026 | Q4 2026 |
|---|---|---|
| # HU refinadas / sprint·mes | +5% | +10% |
| # Reqs/Mejoras / sprint·mes | +15% | +30% |
| Lead time de features | -10% | -20% |
| Productividad DEVs | +15% | +30% |

### > Adopción y Evolución

| Q3 2026 | Q4 2026 |
|---|---|
| 100% Team con Copilot | Conocimiento compartido |
| Integración con herramientas | Repositorio de Skills/Prompts |
| Tablero de métricas disponible | Prácticas homogéneas |
| SonarQube instalado | — |

### + Impacto y Calidad

| Métrica | Q3 2026 | Q4 2026 |
|---|---|---|
| Unit Tests (SonarQube, global) | +5% | +15% |
| Bugs en QA/PROD | -5% | -10% |
| Tiempo de generación de casos de prueba | -10% | (mantenido) |
| Reliability Grade (SonarQube) | — | A o B |
| Vulnerabilidades críticas (SonarQube) | — | Cero |

## Metas por equipo a Q4 2026 (FACT — KO Interno, pág. 20)

Ver detalle en [`../strategy/maturity-model.md`](../strategy/maturity-model.md), sección
"Objetivo de evolución a Q4 2026 por equipo".

## Qué se necesita antes de poder reportar estos KPIs con evidencia real

1. **Baseline medido** del primer semestre 2026 (el KO asume que existe una "media
   actual" pero no la publica en el documento fuente — **[REQUIRES VALIDATION]**).
2. SonarQube efectivamente instalado y conectado (`moa-metrics` ya tiene el conector
   listo, falta confirmar la fuente real).
3. Confirmar que `moa-metrics` está corriendo en producción y alimentando un warehouse
   real, no solo el código de los conectores/indicadores.
