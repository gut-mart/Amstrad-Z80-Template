; =============================================================================
; main.asm - Plantilla base para proyectos de Amstrad CPC en Z80
; =============================================================================

; --- Cabecera y configuración del binario
org #8000             ; Origen del código en memoria

LOAD_ADRESS: equ #8000 ; Dirección de carga (para el script)
START:               ; Etiqueta de inicio (para el script)

; --- Punto de entrada del programa

    ; Cambiamos el color del borde a azul
    ld bc, #7F10     ; Puerto del Gate Array: #7Fxx, Seleccionar Tinta: xx10xxxx
    ld a, 1          ; Tinta 1 (Azul en modo 1)
    out (c), a

; --- Bucle principal infinito
; La mayoría de programas y juegos entran en un bucle para no terminar.
main_loop:
    halt             ; Espera a la siguiente interrupción (ahorra CPU)
    jp main_loop     ; Repetir
    
; --- Final del programa (no se alcanza en este caso)
ret