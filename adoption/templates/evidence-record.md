# Evidence Record — plantilla operacional

> Este archivo es una plantilla operacional. El contrato canónico está en
> [`../../architecture/evidence-evaluation-measurement.md`](../../architecture/evidence-evaluation-measurement.md#1-evidence).
> Esta plantilla **no redefine** ese contrato — es una copia con placeholders, "copy →
> fill → version".

## Cómo usar esta plantilla

1. Copiá este archivo a `evidence/EXEC-<fecha>-<número>.md` en tu propio repo (o en
   `evidence/` de `MOA-AI-Engineering` si estás generando evidencia para una capacidad de
   este repo).
2. Completá cada campo — si un campo no aplica todavía, usá el valor honesto
   (`NOT EVALUATED`, `NOT MEASURED`), nunca lo dejes ambiguo ni lo inventes.
3. Versioná el archivo junto con tu código (commit normal, sin infraestructura especial).

## Evidence Contract

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
| `output_reference` | *(referencia al artefacto producido)* |
| `evidence_reference` | *(referencia a este mismo archivo)* |
| `evaluation_reference` | *(referencia al Evaluation Record correspondiente, o `NOT EVALUATED`)* |
| `metric_reference` | *(referencia al Measurement Result correspondiente, o `NOT MEASURED`)* |
| `status` | *(`EXECUTED` / `PARTIAL` / `FAILED`)* |

## Cómo escribir el texto alrededor de la tabla (no solo llenar campos)

La tabla de campos va tal cual. Pero cualquier explicación que agregues alrededor —
por qué se hizo algo, qué pasó, qué falta — **escribila como si se la contaras a un
colega, no como un reporte de auditoría**. Evitá:

- Hablar del proceso en vez del resultado ("es la primera ejecución con actor
  independiente de quien diseñó el modelo" → mejor: "esta la hizo alguien que no tuvo
  nada que ver con armar el repositorio").
- Meter IDs de otras ejecuciones en el medio de la oración — si hace falta compararlas,
  decilo en una frase aparte, simple.
- Jerga interna de clasificación (`CONTROLLED DRY-RUN`, "2 ejes distintos") — si el
  concepto importa, explicalo con palabras comunes.
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
