# Escalando el Valor del Delivery Mediante IA Aplicada

> Potenciar la productividad, calidad y evolución — Kick-off interno
>
> Fuente: `BAUFEST - Escalando el Valor del Delivery Mediante IA Aplicada (KO Interno).pdf`
> (29 páginas). Documento de referencia para alinear el proyecto — contenido
> completo del deck, reorganizado para lectura (no reproduce diseño gráfico).

## Agenda

1. **Contexto y objetivos** — necesidades y objetivos de trabajo
2. **Panorama actual** — una industria en plena transformación
3. **Qué estamos haciendo hoy en MOA** — el uso actual de IA en nuestros servicios
4. **Evolucionar la productividad de los servicios actuales** — objetivos y plan de trabajo
5. **Charla abierta y próximos pasos** — dudas, consultas, cómo vas a estar participando

---

## 1. Contexto y objetivos

**Evolucionar el delivery de servicios y nuevas soluciones para acelerar la entrega de valor.**

La iniciativa se aborda en 3 tracks:

| Track | Pregunta que responde |
|---|---|
| **1. Evolucionar la productividad de los servicios actuales** | ¿Cómo incrementar la productividad del equipo evolutivo y de operación de las soluciones actuales, mejorando la adopción de IA, trabajando con un SDLC más ágil y midiendo el cambio de velocidad en el tiempo? |
| **2. Acelerar el time-to-market de nuevos proyectos e iniciativas** | ¿Cómo abordar nuevos proyectos para los usuarios bajo un paradigma más ágil, con respuestas tempranas? Modelos Production Readiness Gap con prototipado. |
| **3. Integrar modelos desarrollados** | ¿Cómo integrar trabajo funcional/prototipos en plataformas de IA, para acelerar la construcción de productos digitales? |

> Este documento (y el proyecto que estamos ejecutando) se enfoca en el **Track 1**.

---

## 2. Panorama actual

**Una industria tecnológica que se está redescubriendo y redefiniendo.**

Toda evolución presenta desafíos:

- Más código generado ≠ más productividad real.
- Velocidad sin métricas claras = pérdida de control.
- Incorporar Agentic AI sin erosionar arquitectura o seguridad.
- Equipos híbridos requieren procesos, plataforma y gobierno específicos.
- El SDLC tradicional no está preparado para IA a escala.

**Hoy: humanos + asistentes de IA → equipos híbridos (humanos + agentes).**

La IA no solo sugiere código: ya ejecuta tareas, revisa, testea y opera como
parte activa de los nuevos SDLC inteligentes. El desafío no es incorporar
herramientas, sino **rediseñar el modelo de ingeniería actual** para que la
velocidad no se transforme en un riesgo.

> ¿Cómo podemos incorporar IA de manera eficiente?

---

## 3. Qué estamos haciendo hoy en MOA

**El punto de partida: un equipo que ya utiliza IA, pero de forma heterogénea.**

Una adopción real de IA, con oportunidades para escalarla mejor:

- **Uso real y cotidiano**: los equipos ya utilizan IA en su día a día, en modo chat y en modo agente.
- **Adopción con distintos niveles de madurez**: se comparten algunas prácticas, pero no de forma estandarizada; se está trabajando en establecer procesos comunes.
- **Curva de aprendizaje en marcha**: conviven niveles básico e intermedio según equipo/rol.
- **Conocimiento distribuido**: prompts, prácticas y aprendizajes generados por personas/equipos que pueden consolidarse como activos compartidos en un repositorio común.
- **La oportunidad**: capturar el valor ya generado y escalarlo con método, gobierno y métricas.
- **Foco en el valor**: la adopción debe evolucionar con métricas que evidencien mejoras en productividad, calidad y velocidad.

### Nivel de adopción por equipo — marco Crawl / Walk / Run

| Nivel | Descripción |
|---|---|
| 🐾 **CRAWL — Explorar con control** | Uso inicial de IA en actividades acotadas del SDLC, bajo riesgo, foco en aprendizaje y validación de valor potencial. |
| 🚶 **WALK — Ordenar, repetir y medir** | Adopción regular de IA en casos concretos del SDLC, con prácticas comunes, métricas iniciales y procesos controlados. |
| 🏃 **RUN — Escalar y gobernar** | IA integrada de forma sistemática en el SDLC, con gobierno, automatización, métricas ejecutivas y mejora continua. |

Ejes de progresión entre niveles: **Método, Repetibilidad, Medición** (Crawl→Walk) y **Gobierno, Automatización** (Walk→Run).

**Estado actual por equipo (situación de hoy, no la meta):**

- **DataAgro / MOA Operaciones / Scato Puerto — nivel CRAWL**
  - DEV: autocomplete y sugerencias, debugging, poco modo agente; integración SAP; consultas sobre código existente; V0 para bosquejo.
  - PM/PO/QA: documentación asistida por IA, sin herramienta específica.
- **Scato Logística — nivel WALK** *(en transición actual)*
  - DEV (Cardless): modo agente con reglas de codificación, MCP contra Jira, skills e instructions; soporte con agente y chat.
  - PO: agente en prueba.
  - QA: generación de casos con apoyo de Copilot.
  - PM: gestión, reportes de status, documentación.
- **Nivel RUN**: ningún equipo está hoy en este nivel — es el destino de madurez del marco, no un estado actual de ningún equipo.

### Prácticas, procesos y herramientas

- Trabajo por sprint (1 mes). Refinamiento, estimación, planning y aviso de despliegue al usuario de forma manual.
- **Requerimientos**: Jira como fuente; estimación manual de tickets en la misma herramienta.
- **Documentación**: distribuida entre SharePoint (MOA) y Confluence (Baufest).
- **Coding**: Visual Studio + VS Code con GitHub Copilot, uso diario.
- **Testing**: NUnit para unitarios; Cypress arrancando; algo de JMeter; Playwright en pruebas.
- **Consultoría**: hoy funciona de forma local, sin repositorios compartidos aún.

**Stack actual:**

| Categoría | Herramienta |
|---|---|
| Repos | Azure DevOps |
| Base de datos | SQL Server |
| IA | GitHub Copilot + modelos varios (costo cubierto por Baufest) |
| Gestión y documentación | Jira, SharePoint, Confluence |

### Resultados y aprendizajes actuales de la adopción de IA

- Mayor fluidez en tareas de desarrollo (generación de código, consultas sobre código existente, soporte al desarrollo).
- Mejor asistencia en documentación y conocimiento (documentación, análisis, recuperación de contexto).
- Primeros usos en modo agente (reglas, instructions, skills e integraciones con herramientas del ciclo).
- Valor todavía no capturado de forma homogénea (depende del equipo, la práctica, el nivel de madurez).
- **Necesidad de medición**: consolidar un baseline y medir adopción, productividad, calidad y velocidad de forma consistente.

---

## 4. Track 01 — Evolucionar la productividad de los servicios actuales

**Transformar esta adopción inicial para unificar y escalar el uso de IA en todos los servicios, con método y medición.**

### Nuestro objetivo

Pasar del uso individual y heterogéneo actual de la IA a una **adopción
sistemática en todo el SDLC** de nuestros equipos para MOA, con un enfoque
común, gobierno y métricas que conecten la IA con el impacto positivo en el
equipo y en el negocio.

**Más productividad · mejor calidad · menor time-to-market**

> No se trata de sumar herramientas, sino de convertir el uso de IA en una práctica sostenida de ingeniería.

### Cómo vamos a escalar el uso de IA en todo el ciclo

1. **Empezar por la plataforma** — probar y conectar la base de IA (Jira, Copilot, SharePoint, Azure DevOps) antes de escalar.
2. **Aplicar IA en cada etapa** — llevar la IA a cada ceremonia y actividad del ciclo, no a una sola tarea.
3. **Mantener enfoque human-in-the-loop** — validación y corrección humana estricta antes de integrar cualquier salida.
4. **Medir desde el día 1** — definir baseline e indicadores de uso para gobernar la adopción con datos.

**Alcance**: nuevos desarrollos + evolutivos + soporte.

### Plataforma de IA — stack de herramientas

| Capa | Herramientas |
|---|---|
| **Asistencia** | GitHub Copilot, Copilot Code Review, Rovo |
| **Conectores (MCP/API)** | Jira, Confluence, Azure DevOps, Playwright, App Insights, Base de datos, SonarQube |
| **Automatización** | SKILLs y archivos de instrucciones, Agentes, Integración con Azure DevOps, Tablero de métricas |

### ¿Qué deberíamos agregar al stack actual?

- **Servidores MCP**: garantizar acceso por MCP para Jira, Confluence, Azure DevOps, SQL Server.
- **Tablero Power BI**: visualizar métricas de adopción de IA y productividad; las métricas deben evolucionar con el servicio (sumar/retirar según contexto).
- **Application Insights**: centralizar logs de aplicación para alimentar información de errores productivos a los agentes.
- **SonarQube**: mantener calidad de código bajo control y extraer métricas relacionadas; sumar agentes al ciclo a medida que madura la adopción.

> El set de herramientas será revisado como parte de las actividades de innovación; debe evolucionar con el resto de las aplicaciones y plataforma.

### Quiénes van a estar trabajando en la iniciativa

- **Líderes**: Elmer Charre, Fernando Pagano, Tito Picón
- **Soporte**: Adrián Bepré, Ariel Bensussán
- **Participantes**: todo el equipo

Para gestionar mejor la iniciativa, se irán sumando al backlog las tareas a ejecutar en cada uno de los equipos del servicio.

### Modelo de métricas propuesto

**Adopción, productividad y velocidad:**

- % Team con Copilot (GH + 365) — adopción
- # HU refinadas × sprint/mes (HU completas y listas para trabajar/desarrollar) — productividad & velocidad
- % Aceptación de sugerencias de Copilot (presentadas vs. aceptadas) — adopción
- # Requerimientos/Mejoras × sprint/mes — productividad & velocidad
- Lead time de features (HU desde requerimiento hasta producción) — productividad & velocidad

**Impacto y calidad:**

- # Bugs detectados × sprint/mes (QA & PROD)
- Calidad de código (SonarQube): Reliability Grade, Vulnerabilities, Code Coverage

> Nota del propio deck: *"Esta propuesta de métricas es una estrategia
> inicial que consideramos de valor, pero que se deberá refinar en base a
> las necesidades de MOA y la disponibilidad de la información en los
> sistemas de gestión actuales."*

Métricas consolidadas en un **Dashboard Ejecutivo** (con datos de GitHub y Jira) y en **SonarQube**.

### El impacto al que apuntamos alcanzar — metas a fin de 2026

*(Porcentajes proyectados sobre una media de las métricas actuales del primer Half 2026.)*

**📈 Más productividad y velocidad** *(asistencia de IA en cada etapa del ciclo, reduciendo cambio de contexto y trabajo manual)*

| | Q3 2026 | Q4 2026 |
|---|---|---|
| HU refinadas x sprint/mes | +5% | +10% |
| Requerimientos/Mejoras x sprint/mes | +15% | +30% |
| Lead time de features | -10% | -20% |
| Productividad DEVs | +15% | +30% |

**📊 Mayor adopción y evolución** *(el equipo propone mejoras y suma agentes autónomos al ciclo, no solo ejecuta)*

| Q3 2026 | Q4 2026 |
|---|---|
| 100% Team con Copilot · Integración con herramientas · Tablero de métricas disponible · SonarQube instalado | Conocimiento compartido · Repositorio de Skills/Prompts · Prácticas homogéneas |

**✅ Más impacto y calidad** *(menos bugs en producción, code review automatizado, deuda técnica bajo control)*

| Q3 2026 | Q4 2026 |
|---|---|
| SQ: +5% Unit Tests (global) · -5% Bugs en QA/PROD · -10% tiempo generación de casos de prueba | SQ: Reliability Grade A o B · SQ: Zero Critical Vulnerabilities · SQ: +15% Unit Tests (global) · -10% Bugs en QA/PROD |

### Metas de madurez por equipo a fin de 2026 (progresión Crawl → Walk → Run)

Este es un **mapa de progresión**: cada equipo parte de un nivel de madurez
hoy y se traza hacia el siguiente nivel para fin de 2026 (no son 3 columnas
de "estado actual vs. meta" en paralelo, sino una trayectoria por equipo).

| Equipo | Nivel hoy | Nivel meta fin 2026 |
|---|---|---|
| **Scato Logística** | WALK *(en camino a finalizar de adoptar todos los puntos indicados)* | **RUN** |
| **DataAgro** | CRAWL | **WALK** |
| **MOA Operaciones** | CRAWL | **WALK** |
| **Scato Puerto** | CRAWL | **WALK** |

Lo que caracteriza a cada nivel (aplica a cualquier equipo que esté en él, no es específico de un equipo):

| Nivel | Características |
|---|---|
| **CRAWL** (punto de partida de DataAgro/MOA Oper./Scato Puerto) | Roles y prácticas heterogéneas · IA en DEV principalmente · Sin dashboard ni métricas aún · Poca reutilización |
| **WALK** (meta de DataAgro/MOA Oper./Scato Puerto; punto de partida de Scato Logística) | Prácticas IA comunes por rol · IA en refi, docu, dev y QA · Skills/prompts reutilizables · Integración inicial con tools · Baseline e indicadores · Dashboard ejecutivo · Métricas en SonarQube |
| **RUN** (meta de Scato Logística) | Repositorio de prompts/skills · Agentes para DEVs · IA extendida full a PO/QA/PM · PR, review y testing asistidos · Tools conectadas · Dashboard ejecutivo automatizado · Gobierno formalizado |

### Enfoque de 5 pasos

**Análisis → Desarrollo → Implementación**

1. **Identificar proceso/actividad** — desglosar el proceso de desarrollo global en actividades (ej. generación de pruebas unitarias o documentación de endpoints).
2. **Integrar IA** — asignar un modelo de IA con contexto reducido para resolver la tarea específica, limitando el margen de alucinación.
3. **Auditar** — implementar un filtro humano estricto (human-in-the-loop) que valide y corrija el código propuesto antes de su integración.
4. **Medir resultados** — evaluar métricas clave: tiempo ahorrado, calidad resultante del código, tasas reales de error.
5. **Mejorar** — optimizar la base de conocimientos, los prompts y los parámetros técnicos del modelo en base a las auditorías.

### Roadmap propuesto

Fases: **Foundation → Evolution → Evolution → Evolution → Iteration**, en el eje temporal Q3 2026 → Q4 2027 (Ciclo I, Ciclo II).

Ejes transversales: Visión · Estrategia · Planificación · Gobierno · Monitoreo · Aprendizaje.

*(Responsable entre corchetes: [BF] = Baufest, [MOA] = MOA, [BF+MOA] = conjunto.)*

1. **Identificar proceso/actividad**: mapear SDLC por rol y etapa [BF] · revalidar objetivos [BF+MOA] · revalidar CRAWL→WALK [BF+MOA] · revalidar WALK→RUN [BF+MOA] · acordar métricas [BF+MOA] · validar plan de trabajo [BF+MOA] · verificar requerimientos [MOA] · validar accesos e integraciones [BF+MOA]
2. **Integrar IA**: habilitar Rovo/Jira [MOA+BF] · habilitar MCPs y accesos [MOA+BF] · habilitar GitHub Copilot Code Review for Azure DevOps [MOA+BF] · configurar skills, agents e instructions por rol/etapa [BF] · formar/capacitar/difundir/estandarizar en el equipo [BF] · aplicar IA en Refi, DEV, QA, PR, Docu y Soporte [BF] · definir criterios de revisión para código, docu, tests y PRs [BF] · instalar SonarQube [MOA+BF] · habilitar BBDD + licencia y crear tablero Power BI [BF+MOA] · consolidar repositorio común [BF] · acordar gobierno mínimo [BF+MOA]
3. **Auditar**: integrar proyectos en SonarQube [BF+MOA] · activar controles de calidad SQ [BF] · validar human-in-the-loop [BF]
4. **Medir resultados**: instrumentar métricas SDLC [BF] · medir adopción (licencias y uso) [BF] · medir productividad (HU y lead time) [BF] · medir calidad e impacto (bugs y SQ) [BF]
5. **Mejorar**: ajustar prompts, skills y agentes [BF] · ajustar estrategias y plan de trabajo [BF] · revisar avances vs. objetivos [BF+MOA] · definir backlog evolución 2027 [BF+MOA]

Luego: **iterar** un nuevo ciclo (1-2-3-4-5).

### Desarrollos y evolutivos — SDLC con IA, mapeo etapa por etapa

*(Potencial de mejora estimado por etapa, en base a experiencia en casos comparables — a validar contra el baseline de MOA.)*

| Etapa | Hoy en MOA | Con IA ampliada (Q4 2026) | Impacto esperado Q4 |
|---|---|---|---|
| **Recepción del requerimiento** | PO carga el ticket en Jira manualmente o asistido por agente PO; el equipo detecta inconsistencias recién en el refinamiento | Rovo Agent analiza el ticket al crearse, detecta ambigüedades y genera preguntas para el PO antes del refinamiento | +10% HU ref. x sprint/mes · +30% Reqs/Mej. x sprint/mes · -20% Lead time de features |
| **Refinamiento y estimación** | Reunión grupal manual, sujeta a sesgos y falta de contexto histórico | Rovo Agent propone estimación inicial basada en historial del equipo y descripción técnica | *(mismo impacto que la etapa anterior, agrupado en el slide original)* |
| **Planning** | Dev valida asunciones consultando compañeros/documentación dispersa; identifica dependencias por cuenta propia; lento y propenso a omisiones | Copilot + SKILLs + MCP Jira/Confluence asiste interpretando el ticket, consultando tickets similares y documentación; sugiere dependencias/componentes afectados | — |
| **Desarrollo del código** | Dev lee el ticket en Jira, busca en Confluence, vuelve al editor; alto costo de cambio de contexto | Copilot + SKILLs + MCP Jira/Confluence permite consultar ticket y documentación desde VS Code sin salir del editor; sugerencias alineadas al contexto | +30% Productividad DEVs · 100% Team con Copilot |
| **Apertura del Pull Request** | Dev abre el PR manualmente en Azure DevOps, completa descripción, solicita revisores | Copilot + SKILLs + MCP Jira + MCP Azure DevOps crea el PR automáticamente tras el push: título, descripción y vínculo al ticket sin intervención manual | — |
| **Code Review** | Revisor humano lee el diff manualmente; detecta estilo/lógica/seguridad; lento y sujeto a disponibilidad | GitHub Copilot Code Review for Azure DevOps analiza el diff automáticamente, detecta calidad/seguridad/buenas prácticas, genera comentarios en segundos | 100% Team con Copilot · SQ: Reliability Grade A o B · SQ: Zero Critical Vulnerabilities · SQ: +15% Unit Tests (global) |
| **Testing funcional (QA)** | QA valida manualmente en ambiente QA siguiendo casos de prueba escritos | Copilot + SKILLs + MCP Jira/Confluence analiza el requerimiento y propone casos de prueba automáticamente, publicados como comentario en Jira; QA se enfoca en validación exploratoria/negocio | 100% Team con Copilot · -10% tiempo generación de CP · -10% Bugs en QA/PROD |
| **Test de regresión** | Tests de regresión escritos y mantenidos manualmente por QA; ejecución puede demorar horas | Tests generados por Copilot + SKILLs + MCP Playwright corren automáticamente en el pipeline, cubriendo flujos de los criterios de aceptación | — |
| **Cierre del ticket** | Dev registra horas manualmente y actualiza estado a Done; propenso a postergarse/omitirse | Copilot + SKILLs + MCP Jira sugiere registro de horas basado en tiempo transcurrido/actividad del sprint, y actualiza estado a Done automáticamente | +30% Productividad DEVs · +30% Reqs/Mej. x sprint/mes · -20% Lead time de features |
| **Soporte productivo** | Equipo usa logs de app para monitorear errores/performance; análisis reactivo, ante incidentes | Copilot + MCP Application Insights + MCP Base de Datos analiza periódicamente logs de producción, detecta patrones recurrentes, valida estados inconsistentes/datos anómalos, propone soluciones/ajustes preventivos | — |
| **Build & CI** | Azure DevOps ejecuta build y tests unitarios; cualquier fallo bloquea el merge | DevOps agents ejecutan y validan corridas con `gh cli` en entornos de prueba para diagnosticar y resolver fallos | — |

### Operación y soporte — acelerando las tareas del día a día

1. **Triage asistido y respuesta automática** — el portal completa el pool de preguntas, clasifica workflow/puesto/severidad, y devuelve la contingencia aplicable en menos de un minuto.
2. **Respuesta sugerida a Nivel 1** — ante cada ticket nuevo, la IA trae los tres casos históricos más similares con su diagnóstico y el fragmento pertinente del manual.
3. **Comunicaciones de estado automáticas** — borrador del mail con formato ANS ya definido, y aviso cuando vence la ventana de actualización (10 y 15 minutos).
4. **Cierre asistido con calidad de datos** — propone el campo Efecto, inicio/fin de interrupción, y redacta la causa raíz para un tablero de disponibilidad confiable.
5. **Detección de recurrencia y alerta preventiva** — agrupa tickets por patrón, avisa al tercer caso similar, emite boletín semanal con los cinco recurrentes principales.

---

## 5. Charla abierta y próximos pasos

Sección abierta a discusión en vivo (dudas, consultas, preguntas — cómo vas a estar participando). El deck no trae bullets adicionales para este punto.

---

## Notas de fidelidad de la extracción

- Extracción de texto vía `pypdf`, verificada visualmente contra las
  imágenes de cada slide (`imagenes/pagina-XX.png`) para las 2 páginas que
  presentaban layout multi-columna ambiguo en el texto plano (pág. 9 y pág.
  20) — ambas ya confirmadas y reflejadas correctamente arriba.
- No se reproducen elementos gráficos (iconos, diagramas, colores, logos), solo el contenido textual.
- Portada y contraportada (datos de contacto/oficinas de Baufest) no se incluyen por no tener contenido de negocio.
