             
 DEVICE AMSTRADCPC6128 ;; Especifica que se manejará la arquitectura
                       ;; para la computadora Amstrad CPC6128
LOAD_ADDRESS EQU $8000 ;; Dirección donde se cargara el código en memoria.
                       ;; IMPORTANTE LA ETIQUETA "LOAD_ADDRESS" SIEMPRE DEBE 
                       ;; UTILIZARSE PARA INDICAR LA DIRECCION DE CARGA DEL 
                       ;; CODIGO DEL PROGRAMA EN LA MEMORIA. La dirección por 
                       ;; defecto es la $4000
                       ;; La etiqueta "LOAD_ADDRESS" es utilizada por el script
                       ;; create_dsk.sh para calcular las direcciones necesarias
                       ;; para el programa iDSK que crea un archivo con estensión .dsk
                      


 ORG LOAD_ADDRESS      ;; Cargar en dirección hexadecimal $4000 por defecto


         
      
     

        MACRO   INK pen, col
            ld      bc,$7F00
            ld      a,$40 + pen
            out     (c),a
            ld      a,col         ; 0..26
            out     (c),a
        ENDM

START:
        di
        INK 0, 20     ; papel verde
        INK 1, 24     ; pluma 1 amarilla
        INK 2, 6      ; pluma 2 azul
        INK 16, 14    ; borde gris

wait:   jr wait



        END START     ;;  END START indica cual es el punto de entrada.
                      ;;  IMPORTANTE LA ETIQUETA "START:" SIEMPRE DEBE 
                      ;;  UTILIZARSE PARA INDICAR LA DIRECCION DONDE DEBE COMENZAR EL
                      ;;  CODIGO DEL PROGRAMA A EJECURTARSE. La dirección se calcula
                      ;;  mediante el  script create_dsk.sh que será  utilizado por
                      ;;  el programa iDSK para crear un archivo con estensión .dsk

   