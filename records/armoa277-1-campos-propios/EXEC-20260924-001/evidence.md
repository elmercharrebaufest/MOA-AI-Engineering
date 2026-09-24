## Renombrar "Detalle Inmueble" a "Campos Propios" y pedir Partido en lugar de Localidad

**Historia**: Como analista que carga los datos de una solicitud de crédito, quiero
informar la ubicación de los campos propios por **Provincia y Partido**, para usar el
mismo criterio que en Planteo Productivo y no cargar la misma ubicación de dos formas
distintas.

**Contexto**: Hoy la sección "Detalle Inmueble" pide Provincia (lista) y Localidad (texto
libre). En Planteo Productivo se pide Provincia y **Partido**, y el Partido se elige de
una lista que depende de la provincia. Ver las capturas adjuntas.

**Criterios de aceptación**
1. Dado que entro a Carga de Datos, cuando miro el menú lateral y el título de la
   sección, entonces dice "Campos Propios" en lugar de "Detalle Inmueble".
2. Dado que estoy en Campos Propios, cuando veo la grilla, entonces la columna que decía
   "Localidad" ahora dice "Partido".
3. Dado que elegí una provincia en una fila, cuando abro el campo Partido, entonces solo
   aparecen los partidos de esa provincia, igual que en Planteo Productivo.
4. Dado que todavía no elegí provincia en una fila, cuando intento completar el Partido,
   entonces el campo está deshabilitado.
5. Dado que una fila ya tiene provincia y partido, cuando cambio la provincia, entonces el
   partido se borra y tengo que volver a elegirlo.
6. Dado que abro una solicitud guardada antes de este cambio, cuando entro a Campos
   Propios, entonces veo sus filas sin error y se mantiene lo que se había cargado en
   Localidad (ver pregunta 1).

**Reglas de negocio**: Los partidos salen del mismo catálogo que usa Planteo Productivo.

**Fuera de alcance**: Cambiar las demás columnas (superficie, hipotecado, valores) y
cambiar el catálogo de provincias o partidos.

**Datos y dependencias**: Catálogo de provincias y partidos que ya existe (ABM
Provincias / Localidades). Afecta a la sección de Carga de Datos, a la sección del
Informe de Crédito que muestra estos datos y al backend que guarda los inmuebles.

**Preguntas abiertas**
- ❓ **Bloqueante**: ¿qué se hace con lo que ya se cargó en Localidad como texto libre?
  Opciones: A) asociar cada texto a un partido del catálogo y dejar para revisión manual
  los que no coinciden | B) guardar el texto anterior solo para consulta y pedir el
  Partido de ahora en adelante. Recomendación: B.
- ❓ **Bloqueante**: ¿el cambio aplica también a la pestaña "Campos Propios" de Nueva
  Solicitud y al Informe de Crédito, que también muestran "Localidad"? Opciones: A) sí,
  en todos | B) solo en Carga de Datos. Recomendación: A.
- ❓ **No bloqueante**: ¿el Partido pasa a ser obligatorio? Recomendación: sí, como en
  Planteo Productivo.

**Veredicto**: ⛔ No lista — las 2 preguntas bloqueantes cambian el alcance: pasar de
texto libre a una lista afecta al modelo de datos y a lo ya guardado.

*(Salida del asistente, sin editar salvo formato de listas.)*

## Y ahora qué corresponde

Responder con el PO las 2 preguntas bloqueantes. El renombre de la sección y de la
columna no depende de ellas y puede avanzar como una historia aparte; el cambio de texto
libre a lista espera las respuestas.

<details>
<summary>Trazabilidad (no hace falta leer esto para usar el resultado de arriba)</summary>

| Campo | Valor |
|---|---|
| `capability_id` | CAP-001 (`user-story`) |
| `capability_version` | `capabilities/skills/user-story/SKILL.md`, commit `57e928a` (plugin 0.4.0) |
| `execution_id` | EXEC-20260924-001 |
| `executed_at` | 2026-09-24 |
| `actor` | Developer real de MOA (Portal de Créditos) + Copilot Chat, con el plugin instalado vía marketplace. Agente usado: sin confirmar (el registro muestra búsquedas en el código, que el agente `product-owner` de 0.4.0 no tenía permitidas) |
| `repository` | Portal de Créditos (AWS) — `frontend-angular`, consultado en solo lectura |
| `input_reference` | Requerimiento real del PO, escrito a mano, con 2 capturas (Detalle Inmueble y Planteo Productivo). Sin ticket |
| `output_reference` | Arriba en este mismo archivo |
| `evidence_reference` | Este mismo archivo |
| `evaluation_reference` | [`evaluation.md`](evaluation.md) — `model-assisted`, evaluación humana pendiente |
| `metric_reference` | `NOT MEASURED` |
| `status` | `EXECUTED` |

Las afirmaciones del resultado sobre el sistema actual se verificaron contra el código
real (Localidad como texto libre en Detalle Inmueble; Partido como lista dependiente de
la provincia en Planteo Productivo; "Localidad" también en la pestaña Campos Propios de
Nueva Solicitud y en el Informe de Crédito; ABM de Provincias / Localidades): todas
correctas.

</details>
