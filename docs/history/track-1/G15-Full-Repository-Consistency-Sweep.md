# G15 — Barrido completo de consistencia contra el KO

**Fase**: G15. **Estado**: FACT (correcciones de vigencia y de comportamiento aplicadas y
verificadas por grep/existencia de archivo). Precondición: G14 (primer re-chequeo,
insuficiente — dejó pasar varios de los hallazgos de esta pasada). Disparador: feedback
real de developer (3 preguntas concretas sobre un mismo output de CAP-002) más pedido
explícito del usuario de hacer una revisión **completa**, no puntual, "no puede haber
estos errores".

## 1. Por qué G14 no fue suficiente

G14 corrigió conteos de ejecuciones y un ID de ejecución roto, pero **no releyó el
contenido completo** de los archivos que ya afirmaba estar sincronizados
(`capabilities/skills/user-story/SKILL.md` en particular) ni barrió los índices
secundarios (`evidence/README.md`, `evaluation/README.md`, `measurements/README.md`,
`integrations/catalog.md`, `capabilities/README.md`, entradas del Registry). Esta pasada
sí lo hizo, y encontró bugs reales de comportamiento y de contenido que G14 no había
detectado.

## 2. Feedback real de developer que motivó esta pasada

3 preguntas concretas sobre una misma ejecución (`ARMOA277-194`):

1. "Hay indicaciones que hace el sistema internamente, pero no es para mí" — el agente
   narró housekeeping propio (`git branch --show-current`, `git status --short`, "voy a
   crear X y después validar Y") en la conversación de la persona.
2. "¿Esos comandos git deben mostrarse?" — no, nunca.
3. "Me pide completar con el PO/referente, pero no indica con quién específicamente" — la
   recomendación de CAP-002 no estaba usando el nombre real disponible en el contexto
   recuperado (reporter/assignee), ni explicaba qué hacer cuando ese nombre no está.

## 3. Correcciones de comportamiento (no solo de contenido)

- **`agent-execution-contract.md`, Regla 3**: se agregó una lista explícita de qué cuenta
  como "interno del modelo" — específicamente comandos de housekeeping (`git
  branch`/`git status`/`git diff --check`, narrar "voy a hacer X y después Y") — con el
  mismo principio de separación de audiencias ya citado (logs de CI vs. changelog de
  release), no una regla nueva inventada. Se agregó como 5ta fila a la tabla de "Ejemplos
  reales que motivaron este contrato".
- **`capabilities/skills/user-story/SKILL.md`, sección 5 (Recomendación)**: ahora exige
  usar el nombre real de reporter/assignee cuando el Resolved Context lo trae (la regla ya
  existía pero esta ejecución no la había aplicado), y cuando no está disponible, la
  recomendación **lo dice explícitamente y le pide a la persona que lo busque en Jira** —
  en vez de una referencia vaga ("el PO") que no aclara si el dato faltaba o si el agente
  lo omitió.

## 4. Bugs de contenido encontrados en el propio `SKILL.md` (CAP-002)

3 lugares donde el archivo se contradecía a sí mismo tras el sweep de G14 (quedaron
corregidos a "6ta y 7ma"/"2 ejecuciones" en vez de singular):

- Sección HITL: decía "independientemente de que la 6ta... tenga actor independiente" —
  omitía la 7ma (`EXEC-20260917-001`), que también lo tiene.
- Sección Ejemplos: llamaba a `EXEC-20260909-001` "la única con actor de ejecución
  independiente" — ya no es cierto desde que existe `EXEC-20260917-001`.
- Sección "Evidencia/origen": misma omisión ("aunque una sí tuvo actor... independiente").
- "Criterios de evaluación": seguía diciendo "aplicados 5 veces" en vez de 7.

## 5. Gaps de indexación encontrados (la 7ma ejecución nunca se agregó a los índices cruzados)

`evidence/README.md`, `evaluation/README.md` y `measurements/README.md` — los 3 índices
cruzados por tipo de artefacto — **nunca tuvieron una fila para `EXEC-20260917-001`**,
pese a que ya se citaba en otros 8+ archivos. Se agregó la fila correspondiente en los 3.

## 6. Links y referencias rotas a la estructura plana anterior (pre-`records/`)

`adoption/context-providers-quickstart.md`, `adoption/contribution-guide.md`,
`registry/entries/spec-driven-development.md`, `registry/entries/jira-context.md`,
`integrations/catalog.md` y `capabilities/README.md` seguían citando rutas de la
estructura plana `evidence/EXEC-*.md`/`evaluation/EXEC-*.md`/`measurements/EXEC-*.md`,
eliminada desde la restructuración a `records/<tarea>/<EXEC-ID>/` (G7). Se corrigieron a
la ruta real, y se completaron con las 2 ejecuciones más recientes donde faltaban
(`EXEC-20260909-001`, `EXEC-20260917-001`).

**Nota de alcance**: no se tocaron referencias equivalentes dentro de
`docs/history/track-1/*` ni dentro de los propios registros (`records/*/EXEC-*/*.md`) —
son artefactos históricos/evidencia sellada, se preservan tal cual aunque citen rutas ya
no vigentes, mismo principio ya aplicado en pasadas anteriores.

## 7. `records/jira-ARMOA277-194/EXEC-20260917-001/` — resuelto, no solo documentado

Esta carpeta había aparecido y desaparecido repetidamente durante la sesión (ver G14 §4).
En esta pasada se confirmó que su contenido actual es real, completo (`evidence.md`,
`evaluation.md`, `measurement.md`) y **ya refleja la corrección de la Regla 3** (usa
"Jesús Gutiérrez (reporter)" por nombre real, no una referencia genérica) — señal de que
el developer ya reintentó con el contrato actualizado. Se agregó al control de versiones
junto con el resto de esta pasada, igual que las demás ejecuciones reales — deja de
depender de que la carpeta persista solo en el disco local del developer.

## 8. Verificación final

- `grep` de "6 ejecuciones", "3 ejecuciones reales" (CAP-008) y "la única con actor" fuera
  de `docs/history/`: 0 coincidencias.
- Los 8 `EXEC-ID` citados en cualquier archivo de navegación (`evidence/README.md`,
  `SKILL.md`, `registry/`, etc.) fueron verificados contra el disco — los 8 resuelven a un
  `evidence.md` real.
- `git status` limpio salvo los archivos efectivamente tocados en esta pasada.

## 9. Qué sigue sin resolver (correctamente, no un olvido)

- Ninguna evaluación es todavía humana independiente (7/7 `model-assisted`).
- Ninguna etapa del KO más allá de "Recepción del requerimiento" tiene evidencia real
  (ver `architecture/ai-sdlc.md`, sin cambios en esta pasada).
- `PILOT-003` sigue `EN CURSO`, 4/7 preguntas de feedback pendientes.
