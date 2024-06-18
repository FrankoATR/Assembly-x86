ORG 100h

SECTION .text

XOR EAX, EAX
XOR EBX, EBX
XOR ECX, ECX

MOV EAX, 1d ;Resultado Factorial
MOV EBX, 0d ;Contador
MOV ECX, 12d ;Limite Originalmente N

main:
    CALL product
INT 20h


product:
    CMP EBX, ECX
        JE mov_reg_fact

    INC EBX
    MUL EBX ;Contador por AL

    JMP product

mov_reg_fact:
    MOV [200h], EAX
RET
