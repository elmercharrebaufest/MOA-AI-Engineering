---
name: documentation-style
description: Regla de estilo para generar o actualizar documentación de este modelo base (o de cualquier repositorio que lo adopte) — lenguaje natural, formal y simple, contenido acotado que aporta valor real, sin relleno ni informalidad regional.
---

# documentation-style

**Capability Registry**: [`CAP-022`](../../../registry/entries/documentation-style.md).
Aplica siempre que una persona o un asistente de IA genere o actualice contenido de este
modelo, igual que `repository-governance` (CAP-006) aplica siempre al comportamiento de
un asistente sobre código.

## Propósito

Evitar 2 problemas reales, ya observados en este mismo repositorio durante su
construcción: documentación escrita con voseo argentino u otra informalidad regional en
vez de español formal y natural, y documentación extensa que no aporta valor adicional
real (relleno, repetición, resúmenes redundantes). Ninguno de los 2 es un riesgo
hipotético — ambos aparecieron y se corrigieron en este repositorio antes de existir esta
regla explícita.

## Cuándo usarla

Siempre que se escriba o actualice un archivo de documentación de este modelo (Registry,
capacidades, guías de adopción, arquitectura) — o de un repositorio de equipo que herede
esta convención.

## Cuándo NO usarla

No aplica a una cita textual de una fuente real (el mensaje exacto de un comando, un
párrafo citado de documentación oficial) — eso se transcribe tal cual, sin parafrasear ni
"mejorar" el estilo. Alterar una cita real le resta valor como evidencia.

## Entradas

Ninguna en tiempo de ejecución — es una regla de estilo que se aplica al redactar, no un
artefacto que procese datos.

## Salidas

Documentación en español formal (infinitivo o forma impersonal, nunca voseo), acotada al
contenido que realmente aporta algo nuevo.

## Instrucciones

1. **Español formal, simple y natural — nunca voseo argentino ni otra informalidad
   regional.** Usar infinitivo o forma impersonal para instrucciones ("Verificar el
   entorno", no "Verificá el entorno" ni "Tenés que verificar").
2. **Contenido acotado y accionable, no exhaustivo.** Si hace falta más detalle, enlazar
   a la fuente real (documentación oficial, otro archivo de este mismo modelo) en vez de
   copiarla adentro.
3. **Cada actualización aporta valor verificable.** No agregar texto de relleno,
   resúmenes que repiten lo ya dicho, ni la misma explicación reformulada en más de un
   lugar — un dato vive en un solo archivo, el resto enlaza.
4. **Nunca inventar contenido ni especular.** Toda afirmación se respalda con evidencia
   real citada (archivo y línea, commit, fuente externa verificada); ante algo ambiguo se
   pregunta a la persona antes de decidir, no se completa por cuenta propia.
5. **Sin lenguaje de marketing ni autorreferencial de IA** ("solución revolucionaria",
   "de última generación", "como asistente de IA puedo..."). Se escribe como
   documentación técnica, no como una presentación.

## Dependencias

Ninguna técnica — es una convención de redacción, no un artefacto ejecutable.

## Herramientas / permisos

No aplica.

## Seguridad

No aplica directamente — el riesgo que mitiga es de comunicación (ambigüedad,
desconfianza en el contenido), no de seguridad técnica.

## Datos

No aplica.

## Revisión humana

La misma que ya aplica a cualquier documentación de este modelo — una persona revisa
antes de dar por buena una actualización significativa, igual que con cualquier otra
capacidad.

## Criterios de calidad

- Sin voseo ni informalidad regional, salvo dentro de una cita textual real.
- Ninguna sección repite, con otras palabras, algo ya dicho en otra parte del mismo
  documento o de otro documento enlazable.
- Toda afirmación no evidente tiene una fuente citada (archivo:línea, commit, o
  referencia externa real).

## Origen de esta regla

**Existing Practice**: corrección real y repetida durante la construcción de este mismo
modelo (2026-09-22) — voseo argentino y contenido extenso sin valor real aparecieron
varias veces en versiones tempranas de esta documentación y fueron corregidos
explícitamente cada vez, no es un problema hipotético. **External Best Practice**: guías
de estilo de documentación técnica ampliamente adoptadas en la industria (Microsoft
Writing Style Guide, Google Developer Documentation Style Guide) coinciden en los mismos
principios — lenguaje simple y directo, evitar jerga innecesaria, contenido conciso antes
que exhaustivo. **Architectural Judgment**: se formaliza como Instruction, no como nota
suelta en `capabilities/best-practices.md`, porque — igual que CAP-006 — es una regla que
debe aplicarse siempre que se escribe documentación, no algo que se consulta solo cuando
la tarea lo amerita (eso sería una Skill).

## Compatibilidad / adaptación

Portable a cualquier equipo, sin contenido específico de dominio que adaptar. El único
ajuste real es el idioma/registro formal si un equipo documenta en otro idioma — el
principio (natural, formal, acotado, sin relleno) se mantiene igual.
