#!/usr/bin/env bash
# post-edit-format.sh
# Formatea el archivo recién editado.
# Uso: bash post-edit-format.sh <ruta-del-archivo>
#
# Adapta el comando de formato a tu stack:
#   Python:     black "$FILE"
#   JS/TS:      npx prettier --write "$FILE"
#   Go:         gofmt -w "$FILE"
#   Rust:       rustfmt "$FILE"

set -euo pipefail

FILE="${1:-}"

if [[ -z "$FILE" ]]; then
  echo "Usage: post-edit-format.sh <file>" >&2
  exit 1
fi

if [[ ! -f "$FILE" ]]; then
  # El archivo puede no existir si se eliminó — no es error
  exit 0
fi

# Ejemplo con prettier (JS/TS). Reemplaza con tu formateador:
if command -v prettier &>/dev/null; then
  prettier --write "$FILE"
fi
