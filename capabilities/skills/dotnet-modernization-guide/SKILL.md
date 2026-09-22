---
name: dotnet-modernization-guide
description: Guía para modernizar un proyecto .NET Framework legacy a .NET moderno usando el agente oficial de GitHub Copilot ("Copilot upgrade"), con las restricciones reales de MOA ya incorporadas. No reemplaza la herramienta de Microsoft — la usa bien.
---

# dotnet-modernization-guide

**Capability Registry**: [`CAP-020`](../../../registry/entries/dotnet-modernization-guide.md).
**Estado**: `PROPOSAL` — sin ejecución real ni piloto de ningún equipo todavía.

## Propósito

No construye ninguna herramienta nueva — Microsoft ya tiene un agente oficial de
modernización dentro de GitHub Copilot ("Copilot upgrade"), con documentación real y
vigente. Esta capacidad es la guía para usarlo bien, con las restricciones reales de MOA
ya incorporadas, en vez de que cada equipo la redescubra por su cuenta.

## Cuándo usarla

Un equipo real de MOA con proyectos `.NET Framework` (confirmado: DataAgro, MOA
Operaciones, Orquestador, Scato Logística, Scato Puerto — ver
[`../../../teams/README.md`](../../../teams/README.md), sección "Stack tecnológico
real") quiere avanzar hacia .NET moderno, de forma incremental, no de una vez.

## Cuándo NO usarla

Para Portal de Créditos — ya es 100% .NET moderno (.NET 8), no tiene nada que modernizar.

## Referencia oficial (no duplicada acá, por disciplina de tokens)

[Best practices for GitHub Copilot upgrade - .NET Core](https://learn.microsoft.com/en-us/dotnet/core/porting/github-copilot-upgrade/best-practices)
(Microsoft Learn, verificado 2026-09-22) — el flujo real: `assessment.md` → `plan.md` →
`tasks.md`, con modo guiado (pausa en cada decisión para aprobación humana) y un archivo
persistente de preferencias (`scenario-instructions.md`, siempre en contexto).

## Instrucciones — lo que agrega esta guía sobre la referencia oficial

### 1. Antes de empezar (según la guía oficial, sin excepción)

Solución con build/tests en verde antes de tocar nada; directorio git limpio (si el
proyecto no tiene git, inicializarlo primero — la guía oficial lo recomienda incluso sin
subirlo a ningún remoto); revisar cobertura de tests real, priorizando límites de API,
serialización, acceso a datos y autenticación — no hace falta 100% de cobertura.

### 2. Restricción real de MOA a declarar siempre en `scenario-instructions.md`

**Excluir explícitamente cualquier archivo `.xamlx` (Windows Workflow Foundation) del
alcance automático de la modernización** — son definiciones de negocio sensibles
(confirmado en Scato Logística y Scato Puerto, ver CAP-019). Un cambio automático sobre
estos archivos sin revisión específica es alto riesgo — se documentan y migran aparte,
nunca dentro del mismo flujo automático que el resto del código.

**Segunda restricción, confirmada por `moa-sdlc` (Existing Practice real, DataAgro)**: no
migrar un proyecto legacy a .NET moderno solo porque es técnicamente posible — solo
cuando hay una necesidad real (nueva feature que lo requiere, fin de soporte, riesgo de
seguridad concreto); y nunca romper un contrato de API público sin aprobación explícita
del equipo dueño de los consumidores reales de esa API.

### 3. Empezar con un piloto chico, no con el repo completo

La guía oficial lo recomienda para cualquier primera vez; para MOA es doblemente
relevante porque **4 de 6 equipos ya tienen módulos modernos conviviendo con el legacy en
el mismo repositorio** (ver stack real en `teams/README.md`) — ese módulo moderno ya
construido es la prueba de que el equipo puede avanzar por partes, no una teoría.
Candidato natural de piloto: un proyecto de librería/utilidad chico, no la aplicación web
principal.

### 4. Modo guiado siempre, nunca automático, en la primera vez

Coincide con el principio de este modelo (revisión humana explícita) — no es una
excepción para .NET, es la misma regla de siempre.

### 5. Ser específico, no vago, al darle instrucciones al agente

La guía oficial lo remarca con ejemplos reales (*"Actualizá el proyecto Data.Access a
.NET 10"*, no *"actualizá todo"*) — mismo criterio de evidencia real que rige el resto de
este modelo: nunca una instrucción genérica cuando se puede ser preciso.

## Revisión humana

Obligatoria en cada checkpoint del flujo oficial (assessment, plan, tasks) — esta guía no
cambia ni relaja ningún control ya definido por Microsoft, solo agrega el contexto real de
MOA que la herramienta no conoce de antemano.

## Origen de esta propuesta

**Existing Practice (MOA)**: 4 de 6 equipos ya tienen módulos modernos (.NET 6/7/8/10)
conviviendo con legacy .NET Framework en el mismo repo — la modernización ya está en
marcha, no es hipotética (ver `teams/README.md`). **External Best Practice**: agente
oficial de GitHub Copilot para modernización .NET, documentación de Microsoft Learn
vigente (2026-09-22). **Architectural Judgment**: no se construye una herramienta
propia — se documenta cómo usar bien la oficial, con la única restricción real
específica de MOA (excluir WF4.5 del alcance automático) que Microsoft no podría conocer
de antemano.

## Compatibilidad / adaptación

Portable a cualquier equipo de MOA con .NET Framework real — la restricción de WF4.5 solo
aplica a los 2 equipos que realmente lo usan (Scato Logística, Scato Puerto).
