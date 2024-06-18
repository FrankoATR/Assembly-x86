ORG 100h

SECTION .text

MOV AX, 65279d ; Cargar 256 en AX, AH será 1 y AL será 0
MOV BL, 0FFh    ; Cargar 5 en BL, que es el registro divisor de 8 bits
DIV BL       ; Dividir AX por BL

XOR AX, AX
XOR BX, BX

MOV AH, 5d
MOV AL, 2d

main:
    CALL loop
    INT 20h

loop:
    CMP AH, AL
    JE message
    INC AL
    JMP loop
    RET


message:
    MOV byte[200h], 'M'
    MOV byte[201h], 'V'
    MOV byte[202h], 'L'
    MOV byte[203h], 'V'
