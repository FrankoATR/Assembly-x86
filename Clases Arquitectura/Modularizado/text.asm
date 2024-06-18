ORG 100h

SECTION .text

main:
    CALL clean_regs
    JMP etiqueta
    CALL clean_memory
    CALL vars_def
    CALL factorial
INT 20h

factorial:
    CMP EBX, ECX
        JE return

    INC EBX
    MUL EBX ;Contador por AL

    JMP factorial

return:
RET

mov_reg_fact:
    MOV [200h], EAX
RET

etiqueta:
    mov ax, 8d
RET

clean_regs:
    XOR EAX, EAX
    XOR EBX, EBX
    XOR ECX, ECX
    XOR EDX, EDX
RET

clean_memory:
    
RET

vars_def:
    MOV EAX, 1d ;Resultado Factorial
    MOV EBX, 0d ;Contador
    MOV ECX, 12d ;Limite Originalmente N
RET