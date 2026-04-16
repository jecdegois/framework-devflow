# Fase: Brainstorm

Convierte la idea del usuario en una spec aprobada.

## Proceso

1. **Explora el contexto** — lee el código existente, commits recientes, docs relevantes.
2. **Haz preguntas una a la vez** — entiende propósito, restricciones, criterios de éxito. Prefiere preguntas de opción múltiple.
3. **Propón 2-3 enfoques** — con trade-offs y tu recomendación.
4. **Presenta el diseño por secciones** — pide aprobación después de cada sección.
5. **Escribe la spec** — guárdala en `docs/specs/YYYY-MM-DD-<tema>-design.md`.
6. **Auto-revisión de la spec** — busca placeholders, contradicciones, ambigüedades. Corrígelos antes de continuar.
7. **Pide al usuario que revise** — espera aprobación explícita antes de pasar a Plan.

## Reglas

- Una pregunta por mensaje.
- No escribas código hasta tener la spec aprobada.
- Si la idea cubre múltiples subsistemas independientes, propón descomponerla en sub-proyectos.

## Revisor de spec

Antes de presentar la spec al usuario, usa el prompt en `spec-reviewer.md` para revisarla.

## Al terminar

Spec aprobada → ve a `../plan/README.md`.
