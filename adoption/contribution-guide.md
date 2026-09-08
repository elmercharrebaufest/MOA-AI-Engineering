# Contribution Guide

Cómo reportar feedback y cómo proponer que algo se vuelva reutilizable — con la
limitación real declarada primero, no escondida.

## Limitación honesta, primero

El primer controlled dry-run (`../docs/architecture/G4.4-Real-Adoption-Pilot.md`) — no un
piloto real independiente — confirmó que
hoy **no hay un evaluador/receptor con mandato confirmado** para nada de esto —
`../docs/architecture/BLOCKED-DECISIONS.md` #1. Este documento describe el mecanismo
(cómo se hace), no promete que alguien va a responder de inmediato. Seguí los pasos igual
— es lo que deja el trabajo trazable para cuando esa decisión se resuelva.

## Reportar feedback

No hay un formulario — el mecanismo es abrir una Pull Request (o su equivalente en Azure
DevOps) contra este repositorio, igual que cualquier cambio de código. En la descripción,
respondé lo que puedas de esto (no inventes una respuesta si no la tenés):

- ¿La capability fue útil?
- ¿Qué parte redujo trabajo?
- ¿Qué parte generó retrabajo?
- ¿Qué tuviste que adaptar?
- ¿Qué faltó?
- ¿La volverías a usar?
- ¿Qué cambiarías?

Si tu feedback aplica a una capacidad específica del Registry, actualizá también el campo
`Real Use Status` de esa entrada si tenés evidencia directa de haberla usado — no lo dejes
en blanco, pero tampoco pongas `VERIFIED` sin evidencia real (ver
`../docs/architecture/capability-registry.md`).

## Proponer una capacidad para reutilización (Contribution Model)

```
Team-Specific → Candidate → Evidence → Assessment → Evaluation → Pilot →
Measurement → Human Validation → Reusable Capability → Common Core
```

1. **Team-Specific**: ya tenés algo funcionando en tu propio repo.
2. **Candidate**: agregá una entrada en `../registry/entries/` describiéndola (`Corporate
   Standard: N`, honesto). Esto no requiere aprobación de nadie — es autoservicio.
3. **Evidence**: completá al menos un Evidence Record real (no inventado) — ver
   `../evidence/EXEC-20260907-001.md` como ejemplo.
4. **Assessment**: aplicá el rubric de 14 dimensiones de
   `../docs/architecture/assessment-gate.md` vos mismo, como primer filtro.
5. **Evaluation**: completá un Evaluation Record — si podés conseguir una revisión de
   alguien distinto de quien ejecutó, mejor (ver `evaluation-observability.md`).
6. **Pilot**: si el assessment inicial es favorable, pedí que otro equipo lo pruebe.
7. **Measurement**: completá un Measurement Result — `NOT MEASURED` con razón es un
   resultado válido si no hay baseline.
8. **Human Validation**: acá es donde el proceso **está bloqueado hoy** — no hay quién
   apruebe formalmente. Abrí la PR igual, documentando que llegaste hasta este punto —
   queda trazable para cuando se resuelva.
9. **Reusable Capability → Common Core**: solo ocurre después del paso 8. **Nadie debe
   marcar `Corporate Standard: Y` sin ese paso cumplido** (regla dura, sin excepción).

## Versionar, mantener, retirar

- **Versionar**: si cambiás el contenido de una capacidad, actualizá `Version` en su
  entrada del Registry y `Last Review`.
- **Mantener**: si sos quien más la usa, considerate `Maintainer` de facto — el campo
  formal sigue `REQUIRES VALIDATION` hasta que haya un proceso de asignación real.
- **Retirar**: si dejaste de usarla, actualizá `Lifecycle State` a `Deprecate` con motivo
  explícito (no por antigüedad) — ver `../docs/architecture/lifecycle.md`.
