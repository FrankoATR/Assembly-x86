ORG 100h

SECTION .text

inmediato:
    MOV AH, 0d
    MOV AL, 1d
    MOV BH, 8d
    MOV BL, 2d
    MOV CH, 4d
    MOV CL, 6d

por_registro:
    MOV DX, AX
    MOV AX, CX

absoluto:
    MOV [200h], AH
    MOV [201h], AL

    MOV [202h], DH

    MOV [203h], DH
    MOV [204h], DH

    MOV [205h], BH
    MOV [206h], BL
    MOV [207h], DL

    MOV [208h], DH
    MOV [209h], DH

indirecto:
    MOV BP, 200h
    MOV DH, [BP]
    
    MOV BP, 201h
    MOV DL, [BP]

    MOV BP, 209h
    MOV AL, [BP]

absoluto2:
    MOV [200h], AL
    MOV [201h], AL

    MOV [203h], DH
    MOV [204h], DL




INT 20h