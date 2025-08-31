             
 DEVICE AMSTRADCPC6128 ;; Especifica que es para Amstrad CPC
LOAD_ADDRESS EQU $4500

 ORG LOAD_ADDRESS          ; Cargar en dirección hexadecimal 4000

START:
        ; Establecer modo de video 1 (320x200, 4 colores)
        LD A, 1
        CALL $BC0E          ; SCR SET MODE

        ; Definir la paleta - establecer pen 1 como rojo
        LD A, 1             ; Pen number (1)
        LD B, 6             ; Color rojo brillante en firmware CPC
        CALL $BC32          ; SCR SET INK

        ; Establecer el pen gráfico a color 1 (rojo)
        LD A, 1             ; Pen number para gráficos
        CALL $BBDE          ; GRA SET PEN

        ; Dibujar punto en posición (80, 80)
        LD DE, 80           ; Coordenada X
        LD HL, 80           ; Coordenada Y
        CALL $BBEA          ; GRA PLOT ABSOLUTE

        ; Hacer el punto más visible dibujando un pequeño cuadrado
        LD DE, 81           ; X+1
        LD HL, 80           ; Y
        CALL $BBEA          ; GRA PLOT ABSOLUTE
        
        LD DE, 80           ; X
        LD HL, 81           ; Y+1
        CALL $BBEA          ; GRA PLOT ABSOLUTE
        
        LD DE, 81           ; X+1
        LD HL, 81           ; Y+1
        CALL $BBEA          ; GRA PLOT ABSOLUTE

        ; Bucle infinito para mantener el programa activo
LOOP:
        HALT                ; Esperar al siguiente frame
        JR LOOP

        ; Punto de entrada para BASIC
        ; Para ejecutar desde BASIC: CALL $4000
        
        END START
