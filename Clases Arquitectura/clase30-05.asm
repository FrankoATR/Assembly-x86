ORG 100h

SECTION .text

GLOBAL main

main:

    CALL display_figure_cian

INT 20h

display_textvideo_mode:
    MOV AH, 0Eh
    MOV AL, 41h
    MOV BH, 00h
    MOV BL, 05h
    INT 10h
RET

display_another_part:
    MOV AH, 02h
RET

display_movement_cian:
    MOV AH, 06h ;Mover pantalla hacia arriba  ;07 es hacia abajo
    MOV AL, 01h ;Cantidad de filas a mover
    MOV BH, 30h ;Color de fila
    MOV CX, 00h ;X1 ** - Y1 **
    MOV DX, 184Fh ;X2 ** - Y2 **
    INT 10h
RET

display_figure_cian:
    MOV AH, 06h
    MOV AL, 18h
    MOV BH, 28h
    MOV CX, 0000h
    MOV DX, 184Fh
    INT 10h
    
    MOV AH, 06h
    MOV AL, 06h
    MOV BH, 30h
    MOV CX, 0A1Ch
    MOV DX, 0F34h
    INT 10h
RET