# Cómo usar una capacidad — en la práctica

Esta página responde una sola pregunta: **ya instalé el plugin, ¿qué escribo?** Para todo
lo demás (gobierno, evidencia, Golden Paths), ver [`getting-started.md`](getting-started.md).

## Lo único que hace falta saber

1. Abrir el chat del asistente (Copilot Chat o Claude Code) en modo Agent.
2. Describir la tarea real, en las propias palabras — sin fórmulas ni IDs.
3. Revisar el resultado antes de darlo por bueno.

**No hace falta escribir "CAP-001" ni ningún otro ID del Registry.** Esos IDs son una
referencia interna de este repositorio, para documentación — el asistente no los conoce
ni los necesita. Alcanza con describir lo que se necesita; si hace falta nombrar la
capacidad de forma explícita, se usa su nombre real (ej. `user-story`), nunca el ID.

## Ejemplos reales, listos para copiar

**Refinar un requerimiento**:
```
Necesito refinar este requerimiento en una historia de usuario con criterios de
aceptación: [pegar el requerimiento real acá]
```

**Ordenar un ticket largo que no se entiende**:
```
Revisar este ticket, está muy largo y no se entiende: [pegar el ticket, o su clave
si el asistente tiene acceso a Jira]
```

**Dejar el resultado en el ticket** (el asistente muestra el cambio y espera su "sí"):
```
Actualizar el ticket con esta historia y dejar las preguntas como comentario
```

**Revisar un cambio de código antes de mergear**:
```
Revisar este diff antes de que lo apruebe alguien: [pegar el diff, o pedirle que lo
tome del branch actual]
```

**Operar Azure DevOps sin recordar la sintaxis exacta**:
```
Necesito crear un PR de esta rama hacia develop
```

En todos los casos, si el plugin está instalado, el asistente reconoce qué capacidad
corresponde usar según lo que se describió — no hace falta nombrarlas.

## Recorrer el SDLC completo con los roles

Para seguir un ticket de punta a punta, elegir en el selector de agentes del chat el rol
que corresponda y seguir sus traspasos:

1. **product-owner** — refina la historia. Al aprobarla, botón **"Pasar a desarrollo"**.
2. **ticket-kickoff** — propone el plan, y con su aprobación implementa y corre los
   tests. Botones **"Revisar el código"** y **"Generar pruebas"**.
3. **read-only-code-reviewer** — revisa el cambio. Botón **"Generar pruebas"**.
4. **qa-analyst** — casos de prueba y tests automatizados. Botón **"Validar pruebas"**.
5. **test-validator** — verifica que todo esté probado. Botón **"Preparar cierre"**.

Cada botón solo propone el paso siguiente: usted decide si lo usa, y nada se escribe en
el ticket sin su confirmación. Para escribir en Jira, el asistente necesita el MCP de
Atlassian instalado — ver
[`context-providers-quickstart.md`](context-providers-quickstart.md#3a-atlassian-rovo-mcp-v2--runtime-principal-vs-code--github-copilot).

## Si el asistente no reconoce ninguna capacidad instalada

Nombrarla explícitamente, por su nombre real:

```
Usar la skill user-story para refinar esto: [requerimiento real]
```

Si tampoco así la reconoce, el problema es de instalación, no de cómo se pidió — ver
[`agent-plugin-quickstart.md`](agent-plugin-quickstart.md) o
[`claude-code-plugin-quickstart.md`](claude-code-plugin-quickstart.md) según la
herramienta.

## Qué hacer con el resultado

Revisarlo — ninguna salida de IA se da por aprobada solo por generarse. Si se quiere
dejar registro de que se ejecutó, ver el paso de Evidence en
[`getting-started.md`](getting-started.md#9-generar-evidencia) — es opcional para una
prueba puntual, no un requisito para poder usar la capacidad.
