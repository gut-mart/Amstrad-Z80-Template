#!/usr/bin/env bash
set -euo pipefail

# Ruta a WinApe.exe configurable sin tocar el repo:
#   export WINAPE_EXE="/ruta/a/WinApe.exe"
: "${WINAPE_EXE:?Falta WINAPE_EXE. Ejemplo: export WINAPE_EXE='/ruta/a/WinApe.exe'}"

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD="$ROOT/build"

DSK="$BUILD/disco.dsk"

# En el DSK, el fichero aparece como MAIN.BIN (ver iDSK -l), pero WinAPE suele aceptar main.bin igualmente.
# Para evitar dudas, dejamos el nombre exacto del disco:
BIN_ON_DISK="MAIN.BIN"

# Comprobaciones
if [[ ! -d "$BUILD" ]]; then
  echo "No existe: $BUILD" >&2
  exit 1
fi

if [[ ! -f "$DSK" ]]; then
  echo "No existe: $DSK (ejecuta antes create_dsk.sh o Build + DSK)" >&2
  exit 1
fi

# Ejecutar WinAPE desde el directorio build para poder pasar z:disco.dsk como en tu ejemplo (funciona bien)
cd "$BUILD"

if [[ "${WINAPE_AUTORUN:-0}" == "1" ]]; then
  # Autorun ejecuta un archivo de A: (dentro del DSK), NO una ruta Z:\...
  wine "$WINAPE_EXE" "z:disco.dsk" "/A:${BIN_ON_DISK}"
else
  wine "$WINAPE_EXE" "z:disco.dsk"
fi
