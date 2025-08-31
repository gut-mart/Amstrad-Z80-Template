             
 DEVICE AMSTRADCPC6128 ;; Especifica que se manejará la arquitectura
                       ;; para la computadora Amstrad CPC6128
LOAD_ADDRESS EQU $4000 ;; Dirección donde se cargara el código en memoria.
                       ;; IMPORTANTE LA ETIQUETA "LOAD_ADDRESS" SIEMPRE DEBE 
                       ;; UTILIZARSE PARA INDICAR LA DIRECCION DE CARGA DEL 
                       ;; CODIGO DEL PROGRAMA EN LA MEMORIA. La dirección por 
                       ;; defecto es la $4000
                       ;; La etiqueta "LOAD_ADDRESS" es utilizada por el script
                       ;; create_dsk.sh para calcular las direcciones necesarias
                       ;; para el programa iDSK que crea un archivo con estensión .dsk
                      


 ORG LOAD_ADDRESS      ;; Cargar en dirección hexadecimal $4000 por defecto


         
START:
;
;
;
;

        
        END START     ;;  END START indica cual es el punto de entrada.
                      ;;  IMPORTANTE LA ETIQUETA "START:" SIEMPRE DEBE 
                      ;;  UTILIZARSE PARA INDICAR LA DIRECCION DONDE DEBE COMENZAR EL
                      ;;  CODIGO DEL PROGRAMA A EJECURTARSE. La dirección se calcula
                      ;;  mediante el  script create_dsk.sh que será  utilizado por
                      ;;  el programa iDSK para crear un archivo con estensión .dsk


