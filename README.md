# devflow

Framework de desarrollo en markdown. Agnóstico al agente — funciona con Claude Code, Codex, Gemini CLI, OpenCode o cualquier herramienta que lea instrucciones en markdown.

## Filosofía

Plan antes de código. Verificación automática. Subagentes especializados. Conocimiento que mejora con el tiempo.

Basado en la filosofía de trabajo de Boris Cherny (creador de Claude Code).

## Uso

### Nuevo proyecto

1. Clona este repo como template:
   ```bash
   git clone <este-repo> mi-proyecto
   cd mi-proyecto
   rm -rf .git && git init
   ```

2. Edita `AGENTS.md` (o el equivalente de tu agente) con el contexto de tu proyecto.

3. Edita `.workflow/conventions.md` con tu stack y convenciones.

4. Abre tu agente en el directorio y empieza a trabajar.

### Proyecto existente

```bash
bash init.sh /ruta/a/mi-proyecto
```

El script copia `.workflow/` y actualiza los archivos de entrada sin pisar nada.

## Estructura

```
.workflow/
├── overview.md        ← el agente lee esto primero
├── conventions.md     ← convenciones + correcciones aprendidas
├── brainstorm/        ← idea → spec
├── plan/              ← spec → plan
├── execute/           ← plan → código
├── finish/            ← código → PR/merge
├── hooks/             ← automatización post-edit
└── commands/          ← slash commands reutilizables
```

## Contribuir

Issues y PRs bienvenidos.
