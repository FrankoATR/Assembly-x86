org 100h

section .data
    ONE dd 1
    TWO dd 2

section .text
    XOR AX,AX
    XOR BX,BX

GLOBAL main

main:
    CALL clean_memory

    MOV DI, 203h             ; Dirección base donde comenzar
    CALL read_num
    

    MOV DI, 213h             ; Dirección base donde comenzar 
    CALL read_num

    MOV DI, 220h             ; Dirección base donde comenzar
    CALL read_option



INT 20h

read_num:
    MOV AH, 00h              ; Función para leer un carácter del teclado
    INT 16h                  ; Llamada a la interrupción del teclado
    SUB AL, '0'       ; Convierte ASCII a número decimal (resta 48 o 0x30)
    MOV [DI], AL             ; Guardar el carácter leído en la dirección actual de memoria

RET

read_option:
    MOV AH, 00h              ; Función para leer un carácter del teclado
    INT 16h                  ; Llamada a la interrupción del teclado
    SUB AL, '0'       ; Convierte ASCII a número decimal (resta 48 o 0x30)

    MOV [DI], AL             ; Guardar el carácter leído en la dirección actual de memoria

    CMP AL, 01h             
        JE calculus_division
    CMP AL, 02h              
        JE calculus_sum
    
    JNE error

RET

calculus_division:
    MOV EAX, DWORD[200h] ;
    MOV EBX, DWORD[210h] ;  

    fld dword[EAX]
    fld dword[EBX]
    FDIV
    fstp dword[230h]
RET


calculus_sum:
    MOV EAX, DWORD[200h] ;
    MOV EBX, DWORD[210h] ;   

    ADD EAX, EBX
    MOV [240h], EAX
RET

error:
    MOV byte[250h], "o"
    MOV byte[251h], "p"
    MOV byte[252h], "c"
    MOV byte[253h], "i"
    MOV byte[254h], "o"
    MOV byte[255h], "n"
    MOV byte[256h], " "
    MOV byte[257h], "i"
    MOV byte[258h], "n"
    MOV byte[259h], "c"
    MOV byte[25Ah], "o"
    MOV byte[25Bh], "r"
    MOV byte[25Ch], "r"
    MOV byte[25Dh], "e"
    MOV byte[25Eh], "c"
    MOV byte[25Fh], "t" 
    MOV byte[260h], "o"
    
RET


clean_memory:
    MOV DI, 200h
    MOV ECX, 0x100
    clear_loop:
        MOV DWORD[DI], 0x0000
        INC DI
        LOOP clear_loop
RET