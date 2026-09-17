# Feedback Record — PILOT-003 (cold-start independiente, ARMOA277-45)

**Completar con hechos y citas literales — no resumir, no completar en nombre del developer.**

| Momento | Qué pasó (literal, verificado contra print) |
|---|---|
| Input inicial | Solo el código `ARMOA277-45` — sin mención de `MOA-AI-Engineering` ni capabilities |
| Primera respuesta del asistente | Trajo el detalle real del issue (Xray Test Case) y sugirió, sin que se lo pidieran, "Connected Context capabilities (CAP-002/CAP-008)" |
| Punto de fricción #1 | El developer preguntó "¿debo leer el README?" antes de decidir por su cuenta — no avanzó de forma autónoma inmediata |
| Elección del developer | Eligió `CAP-002` |
| Resultado aplicando CAP-002 | Historia de usuario + criterios de aceptación (2 escenarios) + reglas de negocio (RN-01, RN-02) + análisis de gaps (3 preguntas: comportamiento sin datos SAP, timeout de integración, rol no declarado) |
| Propuesta del asistente | Registrar como `EXEC-YYYYMMDD-NNN` nuevo, siguiendo el patrón de las 5 ejecuciones previas de CAP-002 (dato verificado como correcto) |
| Ejecución registrada | `EXEC-20260909-001` creado real (evidence + evaluation + measurement + registry actualizados a 6 ejecuciones) |
| Punto de fricción #2 (post-ejecución) | El developer no supo cómo continuar tras quedar registrada la ejecución |
| Feedback literal del developer (sin resumir) | "Está todo mezclado, me pide revisar mi tarea registrada en EXEC-* y luego me pide revisar readme, user-story, jira-context, sin embargo, acá muestran análisis de otros proyectos, a mi lo que me interesa es sobre mi tarea y todo respecto a ello, debe estar separado de otros, poder tener toda la información de esa tarea en un directorio bien distribuido, ahora mismo está todo muy mezclado" |

## Preguntas abiertas (de `adoption/contribution-guide.md`) — pendientes de respuesta literal

| Pregunta | Respuesta del developer |
|---|---|
| ¿Se encontró por dónde empezar sin que nadie lo indicara? ¿Cuánto se tardó? | *(pendiente)* |
| ¿Qué parte del contenido resultó clara? | *(pendiente)* |
| ¿Qué parte generó retrabajo o confusión? | Respondido: navegar entre `evidence/EXEC-*`, `registry/entries/user-story.md` y `registry/entries/jira-context.md` para entender su propia ejecución lo obligó a atravesar contenido de análisis de otros repos (DataAgro, Scato Logística, Orquestador) que no le interesaba |
| ¿Qué hubo que adivinar sobre el propio proyecto que el repo no ayudó a resolver? | *(pendiente)* |
| ¿Qué faltó — algo que se buscó y no se encontró? | Respondido: una vista/directorio único con **todo** lo relativo a su propia tarea (ARMOA277-45) — hoy esa información vive repartida entre `evidence/`, `evaluation/`, `measurements/` y 2 archivos de `registry/entries/` que además mezclan evidencia de otros proyectos/repos |
| ¿Se usaría esto de nuevo para otra capacidad? | *(pendiente)* |
| ¿Se bloqueó en algún punto y necesitó ayuda externa? ¿Dónde exactamente? | *(pendiente — preguntó al usuario coordinador si debía leer el README, en vez de decidir solo)* |

## Nota

No se le indicó al developer si debía leer el README o no — se le devolvió la decisión
para no contaminar la observación de comportamiento autónomo (ver historial de esta
sesión de coordinación).
