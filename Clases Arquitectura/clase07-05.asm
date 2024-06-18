ORG 100h

SECTION .text

;guardar en 0200h -> DD


MOV byte[0200h], 0DDh

;guardar en registro base el numero de la direccion
MOV BX, 0200h

;direccionar al registro AL lo que hay en 0200h, de manera indirecta
MOV AL, [BX]

;direccionamiento inmediato
MOV AH, 0FFh ;255d
MOV BL, 10d

;direccionamiento x registro
MOV BH, AH

;suma sin tomar en cuenta el acarreo
ADD AH, BL

;suma sí tome en cuenta el acarreo
ADC AH, BL

;resta sin tomar en cuenta el acarreo
SUB BH, AH


int 20h