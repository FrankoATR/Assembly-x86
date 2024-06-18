ORG 100h

SECTION .text

GLOBAL main

main:
    CALL var_def
    CALL subtrac_func
    CALL if_result_less_7
INT 20h

var_def:
    MOV AX, 10d ;Direccionamiento inmediato
    MOV BX, 4h ;Direccionamiento inmediato
    MOV CX, AX ;Direccionamiento por registro
RET

subtrac_func:
    SUB CX, BX ;Resta de 2 datos
    MOV DI, 210h ;Direccionamiento indirecto
    MOV CS:[DI], CX ;Direccionamiento indirecto
RET

if_result_less_7:
    CMP CX, 7d
        JNAE move_220 ;Si no es mayor ni igual   !(CX >= 7)  -> CX < 6
RET

move_220:
    MOV WORD[220h], 'f'  ;Cargar palabra fin
    MOV WORD[221h], 'i'
    MOV WORD[222h], 'n'
RET