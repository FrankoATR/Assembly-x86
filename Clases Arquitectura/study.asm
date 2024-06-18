ORG 100h

SECTION .text

GLOBAL main

main:
    CALL clear_vars
    CALL read_keyboard
    CALL calculate_div
    CALL print_result
INT 20h

clear_vars:
    XOR AX, AX
    XOR BX, BX
RET

def_vars:
    MOV AL, 15h
    MOV BL, 07h
RET

read_keyboard:
    MOV AH, 00h       ; Función para leer un carácter del teclado
    INT 16h           ; Llamada a la interrupción del teclado
    SUB AL, '0'       ; Convierte ASCII a número decimal (resta 48 o 0x30)
    MOV [200h], AL


    MOV AH, 00h       ; Función para leer un carácter del teclado
    INT 16h           ; Llamada a la interrupción del teclado
    SUB AL, '0'       ; Convierte ASCII a número decimal (resta 48 o 0x30)
    MOV [202h], AL
RET

calculate_div:
    MOV AX, [200h]
    MOV BL, [202h]
    DIV BL

    ADD AL, '0'       ; Convierte ASCII a número decimal (resta 48 o 0x30)
    MOV [206h], AL
RET

print_result:
    MOV AH, 06h        ; Función para desplazar la ventana hacia arriba
    MOV AL, 00h        ; Número de líneas a desplazar (00h limpia la pantalla)
    MOV BH, 1Fh        ; Atributos de color (por ejemplo, fondo azul, letra blanca)
    MOV CX, 0000h      ; Coordenadas del esquina superior izquierda (fila, columna)
    MOV DX, 184Fh      ; Coordenadas de la esquina inferior derecha (fila, columna)
    INT 10h            ; Llamada a la interrupción de video

    MOV AH, 02h        ; Función para mover el cursor
    MOV BH, 00h        ; Página de video 0
    MOV DH, 00h        ; Fila 0
    MOV DL, 00h        ; Columna 0
    INT 10h            ; Llamada a la interrupción de video

    MOV AH, 09H
    MOV AL, [206h]
    MOV BH, 00H
    MOV BL, 72H
    MOV CX, 01H
    INT 10H
RET


