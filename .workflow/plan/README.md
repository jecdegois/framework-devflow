# Fase: Plan

Convierte la spec aprobada en un plan de implementación detallado.

## Prerequisito

Debe existir una spec aprobada en `docs/specs/`.

## Proceso

1. **Lee la spec completa** antes de escribir el plan.
2. **Mapea los archivos** — qué se crea, qué se modifica, qué se testea.
3. **Escribe el plan** en `docs/plans/YYYY-MM-DD-<feature>.md`.
4. **Auto-revisión del plan** — usa `plan-reviewer.md` para verificarlo.
5. **Pregunta al usuario si usar worktree** para aislar el trabajo:
   > "¿Quieres que cree un worktree separado para implementar esto? Útil si tienes trabajo en curso en la rama principal."

## Formato del plan

Cada tarea debe tener:
- Archivos exactos a crear/modificar
- Pasos con checkboxes
- Código completo (no "ver tarea anterior", no "similar a X")
- Comandos exactos con output esperado
- Commit al final

Sin placeholders. Sin "TBD". Sin "implementar después".

## Al terminar

Plan guardado y aprobado → ve a `../execute/README.md`.
