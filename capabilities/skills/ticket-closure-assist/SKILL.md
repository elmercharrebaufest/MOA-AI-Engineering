---
name: ticket-closure-assist
description: Verifica el cumplimiento de los criterios de aceptación de un ticket con evidencia real, estima las horas desde el historial de Git y redacta el comentario de cierre; con confirmación, lo publica, carga las horas y pasa el ticket a Done. Usar al terminar una historia.
---

# ticket-closure-assist

**Idioma de la respuesta**: español neutro y formal: tratar a la persona de usted, sin
voseo ni regionalismos, aunque la persona escriba de otra forma.

**Capability Registry**: [`CAP-016`](../../../registry/entries/ticket-closure-assist.md).
**Golden Path**: [`AI-Assisted Development`](../../../golden-paths/README.md#2-ai-assisted-development)
(extensión — ver nota en ese Golden Path).
**Estado**: `PROPOSAL` — sin ejecución real ni piloto de ningún equipo todavía. Ver la
entrada del Registry para el detalle de evidencia.

## Propósito

Al terminar una historia de usuario, verificar cuáles de sus criterios de aceptación
quedaron efectivamente cumplidos, redactar el comentario de cierre y — con la
confirmación de la persona — publicarlo, cargar las horas y cerrar el ticket, reduciendo
el registro manual propenso a omisión que describe el KO para esta etapa.

## Cuándo usarla

- La historia está desarrollada (y, si corresponde, revisada) y se necesita un resumen de
  cierre antes de mover el ticket a "Done"/"Cerrado".

## Cuándo NO usarla

- Para cerrar un ticket sin confirmación, o con algún criterio sin evidencia — en ese
  caso se informa y no se cierra.
- Cuando los criterios de aceptación no están definidos — sin ellos no hay contra qué
  verificar cumplimiento; corresponde primero refinar la historia.

## Entradas

Los criterios de aceptación de la historia (CAP-001) y evidencia real de que se
cumplieron (tests pasando, PR mergeado, validación de QA) — nunca una suposición de que
"probablemente" se cumplieron.

## Salidas

Un borrador de comentario de cierre: qué criterios se verificaron cumplidos, cuáles no
(si los hay), y un recordatorio de registro de horas si el equipo lo requiere.

## Instrucciones

### 1. Verificación de criterios

Por cada criterio de aceptación de la historia, señalar si hay evidencia real de
cumplimiento (test asociado, validación de QA registrada) o no:

```text
✅ [criterio] — verificado por [evidencia real: test/PR/validación de QA]
❌ [criterio] — sin evidencia de cumplimiento verificada
```

**Nunca marcar un criterio como cumplido sin una evidencia real citada.** Si no hay forma
de verificarlo con el contexto disponible, declararlo explícitamente:

```text
❓ [criterio] — no fue posible verificar cumplimiento con el contexto disponible;
   corresponde que [PO/QA] lo confirme antes de cerrar el ticket.
```

### 2. Estimación de horas desde el historial real de Git (si el equipo lo requiere)

En vez de solo recordarle a la persona que cargue horas, se puede estimar un punto de
partida real a partir del historial de commits de la rama — la persona sigue confirmando
antes de cargar nada:

1. Identificar los días con commits en la rama (`git log <rama-base>..HEAD`).
2. Por día, estimar la duración de la sesión a partir de los timestamps: un solo commit o
   un rango menor a 30 minutos → 1 hora; un rango entre 30 minutos y 4 horas → el rango real
   redondeado a la media hora más cercana; un rango mayor a 4 horas → capear en 4 horas
   (evita sobreestimar por pausas largas sin actividad real).
3. Si ya hay horas cargadas para algún día, restarlas del estimado de ese día — nunca
   duplicar.
4. Presentar el detalle día por día y el total, **nunca cargarlo sin confirmación** — es
   una sugerencia para que la persona confirme o ajuste (paso 5).

```text
⏱️ Estimación de horas para MOA-XXXX (desde el historial de Git)

📅 <fecha> → estimado: Xh | ya registrado: Yh | a cargar: Zh (commits: hh:mm, hh:mm)
...
Total a cargar: Nh

Esto es una estimación derivada de la actividad en Git, no un reemplazo del criterio de
quien registra las horas — confirmar o ajustar antes de cargar.
```

### 3. Borrador de comentario de cierre

```text
Resumen de cierre

Criterios verificados: [N de M]
[detalle de la verificación del paso 1]

Registro de horas: [estimación del paso 2, si el equipo lo requiere — nunca un valor
inventado sin base en el historial real]
```

### 4. Cierre, siempre — el caso con criterios sin verificar y el caso feliz

Si algún criterio queda `❌` o `❓`, la skill no recomienda cerrar el ticket todavía —
debe decirlo explícitamente, igual que la Recomendación de CAP-001 ante gaps bloqueantes.

Si **todos** los criterios quedaron `✅`, cerrar igual con una frase explícita — nunca
terminar en el borrador sin más:

```text
✅ Todos los criterios verificados con evidencia real. Con su confirmación, puedo
   publicar el comentario de cierre, cargar las horas estimadas y pasar el ticket a
   Done — cada paso se muestra antes de escribirlo.
```

### 5. Publicar el cierre (solo con confirmación)

Si la persona lo pide y el asistente tiene acceso de escritura, seguir
[`ticket-update`](../ticket-update/SKILL.md), en este orden y con una confirmación por
paso:

1. Comentario de cierre (paso 3).
2. Horas de la persona que confirma, restando lo ya cargado.
3. Cambio a Done — solo si todos los criterios quedaron `✅` y si la plataforma no lo hace
   sola al mergear el PR (automatización de Jira o "completar work items al mergear" de
   Azure DevOps). Si lo hace, se informa y no se transiciona.

Nunca cargar horas de otra persona ni cerrar con criterios `❌` o `❓`.

## Cómo pedirlo

### Entrada

```
Ticket:
MOA-XXXX

Criterios de aceptación:
[los mismos criterios reales de CAP-001]

Evidencia de cumplimiento:
[tests, PR, validación de QA disponibles — real, no inventada]
```

### Patrón de ejecución

```
Necesito preparar el cierre de [CLAVE-123]: verificar los criterios de aceptación con
esta evidencia [tests, PR, validación de QA] y armar el comentario de cierre con las
horas desde Git.
```

### Revisión humana

Obligatoria: la persona confirma el comentario, las horas y el cambio de estado, cada uno
antes de que se escriba.


## Dependencias

Reutiliza los criterios de aceptación de CAP-001 y, cuando aplica, el Resolved Context de
CAP-002/CAP-003 — no define un mecanismo de acceso a tickets propio.

## Herramientas / permisos

Ninguna propia. La publicación (paso 5) la hace el asistente siguiendo `ticket-update`,
con sus herramientas y límites.

## Seguridad

Riesgo **Medio** cuando publica: escribe en el ticket y cambia su estado. Controles: una
confirmación por escritura, nunca cerrar con criterios sin evidencia, y no duplicar la
transición si la plataforma ya la hace.

## Origen de esta propuesta

**Existing Practice**: ninguna instancia real en MOA. La propia
`architecture/ai-sdlc.md` no incluía esta etapa en su tabla de cobertura real — se agregó
la fila faltante como parte de este mismo trabajo (`architecture/ai-sdlc.md`, etapa
"Cierre del ticket"). KO Interno pág. 26 (*"Copilot + Skills + MCP Jira sugiere registro
de horas y actualiza estado automáticamente"*) — esta versión lo hace, pero con una
confirmación por escritura y sin cerrar nunca con criterios sin evidencia. **External
Best Practice**: verificar criterios de aceptación
contra evidencia real antes de cerrar un ticket es una práctica estándar de Definition of
Done en metodologías ágiles. **Architectural Judgment**: reutiliza los criterios ya
producidos por CAP-001, evita construir un mecanismo de verificación nuevo. La estimación
de horas desde Git (paso 2) se agregó tras contrastar contra una instancia real de un
cliente de Baufest (Camuzzi, skill `log-work`, reunión 2026-09-18) — evidencia externa, no
de un equipo de MOA, generalizada sin copiar contenido específico de ese cliente.

## Compatibilidad / adaptación

Portable a cualquier equipo que ya use CAP-001 — sin contenido específico de dominio que
adaptar. El recordatorio de registro de horas es opcional, según si el equipo lo requiere.
