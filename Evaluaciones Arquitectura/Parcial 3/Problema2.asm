org   100h

section .data
titulo db 'Parcial final de arquitectura.'
varOp1 db 'Para mostrar el triangulo presione 1.'
varOp2 db 'Para mostrar la figura presione 2.'
varOp3 db 'Para salir presione 3.'
myInfo db 'Francisco Alonso Torres Rosa - 00046821.'

status_main_loop DB 1h  ;Variable para mantener el bucle activo miestras sea 1
color DB 10010010b  ;Variable para establecer el color de las figuras
pos_x DW 300d   ;Variable para establecer la posicion en x
pos_y DW 200d   ;Variable para establece la posicion en y
dim_y DW 100d   ;Variable para establecee las dimensiones en y de la figura
dim_x DW 100d   ;Variable para establecee las dimensiones en x de la figura
auxCountLeft DW 0d  ;Contador auxiliar para dibujar triangulo izquierdo
auxCountRight DW 0d ;Contador auxiliar para dibujar triangulo derecho

section .text

main:

    CALL main_loop    ;Llamada al bucle principal

INT 20h


main_loop:
    CMP BYTE[status_main_loop], 0h   ;Si la variable es igual a 0 el bucle termina
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



;-----------------------------------------FIGURES-------------------------------------------------
video_mode_init:
    MOV  AH, 00H  
    MOV AL, 12h ;Inicializar modo video
    INT 10h
RET


print_triangle:    ;Funcion principal que llama los metodos para imprimir un triangulo
    MOV AH, 0CH
    MOV AL, BYTE[color]    ;Establecemos el color para cada uno de los pixeles
    MOV BH, 0h

    MOV DI, 0     
    MOV DX, WORD[pos_y]   ;Establecemos la fila inicial en donde se comenzará a imprimir pixeles
    CALL loop_row

RET

loop_row:
    CMP DI, WORD[dim_y]     ;Cuando contador DI sea igual al tamaño establecido en la dimension y para la figura entonces sale del bucle termiando el dibujo del triangulo
        JE return
    

    MOV CX, WORD[pos_x]   ;Establecemos la columna inicial en donde se comenzará a imprimir pixeles
    INT 10h

    MOV WORD[auxCountLeft], CX    ;Incrementamos el contador auxiliar que ayuda a colocar pixeles hacia la izquierda de la linea que usamos cómo pivote para el triangulo isosceles
    MOV WORD[auxCountRight], CX   ;Incrementamos el contador auxiliar que ayuda a colocar pixeles hacia la derecha de la linea que usamos cómo pivote para el triangulo isosceles

    MOV SI, 0
    CALL loop_column     ;Para cada fila, dibujamos sus respectivas columnas

    INC DI        ;Incrementamos el contador para que a la siguiente fila se dibujen 1 pixel extra a cada lado del pivote.
    ADD DX, 1d    ;Incrementamos el contador para pasar a la siguiente fila
JMP loop_row

loop_column:
    CMP SI, DI     ;Cuando SI alcancé el valor DI significa que se han dibujado la cantidad necesaria de pixeles tanto a la izquierda cómo a la derecha, pasanadose a la siguiente fila
        JAE return


    MOV CX, WORD[auxCountRight]     ;Establecemos la coordenada en X para el pixel de la derecha
    INT 10h

    MOV CX, WORD[auxCountLeft]      ;Establecemos la coordenada en X para el pixel de la izquierda
    INT 10h

    INC WORD[auxCountRight]         ;Incrementamos la coordenada en X para el pixel de la derecha
    DEC WORD[auxCountLeft]          ;Decrementamos la coordenada en X para el pixel de la izquierda
    INC SI

JMP loop_column





print_quad:     ;Funcion principal que llama los metodos para imprimir un rectangulo
    MOV AH, 0CH
    MOV AL, BYTE[color]   ;Establecemos el color para cada uno de los pixeles
    MOV BH, 0h

    MOV DI, 0
    MOV DX, WORD[pos_y]   ;Establecemos la fila inicial en donde se comenzará a imprimir pixeles
    CALL quad_loop_row    

RET

quad_loop_row:
    CMP DI, WORD[dim_y]     ;Cuando DI alcancé el valor de dim_y significa que se han dibujado todas las filas establecidas cómo dimension de y del rectangulo
        JE return
    
    MOV SI, 0
    MOV CX, WORD[pos_x]   ;Establecemos la columna inicial en donde se comenzará a imprimir pixeles
    CALL quad_loop_column   ;Para cada una de las filas mandamos a llamar sus columnas

    INC DI        ;Incrementa en 1 el numero de filas que ha dibujado
    ADD DX, 1d    ;Incrementa en 1 la coordenada en y de la fila a dibujar
JMP quad_loop_row

quad_loop_column:
    CMP SI, WORD[dim_x]     ;Cuando SI sea igual a dim_X significa que ya alcanzó su dimension en x establecida terminando de dibujar las columnas para esa fila
        JE return

    INT 10h

    INC SI         ;Incrementa en 1 el numero de columnas que ha dibujado
    ADD CX, 1d     ;Icrementa en 1 la coordenada en X de la columna a dibujar
JMP quad_loop_column



;-------------------------------------------------INPUT---------------------------------------------------
read_key:     ;Funcion para esperar que se ingrese alguna opcion por teclado
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
    CALL video_mode_init
    
    ;Definicion de variables para el triangulo
    MOV WORD[color], 00010010b
    MOV WORD[pos_x], 200d
    MOV WORD[pos_y], 50d
    MOV WORD[dim_y], 50d
    CALL print_triangle

    ;Esperar hasta que se presione la tecla s para continuar con el programa.
    MOV AH, 00h
    INT 16h
    CMP AL, 's'
    JNE opcion1
RET


opcion2:



RET


opcion3:
    mov BYTE[status_main_loop], 0   ;establece la variable para terminar el bucle en 0, finalizando el programa
RET



return:   ;Funcion para simular el return ya que no puedo ponerlo al lado de un coomparador xd
RET