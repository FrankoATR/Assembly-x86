ORG 100h

SECTION .text

;direccionamiento inmediato
MOV AH, -5d
MOV AL, 4d

;multiplicar s/signo usa al o ax
IMUL AH

;mover resultado con direccionamiento a memoria
MOV BP, 200h
MOV [BP], AL


INT 20h