# Modelo de equipos

## Principio (FACT — brief de la iniciativa)

> "MOA-AI-Engineering establece la base común; cada equipo decide qué adoptar, adaptar o
> no utilizar según sus necesidades, manteniendo los principios y controles
> corporativos."

Ningún equipo está obligado a usar exactamente las mismas herramientas o prácticas que
otro. Este repositorio no reemplaza los repos de cada equipo — los referencia.

## Equipos reales de MOA con evidencia directa

**Actualizado 2026-09-22** — relevamiento de infraestructura real sobre los 6 repos
disponibles (`git`/archivos de configuración reales, no inferencia). El stack tecnológico
exacto por proyecto se está confirmando (ver nota al final de esta sección); esta tabla se
completa apenas esté listo.

| Equipo | Repositorio(s) real(es) | Dónde corre en producción (FACT) | Madurez de IA (FACT, relevamiento 2026-09-04) |
|---|---|---|---|
| DataAgro | `DataAgro/DataAgro` | On-premise (IIS/MSDeploy — servidor destino no confirmado); depende de un scoring API en AWS API Gateway (`us-east-1`); integra SAP on-premise | Agents/Skills/Instructions **formalizados** (`.github/copilot-instructions.md`, `.github/agents/`); uso efectivo `REQUIRES VALIDATION` |
| Scato Logística | `Scato Logistica/Scato%20Logistica` (+ `WebApiCoreAfip`, `PocScatoLogisticaAws`) | On-premise (SQL Server `SCATOAGLSPRD.molinosagro.ad`, logs en unidad local); Application Insights (Azure) ya en uso real para observabilidad; POC real (no producción) migrando parte del flujo a AWS Lambda/Step Functions | Agents/Skills/Instructions **formalizados y más integrados** que DataAgro — incluye `copilot-config.yml` con selección de modelo por sub-agente basada en benchmark propio; uso efectivo `REQUIRES VALIDATION` |
| MOA Operaciones | `MoaOperaciones/MoaOperaciones` | On-premise (IIS, SQL Server `MOAOPAGLSPRD`, SAP PI on-premise); dependencias PaaS reales de Azure (Blob Storage, Cognitive Services/OCR, Azure AD B2C) | Sin capacidades de IA formalizadas encontradas en el repo (CRAWL según KO); sí tiene un bot de Microsoft Copilot Studio embebido (producto distinto de GitHub Copilot, no confundir) |
| Scato Puerto | `ScatoPuerto/scatopuerto`, `ScatoPuerto/scatopuertoAPINet` | Base de datos de producción en **AWS RDS** (`us-east-1`) — confirmado por endpoint real; hosting del proceso de la API sin confirmar | Sin capacidades de IA formalizadas encontradas — pese a compartir dominio/arquitectura con Scato Logística |
| Orquestador | `Orquestador/Orquestador`, `Orquestador/OrquestadorAkka`, `Orquestador/Intercomunicador` | On-premise (servidor `AVVWHSCATAPP00`, domain-joined, deploy vía UNC/Web Deploy); Application Insights (Azure) ya en uso real | Sin capacidades de IA formalizadas encontradas |
| **Portal de Créditos** *(nuevo en esta actualización — faltaba en el relevamiento original)* | `AWS Portal de créditos/backend-net`, `.../frontend-angular` | **AWS real en producción**: ECS/Fargate + ECR + S3 + Secrets Manager (`us-east-1`); CI/CD vía Azure DevOps Pipelines; identidad de usuarios vía Entra ID (no es donde corre el cómputo, solo autenticación). Consume un "Motor de Decisiones" externo expuesto vía AWS API Gateway | Sin capacidades de IA formalizadas encontradas más allá de `.github/copilot-instructions.md` básico |

**Conclusión de infraestructura (FACT, no proyección)**: MOA opera una arquitectura
híbrida real — on-premise sigue siendo el núcleo operativo de 3 equipos (Scato Logística,
Orquestador, MoaOperaciones), AWS ya está en producción real para 2 (Portal de Créditos,
base de datos de Scato Puerto), y Azure aparece en todos lados como capa de **servicios e
identidad** (Application Insights, Blob Storage, Cognitive Services, Entra ID/AD B2C), no
como plataforma de cómputo principal en ningún caso relevado. Detalle completo con cada
archivo citado: ver el historial de esta sesión de trabajo (no duplicado acá para no
quedar desactualizado si cambia la infraestructura real).

## Equipos del framework sin implementación documentada aún (REQUIRES VALIDATION)

Data (más allá de métricas), Web Development, QA/Testing, Seguridad, DevOps, Operaciones,
Arquitectura. Para cada uno, antes de crear contenido en `teams/<equipo>/`, se debe:

1. Confirmar que el equipo existe como tal en la estructura real de MOA (no inventar
   equipos a partir de los ejemplos del encuadre fundacional de la iniciativa).
2. Identificar su nivel de madurez actual (Crawl/Walk/Run) con evidencia, no supuestos.
3. Relevar qué stack/herramientas usa hoy, igual que se hizo para el stack general en
   `architecture/reference-architecture.md`.

## Cómo un equipo nuevo se incorpora a este modelo

1. Crear su propio repositorio o carpeta de trabajo (no dentro de `MOA-AI-Engineering`).
2. Documentar su caso de uso inicial con [`../templates/use-case-template.md`](../templates/use-case-template.md).
3. Consultar `governance/ai-governance.md` y `governance/agent-governance.md` para los
   controles corporativos mínimos (human-in-the-loop, matriz de autonomía).
4. Si el equipo produce una capacidad (skill, agente, patrón) que **parece** útil para más
   de un equipo, se documenta como candidata en [`../docs/history/track-1/relevamiento-capacidades-g2.md`](../docs/history/track-1/relevamiento-capacidades-g2.md)
   y pasa por el pipeline de [`../assessment/README.md`](../assessment/README.md)
   (problema → caso de uso → valor/riesgo → assessment → evaluación → piloto → medición →
   gobierno → validación) antes de proponerse como REUSABLE. Ninguna capacidad se promueve
   solo por existir o por parecer útil.
5. Este README se actualiza agregando la fila correspondiente en la tabla de equipos.

## Líderes de la iniciativa (FACT — KO Interno, pág. 17)

- Líderes: Elmer Charre, Fernando Pagano, Tito Picón.
- Soporte: Adrián Bepré, Ariel Bensussán.
- Participantes: todo el equipo (según backlog que se vaya sumando por equipo).

**[REQUIRES VALIDATION]** Confirmar si estos líderes son los responsables de aprobar
contenido de `governance/` en este repositorio, o si existe otro proceso de gobierno.
