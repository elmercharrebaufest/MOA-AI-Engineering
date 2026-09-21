# Production Diagnostics Provider (pattern) — AWS CloudWatch + Azure Application Insights

**Registry**: [`CAP-017`](../registry/entries/production-incident-investigation.md)
(`production-incident-investigation`) — este patrón es la implementación ejecutable de las
"Consultas de referencia" que el propio `AGENT.md` ya define, para las 2 plataformas con
evidencia real de uso en MOA.
**Action Type**: **READ**. No implementa `ACT` — ninguna de las 2 mitades escribe, borra ni
modifica ningún recurso.

## Origen de este patrón

**Existing Practice**: relevamiento real de 6 repos de equipos de MOA (2026-09-21) confirmó
infraestructura híbrida — Application Insights ya en uso real de producción en Orquestador
y Scato Logística; AWS (ECS/RDS) ya en uso real de producción en Portal de Créditos y
ScatoPuerto. **External Best Practice**: mismo mecanismo oficial de consulta que cada
plataforma documenta (`aws logs start-query`/`get-query-results` para CloudWatch Logs
Insights; `az monitor app-insights query` para Application Insights) — no una API
inventada. **Architectural Judgment**: las 4 consultas (excepciones recientes, requests
fallidos, performance, timeline de operación) son las mismas que ya define CAP-017 — este
patrón no inventa un vocabulario nuevo, solo lo hace ejecutable contra las 2 plataformas
reales de MOA.

## Alcance — qué cubre y qué no

| Plataforma | Cubierta | Mecanismo |
|---|---|---|
| Azure (Application Insights) | Sí | [`scripts/azure-appinsights-diagnostics.ps1`](scripts/azure-appinsights-diagnostics.ps1) |
| AWS (CloudWatch Logs) | Sí | [`scripts/aws-cloudwatch-diagnostics.ps1`](scripts/aws-cloudwatch-diagnostics.ps1) |
| On-premise | No | Sin herramienta nativa identificada — `REQUIRES VALIDATION`, ver `registry/entries/production-incident-investigation.md` |

## Flujo

```text
Incidente reportado (CAP-017) → falta evidencia además de lo pegado a mano
        ↓
¿Dónde corre la app? (Azure / AWS — ver adoption/production-diagnostics-quickstart.md)
        ↓
Script correspondiente, con el QueryType que corresponda al paso de CAP-017
        ↓
Resultado estructurado (JSON) con retrievalStatus explícito
        ↓
CAP-017 lo cita como evidencia real en el reporte de investigación
```

## Input común a ambos scripts

```
QueryType: recent-exceptions | failed-requests | performance | operation-timeline
(operation-timeline requiere además el ID de operación/request puntual)
```

## Output común (ambos scripts, mismo contrato)

```json
{
  "source": "aws-cloudwatch | azure-application-insights",
  "queryType": "...",
  "retrievalStatus": "SUCCESS | PARTIAL | NOT_FOUND | FORBIDDEN | UNAUTHORIZED | SOURCE_UNAVAILABLE | INVALID_REQUEST",
  "retrievedAt": "...",
  "results": [...],
  "provenance": "aws-cloudwatch-diagnostics v1 (aws cli) | azure-appinsights-diagnostics v1 (az cli)",
  "error": null
}
```

## Dependencia

- **AWS**: AWS CLI (`aws`) con una sesión/credenciales ya configuradas — nunca hardcoded en
  este patrón. Ver [`../adoption/production-diagnostics-quickstart.md`](../adoption/production-diagnostics-quickstart.md).
- **Azure**: Azure CLI (`az`) con sesión autenticada (`az login`) — mismo mecanismo ya real
  de CAP-002/CAP-008.

## Autenticación requerida

**No definida por este patrón** — depende de la cuenta/credencial con la que `aws`/`az`
estén autenticados en el entorno de cada equipo, mismo principio ya vigente en CAP-002/
CAP-008/CAP-003: *"este patrón no define ni eleva permisos, opera con los que ya existen en
el entorno."*

## Permisos mínimos

- **AWS**: solo lectura sobre CloudWatch Logs (`logs:StartQuery`, `logs:GetQueryResults`) —
  nunca permisos de escritura ni de administración de otros servicios.
- **Azure**: solo lectura sobre el recurso de Application Insights — nunca permisos de
  escritura ni de administración de la suscripción.

## Errores

| Situación | `retrievalStatus` |
|---|---|
| Log group / aplicación no existe | `NOT_FOUND` |
| Sesión no autenticada / permisos insuficientes | `UNAUTHORIZED` / `FORBIDDEN` — se reporta el error real de `aws`/`az`, nunca se asume un resultado vacío como válido |
| Consulta corrió pero no encontró resultados en la ventana de tiempo | `PARTIAL` |
| CloudWatch Logs Insights no terminó dentro del tiempo de espera del script | `PARTIAL`, con la sugerencia de acotar la ventana |

## Límites

- No pagina resultados grandes más allá de lo que cada consulta ya acota (`limit`/`take`).
- No resuelve automáticamente a qué log group / App ID corresponde un servicio — ese mapeo
  es Team Adaptation (ver `AGENT.md` de CAP-017, paso 1: "resolver a qué servicio se
  refiere el incidente").
- No cubre on-premise — ver tabla de Alcance arriba.

## Provenance

Todo resultado producido por estos scripts declara su `provenance` exacto — permite
distinguir, en el reporte de CAP-017, qué mecanismo produjo cada evidencia citada.

## Evidencia

Ninguno de los 2 scripts tiene ejecución real todavía — son la implementación ejecutable
del patrón, construida sobre el mecanismo oficial de cada plataforma, sin haber corrido
contra un recurso real de producción de MOA. `Real Use Status: NOT FOUND`.

## Implementación ejecutable

- [`scripts/aws-cloudwatch-diagnostics.ps1`](scripts/aws-cloudwatch-diagnostics.ps1)
- [`scripts/azure-appinsights-diagnostics.ps1`](scripts/azure-appinsights-diagnostics.ps1)
- Guía de conexión (tokens/credenciales, paso a paso, en lenguaje simple):
  [`../adoption/production-diagnostics-quickstart.md`](../adoption/production-diagnostics-quickstart.md).

## Qué es Team Adaptation, explícitamente

- Qué log group (AWS) o App ID (Azure) corresponde a cada servicio/componente real.
- La identidad/autenticación usada por `aws`/`az` en el entorno de cada equipo.
- La región de AWS real (`us-east-1` es la que ya se confirmó en uso, pero puede variar).
