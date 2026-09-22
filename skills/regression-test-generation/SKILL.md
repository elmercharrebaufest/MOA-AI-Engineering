---
name: regression-test-generation
description: Clasifica si un caso de prueba funcional conviene automatizar (vs. dejarlo manual) y, si conviene, genera el código de test automatizado siguiendo la estructura ya existente del repo. Usar sobre un caso de prueba ya redactado, nunca para reemplazar la ejecución real del test.
---

# regression-test-generation

**Capability Registry**: [`CAP-015`](../../../registry/entries/regression-test-generation.md).
**Golden Path**: [`AI-Assisted QA`](../../../golden-paths/README.md#3-ai-assisted-qa).
**Estado**: `PROPOSAL` — sin ejecución real ni piloto de ningún equipo todavía. **Cubre solo
la generación de código de test — no incluye ejecutarlo en un pipeline real**, ver
"Alcance" abajo.

## Propósito

A partir de un caso de prueba funcional ya redactado (por ejemplo, salida de CAP-014
`test-case-generation`), decidir si conviene automatizarlo y, si conviene, generar el
código del test siguiendo la estructura de automatización que el repo ya tenga — para que
la etapa "Test de regresión" del KO deje de depender enteramente de reescribir cada caso a
mano.

## Alcance — qué cubre y qué no

**Cubre**: clasificar el caso (¿vale la pena automatizarlo?) y generar el código del test.
**No cubre**: ejecutar el test en un pipeline de CI/CD ni integrarlo con ningún MCP de
automatización de navegador — el KO Interno (pág. 25) menciona MCP Playwright para correr
los tests automáticamente en el pipeline, pero **no existe evidencia de un MCP Playwright
configurado en ningún repo de MOA** (`architecture/ai-sdlc.md`, etapa "Test de regresión").
Proponer esa integración sin evidencia violaría la regla dura del assessment
(`assessment/README.md`) — queda fuera de esta propuesta, como `REQUIRES VALIDATION`
separado.

## Cuándo usarla

- Ya existe un caso de prueba funcional (de CAP-014 o redactado a mano) y se quiere decidir
  si conviene automatizarlo, y en caso de que sí, generar el código.

## Cuándo NO usarla

- Para casos de prueba exploratorios o sin pasos claros — primero hay que estructurar el
  caso (CAP-014).
- Como sustituto de ejecutar el test real — el código generado tiene que correrse (por la
  persona, o por el mecanismo de CI que el equipo ya tenga) antes de confiar en el
  resultado.

## Entradas

Un caso de prueba funcional con: título, precondiciones, pasos, resultado esperado por
paso. Y la estructura real de automatización del repo, si ya existe (framework, carpetas,
convenciones) — nunca inventar una estructura nueva si el repo ya tiene una.

## Salidas

Una clasificación (Candidato / Manual / Diferido) con su justificación, y — solo si es
Candidato — el código de test generado, listo para revisión antes de agregarlo al repo.

## Instrucciones

### 1. Clasificar el caso

Usar una fórmula de ROI simple, explícita, no una intuición:

$$ROI = \frac{Frecuencia \times Impacto \times Estabilidad}{Esfuerzo \times Dependencias}$$

- **Frecuencia**: ¿con qué frecuencia se ejecuta este flujo (cada release, cada sprint,
  cada vez que cambia algo cercano)?
- **Impacto**: ¿qué tan grave es que este flujo se rompa sin que nadie lo note?
- **Estabilidad**: ¿el flujo/UI/API involucrado cambia seguido, o es estable?
- **Esfuerzo**: ¿cuánto cuesta automatizarlo y mantenerlo (selectores frágiles, datos de
  prueba complejos)?
- **Dependencias**: ¿depende de sistemas externos difíciles de simular de forma confiable?

| Clasificación | Cuándo aplica |
|---|---|
| 🤖 **Candidato** | ROI alto — vale la pena automatizar |
| 📋 **Manual** | ROI medio/bajo, o el flujo es difícil de automatizar de forma confiable |
| ⏳ **Diferido** | Inestable, en construcción, o fuera de alcance todavía |

No es necesario calcular un número exacto — alcanza con justificar la clasificación en 1-2
frases por cada factor relevante.

### 2. Generar el código (solo si es Candidato)

1. Verificar si el repo ya tiene una estructura de tests automatizados (framework,
   carpetas, convenciones de nombres). **Nunca inventar una estructura nueva si ya existe
   una** — seguirla tal cual.
2. Si no existe ninguna estructura todavía, proponer una mínima y avisar explícitamente que
   es nueva, para que el equipo la revise antes de adoptarla como convención.
3. Mapear cada paso del caso de prueba a una acción concreta, y cada resultado esperado a
   una verificación (assertion) concreta.
4. Mostrar el plan (qué archivos se van a crear/tocar) antes de generar el código —
   **nunca generar directamente sin mostrar el plan primero**.
5. Generar el código siguiendo la estructura confirmada. Si algún dato (selector, endpoint,
   credencial de prueba) no está disponible en el caso de prueba, dejarlo marcado
   explícitamente (`// TODO: completar selector real`) — nunca inventarlo.

### 3. Verificar el código generado (si es posible ejecutarlo)

Si el entorno permite compilar/ejecutar el test generado, hacerlo y reportar el resultado
real — nunca asumir que el código generado funciona sin haberlo corrido. Si falla, corregir
lo que esté al alcance (errores de sintaxis, selectores evidentes) y volver a intentar,
hasta un máximo razonable de reintentos (ej. 3) antes de escalar el problema a la persona.

## Cómo usar esta capability

### Patrón de ejecución

```
Usa la capability CAP-015 regression-test-generation sobre este caso de prueba:

[caso de prueba real, con pasos y resultados esperados]

Estructura de automatización existente del repo (si la hay):
[framework, carpetas, convenciones reales — o "no existe ninguna todavía"]

1. Clasificá el caso (Candidato / Manual / Diferido) con la fórmula de ROI, justificando
   cada factor.
2. Si es Candidato, mostrame el plan de archivos antes de generar nada.
3. Generá el código siguiendo la estructura real del repo — nunca inventes una nueva sin
   avisar.

No inventes selectores, datos de prueba, ni asumas que el código generado funciona sin
poder verificarlo.
```

### Revisión humana

Obligatoria, sin excepción — QA/el developer debe revisar el código generado antes de
agregarlo al repo, y correrlo al menos una vez antes de confiar en el resultado.

### Evidencia / Evaluación / Medición

Mismo mecanismo que el resto del Registry —
[Evidence Record](../../../adoption/templates/evidence-record.md),
[Evaluation Record](../../../adoption/templates/evaluation-record.md),
[Measurement Record](../../../adoption/templates/measurement-record.md).

## Dependencias

Reutiliza el caso de prueba producido por CAP-014 (`test-case-generation`) — no define un
formato de caso de prueba propio.

## Herramientas / permisos

Lectura de la estructura del repo y, si el entorno lo permite, ejecución del test generado
para verificarlo. No accede a ningún MCP de automatización de navegador ni a ningún
pipeline de CI/CD.

## Seguridad

Riesgo bajo — genera código de test, no lo despliega ni lo ejecuta contra un ambiente
productivo. Si el caso de prueba involucra datos sensibles de ejemplo, no deben
reproducirse textualmente en el código generado sin necesidad.

## Origen de esta propuesta

**Existing Practice**: cero evidencia real en MOA (`architecture/ai-sdlc.md`, etapa "Test
de regresión", sin capacidad ni propuesta hasta este trabajo). **External Best
Practice / evidencia externa**: patrón real de un cliente de Baufest (Camuzzi, skills
`testrail-desde-jira` + `playwright-desde-testrail`, reunión 2026-09-18) — se adoptó la
fórmula de ROI (un criterio de industria reconocible, no inventado por ese cliente) y el
patrón de generación de código con verificación/reintentos, sin copiar el mecanismo
concreto (TestRail como fuente, framework Playwright específico, nombres de repos de ese
cliente). **Architectural Judgment**: separar deliberadamente "generar el código del test"
(esta propuesta, bajo riesgo) de "ejecutarlo automáticamente en el pipeline vía MCP
Playwright" (fuera de alcance, sin evidencia) — cerrar solo la parte de la etapa que puede
justificarse hoy, sin inventar gobierno de MCP que no existe.

## Compatibilidad / adaptación

Portable a cualquier framework de test de UI/API (Playwright, Cypress, Selenium, tests de
integración de API) — la fórmula de ROI y el patrón de generación con plan-antes-de-generar
son independientes de la herramienta; la estructura de código depende 100% de lo que el
repo real ya use.
