ORG 100h

SECTION .text

GLOBAL main

main:
    CALL display_text
    
INT 20h

display_text:
    
    MOV AH, 06h        ; Función para desplazar la ventana hacia arriba
    MOV AL, 00h        ; Número de líneas a desplazar (00h limpia la pantalla)
    MOV BH, 1Fh        ; Atributos de color (por ejemplo, fondo azul, letra blanca)
    MOV CX, 0000h      ; Coordenadas del esquina superior izquierda (fila, columna)
    MOV DX, 184Fh      ; Coordenadas de la esquina inferior derecha (fila, columna)
    INT 10h            ; Llamada a la interrupción de video
    
    
    MOV AH, 02h        ; Función para mover el cursor
    MOV BH, 00h        ; Página de video 0
    MOV DH, 00h        ; Fila 0
    MOV DL, 00h        ; Columna 1
    INT 10h            ; Llamada a la interrupción de video

    
    MOV AH, 09H
    MOV AL, 41H  ; ASCII para 'A'
    MOV BH, 00H
    MOV BL, 72H
    MOV CX, 01H
    INT 10H

    MOV AH, 02h        ; Función para mover el cursor
    MOV BH, 00h        ; Página de video 0
    MOV DH, 00h        ; Fila 0
    MOV DL, 01h        ; Columna 1
    INT 10h            ; Llamada a la interrupción de video

    MOV AH, 09H
    MOV AL, 42H  ; ASCII para 'B'
    MOV BH, 00H
    MOV BL, 72H
    MOV CX, 01H
    INT 10H

    MOV AH, 02h        ; Función para mover el cursor
    MOV BH, 00h        ; Página de video 0
    MOV DH, 00h        ; Fila 0
    MOV DL, 02h        ; Columna 2
    INT 10h            ; Llamada a la interrupción de video

    MOV AH, 09H
    MOV AL, 43H  ; ASCII para 'C'
    MOV BH, 00H
    MOV BL, 72H
    MOV CX, 01H
    INT 10H

RET