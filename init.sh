#!/usr/bin/env bash
# init.sh
# Adopta devflow en un proyecto existente.
# Uso: bash init.sh <ruta-del-proyecto>
#
# Hace cuatro cosas sin pisar nada existente:
# 1. Copia .devflow/ al proyecto destino
# 2. Crea docs/specs/ y docs/plans/ si no existen
# 3. Crea o fusiona AGENTS.md / CLAUDE.md / GEMINI.md
# 4. Copia .opencode/commands/ si OpenCode está instalado

set -euo pipefail

DEVFLOW_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${1:-}"

if [[ -z "$TARGET" ]]; then
  echo "Usage: bash init.sh <target-project-path>" >&2
  exit 1
fi

if [[ ! -d "$TARGET" ]]; then
  echo "Error: '$TARGET' is not a directory" >&2
  exit 1
fi

echo "Installing devflow into: $TARGET"

# 1. Copiar .devflow/
if [[ -d "$TARGET/.devflow" ]]; then
  echo "  ⚠ .devflow/ already exists — skipping (delete it manually to reinstall)"
else
  cp -r "$DEVFLOW_DIR/.devflow" "$TARGET/.devflow"
  echo "  ✓ Copied .devflow/"
fi

# 2. Crear docs/specs/ y docs/plans/
mkdir -p "$TARGET/docs/specs" "$TARGET/docs/plans"
touch "$TARGET/docs/specs/.gitkeep" "$TARGET/docs/plans/.gitkeep"
echo "  ✓ Created docs/specs/ and docs/plans/"

# 3. Crear o fusionar archivos de entrada
ENTRY_LINE="
## Workflow

El proceso de desarrollo de este proyecto está en \`.devflow/overview.md\`.
Léelo antes de hacer cualquier cosa."

for file in AGENTS.md GEMINI.md; do
  if [[ ! -f "$TARGET/$file" ]]; then
    echo "# Workflow
$ENTRY_LINE" > "$TARGET/$file"
    echo "  ✓ Created $file"
  else
    if ! grep -q ".devflow/overview.md" "$TARGET/$file"; then
      echo "$ENTRY_LINE" >> "$TARGET/$file"
      echo "  ✓ Updated $file (appended workflow reference)"
    else
      echo "  ⚠ $file already references .devflow/overview.md — skipped"
    fi
  fi
done

# CLAUDE.md apunta a AGENTS.md (no al overview directamente)
if [[ ! -f "$TARGET/CLAUDE.md" ]]; then
  echo "# Instrucciones del proyecto

> La documentación del proyecto está en **AGENTS.md**.
> Solo actualiza AGENTS.md — este archivo no se toca." > "$TARGET/CLAUDE.md"
  echo "  ✓ Created CLAUDE.md"
else
  echo "  ⚠ CLAUDE.md already exists — skipped"
fi

# 4. Copiar .opencode/commands/ (para usuarios de OpenCode)
if command -v opencode &>/dev/null || [[ -d "$TARGET/.opencode" ]]; then
  if [[ -d "$TARGET/.opencode/commands" ]]; then
    echo "  ⚠ .opencode/commands/ already exists — skipping"
  else
    mkdir -p "$TARGET/.opencode/commands"
    cp "$DEVFLOW_DIR/.opencode/commands/"*.md "$TARGET/.opencode/commands/"
    echo "  ✓ Copied .opencode/commands/ (OpenCode slash commands)"
  fi
fi

echo ""
echo "devflow installed successfully."
echo "Next: open your agent and run /start-devflow to configure the project."
