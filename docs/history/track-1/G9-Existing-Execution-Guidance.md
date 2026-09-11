# G9 — Guía para "ya existe una ejecución de mi tarea" + HITL como oportunidad del developer

**Fase**: G9. **Estado**: FACT (hallazgo real) + PROPOSAL (la guía agregada, sin ejecución
propia todavía). Precondición: G8. Solo se modificó `MOA-AI-Engineering`.

## 1. Disparador — tercer hallazgo real del mismo piloto

El developer de `PILOT-003` volvió a interactuar con `ARMOA277-45`. El asistente encontró
el `EXEC-20260909-001` ya existente (correcto, no duplicó trabajo) pero le devolvió una
pregunta abierta ("¿verifico que PILOT-003 exista, o hay una acción específica?") que el
developer, sin contexto del modelo, no supo responder. El usuario lo resumió: *"nuestro
modelo debe ser muy intuitivo, cualquier persona debe de manera fácil saber interactuar o
cómo seguir."*

## 2. Causa raíz

Ningún documento de adopción (`getting-started.md`, `SKILL.md` de `user-story`) cubría la
rama "ya existe un registro para esta tarea" — todo el material asumía un flujo lineal de
primera ejecución. Cuando el asistente de la sesión del developer encontró un registro
existente, no tenía ninguna guía que seguir más que preguntar de forma abierta.

## 3. Oportunidad identificada, no solo el fix del síntoma

Además de cerrar la rama faltante, se identificó que **el developer es exactamente la
persona que puede resolver la brecha más estructural del modelo**: ninguna de las 6
ejecuciones de CAP-002 tiene HITL humano confirmado. Encontrarse con un registro existente
es, en sí mismo, una oportunidad concreta de dar esa validación — no solo un caso a
resolver sin acción.

## 4. Cambios aplicados

- `adoption/getting-started.md` §6.0 (nueva): 3 decisiones simples cuando ya existe un
  registro (nada que hacer / ejecución nueva anidada / dar HITL) — con la instrucción
  concreta de qué campos tocar (`method`, `evaluator`, `hitl_confirmed_by`).
- `capabilities/skills/user-story/SKILL.md`: misma guía, en el archivo que el asistente
  del developer efectivamente lee en vivo (no solo en la guía de onboarding general) —
  además corregido de "5" a "6 ejecuciones reales" en 3 lugares donde había quedado
  desactualizado tras `EXEC-20260909-001`, y sumado ese ejemplo a la sección "Ejemplos"
  con la nota de actor independiente.
- Auditoría de integridad: 610 links, 0 rotos.

## 5. Sobre el idioma (consulta del usuario, no un cambio de repo)

El otro asistente (GitHub Copilot Agent) respondió en inglés porque el prompt del
developer (`ARMOA277-45`, sin palabras en español) no traía ninguna señal de idioma — no
es un comportamiento configurable desde este repositorio. Se le indicó al usuario pedirle
al developer que escriba la instrucción en español.

## 6. Estado final

Guía cerrada en los 2 lugares que importan (onboarding general + la capability que se usa
en vivo). Pendiente: que el developer efectivamente use esta guía para dar la primera
validación HITL real del modelo — sería el hito más importante de todo Track 1 hasta hoy
si ocurre.
