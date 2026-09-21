# Evidence Record — plantilla operacional

> Este archivo es una plantilla operacional. El contrato canónico está en
> [`../../architecture/evidence-evaluation-measurement.md`](../../architecture/evidence-evaluation-measurement.md#1-evidence).
> Esta plantilla **no redefine** ese contrato — es una copia con placeholders, "copy →
> fill → version".

## Regla de oro: primero el resultado, después el proceso

**Quien abre este archivo quiere ver el resultado de su tarea, no un reporte de cómo
funciona el modelo.** Hallazgo real de un developer que probó esto: el archivo hablaba de
"esta es la ejecución más importante de las 6... la primera con actor independiente de
quien diseñó el modelo" antes de mostrar la historia de usuario — eso es información de
gobierno de `MOA-AI-Engineering`, no algo que la persona necesite para trabajar. No debe
repetirse.

**Orden obligatorio del archivo**:

1. **El resultado real, primero, sin ninguna introducción sobre el modelo o el proceso**
   — lo que la persona pidió (la historia, el análisis, el código, lo que sea), directo.
2. Un párrafo corto (opcional) de "¿y ahora qué corresponde hacer?" si aplica.
3. Recién después, separado con una línea horizontal (`---`) o un bloque `<details>`
   colegable, el detalle de trazabilidad: de dónde salió el dato, qué herramienta se usó,
   la tabla de campos del contrato. Debe marcarse explícitamente como "no hace falta leer
   esto para usar el resultado de arriba".

**Nunca en el archivo, en ningún lugar**: comparaciones con otras ejecuciones ("es la más
significativa de las 6", "a diferencia de EXEC-XXXX"), quién diseñó el modelo, ni jerga de
clasificación interna (`CONTROLLED DRY-RUN`, "2 ejes distintos"). Eso es contenido para
`docs/history/` o para el Registry, nunca para el archivo que la persona realmente abre.

**La misma regla aplica a la respuesta en el chat, no solo a este archivo** — y a
cualquier archivo compartido del modelo (`registry/`, índices, otras tareas de
`records/`): no deben leerse, editarse ni mencionarse como parte de ejecutar la tarea de
una persona. Ver [`agent-execution-contract.md`](../agent-execution-contract.md) para el
contrato completo — es corto, conviene leerlo antes de continuar.

## Cómo usar esta plantilla

1. Copiar este archivo a `records/<fuente>-<tarea>/EXEC-<fecha>-<número>/evidence.md`
   (una carpeta por tarea, ver `evidence/README.md` para la convención completa).
2. Completar cada campo de la tabla — si un campo no aplica todavía, usar el valor
   honesto (`NOT EVALUATED`, `NOT MEASURED`), nunca dejarlo ambiguo ni inventarlo.
3. Versionar el archivo junto con el código (commit normal, sin infraestructura
   especial).

## Evidence Contract (va en la parte de trazabilidad, al final del archivo — ver "Regla de oro" arriba)

| Campo | Valor |
|---|---|
| `capability_id` | *(ej. CAP-001 — ID del Registry)* |
| `capability_version` | *(hash/versión de la capacidad usada)* |
| `execution_id` | *(identificador único de esta ejecución — ej. EXEC-20260101-001)* |
| `executed_at` | *(fecha/hora)* |
| `actor` | *(quién ejecutó — persona o "human+AI assistant"; nunca dejar implícito)* |
| `repository` | *(repositorio donde se ejecutó)* |
| `branch` | *(rama donde se ejecutó)* |
| `input_reference` | *(referencia al insumo — ej. link a un ticket; NO el contenido completo si es sensible)* |
| `output_reference` | *(referencia al resultado — normalmente, "arriba en este mismo archivo")* |
| `evidence_reference` | *(referencia a este mismo archivo)* |
| `evaluation_reference` | *(referencia al Evaluation Record correspondiente, o `NOT EVALUATED`)* |
| `metric_reference` | *(referencia al Measurement Result correspondiente, o `NOT MEASURED`)* |
| `status` | *(`EXECUTED` / `PARTIAL` / `FAILED`)* |

## Cómo escribir el texto libre (además del orden de arriba)

La explicación debe escribirse **como si se le estuviera contando a un colega**, no como
un reporte de auditoría. Conviene evitar:

- Hablar del proceso en vez del resultado.
- Meter IDs de otras ejecuciones en el medio de la oración.
- Jerga interna de clasificación — si el concepto importa, corresponde explicarlo con
  palabras comunes.
- Frases tipo "ver sección de abajo" en cada párrafo — cortan la lectura.

Ante la duda, conviene releer el texto en voz alta: si suena a que alguien está
describiendo un sistema en vez de contar qué pasó, corresponde reescribirlo.

## Qué NO registrar acá

- Secretos, credenciales, tokens.
- Contenido sensible completo — usar referencias (paths, IDs, links), no el payload.
- Un resultado que todavía no ocurrió — este campo se completa **después** de ejecutar,
  no antes.

## Después de completar esto

Corresponde continuar con [`evaluation-record.md`](evaluation-record.md) para registrar
si el resultado es correcto, y [`measurement-record.md`](measurement-record.md) para
registrar impacto (si hay baseline).
