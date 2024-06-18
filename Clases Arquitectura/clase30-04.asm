org 100h
section .text

;usando registros
    MOV AL, 7d
    MOV BL, 11d
    SUB BL, AL
    MOV AX, 2d
    MOV BX, 0FFFFh
    ADD BX, AX
    
    MOV [030Fh], AL
    MOV [031Fh], BX




