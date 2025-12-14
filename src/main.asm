             
 DEVICE AMSTRADCPC6128 ;; Especifica que se manejará la arquitectura
                       ;; para la computadora Amstrad CPC6128
 SLDOPT COMMENT WPMEM, LOGPOINT, ASSERTION
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
 ;
 ;
 ;programa de ejemplo para Amstrad CPC6128
 ;pulsar ctrl+shift+B y selecionar ensamblar con sjasmplus
 ;volver a pulsar ctrl+shift+B y selecionar crear disco .dsk
 ;
 ; --- Poner modo 2 (80x25) y limpiar pantalla ---
    LD A, 2
    CALL $BC0E   ; SCR SET MODE
    CALL $BB6C   ; TXT CLEAR WINDOW

    ; --- Posicionar cursor en el centro (40, 12) ---
    LD H, 40    ; Columna
    LD L, 12    ; Fila
    CALL $BB75  ; TXT SET CURSOR

    ; --- Imprimir la letra 'A' ---
    LD A, 'A'
    CALL $BB5A  ; TXT OUTPUT

    LD A, 'B'
    CALL $BB5A  ; TXT OUTPUT

    LD A, 'C'
    CALL $BB5A  ; TXT OUTPUT

   
    ; --- Esperar a que se pulse una tecla ---
    CALL $BB18  ; KM_WAIT_KEY
    RET
;
;
;
;
;
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

   
//En este punto se trata de integrar  Dezog y MAME para depurar el código ensamblador
//para probar primero debes de lanzar mame desde la linea de comandos 
// /home/isidro/Datos/Z80/Proyectos_ASM/Amstrad/Amstrad cpc-6128k/Amstrad-Z80-Tempalate/build/disco.dsk" -debug -debugger gdbstub -debugger_port 12000
