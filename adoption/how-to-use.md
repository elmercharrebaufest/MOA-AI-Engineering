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
Ayudame a refinar este requerimiento en una historia de usuario con criterios de
aceptación: [pegar el requerimiento real acá]
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

En los 3 casos, si el plugin está instalado, el asistente reconoce que corresponde usar
`user-story`, `read-only-code-reviewer` o `azure-devops-cli` según lo que se describió —
no hace falta nombrarlas.

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
