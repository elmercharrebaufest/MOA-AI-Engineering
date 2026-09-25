---
name: test-pipeline-setup
description: Configura que los tests automatizados de un repo de Azure DevOps corran solos en cada cambio y en cada Pull Request — pipeline de CI para .NET moderno, .NET Framework (NUnit/MSTest) o Angular, publicación de resultados y cobertura, cobertura mínima sobre el código modificado y política de rama que impide completar un PR con tests fallando. Usar cuando un repo tiene tests pero nadie los corre de forma automática.
---

# test-pipeline-setup

**Idioma de la respuesta**: español neutro y formal: tratar a la persona de usted, sin
voseo ni regionalismos, aunque la persona escriba de otra forma.

## Propósito

Que ningún cambio llegue a la rama principal sin que sus tests hayan corrido, con el
resultado visible en Azure DevOps. Es la base para que la validación de pruebas tenga
evidencia real (un número de ejecución de CI) en lugar de depender de una corrida local.

## Cuándo usarla

- El repo tiene tests y ningún pipeline los corre en cada cambio o PR.
- Los tests corren, pero solo en un despliegue manual, sin publicar resultados.

## Cuándo NO usarla

- Para modificar pipelines de despliegue existentes — se agrega un pipeline de CI
  aparte; tocar los de despliegue se consulta primero.
- Para hacer pasar un pipeline excluyendo tests o bajando umbrales.

## Instrucciones

### 1. Relevar antes de proponer

- Stack real: `.csproj` estilo SDK (.NET moderno) o antiguo (.NET Framework); versión
  de NUnit/xUnit/MSTest; Angular con Karma (`karma.conf.js`) o con Vitest.
- Pipelines existentes (`azure-pipelines*.yml`) y si ya corren tests. Los pipelines
  configurados desde la interfaz de Azure DevOps no aparecen en el repo: preguntar.
- Comando de test documentado en el repo. Nunca suponerlo.

### 2. Proponer el pipeline de CI, según el stack

**Importante en Azure Repos**: el disparador `pr:` del YAML no se usa; la validación de
PR se configura con la política de rama del paso 4. El pipeline lleva `trigger` para la
rama principal.

**.NET moderno (.NET 6 o superior)** — el paso de test publica resultados y cobertura
automáticamente
([documentación oficial](https://learn.microsoft.com/en-us/azure/devops/pipelines/ecosystems/dotnet-core?view=azure-devops)):

```yaml
trigger:
  branches:
    include: [ main ]

pool:
  vmImage: 'windows-latest'

variables:
  buildConfiguration: 'Release'

steps:
- task: UseDotNet@2
  inputs:
    version: '8.x'
- task: DotNetCoreCLI@2
  displayName: 'Build'
  inputs:
    command: 'build'
    arguments: '--configuration $(buildConfiguration)'
- task: DotNetCoreCLI@2
  displayName: 'Tests unitarios'
  inputs:
    command: 'test'
    projects: '<ruta al proyecto de tests unitarios>'
    arguments: '--configuration $(buildConfiguration) --no-build --collect "Code Coverage"'
```

Se usa agente Windows y `--collect "Code Coverage"` porque la validación de cobertura en
el PR (paso 3) solo acepta ese formato. Los tests que necesitan Docker (por ejemplo, con
Testcontainers) van en un job aparte con `vmImage: 'ubuntu-latest'`.

**.NET Framework** — agente Windows con Visual Studio, `VSTest@3`
([referencia oficial](https://learn.microsoft.com/en-us/azure/devops/pipelines/tasks/reference/vstest-v3?view=azure-pipelines)):

```yaml
trigger:
  branches:
    include: [ main ]

pool:
  vmImage: 'windows-latest'

steps:
- task: NuGetCommand@2
  inputs:
    command: 'restore'
    restoreSolution: '**/*.sln'
    feedsToUse: 'select'
- task: VSBuild@1
  inputs:
    solution: '**/*.sln'
    configuration: 'Release'
- task: VSTest@3
  inputs:
    testSelector: 'testAssemblies'
    testAssemblyVer2: |
      **\*Test*.dll
      !**\*TestAdapter.dll
      !**\obj\**
    searchFolder: '$(System.DefaultWorkingDirectory)'
    configuration: 'Release'
    codeCoverageEnabled: true
    failOnMinTestsNotRun: true
    minimumExpectedTests: '<cantidad actual de tests>'
```

- **Adaptador de NUnit**: VSTest encuentra el adaptador si está junto a los assemblies
  de test (como paquete NuGet del proyecto de tests). NUnit 2.x necesita
  `NUnitTestAdapter` versión 2.x; NUnit 3 o superior, `NUnit3TestAdapter`.
- **`minimumExpectedTests`** con la cantidad real de tests hace fallar el pipeline si,
  por un adaptador faltante, se descubren menos de los que existen.
- Si el agente hospedado no tiene el targeting pack o una dependencia del proyecto, usar
  un agente propio del equipo.

**Angular con Karma** — correr sin ventana y una sola vez
([guía oficial de testing](https://angular.dev/guide/testing)):

```yaml
- task: NodeTool@0
  inputs:
    versionSpec: '<versión de Node del proyecto>'
- script: npm ci
- script: npx ng test --no-watch --no-progress --browsers=ChromeHeadless --code-coverage
```

Los parámetros de la línea de comandos tienen prioridad sobre `karma.conf.js`
(`singleRun: false` o `browsers: ["Chrome"]` no impiden correr en CI). Para publicar
resultados y cobertura: agregar `karma-junit-reporter` al proyecto, luego
`PublishTestResults@2` (formato JUnit) y `PublishCodeCoverageResults@2` sobre el reporte
Cobertura de `karma-coverage`. **Con Vitest** (predeterminado en proyectos Angular
nuevos): `npx ng test --no-watch --coverage`.

### 3. Cobertura sobre el código modificado, no global

En un repo con mucho código heredado, exigir un porcentaje global no es realista. Azure
DevOps mide la cobertura de las líneas cambiadas en cada PR con un archivo
`azurepipelines-coverage.yml` en la raíz del repo
([documentación oficial](https://learn.microsoft.com/en-us/azure/devops/pipelines/test/review-code-coverage-results?view=azure-devops)):

```yaml
coverage:
  status:
    comments: on
    diff:
      target: 70%
```

El chequeo es informativo hasta que se agregue como política de rama. Solo funciona con
Azure Repos y con el formato de cobertura de Visual Studio (`.coverage`), el que generan
`VSTest@3` y el paso de test de `DotNetCoreCLI@2` del paso 2. La meta la decide el equipo.

### 4. Política de rama: el PR no se completa si fallan los tests

```text
az repos policy build create --blocking true --enabled true --branch main \
  --repository-id <id del repo> --build-definition-id <id del pipeline de CI> \
  --display-name "Build y tests" --manual-queue-only false \
  --queue-on-source-update-only false --valid-duration 720
```

(`az repos show --repository <nombre> --query id` y
`az pipelines show --name <pipeline> --query id` devuelven los IDs —
[referencia oficial](https://learn.microsoft.com/en-us/cli/azure/repos/policy/build?view=azure-cli-latest).)
Requiere ser administrador del proyecto en Azure DevOps
([documentación oficial](https://learn.microsoft.com/en-us/azure/devops/pipelines/repos/azure-repos-git?view=azure-devops#pr-triggers)):
mostrar el comando y ejecutarlo solo con confirmación de quien tenga ese rol. Los PR en
borrador no disparan la validación.

### 5. Orden recomendado

1. Pipeline de CI corriendo en la rama principal, con resultados publicados.
2. Si la suite heredada ya tiene fallas: listarlas, y que el tech lead decida por cada
   una — corregir, o ponerla en cuarentena con un ticket de seguimiento. Nunca borrarla.
3. Política de rama, primero no bloqueante (`--blocking false`) y, cuando el pipeline
   esté estable, bloqueante.
4. Cobertura del código modificado (paso 3).
5. Tests inestables: usar la detección de Azure DevOps
   ([flaky test management](https://learn.microsoft.com/en-us/azure/devops/pipelines/test/flaky-test-management?view=azure-devops))
   en lugar de desactivarlos.

### 6. Cierre, siempre

```text
✅ Propuesta de CI para [repo]: [archivos a crear] y [comando de política, si aplica].
   Pendiente de su revisión: crear los archivos en una rama, hacer push y abrir el PR
   — no se hizo nada de eso todavía. La política de rama la aplica quien tenga permiso.
```

## Herramientas / permisos

Lectura del repo; escritura de los archivos de pipeline solo con confirmación, en una
rama; nunca commit, push ni cambios de política sin confirmación explícita.

## Seguridad

Riesgo **Bajo**: propone configuración; los cambios reales pasan por PR y por quien
administra el proyecto.

## Origen

**Existing Practice**: en los repos relevados de MOA hay suites de tests grandes y reales
que ningún pipeline corre en cada cambio; el único pipeline que las corre lo hace solo
dentro de un despliegue manual, sin publicar resultados. **External Best Practice**:
documentación oficial de Azure Pipelines y Azure Repos citada en cada paso;
[pirámide de tests — Martin Fowler](https://martinfowler.com/articles/practical-test-pyramid.html);
cobertura sobre el código nuevo en lugar de global
([SonarQube — new code](https://docs.sonarsource.com/sonarqube-server/user-guide/about-new-code)).

## Compatibilidad / adaptación

Azure DevOps (Azure Repos y Azure Pipelines). Cada equipo ajusta rutas de proyectos,
versión de Node o .NET, agente y meta de cobertura.
