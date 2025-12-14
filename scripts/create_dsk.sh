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

# Devuelve la dirección en HEX (sin 0x ni &) para un símbolo en el .sym
# Soporta formato: "START: EQU 0x00004000"
get_sym_hex() {
  local sym="$1"
  [[ -f "$SYM" ]] || return 1
  awk -v S="$sym" '
    BEGIN { found=0 }
    {
      name=$1
      sub(/:$/,"",name)    # quita ":" al final del símbolo si existe
      if (name==S) {
        for (i=NF; i>=1; --i) {
          if ($i ~ /^0x[0-9A-Fa-f]+$/) {
            sub(/^0x/,"",$i)
            sub(/^0+/,"",$i)
            if ($i=="") $i="0"
            print $i
            found=1
            exit
          }
          if ($i ~ /^&[0-9A-Fa-f]+$/)  {
            sub(/^&/,"",$i)
            sub(/^0+/,"",$i)
            if ($i=="") $i="0"
            print $i
            found=1
            exit
          }
          if ($i ~ /^[0-9A-Fa-f]{4,8}$/){
            sub(/^0+/,"",$i)
            if ($i=="") $i="0"
            print $i
            found=1
            exit
          }
        }
      }
    }
    END { exit (found?0:1) }
  ' "$SYM"
}

LOAD_HEX="$(get_sym_hex LOAD_ADDRESS 2>/dev/null || true)"
EXEC_HEX="$(get_sym_hex START 2>/dev/null || true)"

# Fallback seguro si el .sym no contiene esos símbolos
if [[ -z "$LOAD_HEX" ]]; then
  LOAD_HEX="4000"
  echo "WARN: no pude leer LOAD_ADDRESS en $SYM; uso 4000h" >&2
fi
if [[ -z "$EXEC_HEX" ]]; then
  EXEC_HEX="4000"
  echo "WARN: no pude leer START en $SYM; uso 4000h" >&2
fi

mkdir -p "$BUILD"

echo "Creando DSK..."
iDSK -n "$DSK"

echo "Insertando main.bin (carga=${LOAD_HEX}h, ejec=${EXEC_HEX}h)..."
iDSK "$DSK" -i "$BIN" -t 1 -c "$LOAD_HEX" -e "$EXEC_HEX"

echo "OK: $DSK listo"
