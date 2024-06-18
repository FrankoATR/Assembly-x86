ORG 100h

SECTION .text

XOR AX, AX
XOR BX, BX
XOR CX, CX
XOR DX, DX

main:
    MOV AH, 10d
    MOV BH, 7d

    MOV AL, BH
    ADD AL, AH

    CALL salto1
    MOV [200h], AL

INT 20h



salto1:
    CMP AL, BH
        JB salto2
    SUB AL, 3d    
    JMP salto1
    
salto2:
    RET