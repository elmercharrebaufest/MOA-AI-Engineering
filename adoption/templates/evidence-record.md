# Evidence Record — plantilla operacional

> Este archivo es una plantilla operacional. El contrato canónico está en
> [`../../architecture/evidence-evaluation-measurement.md`](../../architecture/evidence-evaluation-measurement.md#1-evidence).
> Esta plantilla **no redefine** ese contrato — es una copia con placeholders, "copy →
> fill → version".

## Regla de oro: primero el resultado, después el proceso

**Quien abre este archivo quiere ver el resultado de su tarea, no un reporte de cómo
funciona el modelo.** Hallazgo real de un developer que probó esto: el archivo hablaba de
"esta es la ejecución más importante de las 6... la primera con actor independiente de
quien diseñó el modelo" antes de mostrar su historia de usuario — eso es información
nuestra (de gobierno de `MOA-AI-Engineering`), no algo que la persona necesite para
trabajar. Nunca más así.

**Orden obligatorio del archivo**:

1. **El resultado real, primero, sin ninguna introducción sobre el modelo o el proceso**
   — lo que la persona pidió (la historia, el análisis, el código, lo que sea), directo.
2. Un párrafo corto (opcional) de "¿y ahora qué hago?" si aplica.
3. Recién después, separado con una línea horizontal (`---`) o un bloque `<details>`
   colegable, el detalle de trazabilidad: de dónde salió el dato, qué herramienta se usó,
   la tabla de campos del contrato. Marcalo explícitamente como "no hace falta leer esto
   para usar el resultado de arriba".

**Nunca en el archivo, en ningún lugar**: comparaciones con otras ejecuciones ("es la más
significativa de las 6", "a diferencia de EXEC-XXXX"), quién diseñó el modelo, ni jerga de
clasificación interna (`CONTROLLED DRY-RUN`, "2 ejes distintos"). Eso es contenido para
`docs/history/` o para el Registry, nunca para el archivo que la persona realmente abre.

## Cómo usar esta plantilla

1. Copiá este archivo a `records/<fuente>-<tarea>/EXEC-<fecha>-<número>/evidence.md`
   (una carpeta por tarea, ver `evidence/README.md` para la convención completa).
2. Completá cada campo de la tabla — si un campo no aplica todavía, usá el valor honesto
   (`NOT EVALUATED`, `NOT MEASURED`), nunca lo dejes ambiguo ni lo inventes.
3. Versioná el archivo junto con tu código (commit normal, sin infraestructura especial).

## Evidence Contract (va en la parte de trazabilidad, al final del archivo — ver "Regla de oro" arriba)

| Campo | Valor |
|---|---|
| `capability_id` | *(ej. CAP-002 — ID del Registry)* |
| `capability_version` | *(hash/versión de la capacidad usada)* |
| `execution_id` | *(identificador único de esta ejecución — ej. EXEC-20260101-001)* |
| `executed_at` | *(fecha/hora)* |
| `actor` | *(quién ejecutó — persona o "human+AI assistant"; nunca dejar implícito)* |
| `repository` | *(repo donde se ejecutó)* |
| `branch` | *(rama donde se ejecutó)* |
| `input_reference` | *(referencia al insumo — ej. link a un ticket; NO el contenido completo si es sensible)* |
| `output_reference` | *(referencia al resultado — normalmente, "arriba en este mismo archivo")* |
| `evidence_reference` | *(referencia a este mismo archivo)* |
| `evaluation_reference` | *(referencia al Evaluation Record correspondiente, o `NOT EVALUATED`)* |
| `metric_reference` | *(referencia al Measurement Result correspondiente, o `NOT MEASURED`)* |
| `status` | *(`EXECUTED` / `PARTIAL` / `FAILED`)* |

## Cómo escribir el texto libre (además del orden de arriba)

Escribí cualquier explicación **como si se la contaras a un colega**, no como un reporte
de auditoría. Evitá:

- Hablar del proceso en vez del resultado.
- Meter IDs de otras ejecuciones en el medio de la oración.
- Jerga interna de clasificación — si el concepto importa, explicalo con palabras
  comunes.
- Frases tipo "ver sección de abajo" en cada párrafo — cortan la lectura.

Si dudás, releé lo que escribiste en voz alta: si suena a que alguien está describiendo
un sistema en vez de contarte qué pasó, reescribilo.

## Qué NO registrar acá

- Secretos, credenciales, tokens.
- Contenido sensible completo — usá referencias (paths, IDs, links), no el payload.
- Un resultado que todavía no ocurrió — completá esto **después** de ejecutar, no antes.

## Después de completar esto

Seguí con [`evaluation-record.md`](evaluation-record.md) para registrar si el resultado
es correcto, y [`measurement-record.md`](measurement-record.md) para registrar impacto
(si hay baseline).
