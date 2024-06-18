ORG 100h

SECTION .text

    XOR AX, AX
    XOR BX, BX
    XOR CX, CX
    XOR DX, DX

    MOV AX, 5d
    MOV BX, 13d

main:
    CALL addition
    CALL subrutine
INT 20h

subrutine:
    CMP AX, 20d
    JA end
    CALL addfive
    JMP subrutine

addition:
    ADD AX, BX
RET

addfive:
    ADD AX, 5
RET

end:
    MOV byte[200H], 'e'
    MOV byte[201H], 'n'
    MOV byte[202H], 'd'
RET
