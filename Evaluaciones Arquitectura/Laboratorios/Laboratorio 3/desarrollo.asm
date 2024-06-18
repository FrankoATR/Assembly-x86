ORG 100h

SECTION .text

inmediato:
    MOV AH, 12d
    MOV AL, 0FFh
    MOV BH, 10010b
    MOV BL, "A"

por_registro:
    MOV CX, AX
    MOV DX, BX

;LIMPIAR
XOR AX, AX
XOR BX, BX

absoluto:
    ;RESGISTRO->DIRECCION DE MEMORIA
    ;DIRECCION->REGISTRO
    MOV [200h], CH
    MOV AH, [200h]

    ;16 bits
    MOV [210h], DX
    MOV BX, [210h]

indirecto:
    MOV BP, 200h
    MOV AL, [BP]



INT 20h