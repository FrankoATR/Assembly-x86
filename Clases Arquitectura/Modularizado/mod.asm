ORG 100h

SECTION .text

GLOBAL main

main:
    CALL clean_regs
    CALL clean_memory ;[200h-230h[
    CALL vars_def
    CALL fac_N
    CALL fac_K
    CALL fac_NK
    CALL _equation
INT 20h

return:
RET

fac_N:
    CALL clean_regs
    MOV ECX, DWORD[200h] ;Limite Originalmente N
    CALL factorial
    MOV [210h], EAX
RET


fac_K:
    CALL clean_regs
    MOV ECX, DWORD[204h] ;Limite Originalmente K
    CALL factorial
    MOV DWORD[214h], EAX
RET


fac_NK:
    CALL clean_regs
    MOV ECX, DWORD[200h] 
    MOV EDX, DWORD[204h] 
    SUB ECX, EDX  ; N - K
    CALL factorial
    MOV DWORD[218h], EAX
RET

_equation:
    MOV EAX, DWORD[210h]
    DIV DWORD[214h]
    DIV DWORD[218h]
    MOV DWORD[220h], EAX
RET

factorial:
    CMP BL, CL
        JE return
    INC EBX
    MUL EBX ;Contador por EAL
    JMP factorial

clean_regs:
    XOR EAX, EAX
    XOR EBX, EBX
    XOR ECX, ECX
    XOR EDX, EDX
    MOV EAX, 1d ;factorial Inicial
    MOV EBX, 0d ;Contador
RET

clean_memory:
    MOV DI, 200h
    MOV ECX, 0x030
    clear_loop:
        MOV DWORD[DI], 0x0000
        INC DI
        LOOP clear_loop
RET

vars_def:
    MOV DWORD CS:[200h], 0x0006 ;N
    MOV DWORD DS:[204h], 0x0004 ;K
RET