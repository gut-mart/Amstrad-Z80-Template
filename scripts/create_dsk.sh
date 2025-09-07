#!/bin/bash

# ---
# Script mejorado para automatizar la creación de una imagen de disco (.dsk) para Amstrad CPC,
# insertar un programa binario en ella y ejecutarlo en el emulador WinApe.
#
# Mejoras:
# - Robusto: se detiene si un comando falla (set -e).
# - Eficiente: extrae direcciones sin bucles.
# - Flexible: permite pasar la ruta del emulador como argumento.
# ---

# 1. CONFIGURACIÓN INICIAL
# `set -e` hace que el script se detenga inmediatamente si cualquier comando falla,
# evitando errores en cascada.
set -e

# 2. NAVEGAR AL DIRECTORIO DE COMPILACIÓN
# Nos movemos al directorio 'build' donde se encuentran los archivos generados.
echo "Cambiando al directorio 'build/'..."
cd build

# 3. EXTRAER DIRECCIONES DE INICIO Y CARGA
echo "--- Extrayendo direcciones desde 'main.sym' ---"
# Extraemos las direcciones directamente usando grep, awk y cut. Es más eficiente que los bucles.
direcc_inicio=$(grep 'START' main.sym | awk '{print $3}' | sed 's/0x0000//')
direcc_carga=$(grep 'LOAD_ADDRESS' main.sym | awk '{print $3}' | sed 's/0x0000//')

# 4. VERIFICAR QUE LAS DIRECCIONES FUERON ENCONTRADAS
# Si alguna de las variables está vacía, el grep falló. Mostramos un error y salimos.
if [ -z "$direcc_inicio" ] || [ -z "$direcc_carga" ]; then
  echo "Error: No se pudo encontrar la dirección de inicio o de carga en main.sym."
  exit 1
fi
echo "Dirección de inicio encontrada: $direcc_inicio"
echo "Dirección de carga encontrada: $direcc_carga"
echo "---------------------------------------------"

# 5. CREAR IMAGEN DE DISCO E INSERTAR BINARIO
echo "Creando imagen de disco 'disco.dsk'..."
# iDSK -n: Crea una nueva imagen de disco vacía.
iDSK -n disco.dsk

echo "Insertando 'main.bin' en 'disco.dsk'..."
# -i: Archivo a insertar, -t 1: Tipo binario, -e: Dirección de ejecución, -c: Dirección de carga.
iDSK disco.dsk -i main.bin -t 1 -e "$direcc_inicio" -c "$direcc_carga"

# 6. EJECUTAR EL PROGRAMA EN EL EMULADOR WINAPE
echo "Lanzando emulador WinApe..."

# La ruta a WinApe puede pasarse como primer argumento al script ($1).
# Si no se pasa ningún argumento, se usa la ruta por defecto.
RUTA_WINAPE_DEFAULT="/home/isidro/Datos/Z80/cpctelera/cpctelera/tools/winape/WinApe.exe"
RUTA_WINAPE="${1:-$RUTA_WINAPE_DEFAULT}"

# Parámetros para el emulador.
UNIDAD_DISCO="z:disco.dsk"
PROGRAMA="/A:main.bin"

echo "Usando WinApe desde: $RUTA_WINAPE"
# Usamos 'wine' para ejecutar el emulador de Windows en Linux.
wine "$RUTA_WINAPE" "$UNIDAD_DISCO" "$PROGRAMA"

echo "Script finalizado."
