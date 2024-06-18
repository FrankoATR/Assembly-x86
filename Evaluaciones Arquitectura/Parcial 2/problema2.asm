org 100h

section .data
    ONE dd 1
    TWO dd 2

section .text
    XOR AX,AX
    XOR BX,BX

GLOBAL main

main:
    CALL clean_regs
    MOV AX, [0200h] ;Lecturas por debug
    MOV BX, [0210h] ;Lecturas por debug
    MOV DI, 0220h ;Direccion donde comienza a guardar
    CALL division
INT 20h

clean_regs:
    XOR AX, AX
    XOR BX, BX
    XOR CX, CX
    XOR DX, DX
RET

division:
    DIV BX
    MOV [DI], AL ;Mover Resultado de DIV a Direccion de memoria
    INC DI ;Incrementa 2 veces por ser 16 bits
    INC DI
    CMP AL, [210h] ; Compara EL resultado de la division con [210h] que es segundo numero
    JG division
    JMP end ;Fin de ejecucion



end:
    MOV word[0250h], 'F'
    MOV word[0251h], 'I'
    MOV word[0252h], 'N'
RET