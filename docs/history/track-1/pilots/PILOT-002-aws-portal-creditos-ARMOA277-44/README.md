# PILOT-002 — Exploración libre sobre tarea real ARMOA277-44 (AWS Portal de Créditos) — CERRADO SIN EJECUTAR

**Estado: CERRADO (2026-09-09) — `execution-record.md` y `feedback-record.md` se
borraron porque nunca hubo un developer real de "AWS Portal de Créditos" ejecutando
esto** (mismo problema que PILOT-001: protocolo bien diseñado, cero actor real).
**Superseded by**: el usuario va a correr él mismo el protocolo cold-start, dando como
input una tarea de Jira real — la diferencia clave es que ahora el actor es real, no
hipotético.

## Por qué existe esta carpeta, y en qué se diferencia de PILOT-001

PILOT-001 probó adopción independiente de **una capacidad puntual** (CAP-005,
`repository-governance`) con un protocolo cold-start guiado por un briefing acotado.
Ese piloto sigue abierto — el developer solo dio feedback informal por chat, todavía no
quedó registrado en su `feedback-record.md`.

Este piloto es distinto: un developer (del proyecto "AWS Portal de Créditos", presente en
este mismo workspace pero fuera del set de repos ya relevado) tiene una tarea real
asignada — **ARMOA277-44** — y quiere usar esa tarea para explorar, **sin guía previa ni
capacidad específica asignada**, qué le puede aportar `MOA-AI-Engineering`. No sabe qué
hace el modelo. Esto es más cercano a lo que Track 1 necesita en el fondo: alguien externo,
con una necesidad real, entrando solo y reportando qué le sirvió.

**Restricción de alcance (explícita del usuario, esta sesión)**: es un **experimento
aislado** — lo que produzca no se mergea ni se entrega como parte de ARMOA277-44 todavía.
El objetivo es medir aporte, no completar la tarea con esto.

## Qué contiene

- [`briefing-para-developer.md`](briefing-para-developer.md) — instrucciones para el
  developer: explorar libremente, sin capacidad preasignada.
- [`execution-record.md`](execution-record.md) — Execution Record de este piloto
  (capability_id abierto, no limitado a CAP-005).
- [`feedback-record.md`](feedback-record.md) — preguntas abiertas de exploración +
  espacio para registrar qué usó y qué le aportó.

Nota: no hay `evidence-record.md` todavía — se crea recién cuando exista un output
concreto que evaluar (ver `adoption/templates/evidence-record.md`).

## Qué falta para dejar de ser SANDBOX / EN CURSO

1. Que el developer explore `MOA-AI-Engineering` mientras trabaja en ARMOA277-44 y anote
   qué usó, qué le sirvió y qué no.
2. Recolectar su feedback literal en `feedback-record.md`.
3. Si algo resultó útil y reutilizable, decidir — con aprobación explícita — si se
   documenta como caso de uso o se propone formalizar (Registry) recién ahí.
4. Esto no reemplaza el cierre pendiente de PILOT-001 ni resuelve Blocked Decision #1
   (`governance/BLOCKED-DECISIONS.md`).

## Cierre (2026-09-09)

Se cierra sin ejecutar por la misma razón que PILOT-001 — sin actor real, no hay
evidencia que producir. `execution-record.md`/`feedback-record.md` se eliminaron en vez
de dejarlos con campos "pendiente" indefinidamente. No resuelve Blocked Decision #1.
El reemplazo real de este piloto es el intento del usuario con una tarea de Jira real,
en una sesión nueva sin el contexto ya contaminado de esta conversación (ver nota de
advertencia que se agrega al pie de este documento).
