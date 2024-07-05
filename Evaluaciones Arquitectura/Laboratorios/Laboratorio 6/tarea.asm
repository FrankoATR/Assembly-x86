ORG 100h

SECTION .data
    status_main_loop DB 1h
    color DB 10010010b
    pos_x DW 70d
    pos_y DW 90d
    dim_x DW 200d ;No utilizado por ser triangulo rectangulo cuadrado
    dim_y DW 100d


SECTION .text
    GLOBAL main

main:
    CALL video_mode_init
    CALL main_loop

INT 20h



video_mode_init:
    MOV  AH, 00H
    MOV AL, 12h
    INT 10h
RET


main_loop:
    CMP BYTE[status_main_loop], 0h
        JE return
    CALL clean_display
    CALL print_traingle
    CALL read_key

    JMP main_loop
RET


return:
RET


clean_display:
    MOV AH, 06h
    MOV AL, 00h
    MOV BH, 0h
    MOV CX, 0000h
    MOV DX, 184Fh
    INT 10h
RET



print_traingle:
    MOV AH, 0CH
    MOV AL, BYTE[color]
    MOV BH, 0h

    MOV DI, 0
    MOV DX, WORD[pos_y]   ;FILA
    CALL loop_row

RET

loop_row:
    CMP DI, WORD[dim_y]
        JE return
    
    MOV SI, 0
    MOV CX, WORD[pos_x]   ;COLUMNA
    CALL loop_column

    INC DI
    ADD DX, 1d
JMP loop_row

loop_column:
    CMP SI, DI
        JAE return

    INT 10h

    INC SI
    ADD CX, 1d
JMP loop_column





read_key:
    MOV AH, 00h
    INT 16h
    CMP AL, 'w'
        JE move_up
    CMP AL, 's'
        JE move_down
    CMP AL, 'a'
        JE move_left
    CMP AL, 'd'
        JE move_rigth
    CMP AL, 1Bh ;ESC
        JE end_main_loop
RET

end_main_loop:
    mov BYTE[status_main_loop], 0
RET

move_up:
    SUB WORD[pos_y], 4h
RET

move_down:
    ADD WORD[pos_y], 4h
RET

move_left:
    SUB WORD[pos_x], 4h
RET

move_rigth:
    ADD WORD[pos_x], 4h
RET