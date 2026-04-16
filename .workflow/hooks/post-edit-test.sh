#!/usr/bin/env bash
# post-edit-test.sh
# Corre los tests relacionados con el archivo recién editado.
# Uso: bash post-edit-test.sh <ruta-del-archivo>
#
# Adapta el comando de tests a tu stack:
#   Python:  pytest tests/ -x -q
#   JS/TS:   npx jest --passWithNoTests
#   Go:      go test ./...
#   Rust:    cargo test

set -euo pipefail

FILE="${1:-}"

if [[ -z "$FILE" ]]; then
  echo "Usage: post-edit-test.sh <file>" >&2
  exit 1
fi

if [[ ! -f "$FILE" ]]; then
  exit 0
fi

# Ejemplo con pytest. Reemplaza con tu runner de tests:
if command -v pytest &>/dev/null; then
  pytest --tb=short -q
fi
