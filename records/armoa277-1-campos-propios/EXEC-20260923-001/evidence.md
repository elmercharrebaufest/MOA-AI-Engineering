# Historia de Usuario

Como analista/comercial que carga información del productor,
quiero que la sección actualmente llamada **"Detalle Inmueble"** se presente como
**"Campos Propios"** y que el dato territorial solicitado sea **"Partido"** en lugar de
**"Localidad"**,
para que la carga sea consistente con **Planteo Productivo**, donde se solicita
**Provincia** y **Partido**, evitando que el usuario informe conceptos distintos entre
secciones.

## Criterios de Aceptación

1. Dado que el usuario visualiza el menú lateral del formulario,
   cuando se muestra la opción actualmente llamada **"Detalle Inmueble"**,
   entonces debe visualizarse como **"Campos Propios"**.

2. Dado que el usuario ingresa a la sección **Campos Propios**,
   cuando se muestra el encabezado o título de la pantalla/sección,
   entonces debe visualizarse el nombre **"Campos Propios"** en lugar de
   **"Detalle Inmueble"**, si ese título existe en pantalla.

3. Dado que el usuario visualiza la grilla de inmuebles/campos propios,
   cuando se muestran las columnas de ubicación,
   entonces deben mostrarse **Provincia** y **Partido**, no **Provincia** y
   **Localidad**.

4. Dado que el usuario agrega o edita una fila en **Campos Propios**,
   cuando debe informar la ubicación del campo,
   entonces el sistema debe solicitar **Partido** como dato visible para el usuario.

5. Dado que el usuario visualiza la sección **Planteo Productivo**,
   cuando compara los datos de ubicación con **Campos Propios**,
   entonces ambas secciones deben usar la misma denominación: **Provincia** y
   **Partido**.

6. Dado que existen registros previos cargados en la sección actualmente llamada
   **Detalle Inmueble**,
   cuando el usuario los consulta luego del cambio,
   entonces los datos existentes deben seguir visualizándose sin pérdida de
   información, mostrando la columna bajo el nombre **Partido**.

## Reglas de Negocio

RN-01: En las secciones **Campos Propios** y **Planteo Productivo**, la ubicación
territorial debe denominarse consistentemente como **Provincia** y **Partido**.

RN-02: La denominación **Localidad** no debe mostrarse en la grilla ni en los
formularios de carga de la sección **Campos Propios** para este dato.

RN-03: El cambio de nombre de la sección de **Detalle Inmueble** a **Campos Propios**
debe aplicarse en los textos visibles para el usuario relacionados con esa pantalla.

RN-04: El cambio no debe eliminar ni alterar registros existentes; solo debe ajustar la
denominación funcional visible, salvo que se defina explícitamente una migración de
datos.

## Gaps / Preguntas Abiertas

- ¿El cambio de **"Detalle Inmueble"** a **"Campos Propios"** aplica solo al menú
  lateral o también al título interno de la pantalla, breadcrumbs, permisos,
  reportes/exportaciones y mensajes?
- ¿La columna actualmente llamada **"Localidad"** representa técnicamente el mismo dato
  que **"Partido"**, o hay que cambiar también origen de datos/listado/validación?
- Si existen exportaciones, PDFs o reportes que muestran esta información, ¿también
  deben reemplazar **Localidad** por **Partido**?
- ¿Debe mantenerse algún texto histórico como "Inmuebles" dentro de la grilla, o también
  debe cambiar a "Campos Propios"?

## Versión lista para ticket

Cambiar la sección **Detalle Inmueble** para que se visualice como **Campos Propios** y
reemplazar el campo/columna **Localidad** por **Partido**, de modo que la carga de
ubicación sea consistente con **Planteo Productivo**, donde se solicita **Provincia** y
**Partido**. El usuario debe ver en ambas secciones la misma lógica territorial:
**Provincia + Partido**.

---

## Y ahora qué corresponde

Revisar si esta historia refleja bien el requerimiento real (especialmente los 4 gaps de
arriba) antes de pegarla en el ticket de Jira (`ARMOA277-1`, Fase 1). Los gaps quedaron
señalados, no resueltos por cuenta propia — corresponde responderlos antes de dar la
historia por completa.

<details>
<summary>Trazabilidad (no hace falta leer esto para usar el resultado de arriba)</summary>

| Campo | Valor |
|---|---|
| `capability_id` | CAP-001 (`user-story`) |
| `capability_version` | `capabilities/skills/user-story/SKILL.md`, commit `0049fa0` |
| `execution_id` | EXEC-20260923-001 |
| `executed_at` | 2026-09-23 |
| `actor` | Developer real de MOA (Portal de Créditos) + Copilot Chat, vía la Skill instalada por el Agent Plugin |
| `repository` | Portal de Créditos (AWS) |
| `branch` | No especificada por quien ejecutó |
| `input_reference` | Requerimiento real descrito por el developer (cambio de "Detalle Inmueble" a "Campos Propios" y de "Localidad" a "Partido"), con 2 capturas de pantalla de referencia — pendiente de ticket formal en Jira (`ARMOA277-1`, Fase 1) |
| `output_reference` | Arriba en este mismo archivo |
| `evidence_reference` | Este mismo archivo |
| `evaluation_reference` | `NOT EVALUATED` |
| `metric_reference` | `NOT MEASURED` |
| `status` | `EXECUTED` |

Primera ejecución real registrada del mecanismo de distribución vía Agent Plugin
(GitHub Copilot/VS Code): la Skill se invocó en lenguaje natural, sin nombrar `CAP-001`
ni el nombre de la skill — Copilot la reconoció solo ("Read skill user-story, lines 1 to
220").

</details>
