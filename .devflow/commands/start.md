# Slash command: start

Inicializa devflow en este proyecto: detecta el stack, hace preguntas guiadas y escribe `conventions.md` y `AGENTS.md`.

## Cuándo usarlo

Al abrir un proyecto por primera vez con devflow — antes de cualquier tarea de desarrollo.

## Instrucciones para el agente

### Paso 1 — Saluda y explica qué vas a hacer

Di exactamente esto al usuario:

> "Voy a configurar devflow para este proyecto. Primero voy a explorar el repo para detectar lo que pueda automáticamente, y luego te haré algunas preguntas sobre lo que no pueda inferir. Al final escribiré `conventions.md` y `AGENTS.md` con toda la información."

### Paso 2 — Explora el proyecto en silencio

Sin decirle nada al usuario todavía, haz lo siguiente:

- Lee el `README.md` raíz si existe
- Busca archivos de manifiesto para detectar el stack:
  - `package.json` → Node/JS/TS, framework (Next, Express, Vite, etc.)
  - `pyproject.toml` / `requirements.txt` / `setup.py` → Python, framework (FastAPI, Django, etc.)
  - `go.mod` → Go
  - `Cargo.toml` → Rust
  - `pom.xml` / `build.gradle` → Java/Kotlin
  - `*.csproj` / `*.sln` → C#/.NET
- Detecta base de datos: busca palabras clave como `prisma`, `mongoose`, `sqlalchemy`, `pg`, `redis`, `supabase`, `firebase`, `drizzle` en los manifiestos o imports
- Detecta herramientas de testing: `jest`, `vitest`, `pytest`, `go test`, `rspec`, `xunit`, etc.
- Mira la estructura de carpetas de primer y segundo nivel (`src/`, `app/`, `lib/`, `tests/`, `cmd/`, etc.)
- Si hay commits, corre `git log --oneline -10` para inferir el idioma de los commits y el formato usado

### Paso 3 — Presenta lo que detectaste y pregunta lo que falta

Muestra al usuario un resumen de lo que encontraste en este formato:

```
Esto es lo que detecté del proyecto:

- Lenguaje: [detectado o "no detectado"]
- Framework: [detectado o "no detectado"]
- Base de datos: [detectado o "no detectado"]
- Testing: [detectado o "no detectado"]
- Estructura de carpetas: [lista de carpetas principales]
- Idioma de los commits: [detectado o "no detectado"]
```

Luego haz estas preguntas **de una en una**, esperando respuesta antes de continuar:

1. **Descripción del proyecto** (siempre pregunta esto):
   > "¿Cómo describirías este proyecto en 1-2 frases? (Esto va al AGENTS.md como contexto para el agente)"

2. **Stack** (solo pregunta los que no detectaste):
   - Si no detectaste lenguaje: "¿Cuál es el lenguaje principal?"
   - Si no detectaste framework: "¿Usas algún framework principal? (o 'ninguno')"
   - Si no detectaste base de datos: "¿Usas base de datos? ¿Cuál? (o 'ninguna')"
   - Si no detectaste testing: "¿Qué herramientas de testing usas? (o 'ninguna por ahora')"

3. **Idioma del código y documentación** (siempre pregunta si no está claro):
   > "¿En qué idioma van los nombres de variables y funciones? ¿Y los commits y comentarios?"

4. **Reglas de estilo o convenciones especiales** (siempre pregunta):
   > "¿Tienes reglas de estilo o convenciones que el agente deba seguir? (formateo, nombres, patrones prohibidos, etc.) Puedes decir 'ninguna por ahora'."

5. **Seguimiento de estado** (siempre pregunta):
   > "¿Quieres activar el seguimiento de estado? Con esto el agente registra en qué fase está el proyecto (brainstorm, plan, execute). Útil en proyectos de largo plazo. ¿Sí o no?"

### Paso 4 — Escribe los archivos

Con toda la información recopilada, escribe los siguientes archivos:

#### `.devflow/conventions.md`

Rellena todas las secciones con la información real. No dejes placeholders ni comentarios de "completar". Si el usuario dijo "ninguno/a", escríbelo explícitamente.

Incluye la estructura de carpetas que detectaste en la sección correspondiente.

#### `AGENTS.md`

Reemplaza el contenido con:

```markdown
# [Nombre del proyecto]

[Descripción que dio el usuario en 1-2 frases]

El proceso de desarrollo de este proyecto está en `.devflow/overview.md`.
Léelo antes de hacer cualquier cosa.
```

#### `state/current-phase.md` (solo si el usuario dijo que sí al seguimiento)

```markdown
# Estado actual

- Fase: ninguna (proyecto recién iniciado)
- Feature en curso: —
- Spec activa: —
```

### Paso 5 — Confirma al usuario

Cuando termines, di:

> "Listo. Escribí `conventions.md` con las convenciones del proyecto y actualicé `AGENTS.md` con la descripción. El agente ya tiene todo lo que necesita para trabajar en este proyecto.
>
> Si en algún momento quieres ajustar algo, edita `.devflow/conventions.md` directamente — o dímelo y lo actualizo."
