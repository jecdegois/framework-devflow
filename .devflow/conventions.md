# Convenciones del proyecto

> El agente actualiza la sección "Correcciones aprendidas" cada vez que el usuario lo corrige.
> La sección estática la llena el desarrollador al iniciar el proyecto.

---

## Stack tecnológico

<!-- Completar al adoptar devflow en tu proyecto -->
- Lenguaje principal:
- Framework principal:
- Base de datos:
- Herramientas de testing:

## Idioma

- Código y nombres de variables: inglés
- Documentación y commits: [definir por proyecto]

## Formato de commits

```
tipo: descripción breve en presente

Tipos: feat | fix | chore | docs | refactor | test
```

## Estructura de carpetas

<!-- Describir la estructura principal del proyecto -->

## Reglas de estilo

<!-- Añadir reglas específicas del proyecto -->

## Prompts eficientes

<!-- Estas reglas reducen tokens sin perder calidad -->

- Ser específico: "agrega validación de email en `auth/login.ts`" gasta menos que "mejora el auth"
- Un problema por mensaje: no agrupar múltiples cambios no relacionados en un solo prompt
- Usar `/clear` al cambiar de feature — el contexto viejo es ruido y costo
- Usar `/compact` cuando el contexto es grande pero hay trabajo en progreso
- Actualizar `state/current-phase.md` antes de `/clear` para no perder el hilo

---

## Correcciones aprendidas

<!-- El agente agrega aquí cada corrección del usuario -->
<!-- Formato: - [YYYY-MM-DD] descripción de la corrección -->
