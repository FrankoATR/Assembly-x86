ORG 100h

SECTION .text

GLOBAL main

main:
    CALL clean_memory
    ;CALL read_keyboard
    ;CALL request_word_memory
    ;CALL display_video
    CALL clean_display
    CALL read_and_display
INT 20h

read_buffer:
    MOV AH, 00
    INT 16h
    MOV [200h], AL
RET

read_shift:
    MOV AH, 02h
    INT 16h
    CMP AL, 01
        JNE read_shift
RET

read_keyboard:
    ; Asumimos que DI es el índice donde empezamos a guardar los caracteres en memoria.
    MOV DI, 200h         ; Dirección base para almacenar los caracteres

    read_loop:            ; Etiqueta para el inicio del bucle de lectura
        MOV AH, 00h       ; Función para leer un carácter del teclado
        INT 16h           ; Llamada a la interrupción del teclado
        CMP AL, 0Dh       ; Comparar AL con el código ASCII de Enter (13)
        JE end_read       ; Si es Enter, salimos del bucle
        STOSB             ; Guardar el carácter en [ES:DI] y incrementar DI
        JMP read_loop     ; Volver al inicio del bucle

    ;end_read:
RET


display_video:
    CALL clean_display

    MOV AH, 02h        ; Función para mover el cursor
    MOV BH, 00h        ; Página de video 0
    MOV DH, 10h        ; Fila 16
    MOV DL, 20h        ; Columna 32
    INT 10h            ; Llamada a la interrupción de video

    MOV AH, 09h ;Activar funcion 9
    MOV AL, 42h ;Caracter ASCII 'A'
    MOV BH, 00h ;Pagina 0
    ;MOV BL, 76h ;Fondo Blanco, frente(color texto) Verde (IRGB:0111 - IRGB: 0100)
    MOV BL, 01110010b
    MOV CX, 01h ;Repite 3 veces AL
    INT 10h
RET

clean_display:
    MOV AH, 06h        ; Función para desplazar la ventana hacia arriba
    MOV AL, 00h        ; Número de líneas a desplazar (00h limpia la pantalla)
    MOV BH, 1Fh        ; Atributos de color (por ejemplo, fondo azul, letra blanca)
    MOV CX, 0000h      ; Coordenadas del esquina superior izquierda (fila, columna)
    MOV DX, 184Fh      ; Coordenadas de la esquina inferior derecha (fila, columna)
    INT 10h            ; Llamada a la interrupción de video
RET

move_cursor:
    MOV AH, 02h        ; Función para mover el cursor
    MOV BH, 00h        ; Página de video 0
    MOV DH, 05h        ; Fila 5 (recuerda que comienza en 0)
    MOV DL, 10h        ; Columna 16 (recuerda que comienza en 0)
    INT 10h            ; Llamada a la interrupción de video
RET

read_and_display:
    MOV DI, 200h             ; Dirección base donde comenzar a guardar los caracteres
    MOV BH, 00h              ; Página de video 0
    MOV DH, 0h              ; Fila inicial para mostrar los caracteres
    MOV DL, 0h              ; Columna inicial para mostrar los caracteres

read_next_char:
    MOV AH, 00h              ; Función para leer un carácter del teclado
    INT 16h                  ; Llamada a la interrupción del teclado
    CMP AL, 0Dh              ; Comprobar si el carácter es Enter
    JE end_read              ; Si es Enter, termina la lectura
    CMP AL, 08h              ; Comprobar si el carácter es Backspace
    JE handle_backspace      ; Si es Backspace, manejar el borrado
    
    MOV [DI], AL             ; Guardar el carácter leído en la dirección actual de memoria
    INC DI                   ; Incrementar DI para el siguiente carácter

    MOV AH, 02h              ; Función para mover el cursor
    INT 10h                  ; Llamada a la interrupción de video para mover el cursor

    MOV AH, 09h              ; Función para escribir un carácter con atributos
    MOV BL, 07h              ; Atributos de color (por ejemplo, gris sobre negro)
    MOV CX, 01h              ; Repetir 1 vez el carácter AL
    INT 10h                  ; Llamada a la interrupción de video para mostrar el carácter

    INC DL                   ; Mover el cursor una columna a la derecha
    CMP DL, 80               ; Comprobar si el cursor ha llegado al final de la línea (80 columnas)
    JL skip_newline    ; Si no, salta el cambio de línea

    XOR DL, DL               ; Resetea la columna a 0
    INC DH                   ; Mover el cursor una fila hacia abajo

skip_newline:
    JMP read_next_char       ; Repetir para el próximo carácter

end_read:
    MOV AL, 0                ; Marcar el fin de la cadena con un carácter nulo
    MOV [DI], AL             ; Guardar el carácter nulo en memoria
    RET

handle_backspace:
    CMP DI, 200h             ; Comprobar si hay caracteres para borrar
    JE read_next_char        ; Si DI es 200h, no hay nada que borrar

    DEC DI                   ; Decrementar DI para borrar el último carácter en memoria
    DEC DL                   ; Mover el cursor una posición atrás en la pantalla

    MOV AH, 02h              ; Función para mover el cursor
    INT 10h                  ; Llamada a la interrupción de video para mover el cursor

    ; Colocar un espacio para borrar visualmente el carácter
    MOV AH, 09h              ; Función de teletipo para mostrar el carácter
    MOV AL, ' '              ; Espacio para borrar visualmente el carácter
    MOV BH, 00h              ; Página de video
    INT 10h                  ; Llamada a la interrupción de video


    JMP read_next_char       ; Continuar leyendo más caracteres



request_word_memory:
    MOV WORD[210h], 'V'
    MOV WORD[211h], 'R' 
    MOV WORD[212h], 'O' 
    MOV WORD[213h], 'D' 
    MOV WORD[214h], 'H' 
    MOV WORD[215h], 'I' 
RET

clean_memory:
    MOV DI, 200h
    MOV ECX, 0x030
    clear_loop:
        MOV DWORD[DI], 0x0000
        INC DI
        LOOP clear_loop
RET