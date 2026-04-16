# devflow

Un framework de desarrollo en markdown para trabajar con agentes de IA de forma estructurada, reproducible y que mejora con el tiempo.

---

## El problema que resuelve

Cuando trabajas con un agente de IA (Claude Code, Codex, Gemini CLI, etc.), probablemente te hayas topado con esto:

- El agente empieza a escribir código antes de entender bien lo que necesitas
- Implementa cosas que no pediste, o se olvida cosas que sí pediste
- Comete el mismo error dos sesiones seguidas porque no recuerda la corrección anterior
- No tienes forma de saber en qué punto del trabajo estás cuando retomas un proyecto

**devflow resuelve exactamente eso.** Es un conjunto de archivos markdown que le enseña a cualquier agente cómo trabajar contigo: primero entiende, luego planifica, luego implementa, luego verifica.

---

## Cómo funciona

devflow vive en una carpeta `.devflow/` dentro de tu proyecto. Cuando abres tu agente, lo primero que hace es leer esa carpeta y seguir el proceso definido ahí.

El proceso tiene cuatro fases:

```
1. Brainstorm  →  Entiende la idea y escribe una spec
2. Plan        →  Convierte la spec en tareas de implementación
3. Execute     →  Implementa tarea a tarea con revisión doble
4. Finish      →  Cierra la rama con PR, merge o cleanup
```

No hay saltos. Si no hay spec, no hay plan. Si no hay plan, no hay código.

---

## Instalación

### Opción A: Nuevo proyecto

Clona el template y empieza desde cero:

```bash
git clone https://github.com/tu-usuario/devflow-template mi-proyecto
cd mi-proyecto
rm -rf .git && git init
```

Luego abre tu agente y corre `/start-devflow`. El agente detecta que es un proyecto nuevo y te guía para definir las convenciones desde el inicio.

### Opción B: Proyecto existente

Usa el script de adopción para copiar devflow a tu proyecto:

```bash
bash /ruta/a/devflow-template/init.sh /ruta/a/mi-proyecto
```

El script hace exactamente tres cosas:
- Copia `.devflow/` a tu proyecto
- Crea `docs/specs/` y `docs/plans/` si no existen
- Agrega una línea al final de tu `AGENTS.md` / `CLAUDE.md` / `GEMINI.md` apuntando al framework

Si cualquiera de esos archivos ya tiene la referencia, lo saltea.

Luego abre tu agente y corre `/start-devflow`. El agente detecta que hay código existente, lee el proyecto, infiere el stack y solo te pregunta lo que no puede detectar.

---

## Uso paso a paso

### Cuando tienes una idea nueva

Abre tu agente en el directorio del proyecto y dile lo que quieres construir.

El agente lee `overview.md`, ve que no hay un plan todavía, y entra al flujo de brainstorming:

1. **Explora el contexto** — revisa el código existente para entender qué ya hay
2. **Te hace preguntas de a una** — propósito, restricciones, criterios de éxito
3. **Propone 2-3 enfoques** con sus trade-offs y una recomendación
4. **Presenta el diseño por secciones** — pide aprobación antes de seguir
5. **Escribe la spec** en `docs/specs/YYYY-MM-DD-nombre-design.md`
6. **La auto-revisa** antes de mostrártela — busca placeholders y contradicciones
7. **Espera tu aprobación explícita** antes de pasar al plan

> El agente no escribe código hasta que la spec esté aprobada.

---

### Cuando la spec está aprobada

El agente pasa a la fase de planificación:

1. Lee la spec completa
2. Mapea exactamente qué archivos se crean, modifican o testean
3. Escribe el plan en `docs/plans/YYYY-MM-DD-nombre.md` — cada tarea con pasos detallados, código completo y commits
4. Auto-revisa el plan: ¿cubre toda la spec? ¿hay placeholders? ¿el orden de dependencias es correcto?
5. Te pregunta si quieres usar un git worktree para aislar el trabajo
6. Espera tu aprobación

> Los planes de devflow no tienen "TBD" ni "similar a la tarea anterior". Todo está escrito completo.

---

### Cuando el plan está aprobado — la fase execute

Esta es la parte donde devflow hace la diferencia real.

Por cada tarea del plan, se ejecutan **tres agentes especializados en secuencia**:

#### 1. Implementer

Recibe el texto completo de la tarea, la spec y el contexto de arquitectura. Trabaja en aislamiento:

- Escribe el test fallido primero (TDD)
- Implementa el mínimo para que el test pase
- Se auto-revisa antes de reportar
- Commitea

Reporta uno de cuatro estados:

| Estado | Qué significa |
|--------|---------------|
| `DONE` | Listo para revisión |
| `DONE_WITH_CONCERNS` | Terminó pero tiene dudas — léelas antes de continuar |
| `NEEDS_CONTEXT` | Le falta información específica para continuar |
| `BLOCKED` | No puede continuar — hay que evaluar qué cambió |

#### 2. Spec Reviewer

Solo entra si el implementer dijo `DONE`. Su única pregunta es:

> ¿El código hace exactamente lo que la spec pedía — ni más, ni menos?

Busca dos cosas:
- **Faltantes:** requisitos de la spec que el código no implementa
- **Extras:** código que la spec no pidió (features no solicitadas, over-engineering)

Si encuentra gaps, el implementer los corrige y vuelve a revisión.

#### 3. Quality Reviewer

Solo entra si el spec reviewer dijo ✅. Revisa:

- **Claridad** — ¿los nombres describen bien lo que hacen?
- **Duplicación** — ¿hay lógica repetida que debería estar en una función?
- **Manejo de errores** — ¿los casos de fallo están cubiertos?
- **Tests** — ¿verifican comportamiento o implementación?

Reporta issues con severidad: `critical`, `important` o `minor`.

**El orden es fijo:** spec compliance siempre antes que quality review. No tiene sentido revisar la calidad de código que no cumple la spec.

---

### Cuando todas las tareas están listas

El agente entra a la fase finish:

1. Verifica que todos los tests pasen
2. Verifica que no haya archivos sin commitear
3. Marca todas las checkboxes del plan
4. Te presenta las opciones de integración: PR, merge directo o squash merge
5. Hace cleanup de la rama o worktree si aplica

---

## El archivo que hace el sistema más inteligente: `conventions.md`

`conventions.md` tiene dos partes:

**Parte estática** (la llenas tú al adoptar devflow):
```markdown
## Stack tecnológico
- Lenguaje principal: TypeScript
- Framework: Next.js
- Base de datos: PostgreSQL
- Tests: Vitest

## Formato de commits
feat | fix | chore | docs | refactor | test
```

**Parte dinámica** (la actualiza el agente cada vez que lo corriges):
```markdown
## Correcciones aprendidas
- [2026-04-16] No usar `any` en TypeScript aunque la tarea no lo mencione explícitamente
- [2026-04-20] Los tests de integración deben usar la base de datos real, no mocks
```

El `overview.md` le instruye al agente: *si el usuario te corrige, documenta la corrección aquí antes de continuar.* Así el sistema aprende de los errores en lugar de repetirlos sesión tras sesión.

---

## Cómo devflow ayuda a ahorrar tokens

Trabajar con un agente sin estructura tiende a inflar el contexto: el agente relee archivos, redescubre decisiones que ya se tomaron y procesa ruido que no necesita. devflow ataca esto en tres niveles.

### 1. Carga bajo demanda

Los archivos de cada fase (`brainstorm/`, `plan/`, `execute/`, `finish/`) solo se leen cuando el agente entra a esa fase. El punto de entrada (`overview.md`) es mínimo — menos de 60 líneas. El agente no carga instrucciones de ejecución cuando estás en brainstorming, ni al revés.

### 2. Estado como memoria persistente

`state/current-phase.md` y `state/active-spec.md` guardan el contexto crítico del trabajo activo: fase, tarea, decisiones tomadas, archivos modificados. Esto habilita el hábito más eficiente de todos:

```
/clear   ← elimina todo el contexto acumulado
```

Con el estado actualizado, el agente puede retomar exactamente donde quedó en el siguiente mensaje — sin releer conversaciones anteriores ni redescubrir el contexto. **El estado es lo que hace seguro limpiar el contexto agresivamente.**

El agente también sabe cuándo sugerirte hacer `/clear` (entre features distintos, cuando termina una tarea independiente) y cuándo usar `/compact` (trabajo en progreso que no conviene perder).

### 3. Instrucciones de compactación

Cuando el contexto se compacta, el agente sabe qué priorizar: correcciones aprendidas, plan activo y tarea en curso. No compacta al azar.

### Hábitos recomendados

| Situación | Claude Code | OpenCode | Codex |
|-----------|-------------|----------|-------|
| Terminaste un feature, empiezas otro | `/clear` | Nueva sesión | `/clear` |
| Contexto grande, trabajo en progreso | `/compact` | Automático | Actualizar estado manualmente |
| Retomar trabajo de una sesión anterior | `/resume` | Continuar sesión | `codex resume` |
| Ver cuántos tokens llevas | `/cost` | Ver en UI | Indicador en TUI |
| Corrección importante | El agente documenta en `conventions.md` antes de continuar | ← igual | ← igual |

> En todos los casos, el agente actualiza `state/current-phase.md` antes de limpiar el contexto — eso es lo que hace seguro empezar de cero.

---

## Hooks de automatización

La carpeta `.devflow/hooks/` tiene dos scripts de ejemplo que puedes conectar a tu agente:

| Hook | Cuándo corre | Qué hace |
|------|-------------|----------|
| `post-edit-format.sh` | Después de cada edición | Formatea el archivo automáticamente |
| `post-edit-test.sh` | Después de cada edición | Corre los tests del proyecto |

Para activarlos en Claude Code, agrega esto a `.claude/settings.json`:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "bash .devflow/hooks/post-edit-format.sh $CLAUDE_TOOL_INPUT_FILE_PATH"
          }
        ]
      }
    ]
  }
}
```

Los scripts usan `prettier` y `pytest` como ejemplos. Cámbialos por las herramientas de tu stack.

---

## Slash commands incluidos

La carpeta `.devflow/commands/` tiene plantillas de comandos reutilizables:

**`start-devflow`** — al adoptar devflow en cualquier proyecto:
- Detecta automáticamente si es un proyecto nuevo o existente
- En proyectos existentes, lee el código e infiere el stack; solo pregunta lo que no puede detectar
- En proyectos nuevos, hace preguntas guiadas para definir las convenciones desde el inicio
- Escribe `conventions.md` y `AGENTS.md` con toda la información

**`commit-push-pr`** — cuando tienes cambios listos:
- Revisa el diff y el historial de commits
- Propone un mensaje siguiendo tus convenciones
- Espera tu confirmación antes de ejecutar
- Hace `git push` y crea el PR con `gh pr create`

**`simplify`** — después de implementar algo:
- Revisa los archivos que tocaste en esta sesión
- Busca lógica duplicada, abstracciones innecesarias y tests que verifican implementación en lugar de comportamiento
- Solo modifica lo que ya está en scope — no toca código ajeno

Para usar un comando: `/<nombre-del-comando>` en la sesión de tu agente.

---

## Seguimiento de estado (opcional)

Si tienes proyectos largos o retomas trabajo después de días, puedes activar el seguimiento de estado. El agente te preguntará la primera vez:

> "¿Quieres activar el seguimiento de estado? Creo una carpeta `state/` donde registro la fase activa, feature en curso y spec activa."

Con el estado activo, cuando retomes el proyecto el agente sabe exactamente dónde quedó:

```markdown
## Estado actual
- Fase: execute
- Feature: sistema de autenticación
- Plan: docs/plans/2026-04-16-auth.md
- Tarea activa: Task 3 — endpoint de login
- Última actualización: 2026-04-16
```

> **Nota para equipos:** `state/` genera commits frecuentes. Se recomienda agregarlo a `.gitignore` en repos compartidos.

---

## Estructura completa del framework

```
.devflow/
├── overview.md              ← el agente lee esto primero en cada sesión
├── conventions.md           ← convenciones estáticas + correcciones aprendidas
│
├── brainstorm/
│   ├── README.md            ← proceso: idea → spec aprobada
│   └── spec-reviewer.md     ← prompt de auto-revisión de la spec
│
├── plan/
│   ├── README.md            ← proceso: spec → plan detallado
│   └── plan-reviewer.md     ← prompt de auto-revisión del plan
│
├── execute/
│   ├── README.md            ← proceso: tarea por tarea con revisión doble
│   ├── implementer.md       ← prompt del agente implementador
│   ├── spec-reviewer.md     ← prompt: ¿el código cumple la spec?
│   └── quality-reviewer.md  ← prompt: ¿el código está bien construido?
│
├── finish/
│   └── README.md            ← checklist de cierre + opciones de integración
│
├── hooks/
│   ├── README.md            ← cómo instalar los hooks en tu agente
│   ├── post-edit-format.sh  ← formatea al editar
│   └── post-edit-test.sh    ← corre tests al editar
│
├── commands/
│   ├── start-devflow.md     ← slash command: onboarding guiado del proyecto
│   ├── commit-push-pr.md    ← slash command: commit + push + PR
│   └── simplify.md          ← slash command: revisión de calidad
│
└── state/                   ← opcional — el agente pregunta si activarlo
    ├── current-phase.md     ← fase y tarea activa
    └── active-spec.md       ← spec en curso y su estado
```

---

## Compatibilidad

devflow funciona con cualquier agente que lea archivos markdown:

| Agente | Archivo de entrada | Slash commands | Limpiar contexto | Compactar |
|--------|-------------------|----------------|-----------------|-----------|
| Claude Code | `CLAUDE.md` → `AGENTS.md` → `.devflow/overview.md` | `.devflow/commands/*.md` via skills | `/clear` | `/compact` |
| OpenCode | `AGENTS.md` → `.devflow/overview.md` | `.opencode/commands/*.md` | Nueva sesión | Automático |
| Codex | `AGENTS.md` → `.devflow/overview.md` | En desarrollo | `/clear` | Manual (actualizar estado) |
| Gemini CLI | `GEMINI.md` → `.devflow/overview.md` | — | Nueva sesión | — |
| Cualquier otro | Apunta a `.devflow/overview.md` desde tu archivo de instrucciones | — | — | — |

---

## Filosofía

devflow implementa la filosofía de Boris Cherny (creador de Claude Code):

- **Plan antes de código** — ningún agente escribe código sin spec y plan aprobados
- **Verificación, no confianza** — dos revisores independientes por cada tarea implementada
- **Agentes especializados** — el implementer no revisa su propio trabajo (sesgo de contexto)
- **Conocimiento vivo** — cada corrección del usuario queda documentada para siempre
- **Sin dependencias** — todo son archivos de texto que cualquier herramienta puede leer

---

## Contribuir

Issues y PRs bienvenidos.
