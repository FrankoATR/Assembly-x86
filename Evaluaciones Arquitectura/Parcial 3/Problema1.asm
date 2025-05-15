org   100h

section .data
titulo db 'Parcial final de arquitectura.'
varOp1 db 'Para mostrar el triangulo presione 1.'
varOp2 db 'Para mostrar la figura presione 2.'
varOp3 db 'Para salir presione 3.'
myInfo db 'Francisco Alonso Torres Rosa - 00046821.'

select1 db 'Ingresaste la opcion del triangulo.'
select2 db 'Ingresaste la opcion de la figura.'
exitText db 'Seleccionaste Salir del programa.'

status_main_loop DB 1h  ;Variable para mantener el bucle activo miestras sea 1


section .text

main:

    CALL main_loop    ;Llamada al bucle principal

INT 20h


main_loop:
    CMP BYTE[status_main_loop], 0h
        JE return


    CALL IniciarModoTexto
    
    MOV BH, 0d ; Establece la página 0

    MOV DH, 10 ; Fila
    MOV DL, 25 ; Columna
    CALL MoverCursor
    MOV SI, 0 ;Declaramos contador en SI
    CALL display_text1  ;Imprimir texto1

    MOV DH, 0 ; Fila
    MOV DL, 0 ; Columna
    CALL MoverCursor
    MOV SI, 0 ;Declaramos contador en SI
    CALL display_text2  ;Imprimir texto2

    MOV DH, 1 ; Fila
    MOV DL, 0 ; Columna
    CALL MoverCursor
    MOV SI, 0 ;Declaramos contador en SI
    CALL display_text3   ;Imprimir texto3

    MOV DH, 2 ; Fila
    MOV DL, 0 ; Columna
    CALL MoverCursor
    MOV SI, 0 ;Declaramos contador en SI
    CALL display_text4   ;Imprimir texto4

    MOV DH, 20 ; Fila
    MOV DL, 20 ; Columna
    CALL MoverCursor
    MOV SI, 0 ;Declaramos contador en SI
    CALL display_text5   ;Imprimir texto5


    CALL read_key   ;Espera que se ingrese por teclado una opcion

    JMP main_loop

RET



;-----------------------------------------TEXT-------------------------------------------------

IniciarModoTexto:
    MOV AH, 0h
    MOV AL, 03h ; Establece modo texto 80x25   - 16 colores y 8 paginas
    int 10h ; Llama a la interrupción del BIOS para cambiar el modo texto
RET



MoverCursor:
    MOV AH, 02h
    int 10h ; Llama a la interrupción del BIOS para posicionar el cursor
RET

move_cursor1:
    MOV AH, 02h  ;Función para mover el cursor
    INC DL
    INT 10h 
    
    JMP display_text1
RET

display_text1:

    MOV BL, 10000111b
    MOV AH, 09h              ;Función para escribir un carácter con atributos
    MOV AL, [titulo + SI]    ;Dirección base donde comenzar a guardar los caracteres
    INC SI
    MOV CX, 01h              ;Repetir 1 vez el carácter AL
    INT 10h                  ;Llamada a la interrupción de video para mostrar el carácter
    
    CMP AL, '.'     ;Cuando ecuentra un . en la cadena deja de leer la memoria e imprimir y termina el bucle
    JE return

    JMP move_cursor1
RET


move_cursor2:
    MOV AH, 02h ;Función para mover el cursor
    INC DL
    INT 10h 
    
    JMP display_text2
RET

display_text2:

    MOV BL, 00000010b
    MOV AH, 09h              ;Función para escribir un carácter con atributos
    MOV AL, [varOp1 + SI]    ;Dirección base donde comenzar a guardar los caracteres
    INC SI
    MOV CX, 01h              ;Repetir 1 vez el carácter AL
    INT 10h                  ;Llamada a la interrupción de video para mostrar el carácter
    
    CMP AL, '.'     ;Cuando ecuentra un . en la cadena deja de leer la memoria e imprimir y termina el bucle
    JE return

    JMP move_cursor2
RET



move_cursor3:
    MOV AH, 02h ;Función para mover el cursor
    INC DL
    INT 10h 
    
    JMP display_text3
RET

display_text3:

    MOV BL, 00000010b
    MOV AH, 09h              ;Función para escribir un carácter con atributos
    MOV AL, [varOp2 + SI]    ;Dirección base donde comenzar a guardar los caracteres
    INC SI
    MOV CX, 01h              ;Repetir 1 vez el carácter AL
    INT 10h                  ;Llamada a la interrupción de video para mostrar el carácter
    
    CMP AL, '.'     ;Cuando ecuentra un . en la cadena deja de leer la memoria e imprimir y termina el bucle
    JE return

    JMP move_cursor3
RET



move_cursor4:
    MOV AH, 02h ;Función para mover el cursor
    INC DL
    INT 10h 
    
    JMP display_text4
RET

display_text4:

    MOV BL, 00000010b
    MOV AH, 09h              ;Función para escribir un carácter con atributos
    MOV AL, [varOp3 + SI]    ; Dirección base donde comenzar a guardar los caracteres
    INC SI
    MOV CX, 01h              ;Repetir 1 vez el carácter AL
    INT 10h                  ;Llamada a la interrupción de video para mostrar el carácter
    
    CMP AL, '.'     ;Cuando ecuentra un . en la cadena deja de leer la memoria e imprimir y termina el bucle
    JE return

    JMP move_cursor4
RET




move_cursor5:
    MOV AH, 02h ;Función para mover el cursor
    INC DL
    INT 10h 
    
    JMP display_text5
RET

display_text5:

    MOV BL, 00000010b
    MOV AH, 09h              ;Función para escribir un carácter con atributos
    MOV AL, [myInfo + SI]    ; Dirección base donde comenzar a guardar los caracteres
    INC SI
    MOV CX, 01h              ;Repetir 1 vez el carácter AL
    INT 10h                  ;Llamada a la interrupción de video para mostrar el carácter
    
    CMP AL, '.'     ;Cuando ecuentra un . en la cadena deja de leer la memoria e imprimir y termina el bucle
    JE return

    JMP move_cursor5
RET



move_cursor6:
    MOV AH, 02h ;Función para mover el cursor
    INC DL
    INT 10h 
    
    JMP display_text6
RET

display_text6:

    MOV BL, 00000010b
    MOV AH, 09h              ;Función para escribir un carácter con atributos
    MOV AL, [select1 + SI]    ; Dirección base donde comenzar a guardar los caracteres
    INC SI
    MOV CX, 01h              ;Repetir 1 vez el carácter AL
    INT 10h                  ;Llamada a la interrupción de video para mostrar el carácter
    
    CMP AL, '.'     ;Cuando ecuentra un . en la cadena deja de leer la memoria e imprimir y termina el bucle
    JE return

    JMP move_cursor6
RET





move_cursor7:
    MOV AH, 02h ;Función para mover el cursor
    INC DL
    INT 10h 
    
    JMP display_text7
RET

display_text7:

    MOV BL, 00000010b
    MOV AH, 09h              ;Función para escribir un carácter con atributos
    MOV AL, [select2 + SI]    ; Dirección base donde comenzar a guardar los caracteres
    INC SI
    MOV CX, 01h              ;Repetir 1 vez el carácter AL
    INT 10h                  ;Llamada a la interrupción de video para mostrar el carácter
    
    CMP AL, '.'     ;Cuando ecuentra un . en la cadena deja de leer la memoria e imprimir y termina el bucle
    JE return

    JMP move_cursor7
RET




move_cursor8:
    MOV AH, 02h ;Función para mover el cursor
    INC DL
    INT 10h 
    
    JMP display_text8
RET

display_text8:

    MOV BL, 00000010b
    MOV AH, 09h              ;Función para escribir un carácter con atributos
    MOV AL, [exitText + SI]    ; Dirección base donde comenzar a guardar los caracteres
    INC SI
    MOV CX, 01h              ;Repetir 1 vez el carácter AL
    INT 10h                  ;Llamada a la interrupción de video para mostrar el carácter
    
    CMP AL, '.'     ;Cuando ecuentra un . en la cadena deja de leer la memoria e imprimir y termina el bucle
    JE return

    JMP move_cursor8
RET



read_key:
    MOV AH, 00h
    INT 16h
    CMP AL, '1'
        JE opcion1
    CMP AL, '2'
        JE opcion2
    CMP AL, '3'
        JE opcion3
RET


opcion1:
    
    MOV DH, 10 ; Fila
    MOV DL, 25 ; Columna
    CALL MoverCursor
    MOV SI, 0 ;Declaramos contador en SI
    CALL display_text6  ;Imprimir texto6

    MOV AH, 00h
    INT 16h

RET


opcion2:

    MOV DH, 10 ; Fila
    MOV DL, 25 ; Columna
    CALL MoverCursor
    MOV SI, 0 ;Declaramos contador en SI
    CALL display_text7  ;Imprimir texto7

    MOV AH, 00h
    INT 16h
RET


opcion3:
    mov BYTE[status_main_loop], 0   ;establece la variable para terminar el bucle en 0, finalizando el programa

    MOV DH, 10 ; Fila
    MOV DL, 25 ; Columna
    CALL MoverCursor
    MOV SI, 0 ;Declaramos contador en SI
    CALL display_text8  ;Imprimir texto8
RET



return:   ;Funcion para simular el return ya que no puedo ponerlo al lado de un coomparador xd
RET