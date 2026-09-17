# Contribution Guide

Cómo reportar feedback y cómo proponer que algo se vuelva reutilizable — con la
limitación real declarada primero, no escondida.

## Limitación honesta, primero

El primer controlled dry-run ([historial](../docs/history/track-1/G4.4-Real-Adoption-Pilot.md))
— no un piloto real independiente — confirmó que hoy **no hay un evaluador/receptor con
mandato confirmado** para nada de esto — `../governance/BLOCKED-DECISIONS.md` #1. Este
documento describe el mecanismo (cómo se hace), no promete que alguien va a responder de
inmediato. Conviene seguir los pasos igual — es lo que deja el trabajo trazable para
cuando esa decisión se resuelva.

## Reportar feedback

No hay un formulario — el mecanismo es abrir una Pull Request (o su equivalente en Azure
DevOps) contra este repositorio, igual que cualquier cambio de código. En la descripción,
corresponde responder lo que se pueda de esto (sin inventar una respuesta si no se
tiene):

- ¿La capability fue útil?
- ¿Qué parte redujo trabajo?
- ¿Qué parte generó retrabajo?
- ¿Qué hubo que adaptar?
- ¿Qué faltó?
- ¿Se volvería a usar?
- ¿Qué se cambiaría?

Si el feedback aplica a una capacidad específica del Registry, corresponde actualizar
también el campo `Real Use Status` de esa entrada si existe evidencia directa de
haberla usado — no debe dejarse en blanco, pero tampoco debe declararse `VERIFIED` sin
evidencia real (ver `../architecture/capability-registry.md`).

## Proponer una capacidad para reutilización (Contribution Model)

```text
Team-Specific → Candidate → Evidence → Assessment → Evaluation → Pilot →
Measurement → Human Validation → Reusable Capability → Common Core
```

1. **Team-Specific**: ya existe algo funcionando en el repositorio propio.
2. **Candidate**: agregar una entrada en `../registry/entries/` describiéndola
   (`Corporate Standard: N`, honesto). Esto no requiere aprobación de nadie — es
   autoservicio.
3. **Evidence**: completar al menos un Evidence Record real (no inventado) — ver
   [`../adoption/templates/evidence-record.md`](../adoption/templates/evidence-record.md)
   como plantilla.
4. **Assessment**: aplicar el rubric de 14 dimensiones de
   `../architecture/assessment-gate.md` como primer filtro.
5. **Evaluation**: completar un Evaluation Record — si se puede conseguir una revisión de
   alguien distinto de quien ejecutó, mejor (ver `evaluation-observability.md`).
6. **Pilot**: si el assessment inicial es favorable, solicitar que otro equipo lo pruebe.
7. **Measurement**: completar un Measurement Result — `NOT MEASURED` con razón es un
   resultado válido si no hay baseline.
8. **Human Validation**: acá es donde el proceso **está bloqueado hoy** — no hay quién
   apruebe formalmente. Corresponde abrir la PR igual, documentando que se llegó hasta
   este punto — queda trazable para cuando se resuelva.
9. **Reusable Capability → Common Core**: solo ocurre después del paso 8. **Nadie debe
   marcar `Corporate Standard: Y` sin ese paso cumplido** (regla dura, sin excepción).

## Versionar, mantener, retirar

- **Versionar**: si se modifica el contenido de una capacidad, corresponde actualizar
  `Version` en su entrada del Registry y `Last Review`.
- **Mantener**: quien más la usa puede considerarse `Maintainer` de facto — el campo
  formal sigue `REQUIRES VALIDATION` hasta que haya un proceso de asignación real.
- **Retirar**: si se dejó de usar, corresponde actualizar `Lifecycle State` a `Deprecate`
  con motivo explícito (no por antigüedad) — ver `../architecture/lifecycle.md`.
