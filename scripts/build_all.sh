#!/usr/bin/env bash
set -euo pipefail

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "ERROR: falta '$1' en PATH." >&2
    exit 127
  }
}

require_cmd sjasmplus
require_cmd iDSK

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD="$ROOT/build"
mkdir -p "$BUILD"

sjasmplus --fullpath "$ROOT/src/main.asm" \
  --raw="$BUILD/main.bin" \
  --lst="$BUILD/main.lst" \
  --sym="$BUILD/main.sym" \
  --sld="$BUILD/main.sld"

[[ -f "$ROOT/scripts/create_dsk.sh" ]] || {
  echo "ERROR: falta scripts/create_dsk.sh" >&2
  exit 1
}

bash "$ROOT/scripts/create_dsk.sh"

echo "OK: generado build/main.bin y build/disco.dsk"
