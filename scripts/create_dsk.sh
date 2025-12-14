#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT/build"

# Comprobaciones básicas
[[ -f main.bin ]] || { echo "Falta build/main.bin"; exit 1; }
[[ -f main.sym ]] || { echo "Falta build/main.sym"; exit 1; }

# Extraer direcciones desde main.sym (ajústalo si tus símbolos se llaman distinto)
direcc_inicio=$(grep -E '^START\b' main.sym | awk '{print $3}' | sed 's/0x0000//')
direcc_carga=$(grep -E '^LOAD_ADDRESS\b' main.sym | awk '{print $3}' | sed 's/0x0000//')

if [[ -z "${direcc_inicio:-}" || -z "${direcc_carga:-}" ]]; then
  echo "No se encontraron START o LOAD_ADDRESS en build/main.sym"
  echo "Revisa los símbolos disponibles con: head -n 50 build/main.sym"
  exit 1
fi

echo "Creando DSK..."
iDSK -n disco.dsk

echo "Insertando main.bin (carga=$direcc_carga, ejec=$direcc_inicio)..."
iDSK disco.dsk -i main.bin -t 1 -c "$direcc_carga" -e "$direcc_inicio"

echo "OK: build/disco.dsk listo"
