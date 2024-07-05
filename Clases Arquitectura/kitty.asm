ORG 100h

SECTION .data
    status_main_loop DB 1h
    color DB 10010010b
    pos_x DW 300d
    pos_y DW 200d
    dim_y DW 100d
    dim_x DW 100d
    auxCountLeft DW 0d
    auxCountRight DW 0d



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

    ;Orejas
    MOV WORD[color], 00010010b
    MOV WORD[pos_x], 200d
    MOV WORD[pos_y], 50d
    MOV WORD[dim_y], 50d
    CALL print_triangle

    MOV WORD[color], 00010010b
    MOV WORD[pos_x], 300d
    MOV WORD[pos_y], 50d
    MOV WORD[dim_y], 50d
    CALL print_triangle

    ;Cara
    MOV WORD[color], 00010110b
    MOV WORD[pos_x], 150d
    MOV WORD[pos_y], 100d
    MOV WORD[dim_y], 150d
    MOV WORD[dim_x], 200d
    CALL print_quad

    ;Ojos
    MOV WORD[color], 00010111b
    MOV WORD[pos_x], 160d
    MOV WORD[pos_y], 130d
    MOV WORD[dim_y], 5d
    MOV WORD[dim_x], 60d
    CALL print_quad

    MOV WORD[color], 00010111b
    MOV WORD[pos_x], 280d
    MOV WORD[pos_y], 130d
    MOV WORD[dim_y], 5d
    MOV WORD[dim_x], 60d
    CALL print_quad


    ;Bigotes
    MOV WORD[color], 00010101b
    MOV WORD[pos_x], 75d
    MOV WORD[pos_y], 175d
    MOV WORD[dim_y], 1d
    MOV WORD[dim_x], 125d
    CALL print_quad

    MOV WORD[color], 00010101b
    MOV WORD[pos_x], 75d
    MOV WORD[pos_y], 185d
    MOV WORD[dim_y], 1d
    MOV WORD[dim_x], 125d
    CALL print_quad

    MOV WORD[color], 00010101b
    MOV WORD[pos_x], 75d
    MOV WORD[pos_y], 195d
    MOV WORD[dim_y], 1d
    MOV WORD[dim_x], 125d
    CALL print_quad

    MOV WORD[color], 00010101b
    MOV WORD[pos_x], 300d
    MOV WORD[pos_y], 175d
    MOV WORD[dim_y], 1d
    MOV WORD[dim_x], 125d
    CALL print_quad

    MOV WORD[color], 00010101b
    MOV WORD[pos_x], 300d
    MOV WORD[pos_y], 185d
    MOV WORD[dim_y], 1d
    MOV WORD[dim_x], 125d
    CALL print_quad

    MOV WORD[color], 00010101b
    MOV WORD[pos_x], 300d
    MOV WORD[pos_y], 195d
    MOV WORD[dim_y], 1d
    MOV WORD[dim_x], 125d
    CALL print_quad

    ;Boca
    MOV WORD[color], 00010111b
    MOV WORD[pos_x], 250d
    MOV WORD[pos_y], 175d
    MOV WORD[dim_y], 20d
    CALL print_triangle


    ;Cara Fixed
    MOV WORD[color], 00010000b
    MOV WORD[pos_x], 150d
    MOV WORD[pos_y], 200d
    MOV WORD[dim_y], 50d
    CALL print_triangle

    ;Cara Fixed
    MOV WORD[color], 00010000b
    MOV WORD[pos_x], 350d
    MOV WORD[pos_y], 200d
    MOV WORD[dim_y], 50d
    CALL print_triangle

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




print_triangle:
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
    

    MOV CX, WORD[pos_x]   ;COLUMNA
    INT 10h

    MOV WORD[auxCountLeft], CX
    MOV WORD[auxCountRight], CX

    MOV SI, 0
    CALL loop_column

    INC DI
    ADD DX, 1d
JMP loop_row

loop_column:
    CMP SI, DI
        JAE return


    MOV CX, WORD[auxCountRight]
    INT 10h

    MOV CX, WORD[auxCountLeft]
    INT 10h

    INC WORD[auxCountRight]
    DEC WORD[auxCountLeft]
    INC SI

JMP loop_column





print_quad:
    MOV AH, 0CH
    MOV AL, BYTE[color]
    MOV BH, 0h

    MOV DI, 0
    MOV DX, WORD[pos_y]   ;FILA
    CALL quad_loop_row

RET

quad_loop_row:
    CMP DI, WORD[dim_y]
        JE return
    
    MOV SI, 0
    MOV CX, WORD[pos_x]   ;COLUMNA
    CALL quad_loop_column

    INC DI
    ADD DX, 1d
JMP quad_loop_row

quad_loop_column:
    CMP SI, WORD[dim_x]
        JE return

    INT 10h

    INC SI
    ADD CX, 1d
JMP quad_loop_column





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