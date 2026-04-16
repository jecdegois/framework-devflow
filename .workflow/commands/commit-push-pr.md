# Slash command: commit-push-pr

Crea un commit con los cambios actuales, hace push y abre un PR.

## Cuándo usarlo

Cuando tienes cambios listos para revisar y quieres crear un PR de forma rápida.

## Instrucciones para el agente

1. Corre `git status` para ver qué hay pendiente.
2. Corre `git diff` para entender los cambios.
3. Corre `git log --oneline -5` para seguir el estilo de commits del repo.
4. Propón un mensaje de commit siguiendo las convenciones de `../.workflow/conventions.md`.
5. Espera confirmación del usuario antes de commitear.
6. Haz `git add` de los archivos relevantes (nunca `git add -A` sin revisar primero).
7. Crea el commit.
8. Haz `git push origin <rama-actual>`.
9. Crea el PR con `gh pr create` incluyendo:
   - Título corto (< 70 caracteres)
   - Body con: resumen en bullets, plan de tests

## Seguridad

- Nunca commitees archivos `.env`, credenciales o binarios grandes.
- Nunca hagas force push a main/master.
- Si hay hooks de pre-commit que fallan, investiga la causa — no uses `--no-verify`.
