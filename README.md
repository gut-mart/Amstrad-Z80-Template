# Amstrad Z80 Template (sjasmplus + DSK + WinAPE)

Plantilla de proyecto Z80 para Amstrad CPC con:
- Ensamblado con **sjasmplus**
- Generación de binario + símbolos (`.bin/.sym/.sld`)
- Creación de imagen **.DSK** con **iDSK**
- Ejecución en **WinAPE** vía **Wine** (con autorun opcional)
- Integración cómoda desde **Visual Studio Code** (Tasks)

---

## Estructura del proyecto


Notas:
- `build/` se genera automáticamente.
- `create_dsk.sh` inserta `build/main.bin` en `build/disco.dsk`.

---

## Requisitos

### Paquetes / herramientas
- `sjasmplus` (ensamblador Z80)
- `iDSK` (creación y manipulación de .DSK)
- `wine` (solo si vas a usar WinAPE)

### En Manjaro (ejemplo)
- Instala `sjasmplus` (AUR habitual): `sjasmplus-z00m128`
- Instala `idsk` (según tu método: AUR o compilación)
- Instala `wine`

(El nombre exacto del paquete puede variar según repos/AUR.)

---

## Convención de símbolos en ASM (IMPORTANTE)

Para que el empaquetado del DSK sea reproducible, el script `create_dsk.sh` intenta leer del fichero `build/main.sym`:

- `LOAD_ADDRESS` → dirección de carga del binario
- `START` → dirección de ejecución/entrada

Asegúrate de definirlo en `src/main.asm` de forma consistente, por ejemplo:

```asm
LOAD_ADDRESS  EQU $4000
              ORG LOAD_ADDRESS

START:
    ; tu código...
