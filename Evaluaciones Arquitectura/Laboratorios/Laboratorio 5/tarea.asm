org   100h

section .data
nombre db 'Francisco'


section .text

main:
    CALL IniciarModoTexto
    
    MOV BH, 0d ; Establece la página 0
    CALL CentrarCursor


    CALL define_colors

    MOV SI, 0 ;Declaramos contador en SI
    CALL display_name

INT 20h


IniciarModoTexto:
    MOV AH, 0h
    MOV AL, 03h ; Establece modo texto 80x25   - 16 colores y 8 paginas
    int 10h ; Llama a la interrupción del BIOS para cambiar el modo texto
RET


CentrarCursor:
    MOV AH, 02h
    MOV DH, 10 ; Fila central
    MOV DL, 25 ; Columna central
    int 10h ; Llama a la interrupción del BIOS para posicionar el cursor
RET

move_cursor:
    MOV AH, 02h              ; Función para mover el cursor
    INC DL
    INT 10h 
    
    JMP display_name                 ; Llamada a la interrupción de video para mover el cursor
RET

display_name:

    CALL change_color

    MOV AH, 09h              ; Función para escribir un carácter con atributos
    MOV AL, [nombre + SI]             ; Dirección base donde comenzar a guardar los caracteres
    INC SI
    MOV CX, 01h              ; Repetir 1 vez el carácter AL
    INT 10h                  ; Llamada a la interrupción de video para mostrar el carácter
    
    CMP AL, 0h
    JE return

    JMP move_cursor
RET


change_color:
    MOV BL, [200h + SI]
RET


define_colors:
    MOV BYTE[200h], 11000101b
    MOV BYTE[201h], 10101111b
    MOV BYTE[202h], 10011101b
    MOV BYTE[203h], 11011011b
    MOV BYTE[204h], 11101101b
    MOV BYTE[205h], 10111110b
    MOV BYTE[206h], 11011001b
    MOV BYTE[207h], 11111010b
    MOV BYTE[208h], 01011100b
RET

return:
RET