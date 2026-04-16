#!/usr/bin/env bash
# init.sh
# Adopta devflow en un proyecto existente.
# Uso: bash init.sh <ruta-del-proyecto>
#
# Hace tres cosas sin pisar nada existente:
# 1. Copia .workflow/ al proyecto destino
# 2. Crea docs/specs/ y docs/plans/ si no existen
# 3. Crea o fusiona AGENTS.md / CLAUDE.md / GEMINI.md

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

# 1. Copiar .workflow/
if [[ -d "$TARGET/.workflow" ]]; then
  echo "  ⚠ .workflow/ already exists — skipping (delete it manually to reinstall)"
else
  cp -r "$DEVFLOW_DIR/.workflow" "$TARGET/.workflow"
  echo "  ✓ Copied .workflow/"
fi

# 2. Crear docs/specs/ y docs/plans/
mkdir -p "$TARGET/docs/specs" "$TARGET/docs/plans"
touch "$TARGET/docs/specs/.gitkeep" "$TARGET/docs/plans/.gitkeep"
echo "  ✓ Created docs/specs/ and docs/plans/"

# 3. Crear o fusionar archivos de entrada
ENTRY_LINE="
## Workflow

El proceso de desarrollo de este proyecto está en \`.workflow/overview.md\`.
Léelo antes de hacer cualquier cosa."

for file in AGENTS.md GEMINI.md; do
  if [[ ! -f "$TARGET/$file" ]]; then
    echo "# Workflow
$ENTRY_LINE" > "$TARGET/$file"
    echo "  ✓ Created $file"
  else
    if ! grep -q ".workflow/overview.md" "$TARGET/$file"; then
      echo "$ENTRY_LINE" >> "$TARGET/$file"
      echo "  ✓ Updated $file (appended workflow reference)"
    else
      echo "  ⚠ $file already references .workflow/overview.md — skipped"
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

echo ""
echo "devflow installed successfully."
echo "Next: edit $TARGET/.workflow/conventions.md with your project's conventions."
