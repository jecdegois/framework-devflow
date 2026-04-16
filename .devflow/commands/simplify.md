# Slash command: simplify

Revisa el código recién cambiado y elimina complejidad innecesaria.

## Cuándo usarlo

Después de implementar una feature o fix, antes de hacer el commit final.

## Instrucciones para el agente

Revisa los archivos modificados desde el último commit contra estos criterios:

### Reutilización
¿Hay lógica duplicada que ya existe en el codebase?
- Si sí: refactoriza para usar la implementación existente.

### Complejidad innecesaria
¿Hay abstracciones para un solo uso? ¿Hay código preparado para "el futuro"?
- Principio YAGNI: elimina lo que no se usa ahora.

### Claridad
¿Los nombres describen bien qué hace cada cosa?
- Renombra si es necesario.

### Tests
¿Los tests verifican comportamiento o implementación?
- Los tests de implementación se rompen con refactors. Conviértelos a tests de comportamiento.

## Reglas

- Solo modifica archivos que ya tocaste en esta sesión.
- No refactorices código que no está en scope.
- Si un cambio es debatible, descríbelo y pregunta antes de hacerlo.
- Commitea cada mejora por separado con mensaje descriptivo.
