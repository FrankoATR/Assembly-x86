ORG 100h

SECTION .text

GLOBAL main

main:
    CALL vars_def
    CALL product
INT 20h

vars_def:
    MOV WORD[200h], 0BCh ;Registro inicialmente en 220h
    MOV AX, WORD[200h] ;Direccionamiento absoluto 
    MOV DX, 2d ;Almacenar el 2d para la multiplicacion con AX
RET

product:
    CMP AX, 0FFFFh ;Comparacion con FFFF
        JA mov_result ; Si es mayor  AX > FFFFF
    MUL DX ; AX por DX -> AX por 2

    JMP product

RET

mov_result:
    MOV [210h], AX  ;Este resultado al no ocurrira por tener overflow al hacer 178h por 2h
RET