# Fase: Execute

Implementa el plan tarea a tarea usando subagentes especializados.

## Prerequisito

Debe existir un plan aprobado en `docs/plans/`.

## Flujo por tarea

```
Implementer (execute/implementer.md)
  ↓ (solo si DONE)
Spec Reviewer (execute/spec-reviewer.md)
  ↓ (solo si ✅ compliant)
Quality Reviewer (execute/quality-reviewer.md)
  ↓ (solo si ✅ approved)
Siguiente tarea
```

## Estados del implementer

| Estado | Acción |
|--------|--------|
| `DONE` | Despachar spec reviewer |
| `DONE_WITH_CONCERNS` | Leer concerns; si afectan correctitud, resolver primero |
| `NEEDS_CONTEXT` | Proveer contexto y re-despachar implementer |
| `BLOCKED` | Evaluar: más contexto / modelo más capaz / descomponer tarea / escalar al usuario |

## Regla de orden estricto

**Spec compliance siempre antes que quality review.**
No tiene sentido revisar la calidad de código que no cumple la spec.

## Contexto para cada subagente

Cuando despaches un subagente, provéele:
- El texto completo de la tarea del plan
- La spec activa (ruta en `state/active-spec.md` si existe)
- Esta arquitectura general (overview.md + conventions.md)

## Al terminar todas las tareas

Ve a `../finish/README.md`.
