             
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
                      
TXT_OUTPUT EQU $BB5A    ; Rutina para imprimir un carácter en pantalla.
                        ; El carácter a imprimir debe estar en el registro A.

 ORG LOAD_ADDRESS      ;; Cargar en dirección hexadecimal $4000 por defecto


MiTexto:
    DEFB "Hola, mundo desde mi Amstrad CPC!"
    DEFB 13,10, 10         ; 13 = Retorno de Carro (CR), 10 = Nueva Línea (LF)
    DEFB "Ensamblado con SJAsmPlus."
    DEFB 0              ; El terminador NULO. Imprescindible para saber dónde acaba el texto.
START:
    LD HL, MiTexto      ; Cargamos en el registro HL la dirección de memoria
                        ; donde comienza nuestro texto. HL actuará como puntero.

BucleImprimir:
    LD A, (HL)          ; Cargamos en el registro A el valor al que apunta HL
                        ; (es decir, un carácter de nuestro texto).

    CP 0                ; Comparamos el valor de A con 0.
                        ; Usaremos el byte 0 como marca de fin de texto (null-terminated string).

    JR Z, FinPrograma   ; Si el resultado es Cero (Z flag = 1), saltamos al final.

    CALL TXT_OUTPUT     ; Si no es 0, llamamos a la rutina del firmware para
                        ; que imprima el carácter que está en A.

    INC HL              ; Incrementamos HL para que apunte al siguiente carácter.

    JR BucleImprimir    ; Saltamos de nuevo al inicio del bucle para procesar
                        ; el siguiente carácter.

FinPrograma:
    JR FinPrograma:
                    ; Retornamos el control al sistema (BASIC).
  
;
;
;

        
        END START     ;;  END START indica cual es el punto de entrada.
                      ;;  IMPORTANTE LA ETIQUETA "START:" SIEMPRE DEBE 
                      ;;  UTILIZARSE PARA INDICAR LA DIRECCION DONDE DEBE COMENZAR EL
                      ;;  CODIGO DEL PROGRAMA A EJECURTARSE. La dirección se calcula
                      ;;  mediante el  script create_dsk.sh que será  utilizado por
                      ;;  el programa iDSK para crear un archivo con estensión .dsk


