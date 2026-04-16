# Slash command: start-devflow

Inicializa devflow en este proyecto. Detecta automáticamente si es un proyecto nuevo o existente y adapta el proceso en consecuencia.

## Cuándo usarlo

Siempre que adoptes devflow en un proyecto — ya sea uno nuevo que acabas de crear o uno existente con código y commits.

## Instrucciones para el agente

### Paso 1 — Detecta el tipo de proyecto en silencio

Sin decirle nada al usuario todavía, evalúa lo siguiente:

**Señales de proyecto existente:**
- Hay archivos de código fuera de `.devflow/` (`.js`, `.ts`, `.py`, `.go`, `.rs`, etc.)
- `git log` tiene commits previos
- Existe un `README.md` con contenido real (no el del template de devflow)
- Hay manifiestos de dependencias (`package.json`, `go.mod`, `pyproject.toml`, etc.)

**Señales de proyecto nuevo:**
- El directorio está vacío o solo tiene archivos de devflow
- No hay commits o el único commit es el inicial del template
- No hay manifiestos de dependencias

Clasifica el proyecto como **nuevo** o **existente** antes de continuar.

---

### Paso 2 — Saluda y explica qué vas a hacer

**Si es proyecto nuevo**, di:

> "Voy a configurar devflow para este proyecto nuevo. Como todavía no hay código, te haré algunas preguntas para definir las convenciones desde el inicio. Al final escribiré `conventions.md` y `AGENTS.md`."

**Si es proyecto existente**, di:

> "Voy a configurar devflow para este proyecto. Primero voy a explorar el código para detectar el stack automáticamente y luego te haré solo las preguntas que no pueda inferir. Al final escribiré `conventions.md` y `AGENTS.md`."

---

### Paso 3 — Explora el proyecto (solo si es existente)

Si el proyecto es existente, haz esto en silencio antes de hacer preguntas:

- Lee el `README.md` raíz
- Busca manifiestos para detectar el stack:
  - `package.json` → Node/JS/TS, framework (Next, Express, Vite, etc.)
  - `pyproject.toml` / `requirements.txt` / `setup.py` → Python, framework (FastAPI, Django, etc.)
  - `go.mod` → Go
  - `Cargo.toml` → Rust
  - `pom.xml` / `build.gradle` → Java/Kotlin
  - `*.csproj` / `*.sln` → C#/.NET
- Detecta base de datos: busca `prisma`, `mongoose`, `sqlalchemy`, `pg`, `redis`, `supabase`, `firebase`, `drizzle` en manifiestos e imports
- Detecta testing: `jest`, `vitest`, `pytest`, `go test`, `rspec`, `xunit`, etc.
- Mira la estructura de carpetas de primer y segundo nivel
- Corre `git log --oneline -10` para inferir el idioma y formato de commits ya usado

Luego muestra al usuario un resumen de lo que encontraste:

```
Esto es lo que detecté del proyecto:

- Lenguaje: [detectado o "no detectado"]
- Framework: [detectado o "no detectado"]
- Base de datos: [detectado o "no detectado"]
- Testing: [detectado o "no detectado"]
- Estructura de carpetas: [lista de carpetas principales]
- Idioma de los commits: [detectado o "no detectado"]
```

---

### Paso 4 — Haz las preguntas que faltan

Haz las preguntas **de una en una**, esperando respuesta antes de continuar.

#### Si es proyecto nuevo — pregunta todo:

1. **Descripción:**
   > "¿Qué vas a construir? Descríbelo en 1-2 frases."

2. **Lenguaje y framework:**
   > "¿Qué lenguaje y framework vas a usar? (por ejemplo: TypeScript con Next.js, Python con FastAPI, Go sin framework, etc.)"

3. **Base de datos:**
   > "¿Vas a usar base de datos? ¿Cuál? (o 'ninguna por ahora')"

4. **Testing:**
   > "¿Qué herramientas de testing vas a usar? (o 'ninguna por ahora')"

5. **Idioma del código y documentación:**
   > "¿En qué idioma van los nombres de variables y funciones? ¿Y los commits y comentarios?"

6. **Estructura de carpetas:**
   > "¿Tienes pensada una estructura de carpetas? (por ejemplo: src/, lib/, tests/ — o puedes decir 'todavía no definida')"

7. **Reglas de estilo:**
   > "¿Alguna convención de estilo que quieras que el agente respete desde el inicio? (formateo, nombres, patrones, etc.) Puedes decir 'ninguna por ahora'."

8. **Seguimiento de estado:**
   > "¿Quieres activar el seguimiento de estado? El agente registrará en qué fase está el proyecto (brainstorm, plan, execute). Útil para proyectos de largo plazo. ¿Sí o no?"

#### Si es proyecto existente — pregunta solo lo que no detectaste:

1. **Descripción** (siempre pregunta):
   > "¿Cómo describirías este proyecto en 1-2 frases? (Esto va al AGENTS.md como contexto para el agente)"

2. **Stack** (solo lo que no detectaste):
   - Si no detectaste lenguaje: "¿Cuál es el lenguaje principal?"
   - Si no detectaste framework: "¿Usas algún framework principal? (o 'ninguno')"
   - Si no detectaste base de datos: "¿Usas base de datos? ¿Cuál? (o 'ninguna')"
   - Si no detectaste testing: "¿Qué herramientas de testing usas? (o 'ninguna por ahora')"

3. **Idioma del código y documentación** (solo si no lo inferiste de los commits):
   > "¿En qué idioma van los nombres de variables y funciones? ¿Y los commits y comentarios?"

4. **Reglas de estilo** (siempre pregunta):
   > "¿Tienes reglas de estilo o convenciones que el agente deba seguir? (formateo, nombres, patrones prohibidos, etc.) Puedes decir 'ninguna por ahora'."

5. **Seguimiento de estado** (siempre pregunta):
   > "¿Quieres activar el seguimiento de estado? El agente registrará en qué fase está el proyecto (brainstorm, plan, execute). ¿Sí o no?"

---

### Paso 5 — Escribe los archivos

Con toda la información recopilada, escribe:

#### `.devflow/conventions.md`

Rellena todas las secciones con la información real. No dejes placeholders ni comentarios de "completar". Si algo no aplica, escríbelo explícitamente (ej: "ninguna", "por definir").

Si el proyecto es nuevo y la estructura de carpetas está por definir, escríbelo tal cual.

#### `AGENTS.md`

Reemplaza el contenido con:

```markdown
# [Nombre del proyecto]

[Descripción que dio el usuario]

El proceso de desarrollo de este proyecto está en `.devflow/overview.md`.
Léelo antes de hacer cualquier cosa.
```

> Si `AGENTS.md` ya tiene contenido significativo (no es el template vacío), agrega la línea de `.devflow/overview.md` al final en lugar de reemplazar todo el archivo.

#### `state/current-phase.md` (solo si el usuario dijo que sí al seguimiento)

```markdown
# Estado actual

- Fase: ninguna (proyecto recién iniciado con devflow)
- Feature en curso: —
- Spec activa: —
```

---

### Paso 6 — Confirma al usuario

**Si es proyecto nuevo**, di:

> "Listo. Configuré devflow para empezar desde cero. Cuando tengas tu primera idea, cuéntamela y arrancamos con el flujo de brainstorming."

**Si es proyecto existente**, di:

> "Listo. Escribí `conventions.md` con las convenciones del proyecto y actualicé `AGENTS.md`. El agente ya tiene todo lo que necesita para trabajar en este proyecto.
>
> Si en algún momento quieres ajustar algo, edita `.devflow/conventions.md` directamente — o dímelo y lo actualizo."
