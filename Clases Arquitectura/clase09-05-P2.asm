ORG 100h

SECTION .text

;direccionamiento inmediato
MOV AH, 5d
MOV AL, 4d

;comparacion
TEST1:
    CMP AH, AL
    JA SALTO1
    MOV BH, 03d

SALTO1:
    MOV AH, 2d
    JMP TEST1

INT 20h