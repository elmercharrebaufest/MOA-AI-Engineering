# Evidence Record — EXEC-20260908-001

**Modo de ejecución: CONTROLLED DRY-RUN.** Igual que en `EXEC-20260907-001`, no fue posible
obtener ejecución independiente por un miembro real de un equipo de MOA dentro de esta
sesión — sigue sin existir un mecanismo en este entorno para contactar, asignar tarea, o
recibir trabajo de un humano de DataAgro en tiempo real. Ver
`../docs/history/track-1/G4.6-Independent-Adoption-and-Validation.md` sección 14 para el
razonamiento completo.

**Por qué una segunda ejecución, y por qué un ticket distinto de `EXEC-20260907-001`**: en
G4.4 se usó el ticket MOA-1816. Reutilizar el mismo ticket en G4.6 habría probado que el
mismo agente puede repetir su propio trabajo, no que la capability generaliza a un
requerimiento nuevo y no visto. Se seleccionó deliberadamente un ticket real distinto —
MOA-1765 — para poner a prueba la generalización. Ver
`G4.6-Independent-Adoption-and-Validation.md` secciones 4-5 (Pilot Selection / Rationale)
para el detalle de por qué se descartaron los otros 4 repos del workspace y por qué,
dentro de DataAgro, se eligió este ticket y no otro.

Lo que sigue **es real, no inventado**: el requerimiento de entrada es un ticket real y ya
existente (no creado para este ejercicio), con estado `draft` en el repo real, y el
artefacto de salida fue genuinamente producido aplicando la estructura de CAP-002 a los
requisitos todavía sin `signOff`.

## Evidence Contract

| Campo | Valor |
|---|---|
| `capability_id` | CAP-002 |
| `capability_version` | Commit `20b6363a3` (DataAgro) — misma versión de referencia usada en `EXEC-20260907-001`, para poder comparar resultados entre ejecuciones |
| `execution_id` | EXEC-20260908-001 |
| `executed_at` | 2026-09-08 |
| `actor` | Claude Code (esta sesión) — **no es un miembro independiente de un equipo de MOA**; mismo actor que en `EXEC-20260907-001` y que diseñó el Registry. Ver limitación explícita arriba |
| `repository` | `DataAgro/DataAgro` (fuente del requerimiento) |
| `branch` | `dev` (donde vive el requerimiento original) |
| `input_reference` | Ticket real `MOA-1765` — `_sdd/specs/MOA-1765-DistribuidorCupos/requirements.md` (R11, R16, R17) y `feature.json`, estado `draft` en el repo real |
| `output_reference` | Ver "Artefacto generado" más abajo, en este mismo archivo |
| `evidence_reference` | Este archivo (auto-referencia) |
| `status` | `EXECUTED` (no `VERIFIED`) |

## Requerimiento de entrada (real, no inventado)

Ticket MOA-1765 — migración del "Distribuidor de Cupos SL" (Planta San Lorenzo) de un POC
100% client-side a ASP.NET MVC con cálculo en backend. De los 17 requisitos EARS (R1-R17)
del ticket, **solo R11, R16 y R17 tienen `traceability` y `qaManualPending` abiertos con
`signOff: null`** en `feature.json` — R1-R10/R12-R15 ya cuentan con cobertura unitaria y no
figuran como pendientes en este archivo. Se acotó la ejecución a esos 3 requisitos porque
son, con evidencia directa del propio `feature.json`, la parte realmente activa/pendiente
del ticket — el mismo criterio de alcance que se usó en `EXEC-20260907-001` (R1-R6 de
MOA-1816, no todo el historial del ticket).

- **R11** — Exportar Excel desde el frontend (SheetJS, sin endpoint backend), archivo
  `Cupos_SL_<fecha>.xlsx`, columna `ContratoSAP` como texto. Tipo de verificación: manual.
- **R16** — Sin CORS: la Vista Razor inyecta las 6 URLs de los endpoints vía
  `@Url.Action(...)`. Tipo de verificación: manual.
- **R17** — Paridad visual exacta con el POC (`distribuidor_cupos.html`), sin estilos
  inline, siguiendo `.github/instructions/instructions.frontend-template.md` (verificado:
  el archivo existe en el repo real). Tipo de verificación: manual.

## Artefacto generado — aplicando la estructura de CAP-002 (`user-story`)

### Historia de usuario

```
Como operador de planta [FACT — rol usado explícitamente en las historias de usuario
originales del propio ticket, req/UserStories_API_Cupos.md, US-01 a US-05; no inferido],
quiero exportar a Excel el resultado de la distribución de cupos calculada, con el número
de contrato SAP preservado como texto,
para poder cargar el archivo en SAP sin que se pierdan los ceros a la izquierda del
número de contrato ni tener que reformatear la columna manualmente antes de subirlo.
```

**Nota de evaluación sobre el rol**: el catálogo de roles del propio `SKILL.md` de
`user-story` (Comercial, Corredor, Administrativo, Administrador del sistema) **no incluye
"operador de planta"**, que es el rol real y ya documentado del dominio para este ticket
específico. Se usó igual el rol real (más fuerte como evidencia que forzar uno del
catálogo) — ver hallazgo de mejora en la sección "Análisis de gaps" y en
`G4.6-Independent-Adoption-and-Validation.md` sección 17 (Improvement Loop).

### Criterios de aceptación (Given/When/Then, derivados de R11, R16, R17)

```
1. Dado un resultado de distribución calculado (uno o varios días),
   cuando el operador pulsa "Exportar Excel",
   entonces el sistema genera, en el navegador (sin llamada a backend), un archivo
   Cupos_SL_<fecha>.xlsx con una hoja "Cupos" y las columnas FechaSugerida,
   CantidadDeCupos, ContratoSAP.

2. Dado el archivo .xlsx generado,
   cuando se abre en Excel,
   entonces la columna ContratoSAP se muestra como texto, preservando ceros a la
   izquierda si los hubiera.

3. Dado que la Vista Razor Distribucion/Index.cshtml se renderiza,
   cuando el navegador la carga,
   entonces las 6 URLs de los endpoints (API_IMPORTAR, API_CALCULAR, API_CALCULAR_MD,
   API_CONFIG_GET, API_CONFIG_PUT, API_PROCESAR_DATAAGRO) están inyectadas vía
   @Url.Action(...), y ninguna llamada fetch() requiere configuración CORS porque todas
   son same-origin.

4. Dado el POC original distribuidor_cupos.html,
   cuando se lo compara visualmente contra la Vista Razor migrada,
   entonces el layout, los colores y la imagen de fondo del header son idénticos, y no
   existen atributos style="..." inline ni en el markup ni generados dinámicamente por JS.
```

### Reglas de negocio (RN-XX)

```
RN-01: La exportación a Excel se genera siempre en el navegador (SheetJS); no existe ni
       se debe crear un endpoint de backend para este propósito (decisión ya tomada y
       documentada en plan-distribucionCuposSL-v2.md, no una omisión del requerimiento).
RN-02: La columna ContratoSAP debe tratarse como texto en toda la cadena de exportación,
       nunca como tipo numérico, para no perder ceros a la izquierda.
RN-03: Ninguna URL de endpoint puede hardcodearse en la Vista o en el JS — todas se
       inyectan vía @Url.Action en el servidor.
RN-04: El estilo visual del formulario vive exclusivamente en distribucion-cupos.css vía
       clases utilitarias; el markup y el JS no pueden fijar estilos inline.
```

### Análisis de gaps — hallazgos genuinos de este ejercicio

```
❓ ¿Qué debe mostrar/hacer el botón "Exportar Excel" si el operador lo pulsa sin haber
   ejecutado antes una distribución (resultado vacío o inexistente)?
   Contexto: ni R11 ni el detalle de qaManualPending especifican este caso — la vieja
   historia US-04 (req/UserStories_API_Cupos.md) sí definía un error 400 explícito
   ("El array 'sap' no puede estar vacío") para el endpoint backend que existía en ese
   momento; al mover la exportación al frontend (decisión documentada en
   plan-distribucionCuposSL-v2.md), ese caso de error no fue re-especificado para el
   flujo 100% cliente.
   Opciones: A) deshabilitar el botón hasta que exista un resultado | B) mostrar un
   mensaje de validación al pulsarlo sin resultado.
   Impacto si no se resuelve: bajo — es un caso de UX, no de integridad de datos, pero
   queda sin comportamiento definido.

❓ "Preservar ceros a la izquierda" en la columna ContratoSAP (R11) no especifica el
   mecanismo concreto en SheetJS (¿tipo de celda `s` con formato de texto explícito, o
   alcanza con pasar el valor como string?). La US-04 original (versión backend, ya
   superada) sí mencionaba explícitamente el formato de celda `@` de Excel para este
   mismo propósito — ese nivel de detalle no se trasladó a R11 al migrar la exportación
   al frontend.
   Contexto: SheetJS puede re-inferir un string puramente numérico como número al abrir
   en Excel si no se fuerza el tipo de celda.
   Opciones: A) forzar tipo de celda texto explícitamente en el objeto SheetJS | B)
   confiar en que el string ya alcanza.
   Impacto si no se resuelve: medio — es exactamente el defecto que R11 busca evitar.

❓ R17 exige paridad visual "contra el POC" — pero no aclara si el POC de referencia es
   el archivo `distribuidor_cupos.html` actualmente en el repo, o una versión congelada/
   versionada aparte. Si el POC se modifica en paralelo, la comparación pierde su
   referencia estable.
   Impacto si no se resuelve: bajo — riesgo solo si el POC se sigue tocando en paralelo.
```

**Verificación explícita, no asumida**: antes de reportar el primer punto como una
inconsistencia real (¿R11 contradice la meta declarada del ticket de "eliminar el cálculo
en el navegador"?), se leyó `plan-distribucionCuposSL-v2.md` completo — contiene una
sección explícita **"Decisión: US-04 Export Excel — Frontend vs Backend"** con una tabla
de criterios y la conclusión ya tomada de mantener la exportación en el frontend. **No es
un gap** — se descarta explícitamente para no reportar como hallazgo algo que ya fue
decidido y documentado.
