# G12 — Bloques de flechas sin etiquetar, mal detectados como diagrama

**Fase**: G12. Precondición: G11. Solo se modificó `MOA-AI-Engineering`.

## 1. Disparador

El developer reportó que le aparecía el texto "No diagram type detected matching given
configuration for text" — es el error real que tira Mermaid.js cuando algún visor intenta
renderizar un bloque de código como diagrama y el contenido no es sintaxis de Mermaid
válida.

## 2. Causa raíz

El repositorio tiene 25 bloques de código (en 20 archivos) que muestran una cadena
conceptual tipo `A → B → C` **sin ninguna etiqueta de lenguaje** (` ``` ` a secas, sin
`text`, `bash`, etc.). Algunos visores (VS Code, extensiones de Copilot Chat) intentan
auto-detectar si un bloque sin etiquetar "parece" un diagrama y lo pasan a Mermaid — como
no es sintaxis de Mermaid, falla con ese mensaje exacto.

## 3. 2 intentos fallidos antes de la solución correcta (documentado para no repetir el error)

Los primeros 2 intentos de corregir esto con una regex sobre el texto completo del archivo
**rompieron el emparejamiento de bloques**: al no entender que el archivo ya tenía otros
bloques de código antes (ej. un diagrama ` ```mermaid `), la regex emparejaba el cierre de
un bloque con la apertura del siguiente, corriendo la etiqueta varias posiciones más
adelante de donde correspondía. Se detectó por una verificación directa del archivo
después de cada intento (nunca se asumió que el script funcionó solo porque no tiró
error), se revirtió con `git checkout` las 2 veces (nada llegó a commitearse roto), y
recién el tercer intento — un recorrido línea por línea que sabe en todo momento si está
"dentro" o "fuera" de un bloque de código, sin importar cuántos bloques haya antes — quedó
bien.

## 4. Corrección aplicada

- 24 bloques etiquetados `text` (cadenas conceptuales — Golden Path, Adoption Flow,
  Lifecycle, Contribution Model, etc.), 1 etiquetado `bash` (el único que muestra comandos
  reales de terminal, en `capabilities/skills/azure-devops-cli/SKILL.md`).
- Ningún contenido cambiado — verificado línea por línea: de los 32 cambios totales en
  todo el repo, las 32 son exactamente `` -``` `` / `` +```text `` o `` +```bash ``, nada
  más.
- Verificación de integridad: cada archivo `.md` del repo tiene una cantidad par de líneas
  que empiezan con `` ``` `` (ningún fence huérfano), y los 622 links relativos siguen sin
  romperse.

## 5. Qué no se tocó

Los diagramas `` ```mermaid `` reales (12 archivos) — se revisaron sus declaraciones de
tipo (`flowchart`, `stateDiagram-v2`, `graph`) y están todas bien formadas, no eran la
causa del problema.
