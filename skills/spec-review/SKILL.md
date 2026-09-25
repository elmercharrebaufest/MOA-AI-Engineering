---
name: spec-review
description: Audita requirements.md, design.md, tasks.md y feature.json generados con spec-driven-development (CAP-005) contra su formato esperado. Detecta ambigüedades sin resolver, tareas huérfanas, y sign-off marcado sin evidencia real. Usar cuando se pida revisar, auditar o validar una spec.
---

# spec-review

**Idioma de la respuesta**: español neutro y formal: tratar a la persona de usted, sin
voseo ni regionalismos, aunque la persona escriba de otra forma.

## Propósito

Leer los artefactos ya generados por CAP-005 (`requirements.md`, `design.md`, `tasks.md`,
`feature.json`) y reportar problemas de calidad y consistencia — sin modificarlos, salvo
que el usuario lo pida explícitamente. Complementa a CAP-005: esa capability define cómo
generar los artefactos, esta los audita.

## Cuándo usarla

- Antes de pasar del rol Spec Author al Implementer, para confirmar que `requirements.md`
  está completo.
- Antes de que el Reviewer dé por cumplido un requisito, para confirmar que `tasks.md`
  cubre todo lo que `requirements.md` pide y que ningún sign-off quedó marcado sin
  evidencia real.
- Periódicamente, para auditar todas las specs de un repo.

## Cuándo NO usarla

- No usarla para escribir contenido nuevo de la spec — eso es CAP-005 (`Spec Author`).
- No pedirle que resuelva una ambigüedad marcada `[NEEDS CLARIFICATION]` por su cuenta —
  siempre requiere una respuesta real de quien corresponda.

## Entradas

Los archivos reales de una carpeta de feature (`requirements.md`, `design.md`, `tasks.md`,
`feature.json`), o todas las carpetas de features de un repo.

## Salidas

Reporte con hallazgos agrupados por severidad, y un resumen de cobertura.

## Instrucciones

### 1. Identificar el alcance

Una carpeta de feature puntual, todas las de un repo, o las de todo el workspace — según
lo que pida el usuario o el contexto lo deje claro.

### 2. Aplicar los checks

Sobre `requirements.md`:

| Check | Qué detecta | Severidad |
|---|---|---|
| Marcador `[NEEDS CLARIFICATION: ...]` sin resolver | Ambigüedad pendiente | 🔴 Alta |
| Requisito no expresado en formato EARS ("Cuando X, el sistema debe Y") | Desvío del formato ya definido por CAP-005 | 🟡 Media |
| Requisito con término no medible ("adecuado", "rápido", "correctamente", "óptimo") | No es verificable | 🟡 Media |
| Detalle de implementación mezclado en el requisito (nombre de archivo, tabla de BD, endpoint concreto) | El detalle técnico pertenece a `design.md`/`tasks.md`, no a `requirements.md` | 🟡 Media |

Sobre `tasks.md`:

| Check | Qué detecta | Severidad |
|---|---|---|
| Tarea que no mapea a ningún requisito de `requirements.md` | Tarea huérfana | 🟡 Media |
| Requisito de `requirements.md` sin ninguna tarea que lo cubra | Cobertura incompleta | 🔴 Alta |
| Tarea con verbo vago ("Analizar", "Ver", "Definir") sin acción concreta | Tarea no accionable | 🟢 Baja |

Sobre `feature.json`:

| Check | Qué detecta | Severidad |
|---|---|---|
| Requisito marcado como cubierto sin sign-off humano real, cuando el tipo de requisito lo exige | **Regla dura de CAP-005** — ningún requisito manual se marca cumplido sin confirmación humana | 🔴 Alta |
| `estado` distinto de `"draft"` sin que el resto de los artefactos respalde ese avance | Inconsistencia de estado | 🟡 Media |

### 3. Reportar

```text
# Spec Review — <carpeta de la feature>

## 🔴 Alta prioridad (bloquea avanzar de rol)
- [checks con hallazgo real, cita textual y ubicación]

## 🟡 Media prioridad
- ...

## 🟢 Baja prioridad
- ...

## Cobertura
- Requisitos: N | Tareas: M | Cobertura requisito→tarea: X/N
- Ambigüedades sin resolver: Y
- Sign-offs marcados sin evidencia real: Z (si Z > 0, esto bloquea el cierre del ticket)
```

### 4. Aplicar fixes (solo si el usuario lo pide explícitamente)

Si la persona pide aplicar las correcciones: se pueden agregar headers faltantes o mover detalle
técnico de `requirements.md` a `tasks.md`. **Nunca resolver un `[NEEDS CLARIFICATION]` por
cuenta propia** — siempre requiere respuesta real de quien corresponda.

### 5. Cierre, siempre

```text
🔴 Con hallazgos de alta prioridad: no corresponde avanzar al siguiente paso del
   desarrollo hasta resolverlos — indicar cuáles bloquean.
✅ Sin hallazgos de alta prioridad: la spec está lista para seguir adelante — la persona
   a cargo decide si avanza, esta skill no lo hace por sí misma.
```

## Cómo pedirlo

### Patrón de ejecución

```
Revisar la spec de [carpeta de la feature real].

Aplicar los checks de requirements.md, tasks.md y feature.json.

No inventar hallazgos ni resolver ambigüedades por cuenta propia — solo reportar lo que
se encuentra, con ubicación exacta.
```

### Revisión humana

El reporte es un insumo — la decisión de si una spec está lista para avanzar de rol sigue
siendo de una persona, especialmente cuando hay sign-offs pendientes.

## Dependencias

Los artefactos ya generados por CAP-005 (`spec-driven-development`) — no define un formato
propio, audita el que CAP-005 ya definió.

## Herramientas / permisos

Ninguna — solo lectura de los artefactos existentes; no edita nada salvo pedido explícito.

## Seguridad

Riesgo bajo — solo lectura, sin acceso a sistemas externos.

## Origen de esta propuesta

**Existing Practice**: ninguna instancia real en MOA — CAP-005 define cómo generar los
artefactos, pero ningún equipo relevado tiene un mecanismo de auditoría separado sobre
ellos. **External Best Practice / evidencia externa**: patrón real observado en un cliente
de Baufest (Camuzzi, skill `spec-review`, reunión 2026-09-18), adaptado al formato real de
CAP-005 (`requirements.md` en EARS + `design.md` + `tasks.md` + `feature.json`, distinto
del `spec.md`/`tasks.md` de Camuzzi) — no se copiaron los headers ni la convención de IDs
de ese cliente, se auditó el formato que MOA ya tiene definido. **Architectural Judgment**:
separar la generación (CAP-005) de la auditoría (esta skill) sigue el mismo principio de
Camuzzi de no mezclar quien escribe con quien revisa — sin agregar un rol nuevo al
Workflow, como una capacidad complementaria e independiente.

## Compatibilidad / adaptación

Portable a cualquier equipo que ya use CAP-005 — sin contenido específico de dominio que
adaptar.
