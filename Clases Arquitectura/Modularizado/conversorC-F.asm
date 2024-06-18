ORG 100h

SECTION .text

GLOBAL main

main:
    CALL clean_regs
    CALL clean_memory ;[200h-230h[
    CALL vars_def
    CALL equation
INT 20h

equation:
    MOV EAX, DWORD[200h]
    MOV EBX, 9d
    MOV ECX, 5d
    MUL EBX
    DIV ECX
    ADD EAX, 32d
    
    MOV DWORD CS:[210h], EAX
RET

clean_regs:
    XOR EAX, EAX
    XOR EBX, EBX
    XOR ECX, ECX
    XOR EDX, EDX
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
    MOV DWORD CS:[200h], 0x0000 ; C=25
RET