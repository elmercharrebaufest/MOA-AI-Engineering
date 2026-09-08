# Evidence Record — EXEC-20260907-001

**Modo de ejecución: CONTROLLED DRY-RUN.** No fue posible obtener ejecución independiente
por un miembro real de un equipo de MOA dentro de esta sesión — no existe mecanismo en
este entorno para contactar, asignar tarea, o recibir trabajo de un humano de DataAgro (o
cualquier otro equipo) en tiempo real. Se documenta esta limitación explícitamente en vez
de simularla. Ver `../docs/history/track-1/G4.4-Real-Adoption-Pilot.md` sección 3 para el
razonamiento completo de por qué no fue posible la ejecución independiente.

Lo que sigue **es real, no inventado**: el requerimiento de entrada es un ticket real y ya
existente (no creado para este ejercicio), y el artefacto de salida fue genuinamente
producido aplicando la estructura de CAP-002 a ese requerimiento — no es un ejemplo
sintético como el de G4.3 §13.

## Evidence Contract

| Campo | Valor |
|---|---|
| `capability_id` | CAP-002 |
| `capability_version` | Commit `20b6363a3` (DataAgro) — versión de referencia usada para la estructura (Historia/Criterios/Reglas/Gaps), aunque el contenido específico de DataAgro no fue reutilizado literal (ver nota) |
| `execution_id` | EXEC-20260907-001 |
| `executed_at` | 2026-09-07 |
| `actor` | Claude Code (esta sesión) — **no es un miembro independiente de un equipo de MOA**; ejecutado por el mismo agente que diseñó el Registry. Ver limitación explícita arriba |
| `repository` | `DataAgro/DataAgro` (fuente del requerimiento) |
| `branch` | `dev` (donde vive el requerimiento original) |
| `input_reference` | Ticket real `MOA-1816` — `_sdd/specs/MOA-1816-CambiosFormulario/requirements.md` y `feature.json`, estado `in_progress` en el repo real |
| `output_reference` | Ver "Artefacto generado" más abajo, en este mismo archivo |
| `evidence_reference` | Este archivo (auto-referencia) |
| `status` | `EXECUTED` (no `VERIFIED` — ver Registry update) |

## Requerimiento de entrada (real, no inventado)

Ticket MOA-1816 — ajuste a la lógica de elegibilidad del formulario de distribución de
cupos: los contratos vencidos dejan de excluirse; la vigencia se calcula con
`Fecha Hasta Contra` (fallback a `Fecha Hasta`); se preserva la exclusión de contratos no
iniciados; no cambia el criterio de ordenamiento ni el diagnóstico visual. Documentado
originalmente en formato EARS (6 requisitos R1-R6), estado `in_progress`, sin QA sign-off
todavía (los 6 requisitos tienen `signOff: null` en `feature.json`).

## Artefacto generado — aplicando la estructura de CAP-002 (`user-story`)

### Historia de usuario

```
Como analista de distribución de cupos [INFERENCE — rol no confirmado explícitamente en
el ticket original; inferido del dominio del formulario, no verificado con el equipo],
quiero que el sistema no descarte contratos vencidos al calcular la elegibilidad, y que
use "Fecha Hasta Contra" (con fallback a "Fecha Hasta") como criterio de vigencia,
para poder incluir contratos que hoy se excluyen incorrectamente y recuperar cupos
elegibles que se estaban perdiendo.
```

### Criterios de aceptación (Given/When/Then, derivados de R1-R6)

```
1. Dado un contrato con Fecha Hasta anterior a hoy,
   cuando el sistema calcula elegibilidad,
   entonces el contrato NO se excluye solo por esa razón.

2. Dado un contrato sin valor en Fecha Hasta Contra,
   cuando el sistema evalúa el rango de vigencia,
   entonces usa Fecha Hasta como fallback.

3. Dado un contrato con Fecha Desde posterior a hoy,
   cuando el sistema calcula elegibilidad,
   entonces el contrato se sigue excluyendo.

4. Dado el listado de contratos elegibles,
   cuando el sistema lo ordena,
   entonces sigue usando Fecha Hasta como criterio de desempate.

5. Dado el panel de diagnóstico,
   cuando se muestra el rango de fechas,
   entonces sigue mostrando Fecha Hasta como referencia visual.

6. Dado el archivo real de San Lorenzo (1265 contratos, fecha 06.05.2026),
   cuando se aplica el nuevo cálculo,
   entonces el resultado pasa de 486 a 608 contratos elegibles.
```

### Reglas de negocio (RN-XX)

```
RN-01: La vigencia de un contrato se determina por Fecha Hasta Contra; si está vacía,
       se usa Fecha Hasta como fallback.
RN-02: Un contrato con Fecha Desde futura nunca es elegible, sin importar su vencimiento.
RN-03: El vencimiento (Fecha Hasta < hoy) ya no es motivo de exclusión por sí solo.
RN-04: Ordenamiento y diagnóstico visual siempre usan Fecha Hasta, nunca
       Fecha Hasta Contra — aunque la elegibilidad sí use el segundo campo.
```

### Análisis de gaps — hallazgo genuino de este ejercicio

Aplicar el formato Given/When/Then a un requerimiento EARS ya escrito **expuso una
ambigüedad real que el documento original no tenía explícita**:

```
❓ ¿Qué pasa si TANTO "Fecha Hasta Contra" COMO "Fecha Hasta" están vacíos para un
   contrato? Ninguno de los 6 requisitos (R1-R6) lo cubre.
   Contexto: si ambos campos vienen vacíos (dato incompleto del archivo SAP), el
   comportamiento del sistema queda indefinido por el requerimiento tal como está escrito.
   Opciones: A) excluir el contrato por defecto | B) incluirlo por defecto
   Impacto si no se resuelve: medio — depende de cuántos registros reales tengan ambos
   campos vacíos en el archivo de origen (no determinable sin acceso al dato real).

❓ ¿Qué pasa si "Fecha Hasta Contra" tiene un valor pero está mal formado (dato corrupto
   del archivo SAP)? Tampoco cubierto por R1-R6.
```

**Este hallazgo no estaba en el requerimiento original ni fue inventado para este
ejercicio** — surgió directamente de aplicar la estructura Given/When/Then + Análisis de
gaps de CAP-002 al contenido real. Es la evidencia más concreta de valor que produjo este
piloto.
