# Fase: Finish

Cierra el trabajo de implementación de forma ordenada.

## Prerequisito

Todas las tareas del plan tienen status ✅ (spec compliant + quality approved).

## Checklist

- [ ] Todos los tests pasan: `[comando de tests del proyecto]`
- [ ] No hay archivos sin commitear: `git status`
- [ ] El plan en `docs/plans/` refleja el estado final (todas las checkboxes marcadas)
- [ ] `conventions.md` tiene documentadas las correcciones aprendidas durante la implementación

## Opciones de integración

### Opción A: Pull Request
```bash
git push origin <rama-feature>
# Crear PR en GitHub/GitLab apuntando a main
```

### Opción B: Merge directo
```bash
git checkout main
git merge --no-ff <rama-feature> -m "feat: [descripción del feature]"
git push origin main
```

### Opción C: Squash merge (historial limpio)
```bash
git checkout main
git merge --squash <rama-feature>
git commit -m "feat: [descripción del feature completo]"
git push origin main
```

## Cleanup

```bash
# Eliminar rama local si ya se mergeó
git branch -d <rama-feature>

# Si se usó worktree
git worktree remove <path-del-worktree>
```

## Actualizar state/ (si está activo)

Si `state/current-phase.md` existe, actualízalo:
```markdown
## Estado actual
- Fase: finish ✅
- Feature: [nombre] — COMPLETADO
- Última actualización: YYYY-MM-DD
```
