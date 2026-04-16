# devflow — Punto de entrada

Lee este archivo antes de hacer cualquier cosa en este proyecto.

## Qué es devflow

Framework de desarrollo en markdown. Agnóstico al agente — funciona en Claude Code, Codex, Gemini CLI, OpenCode o cualquier herramienta que lea markdown.

Filosofía: plan antes de código, verificación automática, subagentes especializados, conocimiento que mejora con el tiempo.

## Antes de empezar

1. Lee `conventions.md` (este directorio) — tiene las convenciones del proyecto y las correcciones aprendidas.
2. Si existe `state/current-phase.md`, léelo — te dice en qué punto está el trabajo activo.
3. Si el usuario te corrige un error, **documenta la corrección en `conventions.md` antes de continuar**.

## Flujo de trabajo

```
Usuario pide algo
       ↓
¿Existe un plan en docs/plans/ para esta tarea?
   ├── SÍ → ve a execute/README.md
   └── NO → ve a brainstorm/README.md
```

## Fases

| Fase | Archivo | Propósito |
|------|---------|-----------|
| Brainstorm | `brainstorm/README.md` | Explorar idea → escribir spec |
| Plan | `plan/README.md` | Spec aprobada → escribir plan |
| Execute | `execute/README.md` | Plan listo → implementar |
| Finish | `finish/README.md` | Implementación lista → cerrar rama |

## Seguimiento de estado (opcional)

Si `state/current-phase.md` existe, léelo para saber en qué punto estás.

Si no existe y el proyecto es personal o de larga duración, pregunta al usuario:
> "¿Quieres activar el seguimiento de estado? Creo una carpeta `state/` donde registro la fase activa, feature en curso y spec activa."

---

## Gestión de contexto y tokens

El contexto crece con cada mensaje. Estas reglas aplican en cualquier agente.

**Regla principal: actualiza el estado antes de limpiar**
Antes de limpiar o compactar el contexto, asegúrate de que `state/current-phase.md` esté al día con las decisiones tomadas, la tarea activa y los archivos modificados. El estado es la memoria persistente — si está completo, el contexto se puede limpiar sin perder el hilo.

**Cuándo sugerir limpiar el contexto**
Sugiere al usuario limpiar el contexto (y ofrece actualizar el estado antes) cuando:
- Se termina una tarea del plan y la siguiente es independiente
- Se cambia a un feature completamente distinto
- El usuario menciona que la sesión está lenta o costosa

**Cuándo sugerir compactar en lugar de limpiar**
Cuando hay trabajo en progreso que no conviene perder pero el contexto ya es grande, compactar es mejor que limpiar.

**Qué preservar al compactar** (en orden de prioridad):
1. Las correcciones aprendidas de `conventions.md`
2. El plan activo en `docs/plans/` y la tarea en curso
3. El estado en `state/current-phase.md`
4. Las decisiones de diseño relevantes de la spec activa

**Comandos por agente**

| Acción | Claude Code | OpenCode | Codex |
|--------|-------------|----------|-------|
| Limpiar contexto | `/clear` | Iniciar nueva sesión | `/clear` o `Ctrl+L` |
| Compactar | `/compact` | Automático (sin comando) | No disponible — actualizar estado manualmente |
| Retomar trabajo | `/resume` | Continuar sesión existente | `codex resume` |
| Ver uso de tokens | `/cost` | Ver en la UI | Indicador en TUI |
