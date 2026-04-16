# devflow — Punto de entrada

Lee este archivo antes de hacer cualquier cosa en este proyecto.

## Qué es devflow

Framework de desarrollo en markdown. Agnóstico al agente — funciona en Claude Code, Codex, Gemini CLI, OpenCode o cualquier herramienta que lea markdown.

Filosofía: plan antes de código, verificación automática, subagentes especializados, conocimiento que mejora con el tiempo.

## Antes de empezar

1. Lee `conventions.md` (este directorio) — tiene las convenciones del proyecto y las correcciones aprendidas.
2. Si el usuario te corrige un error, **documenta la corrección en `conventions.md` antes de continuar**.

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
