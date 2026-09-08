# Assessment — metodología

El pipeline que cualquier capacidad debe atravesar antes de promoverse a candidata de
Common Core — desde identificar el problema real hasta la decisión de reutilización.

> El rubric multi-dimensión que se aplica en los pasos "Assessment" y "Validación" del
> pipeline de abajo está elaborado en
> [`../architecture/assessment-gate.md`](../architecture/assessment-gate.md) (14
> dimensiones: Value, Reusability, Quality, Security, Data, Risk, Integration, Autonomy,
> HITL, Evaluation, Observability, Metrics, Ownership, Lifecycle). Este documento sigue
> siendo la referencia del proceso completo — no se duplica.

## Principio central

El objetivo del Track 1 **no es agregar más IA**. Es transformar la IA que MOA ya usa
—hoy real pero heterogénea entre equipos— en una práctica de ingeniería sistemática,
reutilizable, gobernada y medible. No se crea un Agent, Skill o MCP porque la tecnología
esté disponible o de moda; se crea porque un proceso/problema real lo justifica después de
pasar por este pipeline.

**Ninguna capacidad existente en un equipo es automáticamente un estándar corporativo.**
Encontrar un patrón real y maduro en un repo (por ejemplo, `AGENTS.md` + agentes por rol +
skills en `DataAgro`/`Scato Logística` — ver
[relevamiento histórico de capacidades](../docs/history/track-1/relevamiento-capacidades-g2.md)) no significa que deba
replicarse a los demás equipos. Primero debe demostrar **valor, calidad, seguridad,
reutilización y resultados** a través de este pipeline.

## Pipeline obligatorio (no empezar por la tecnología)

```
Problema/proceso
   → Use Case
   → Valor esperado + Riesgo
   → Assessment
   → Selección de la capacidad adecuada
   → Evaluación
   → Piloto
   → Medición
   → Gobierno
   → Validación
   → Reutilización / escalamiento
```

La "capacidad adecuada" puede ser, según el caso: **Prompt, Instruction, Skill, Workflow,
Knowledge/RAG, Agent, MCP/API/Tool, Automation**, o una combinación. No se asume que todo
problema requiere un Agent — la mayoría de los patrones reales encontrados en MOA hasta
ahora son Instructions y Skills, no Agents autónomos (ver relevamiento).

## Taxonomía de evaluación (5 categorías)

- **FACT** — evidencia comprobada en MOA (código real, configuración real, uso real
  observado). No basta con que algo aparezca mencionado en una presentación, nombre de
  archivo, backlog o documentación — requiere evidencia verificable.
- **INFERENCE** — conclusión razonable derivada de la evidencia (ej. inferir el problema
  que resuelve un skill a partir de su contenido, cuando no está documentado
  explícitamente).
- **PROPOSAL** — recomendación arquitectónica, no es decisión oficial de MOA.
- **EXTERNAL EVIDENCE** — buena práctica o benchmark externo a MOA. Este repositorio no
  produce investigación externa por iniciativa propia; se incorpora cuando el
  Arquitecto/usuario la aporta (típicamente desde su trabajo de research con el supervisor
  arquitectónico externo a este repo).
- **REQUIRES VALIDATION** — información o decisión pendiente de confirmar con MOA.

## Roles en este flujo de trabajo

```
Usuario / Arquitecto de Soluciones — decisiones arquitectónicas finales
        ↓
Supervisor arquitectónico externo — investigación externa, benchmarks, evaluación
        ↓
Este repositorio (implementación/análisis) — inspecciona evidencia real en repos y
documentación de MOA, materializa decisiones ya tomadas, genera documentación y
artefactos, identifica inconsistencias, señala incertidumbres y dependencias
        ↓
Contenido de MOA-AI-Engineering
```

Las decisiones de qué capacidad se adopta, adapta, descarta, o se promueve a REUSABLE, son
del Arquitecto de Soluciones — este repositorio prepara el relevamiento y el assessment,
no decide la promoción.

## Estado del pipeline

Los 6 pasos de este pipeline ya se recorrieron una vez, de punta a punta:

1. **Comprender qué existe realmente en MOA** — completo, ver
   [relevamiento histórico de capacidades](../docs/history/track-1/relevamiento-capacidades-g2.md).
2. **Relevar las prácticas de los distintos equipos** — completo, mismo documento.
3. **Contrastar con buenas prácticas externas (EXTERNAL EVIDENCE)** — completo, ver
   fuentes citadas en [`../capabilities/best-practices.md`](../capabilities/best-practices.md).
4. **Identificar qué debe ADOPTARSE, ADAPTARSE o DESCARTARSE** por capacidad — completo,
   ver clasificación por capacidad en [`../registry/INDEX.md`](../registry/INDEX.md).
5. **Definir el modelo de referencia de AI Engineering** — completo,
   [`../architecture/reference-architecture.md`](../architecture/reference-architecture.md).
6. **Materializar el modelo** (capacidades reales, no solo conceptos) — completo,
   [`../capabilities/README.md`](../capabilities/README.md).

Esto **no significa que el pipeline esté "terminado" para siempre** — cualquier
capacidad nueva que un equipo proponga vuelve a atravesar los 6 pasos desde el principio
(ver [`../adoption/contribution-guide.md`](../adoption/contribution-guide.md)).

## Cómo usar esta carpeta

- [Relevamiento histórico de capacidades](../docs/history/track-1/relevamiento-capacidades-g2.md)
  — inventario FACT de capacidades de IA reales encontradas por equipo/repo en el
  relevamiento original, sin recomendación de adopción.
- Para la clasificación actual de cada capacidad (ADOPT/ADAPT/TEAM-SPECIFIC/EXPERIMENTAL)
  y su evidencia, ver [`../registry/INDEX.md`](../registry/INDEX.md) — no se duplica acá.
