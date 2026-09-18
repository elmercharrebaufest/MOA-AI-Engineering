# Preparación de reunión — Scato Logística y Scato Puerto

**Documento temporal**, dentro de `TRACK-1/` porque se va a mover a otro lugar más
adelante. No existía un análisis consolidado de estos 2 equipos en ningún otro archivo
del repositorio — la información está repartida entre `teams/README.md`, las entradas
del Registry y el historial de construcción (`docs/history/track-1/`). Este documento la
junta en un solo lugar para preparar la reunión.

## 1. Scato Logística — qué se sabe hoy

**Nivel de madurez (KO Interno)**: WALK, en transición hacia RUN a fin de 2026. Es el
único equipo relevado en ese nivel — los demás (DataAgro, MOA Operaciones, Scato Puerto)
están en CRAWL.

**Es el repositorio con más formalización de IA encontrada en todo el relevamiento**:

- 13 agentes por rol (`.github/agents/`): incluye `dotnet-code-reviewer`,
  `afip-integration`, `architect`, `product-owner`, `devops`, `test-engineer`,
  `wf-activity-refactor`, `workflow-designer`, `xamlx-documenter`, entre otros.
- 13 skills (`.github/skills/`): incluye `dotnet-best-practices` (target real: .NET
  Framework 4.5.2, EF5, MVC4, NUnit 2.6.3), `afip-cpe-ctg`, `azure-devops-cli`,
  `user-story`, `ef5-n-plus-one-review`.
- 14 archivos de instructions + `AGENTS.md` + `copilot-instructions.md`.
- Automatización propia: `AiEnablement/` (scripts de Azure DevOps CLI y generación de
  documentación de Workflows), `QaTools/` (contenido nunca inspeccionado en el
  relevamiento).
- Un `copilot-config.yml` con ruteo de modelo por costo/criticidad — 1 benchmark real
  reportado ("17/18 tareas exitosas, 0 USD de costo de IA"), sin evaluación cruzada más
  allá de esa instancia.
- Referencias a MCP de Atlassian en 2 agentes: `architect` con scope acotado a un solo
  método (`getJiraIssue`), `product-owner` con scope wildcard
  (`com.atlassian/atlassian-mcp-server/*`) — sin configuración local (`mcp.json`) que lo
  respalde en el repo, probablemente configurado a nivel de usuario.

**Capacidades ya generalizadas en este repositorio (`MOA-AI-Engineering`) con origen en
Scato Logística**: `azure-devops-cli` (CAP-001), `user-story` (CAP-002),
`.NET Code Reviewer` (CAP-003), el patrón de gobierno `AGENTS.md`/matriz de autonomía
(CAP-005), `stack-best-practices-template` (CAP-006).

**Hallazgo de seguridad real, sin resolver**: la skill `afip-cpe-ctg` documenta que el
código real deshabilita incondicionalmente la validación de certificado SSL en las
llamadas a AFIP, con el comentario "AFIP no valida certificado en todos los ambientes".
Es un riesgo real de integridad de datos en tránsito sobre un sistema regulatorio.

## 2. Qué hacía cada cosa, y cómo ya la llevamos a la base común

Esta sección explica, en lenguaje simple, qué resolvía cada agente/skill real de Scato
Logística, y qué quedó de eso en las 5 capacidades que ya forman parte de la base común
de IA para todo MOA (`MOA-AI-Engineering`). La idea siempre fue la misma en los 5 casos:
**tomar la estructura que ya funcionaba y sacarle todo lo específico de Scato**, para que
cualquier otro equipo (incluido Scato Puerto) pueda usarla con su propio contenido.

### 2.1. Revisor de código automático → CAP-003 (`.NET Code Reviewer`)

**Qué hacía en Scato Logística**: un asistente de IA que revisaba únicamente el cambio
de código de un Pull Request (nunca el repositorio completo) y devolvía una lista de
problemas encontrados — de seguridad, de manejo de errores, de calidad de tests —
clasificados por severidad (Crítico/Mayor/Menor), cada uno con el archivo y línea
exactos y una sugerencia concreta. Lo más importante: **este asistente no tiene permiso
para editar código**, solo para leerlo y comentarlo — es una revisión adicional antes de
que un humano apruebe el cambio, nunca un reemplazo de esa revisión.

**Qué se llevó a la base común**: exactamente ese diseño — revisar solo el cambio, nunca
poder escribir código, devolver hallazgos clasificados por severidad. Lo que se sacó: el
modelo de IA que Scato tenía fijado, y todas las reglas específicas de su versión de
.NET (esas quedaron en un componente separado, ver 2.5). Hoy cualquier equipo puede
copiar este mismo patrón de "revisor de solo lectura" y aplicarlo a su propio stack.

### 2.2. Operar Azure DevOps sin inventar comandos → CAP-001 (`azure-devops-cli`)

**Qué hacía en Scato Logística**: evitaba que el asistente de IA "inventara" comandos de
Azure DevOps que no existen o cambiaron de versión (una fuente real de errores). Antes
de crear un Pull Request, consultar un pipeline o modificar una variable, el asistente
debía primero verificar 4 cosas (que la herramienta esté instalada, que la sesión esté
autenticada, contra qué organización/proyecto va a operar) y mostrar esa verificación
antes de actuar.

**Qué se llevó a la base común**: el mecanismo completo, sin cambios — esta práctica ya
era genérica desde el origen, no tenía nada específico de Scato para sacar. Cualquier
equipo que use Azure DevOps puede adoptarla igual.

### 2.3. Estructurar requerimientos → CAP-002 (`user-story`)

**Qué hacía en Scato Logística**: convertía un ticket o una idea de negocio en lenguaje
natural en una historia de usuario completa — con criterios de aceptación verificables,
reglas de negocio numeradas, y un análisis explícito de qué falta o es ambiguo, antes de
que ese requerimiento llegue a desarrollo. El mismo patrón apareció, de forma
independiente, también en DataAgro y Orquestador.

**Qué se llevó a la base común**: la estructura (historia + criterios + reglas + gaps).
Lo que se sacó: cualquier lista fija de roles de negocio — se descubrió, al generalizar,
que una lista cerrada de roles de un equipo no cubre los roles reales de otro (a
DataAgro, por ejemplo, le faltaba "operador de planta"). Por eso hoy cada equipo completa
su propia tabla de roles reales, en vez de heredar una ajena.

### 2.4. Gobierno del asistente de IA → CAP-005 (patrón `AGENTS.md`)

**Qué hacía en Scato Logística**: un archivo (`AGENTS.md`) que le decía a cualquier
asistente de IA, en un solo lugar, **qué puede hacer sin pedir permiso, qué debe
confirmar antes de hacer, y qué nunca debe hacer** — por ejemplo, nunca desactivar
validaciones de seguridad, nunca subir código directo a la rama principal sin revisión.
Este mismo patrón de 3 columnas apareció, sin que ningún equipo copiara a otro, en
DataAgro, Scato Logística, Orquestador y en la herramienta de referencia de Baufest
(`moa-sdlc`) — 4 veces de forma independiente.

**Qué se llevó a la base común**: la estructura de 3 columnas (qué se permite siempre,
qué se confirma antes, qué nunca se hace). Lo que se sacó: el contenido real de cada
columna — las reglas específicas del monolito .NET de Scato no tienen sentido para otro
equipo con otro riesgo real. Hoy la plantilla viene vacía a propósito, con solo ejemplos
ilustrativos, para que cada equipo declare su propio riesgo.

### 2.5. Buenas prácticas del stack real → CAP-006 (`stack-best-practices-template`)

**Qué hacía en Scato Logística**: un documento separado (`dotnet-best-practices`) que el
revisor de código (2.1) cargaba para aplicar las reglas específicas de su stack real
(.NET Framework 4.5.2, Entity Framework 5, NUnit 2.6.3) — por ejemplo, cómo evitar un
problema de performance típico de esa versión exacta de Entity Framework. Orquestador
tenía un documento equivalente, pero para .NET Framework 4.7.2 — y se confirmó que **no
son intercambiables**: una regla pensada para una versión no siempre aplica a la otra.

**Qué se llevó a la base común**: solo el esqueleto de 8 secciones (arquitectura, manejo
de errores, acceso a datos, concurrencia, inyección de dependencias, testing, checklist).
El contenido real de Scato **no se copió a ningún lado** — la plantilla se entrega
completamente vacía, porque el objetivo es que cada equipo documente su propio stack, no
que herede el de otro.

### Lo que NO se llevó a la base común (y por qué)

De los 13 agentes y 13 skills reales de Scato Logística, solo 3 (el revisor de código,
`azure-devops-cli` y `user-story`) se generalizaron como capacidades — más el patrón de
gobierno (`AGENTS.md`) y la plantilla de buenas prácticas. El resto quedó fuera, no por
ser de mala calidad, sino porque su contenido solo tiene sentido dentro de Scato
Logística:

- **`afip-integration` y `afip-cpe-ctg`**: manejan la integración regulatoria con AFIP —
  contenido 100% específico de esa integración, sin valor para un equipo que no
  interactúe con AFIP.
- **`wf-activity-refactor`, `workflow-designer`, `xamlx-documenter`**: dependen de
  Workflow Foundation 4.5, una tecnología que no se encontró en ningún otro repositorio
  relevado.
- **`architect`, `product-owner`, `devops`, `test-engineer`, `release-manager`,
  `database-migration`, `domain-validation-engineer`, `frontend-engineer`**: agentes por
  rol, con contenido atado a la arquitectura puntual del monolito de Scato.
- **`ef5-n-plus-one-review`, `entity-scaffold`**: reglas puntuales de Entity Framework 5
  — su versión exacta ya quedó cubierta, como concepto general, dentro de CAP-006.
- **`AiEnablement/`** (generación automática de documentación de Workflows) y
  **`QaTools/`**: herramientas propias, no evaluadas como candidatas todavía (`QaTools/`
  ni siquiera se llegó a inspeccionar en el relevamiento).
- **`copilot-config.yml`** (ruteo de modelo de IA según costo/criticidad de la tarea):
  una práctica real e interesante, con un solo resultado medido hasta ahora, pero todavía
  sin comparar contra la experiencia de otro equipo — por eso sigue marcada como
  experimental, no como capacidad lista para adoptar.

## 3. Scato Puerto — qué se sabe hoy

**Nivel de madurez (KO Interno)**: CRAWL, junto con DataAgro y MOA Operaciones.

**No se encontró ninguna capacidad de IA formalizada** en ninguno de sus 2 repositorios
(`scatopuerto`, `scatopuertoAPINet`): sin `AGENTS.md`, sin `.github/agents/`, sin skills
ni instructions versionadas. Es una ausencia total, no parcial.

**Punto notable para la reunión**: Scato Puerto comparte linaje de código y dominio de
negocio con Scato Logística (mismos patrones de arquitectura, nombres de clase
similares), pero son repositorios git independientes que divergieron fuertemente en
madurez de IA — uno con 13 agentes y 13 skills, el otro con ninguno. El relevamiento
original señala explícitamente que **por qué divergieron es una pregunta para los
equipos, no algo que se pueda concluir desde el código**.

**Importante — no confundir ausencia de evidencia en el repo con ausencia de uso real**:
el KO Interno afirma que este grupo de equipos (CRAWL) ya usa IA de forma informal (modo
chat, autocomplete, debugging) — lo que no se encontró es una capacidad *formalizada y
versionada en el repositorio*, no el uso cotidiano de un asistente.

## 4. Lo que no se sabe (gaps reales — no inferir en la reunión, preguntar)

- Si los 13 agentes y 13 skills de Scato Logística se usan de verdad en el día a día, o
  quedaron configurados sin adopción real (la distinción "configurado ≠ usado" es
  central en todo este proyecto).
- Quién es el dueño/mantenedor real de ese conjunto de agentes y skills.
- Si el riesgo de SSL de `afip-cpe-ctg` ya fue evaluado y aceptado por el equipo, o es
  una brecha no revisada.
- Si el scope wildcard del agente `product-owner` es una decisión consciente o un
  descuido frente al patrón acotado que ya usa `architect`.
- Qué contiene `QaTools/`.
- Si existe algún proceso de spec-driven development (definir requerimientos/diseño
  antes de codear) en Scato Logística — no se encontró evidencia de eso.
- Si Scato Puerto usa IA de forma informal hoy, y en qué actividades.
- Por qué Scato Puerto no formalizó nada pese a compartir dominio con Scato Logística.

## 5. Preguntas sugeridas para la reunión

### Para Scato Logística

1. De los 13 agentes y 13 skills que tienen configurados, ¿cuáles se usan realmente hoy?
   ¿Hay alguno que quedó armado pero nunca se adoptó en la práctica?
2. ¿Quién es responsable de mantener ese conjunto de agentes/skills cuando algo cambia
   (una versión de librería, una convención nueva)?
3. El agente `product-owner` tiene acceso amplio (wildcard) al MCP de Atlassian,
   mientras que `architect` lo tiene acotado a una sola operación de lectura — ¿fue una
   decisión deliberada, o conviene alinear `product-owner` al mismo patrón acotado?
4. La skill `afip-cpe-ctg` deshabilita la validación de certificado SSL para las
   llamadas a AFIP — ¿el equipo ya evaluó y aceptó ese riesgo, o vale la pena revisarlo
   ahora?
5. ¿Existe algún tipo de definición de requerimientos o diseño técnico antes de escribir
   código, asistido por IA, o el flujo va directo del ticket al código?
6. Sobre el ruteo de modelo por costo/criticidad (`copilot-config.yml`) — ¿lo siguen
   usando? ¿hay más experiencia real más allá del primer benchmark?
7. ¿Qué hace `QaTools/`? ¿Tiene algo reutilizable para otros equipos?

### Para Scato Puerto

8. Hoy no encontramos ningún agente, skill ni instruction formalizada en sus
   repositorios — ¿usan IA de alguna forma informal (chat, autocomplete)? ¿En qué
   actividades?
9. ¿Alguna vez evaluaron adoptar algo de lo que ya construyó Scato Logística, dado que
   comparten dominio y arquitectura? ¿Qué lo impidió, si lo consideraron?
10. Si tuvieran que empezar hoy, ¿qué actividad del día a día les gustaría mejorar
    primero con IA (refinar requerimientos, revisar código, generar pruebas)?

### Preguntas conjuntas

11. El KO menciona "Cardless" en relación al modo agente de Scato Logística — ¿qué es
    exactamente (una feature, un epic, un squad)? Nunca quedó aclarado en el
    relevamiento.
12. ¿Manuel Davila, Alexis Morales Vega y Gonzalo Sian —autores identificados detrás de
    la mayoría de la evidencia real encontrada— son referentes formales de esta
    iniciativa para sus equipos?
13. Si Scato Puerto arrancara a adoptar algo, ¿tendría sentido que Scato Logística sea
    su referencia directa (mismas capacidades, mismo dominio), en vez de partir de cero?

## 6. Recomendaciones para plantear en la reunión

No son conclusiones — son puntos concretos para poner sobre la mesa y validar con los
equipos, ordenados por relevancia.

### 6.1. Riesgo de seguridad real, sin resolver

La skill `afip-cpe-ctg` deshabilita la validación de certificado SSL para **todas** las
llamadas a AFIP, no solo para los ambientes que carecen de certificado válido
(`ServicePointManager.ServerCertificateValidationCallback = ((...) => true)`, con el
comentario "AFIP no valida certificado en todos los ambientes"). Es un riesgo concreto
de integridad de datos en tránsito sobre un sistema regulatorio real. Recomendación:
evaluar si la excepción puede acotarse solo a los ambientes que efectivamente lo
necesitan, en vez de deshabilitarla siempre.

### 6.2. Inconsistencia de gobierno de accesos (MCP de Atlassian)

El agente `product-owner` tiene acceso amplio (wildcard,
`com.atlassian/atlassian-mcp-server/*`) al MCP de Atlassian, mientras que `architect`,
en el mismo repositorio, ya usa un patrón acotado a una sola operación de lectura
(`getJiraIssue`). Es la misma integración, con dos niveles de riesgo distintos sin
razón documentada — y es exactamente el antipatrón que este mismo proyecto identificó y
evitó al construir el patrón `jira-context` de la base común (que solo generalizó el
patrón acotado, descartando el wildcard a propósito). Recomendación: alinear
`product-owner` al mismo patrón acotado que ya usa `architect`.

### 6.3. La etapa "antes de codear" no está cubierta

Scato Logística tiene fuerza real en desarrollo y revisión de código, pero no se
encontró ningún proceso de estructurar o definir un requerimiento antes de llegar a
desarrollo. Es justamente lo que resuelve `user-story` (CAP-002) — generalizado, en
parte, a partir de la propia práctica de Scato. Recomendación: adoptarlo formalmente
para cerrar ese hueco, usando algo que el propio equipo ayudó a construir.

### 6.4. Camino más corto para Scato Puerto

Scato Puerto comparte dominio y arquitectura con Scato Logística, pero no tiene ninguna
capacidad formalizada propia. En vez de empezar de cero, podría adoptar directamente las
5 capacidades ya generalizadas en la base común — que además nacieron, en su mayoría, de
la práctica real de Scato Logística. Es, en principio, el camino más corto para pasar de
CRAWL a WALK.

### 6.5. Un modelo de IA fijado en el código

El agente `afip-integration` tiene el modelo de IA fijado en su configuración
(`model: claude-opus-4.8`), en vez de dejarlo configurable. Es la única referencia de
este tipo encontrada en todo el relevamiento de MOA. Si ese modelo se discontinuara o
cambiara de disponibilidad, el agente deja de funcionar hasta que alguien lo corrija
manualmente. Recomendación: revisar si conviene dejar el modelo sin fijar, igual que ya
se hizo al generalizar el patrón de revisor de código en la base común.

### 6.6. Medir antes de seguir sumando

Con 13 agentes y 13 skills ya construidos, no hay evidencia de que se haya medido
cuáles se usan realmente y cuáles quedaron configurados sin adopción real. Antes de
agregar más, tiene sentido validar el impacto real de lo que ya existe — es el mismo
principio que el propio KO plantea: no se trata de sumar herramientas, sino de
sostener una práctica de ingeniería con datos reales detrás.
