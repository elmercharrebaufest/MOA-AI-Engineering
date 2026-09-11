# G8 — `research.md` y `contracts/` incorporados a `spec-driven-development` (CAP-004)

**Fase**: G8. **Estado**: FACT donde se cita evidencia; PROPOSAL en lo incorporado sin
evidencia real. Precondición: G7 (records/ por tarea). Solo se modificó
`MOA-AI-Engineering`.

## 1. Disparador

Al validar contra el .md CORE si `moa-sdlc` había adoptado buenas prácticas de GitHub
(Spec Kit), surgió una comparación literal archivo-por-archivo entre nuestro modelo
(CAP-004) y Spec Kit — 2 artefactos de Spec Kit (`research.md`, `contracts/`) no tenían
equivalente formal en `capabilities/workflows/spec-driven-development/WORKFLOW.md`. El
Solutions Architect pidió explícitamente que el modelo adopte "el nivel más maduro y
adoptable" — decisión suya, no una inferencia mía.

## 2. Decisión, con evidencia separada por artefacto (sin mezclar)

| Artefacto | Evidencia interna real | Decisión |
|---|---|---|
| `research.md` | **Sí existe, informal** — `moa-sdlc/_sdd/specs/MOA-1765-DistribuidorCupos/plan-distribucionCuposSL-v2.md` + `_old_v1.md` + `req/` ya cumplen esta función, sin el nombre formal | Formalizado — `CONFIGURED` por reclasificación de evidencia ya real, no una capacidad inventada |
| `contracts/` | **No se encontró** ninguna instancia real en ningún repo de MOA relevado | Incorporado como `NOT FOUND`/PROPOSAL puro — gap real identificado (endpoints reales sin contrato pre-implementación, ej. `R16` de `MOA-1765`), no evidencia de uso |

Ambos quedan **opcionales**, no obligatorios — condicionados a que la feature real lo
justifique (investigación real que documentar; API real que definir antes de
implementar), mismo principio que rige el resto del Workflow desde G5.1.

## 3. Qué NO cambió

- Los nombres de archivo ya definidos (`requirements.md`, `design.md`, `tasks.md`,
  `feature.json`) — el usuario confirmó explícitamente mantenerlos (no alinear a
  `spec.md`/`plan.md` de Spec Kit sin necesidad real).
- Ningún caso real existente (`MOA-1765`, `MOA-1816`, ambos niveles) deja de cumplir el
  Workflow por no tener `research.md`/`contracts/` — son aditivos, no retroactivos.
- El contrato JSON *entre roles* del nivel Full (`mustNotChange`/`mustAskBefore`) — se
  aclaró explícitamente en `WORKFLOW.md` que es un concepto distinto de `contracts/`
  (proceso vs. API técnica), para no confundir vocabulario.

## 4. Archivos modificados

`capabilities/workflows/spec-driven-development/WORKFLOW.md` (nueva sección "Artefactos
ampliados", `Salidas` actualizada, instrucciones del Spec Author actualizadas, versión
`1.0-generalized` → `1.1-generalized`), `registry/entries/spec-driven-development.md`
(campo `Version` + nota de ampliación).

## 5. Estado final

Extensión aditiva, sin romper compatibilidad, con la evidencia de cada mitad declarada
por separado y sin inflar lo que no tiene uso real todavía. Pendiente de commit/push a
confirmación del usuario.
