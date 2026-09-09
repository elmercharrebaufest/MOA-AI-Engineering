# AGENTS.md — MoaOperaciones (BORRADOR SANDBOX — no integrado al repo real)

> **No copiar este archivo tal cual al repositorio real todavía.** Las líneas marcadas
> `INFERENCE` fueron inferidas solo de la estructura pública de carpetas del repo
> (`Keys/`, `SustitucionMOASecurity`, `SustitucionMOACrypting`, `SustitucionMOAExternalAPI`,
> `SustitucionMOADatabase`, `SustitucionMOAQRCamionesWeb`) — deben ser confirmadas o
> corregidas por alguien del equipo real de MoaOperaciones antes de usarse.

## Antes de empezar

- Este repo es una solución .NET (`SustitucionMOA.sln`) con módulos separados por
  responsabilidad (Database, Security, Crypting, ExternalAPI, Repositorio, Validator,
  Model, WS, Web). `INFERENCE`.
- Referenciar siempre un ticket/work item real de MOA antes de generar código o
  documentación — nunca contenido inventado (regla transversal de `MOA-AI-Engineering`).

## Matriz de autonomía

### ALWAYS (sin pedir confirmación)
- Generar tests para lógica de negocio nueva o modificada, sin tocar módulos de
  `SustitucionMOASecurity`/`SustitucionMOACrypting`. `INFERENCE` — confirmar con el equipo.
- Formatear archivos editados con el linter/formatter del proyecto.

### ASK FIRST (confirmar antes de ejecutar)
- Instalar o actualizar paquetes NuGet (`NuGet.Config` presente en el repo).
- Modificar `SustitucionMOADatabase` o `SustitucionMOARepositorio` (posibles migraciones
  o cambios de esquema). `INFERENCE`.
- Modificar `SustitucionMOAExternalAPI` (contratos con sistemas externos — confirmar
  cuáles: ¿AFIP, terceros, otro sistema de MOA?). `REQUIRES VALIDATION` — no se pudo
  confirmar el/los sistema(s) externo(s) reales desde la estructura pública.
- Cambiar pipelines (`azure-pipelines.yml`, `Jenkinsfile-Analisis-Dinamico`,
  `Jenkinsfile-Analisis-Estatico` — hay evidencia de análisis estático/dinámico de
  seguridad ya integrado al CI).

### NEVER (nunca, sin excepción)
- Modificar `SustitucionMOASecurity`, `SustitucionMOACrypting` o cualquier archivo bajo
  `Keys/` sin aprobación humana explícita y revisión de seguridad. `INFERENCE` — la sola
  existencia de estas carpetas ya indica manejo de criptografía/seguridad, tratar como
  alto riesgo por defecto hasta que el equipo confirme el detalle.
- Commitear secretos, connection strings, tokens o contenido de `Keys/`.
- Desactivar los análisis estático/dinámico de seguridad ya configurados en el CI
  (`Jenkinsfile-Analisis-*`).
- Hacer push/merge directo a la rama principal sin revisión humana.

## Dependencias

Ninguna técnica — depende de que alguien del equipo real de MoaOperaciones confirme o
corrija las líneas `INFERENCE`/`REQUIRES VALIDATION` antes de integrarse al repo real.

## Origen

Piloto de adopción independiente de CAP-005 (`repository-governance`), generado a partir
de [`capabilities/instructions/repository-governance/INSTRUCTIONS.md`](../../../../../capabilities/instructions/repository-governance/INSTRUCTIONS.md).
Ver [`README.md`](README.md) de esta carpeta para el estado y los próximos pasos.
