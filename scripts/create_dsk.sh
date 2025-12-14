#!/usr/bin/env bash
set -euo pipefail

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "ERROR: falta '$1' en PATH." >&2
    exit 127
  }
}

require_cmd iDSK
require_cmd awk

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD="$ROOT/build"

BIN="$BUILD/main.bin"
DSK="$BUILD/disco.dsk"
SYM="$BUILD/main.sym"

[[ -f "$BIN" ]] || { echo "ERROR: falta $BIN (ejecuta antes el ensamblado)" >&2; exit 1; }

get_sym_hex() {
  local sym="$1"
  [[ -f "$SYM" ]] || return 1
  awk -v S="$sym" '
    $1==S {
      for (i=NF; i>=1; --i) {
        if ($i ~ /^0x[0-9A-Fa-f]+$/) { print $i; exit }
        if ($i ~ /^&[0-9A-Fa-f]+$/)  { print $i; exit }
        if ($i ~ /^[0-9A-Fa-f]{4,8}$/){ print $i; exit }
      }
    }
  ' "$SYM"
}

hex_to_dec() {
  local x="${1#0x}"
  x="${x#&}"
  echo $((16#$x))
}

LOAD_DEC=""
EXEC_DEC=""

if x="$(get_sym_hex LOAD_ADDRESS)"; then LOAD_DEC="$(hex_to_dec "$x")"; fi
if x="$(get_sym_hex START)"; then EXEC_DEC="$(hex_to_dec "$x")"; fi

if [[ -z "${LOAD_DEC}" ]]; then
  LOAD_DEC=16384  # 0x4000
  echo "WARN: no pude leer LOAD_ADDRESS en $SYM; uso 0x4000" >&2
fi
if [[ -z "${EXEC_DEC}" ]]; then
  EXEC_DEC=16384  # 0x4000
  echo "WARN: no pude leer START en $SYM; uso 0x4000" >&2
fi

mkdir -p "$BUILD"

echo "Creando DSK..."
iDSK -n "$DSK"

echo "Insertando main.bin (carga=$LOAD_DEC, ejec=$EXEC_DEC)..."
iDSK "$DSK" -i "$BIN" -t 1 -c "$LOAD_DEC" -e "$EXEC_DEC"

echo "OK: $DSK listo"
