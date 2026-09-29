# Cómo usar una capacidad — en la práctica

Esta página responde una sola pregunta: **ya instalé el plugin, ¿qué escribo?** Para todo
lo demás (gobierno, evidencia, Golden Paths), ver [`getting-started.md`](getting-started.md).

## Lo único que hace falta saber

1. Abrir Copilot Chat en VS Code y **elegir explícitamente el agente que corresponda** en
   el selector (por ejemplo, `product-owner`, `ticket-kickoff`). El modo genérico
   **Agent** de VS Code no tiene ninguna de las restricciones ni los checkpoints de este
   modelo — sirve para una consulta suelta que no toque código real, nunca para refinar
   o implementar con las garantías de este modelo.
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
aceptación: [pegar el requerimiento real aquí]
```

**Ordenar un ticket largo que no se entiende**:
```
Revisar este ticket, está muy largo y no se entiende: [pegar el ticket, o su URL de
Jira, por ejemplo https://molinosagro.atlassian.net/browse/SEFI-36]
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

Con un agente ya elegido en el selector, el asistente reconoce qué skill corresponde usar
según lo que se describió — no hace falta nombrarla. **Esto no reemplaza elegir el agente
correcto**: si no hay ningún agente seleccionado, Copilot puede igual reconocer y aplicar
el contenido de una skill (por ejemplo, `user-story`) dentro de su propio modo genérico —
y ese modo no tiene ninguna restricción de herramientas ni checkpoints, aunque el
resultado de texto se vea igual de bien. Por eso, para refinar o implementar, elegir
siempre el agente en el selector, no solo describir la tarea.

## Recorrer el SDLC completo con los roles

Para seguir un ticket de punta a punta, elegir en el selector de agentes del chat el rol
que corresponda y seguir sus traspasos. Cada uno enlaza a su "Cuándo usarlo / Cuándo NO
usarlo" real, con más detalle que el resumen de acá:

1. **[product-owner](../capabilities/agents/product-owner/AGENT.md)** — refina la
   historia. Al aprobarla, botón **"Pasar a desarrollo"**.
2. **[ticket-kickoff](../capabilities/agents/ticket-kickoff/AGENT.md)** — propone el
   plan, y con su aprobación implementa y corre los tests. Botones **"Revisar el
   código"** y **"Generar pruebas"**.
3. **[read-only-code-reviewer](../capabilities/agents/read-only-code-reviewer/AGENT.md)**
   — revisa el cambio. Botón **"Generar pruebas"**.
4. **[qa-analyst](../capabilities/agents/qa-analyst/AGENT.md)** — casos de prueba y
   tests automatizados. Botón **"Validar pruebas"**.
5. **[test-validator](../capabilities/agents/test-validator/AGENT.md)** — verifica que
   todo esté probado. Botón **"Preparar cierre"**.

Cada botón solo propone el paso siguiente: usted decide si lo usa, y nada se escribe en
el ticket sin su confirmación.

**Estos 5 no son todos los agentes del modelo — son los del flujo principal de
desarrollo.** Otros 4 cubren casos distintos: `git-worktree-setup` y `spec-reader` no se
eligen a mano, `ticket-kickoff` los invoca por detrás cuando corresponde;
`production-incident-investigation` es para soporte productivo, un flujo aparte del de
desarrollo; `workflow-documenter` es opcional, solo para equipos que usan WF4.5. Ver
[`capabilities/README.md`](../capabilities/README.md) para el listado completo.

**Para pasar de refinar a implementar, abrir una conversación nueva con `ticket-kickoff`
seleccionado — nunca escribir "implementar" en la conversación de refinamiento.** Cada
agente tiene una lista cerrada de herramientas que la plataforma hace cumplir — por
ejemplo, `product-owner` no puede editar código ni ejecutar comandos, aunque se le pida.
Pero esa garantía existe **solo si `product-owner` fue el agente realmente seleccionado**.
Si el refinamiento se pidió con el modo genérico Agent (sin elegir `product-owner` en el
selector), esa conversación nunca tuvo ninguna restricción, aunque el resultado se haya
visto igual de bien — y seguir escribiendo ahí "implementar" implementa de verdad, sin plan
ni aprobación de por medio. Así es como funciona también el flujo real de un cliente de
Baufest con SDLC-IA maduro: la palabra que aprueba la implementación se escribe *dentro*
de la conversación de kickoff que ya armó el plan con estimación, después de revisarlo —
nunca en la conversación de refinamiento. Antes de pedir que se implemente algo, confirmar
que el selector de agentes diga `ticket-kickoff` — si sigue mostrando el agente anterior (o
ningún agente), abrir una conversación nueva con `ticket-kickoff` en vez de continuar ahí.

Para leer y escribir en Jira, el servidor de Atlassian tiene
que estar conectado en VS Code — ver
[`agent-plugin-quickstart.md`](agent-plugin-quickstart.md#3-conectar-jira-una-vez).

## Si el asistente no reconoce ninguna capacidad instalada

Nombrarla explícitamente, por su nombre real:

```
Usar la skill user-story para refinar esto: [requerimiento real]
```

Si tampoco así la reconoce, el problema es de instalación, no de cómo se pidió — ver
[`agent-plugin-quickstart.md`](agent-plugin-quickstart.md).

## Qué hacer con el resultado

Revisarlo: ninguna salida de IA se da por aprobada solo por generarse.
