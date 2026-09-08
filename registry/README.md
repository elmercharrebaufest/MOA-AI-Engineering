# Capability Registry — README

**Fase**: G4.2 (MVP). **Estado**: PROPOSAL — mecanismo operativo mínimo, no una base de
datos ni servicio (decisión de diseño ya tomada en
[`../docs/architecture/G4.1-Product-Architecture-Baseline.md`](../docs/architecture/G4.1-Product-Architecture-Baseline.md)).
Este README documenta el mecanismo; el **schema** de campos está definido en
[`../docs/architecture/capability-registry.md`](../docs/architecture/capability-registry.md)
— no se duplica acá, se reutiliza.

## Propósito

Ser el **source of truth versionado en git** de qué capacidades de IA existen en MOA, con
qué evidencia, en qué estado, y quién las usa — reemplazando progresivamente a
[`../assessment/relevamiento-capacidades.md`](../assessment/relevamiento-capacidades.md)
(que sigue siendo válido como relevamiento narrativo original de G2, no se borra).

## Estructura

```
registry/
├── README.md      (este archivo)
├── INDEX.md        Mecanismo de discovery — índice manual, agrupado por tipo/equipo/estado
└── entries/         Un archivo por capability, siguiendo el schema de capability-registry.md
```

## Schema

Los 27 campos (18 originales de G3.1 + 6 de G3.3 + 3 de G3.3 Corrections) están definidos
en [`capability-registry.md`](../docs/architecture/capability-registry.md). Cada archivo en
`entries/` los completa. **Regla dura, sin excepción**: si un campo no tiene evidencia
directa, se marca `REQUIRES VALIDATION` — nunca se infiere ni se inventa. Si depende de
una decisión bloqueada, se marca `BLOCKED` con referencia al ítem de
[`../docs/architecture/BLOCKED-DECISIONS.md`](../docs/architecture/BLOCKED-DECISIONS.md).

## Dos clases de entrada (ya definidas en G4.1, sección 7)

1. **Team-Specific** (`Corporate Standard: N`) — cualquier equipo puede agregar una
   entrada describiendo su propia capacidad, sin necesidad de pasar el Assessment Gate.
   Es puramente informativa/de discovery.
2. **Common Core Candidate → Corporate Standard** (`Corporate Standard: Y`) — requiere
   haber pasado el rubric de 14 dimensiones de
   [`assessment-gate.md`](../docs/architecture/assessment-gate.md) y **Human Validation**
   explícita (ver `lifecycle.md`). **Ninguna entrada de este Registry tiene hoy
   `Corporate Standard: Y`** — el mecanismo existe, pero ninguna capacidad completó el
   Gate todavía.

## Estados que usa una entrada

- **`Lifecycle State`**: posición dentro del **Capability Lifecycle** de
  [`lifecycle.md`](../docs/architecture/lifecycle.md) (Use Case→...→Promote). No confundir
  con `Corporate Standard` (Adoption Status — Y/N, no secuencial).
- **`Configuration Status`** y **`Real Use Status`**: independientes entre sí y de
  `Evaluation Status`/`Observability Status`. **Nunca se infiere Real Use desde
  Configuration ni desde Evaluation/Observability** (regla fijada en G3.3 Corrections, sin
  excepción en este Registry).

## Ownership

**BLOCKED** — ver `BLOCKED-DECISIONS.md` #1. No hay owner formal del Registry todavía.
Mientras tanto: cualquier equipo puede proponer una entrada Team-Specific; la aprobación
de `Corporate Standard: Y` recae, de facto y sin mandato organizacional confirmado, en el
Solutions Architect de esta iniciativa.

## Cómo registrar una capability nueva

1. Copiar la estructura de una entrada existente en `entries/` (no hay template separado
   todavía — evita duplicar `capability-registry.md`).
2. Completar los 27 campos con evidencia real. Si falta evidencia para alguno,
   `REQUIRES VALIDATION`, nunca un valor inventado.
3. Clasificar como Team-Specific por default (`Corporate Standard: N`).
4. Abrir una Pull Request (mecanismo de contribución ya definido en G4.1, sección 10 —
   reutiliza el flujo de PR existente, no se inventa tooling nuevo).
5. Actualizar `INDEX.md` con la nueva entrada.

## Cómo actualizar una capability existente

1. Editar el archivo de `entries/` correspondiente.
2. Incrementar `Version` si cambió el contenido de la capacidad (no si solo se corrigió un
   campo del Registry).
3. Actualizar `Last Review` con la fecha de la revisión.
4. Si el cambio afecta `Corporate Standard`, requiere pasar (de nuevo) por
   `assessment-gate.md` — no se cambia ese campo directamente.

## Cómo deprecar una capability

1. Cambiar `Lifecycle State` a `Deprecate`, con justificación explícita (no por
   antigüedad — regla dura de `lifecycle.md`).
2. Cuando se confirme cero `Adopters` activos, cambiar a `Retire`.
3. La entrada **no se borra** — el Registry conserva historial (ya lo hace git de forma
   nativa).

## Relación con el resto del modelo

No duplica contenido de `capability-model.md` (taxonomía), `lifecycle.md` (estados),
`assessment-gate.md` (rubric de promoción), `evaluation-observability.md` (contratos de
Evaluation/Observability/Metrics) ni `golden-paths.md` (caminos de adopción) — este README
y las entradas de `entries/` son la instancia operativa de esos modelos conceptuales.
