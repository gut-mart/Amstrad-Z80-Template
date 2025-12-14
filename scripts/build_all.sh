#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

mkdir -p build

sjasmplus --fullpath "$ROOT/src/main.asm" \
  --raw="$ROOT/build/main.bin" \
  --lst="$ROOT/build/main.lst" \
  --sym="$ROOT/build/main.sym" \
  --sld="$ROOT/build/main.sld"

chmod +x "$ROOT/scripts/create_dsk.sh"
"$ROOT/scripts/create_dsk.sh"

echo "OK: generado build/main.bin y build/disco.dsk"
