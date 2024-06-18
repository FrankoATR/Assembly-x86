org   100h

section .data
msgMayor db 'El digito es mayor que 5$'
msgMenor db 'El digito es menor que 5$'
msgIgual db 'El digito es igual a 5$'
msgFin db 'Fin del programa$'

section .text

main:
    CALL IniciarModoTexto
    
    MOV BH, 0d ; Establece la página 0
    CALL CentrarCursor
    
    CALL CompararNumero
    
    CALL EsperarTecla
    
    CALL CambiarPagina
    
    MOV BH, 1d ; Cambia a la página 1
    CALL CentrarCursor
    
    CALL ImprimirFin
    
    CALL EsperarTecla
    
INT 20h


IniciarModoTexto:
    MOV AH, 0h
    MOV AL, 03h ; Establece modo texto 80x25   - 16 colores y 8 paginas
    int 10h ; Llama a la interrupción del BIOS para cambiar el modo texto
RET


CentrarCursor:
    MOV AH, 02h
    MOV DH, 10 ; Fila central
    MOV DL, 25 ; Columna central
    int 10h ; Llama a la interrupción del BIOS para posicionar el cursor
RET


CambiarPagina:
    MOV AH, 05h
    MOV AL, 01H ; Cambia a la página 1
    INT 10h
RET


CompararNumero:
    MOV AL, 5d
    CMP AL, 5
    JA mayor
    JB menor
    JE igual
RET


EsperarTecla:
    MOV AH, 00h
    INT 16h
RET


mayor:
    MOV AH, 09h
    MOV DX, msgMayor
    INT 21h
RET


menor:
    MOV AH, 09h
    MOV DX, msgMenor
    INT 21h
RET


igual:
    MOV AH, 09h
    MOV DX, msgIgual
    INT 21h
RET


ImprimirFin:
    MOV AH, 09h
    MOV DX, msgFin
    INT 21h
RET