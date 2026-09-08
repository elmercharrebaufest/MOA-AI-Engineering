# Assessment — metodología

**Origen (FACT):** encuadre explícito del Arquitecto de Soluciones responsable del Track
1 (2026-09-04), que corrige y precisa el alcance de la fase Foundation de este
repositorio.

> **G3.3**: el rubric multi-dimensión que se aplica en los pasos "Assessment" y
> "Validación" del pipeline de abajo está elaborado en
> [`../docs/architecture/assessment-gate.md`](../docs/architecture/assessment-gate.md) (14
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
[`relevamiento-capacidades.md`](relevamiento-capacidades.md)) no significa que deba
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

## Etapa actual (FACT — 2026-09-04)

Estamos construyendo la base arquitectónica de "MOA AI Engineering". Orden de trabajo,
sin adelantar implementación tecnológica nueva hasta completar los primeros pasos:

1. **Comprender qué existe realmente en MOA** — en curso, ver
   [`relevamiento-capacidades.md`](relevamiento-capacidades.md).
2. **Relevar las prácticas de los distintos equipos** — en curso, mismo documento.
3. **Contrastar con buenas prácticas externas (EXTERNAL EVIDENCE)** — pendiente, insumo
   externo del Arquitecto.
4. **Identificar qué debe ADOPTARSE, ADAPTARSE o DESCARTARSE** por capacidad — pendiente,
   requiere completar este pipeline por cada capacidad candidata, no es una recomendación
   directa desde el relevamiento.
5. **Definir el modelo de referencia de AI Engineering** — pendiente, posterior al paso 4.
6. **Materializar el modelo** (arquitectura, gobierno, patrones, capacidades, pilotos) —
   fase posterior, no iniciada.

## Cómo usar esta carpeta

- [`relevamiento-capacidades.md`](relevamiento-capacidades.md) — inventario FACT de
  capacidades de IA reales encontradas por equipo/repo, sin recomendación de adopción.
- Próximos documentos de esta carpeta (a medida que se avance en el pipeline):
  assessment individual por capacidad candidata (valor/riesgo), resultados de pilotos,
  decisiones de adopción/adaptación/descarte ya tomadas por el Arquitecto.
