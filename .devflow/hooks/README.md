# Hooks de desarrollo

Scripts que se ejecutan automáticamente durante el desarrollo para mantener la calidad.

## Hooks disponibles

| Hook | Cuándo corre | Propósito |
|------|-------------|-----------|
| `post-edit-format.sh` | Después de cada edición | Formatea el código automáticamente |
| `post-edit-test.sh` | Después de cada edición | Corre los tests del archivo editado |

## Instalación en Claude Code

Agrega en `.claude/settings.json`:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "bash .devflow/hooks/post-edit-format.sh $CLAUDE_TOOL_INPUT_FILE_PATH"
          }
        ]
      }
    ]
  }
}
```

Reemplaza `post-edit-format.sh` con `post-edit-test.sh` para correr tests, o encadena ambos.

## Adaptación al proyecto

Los scripts usan `prettier` y `pytest` como ejemplos. Cámbialos por las herramientas de tu stack:
- **Formato:** `black`, `gofmt`, `rustfmt`, `eslint --fix`, etc.
- **Tests:** `jest`, `go test`, `cargo test`, `rspec`, etc.
