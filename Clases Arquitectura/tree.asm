ORG     100h

section .data
    status_main_loop db 1h
    color            db 10010010b
    global_pos_x     dw 300d
    global_pos_y     dw 200d
    local_pos_x      dw 0d
    local_pos_y      dw 0d
    dim_y            dw 100d
    dim_x            dw 100d
    movement_speed   dw 8h
    auxCountLeft     dw 0d
    auxCountRight    dw 0d



section .text
    global main

main:
    call video_mode_init
    call main_loop
int 20h



video_mode_init:
    mov ah, 00h
    mov al, 12h
    int 10h
ret




main_loop:
    cmp byte[status_main_loop], 0h
        je return
        
    call clean_display

    ;Update local position with global position
    mov ax,                [global_pos_x]
    mov word[local_pos_x], ax
    mov ax,                [global_pos_y]
    mov word[local_pos_y], ax

    ;First triangle
    mov  byte[color], 00000010b
    mov  word[dim_y], 100d
    call print_triangle

    ;Second triangle
    mov  byte[color],       00001010b
    sub  word[local_pos_y], 50d
    mov  word[dim_y],       75d
    call print_triangle

    ;Third triangle
    mov  byte[color],       00001110b
    sub  word[local_pos_y], 25d
    mov  word[dim_y],       50d
    call print_triangle

    ;Rectangle
    sub  word[local_pos_x], 20d
    add  word[local_pos_y], 175d
    mov  byte[color],       00010110b
    mov  word[dim_y],       75d
    mov  word[dim_x],       40d
    call print_quad

    call read_key

    jmp main_loop
ret


return:
ret


clean_display:
    push es
    mov ax, 0A000h
    mov es, ax
    xor di, di
    xor ax, ax
    mov ecx, 153600 
    rep stosw
    pop es
    ret



print_triangle:
    mov ah, 0CH
    mov al, [color]
    mov bh, 0h

    mov  di, 0
    mov  dx, [local_pos_y] ;FILA
    call loop_row

ret

loop_row:
    cmp di, [dim_y]
        je return
    

    mov cx, [local_pos_x] ;COLUMNA
    int 10h

    mov [auxCountLeft],  cx
    mov [auxCountRight], cx

    mov  si, 0
    call loop_column

    inc di
    add dx, 1d
jmp loop_row

loop_column:
    cmp si, di
        jae return


    mov cx, [auxCountRight]
    int 10h

    mov cx, [auxCountLeft]
    int 10h

    inc word[auxCountRight]
    DEC word[auxCountLeft]
    inc si

jmp loop_column





print_quad:
    mov ah, 0CH
    mov al, [color]
    mov bh, 0h

    mov  di, 0
    mov  dx, [local_pos_y] ;FILA
    call quad_loop_row

ret

quad_loop_row:
    cmp di, [dim_y]
        je return
    
    mov  si, 0
    mov  cx, [local_pos_x] ;COLUMNA
    call quad_loop_column

    inc di
    add dx, 1d
jmp quad_loop_row

quad_loop_column:
    cmp si, [dim_x]
        je return

    int 10h

    inc si
    add cx, 1d
jmp quad_loop_column





read_key:
    mov ah, 00h
    int 16h

    cmp al, 'w'
        je move_up
    cmp al, 's'
        je move_down
    cmp al, 'a'
        je move_left
    cmp al, 'd'
        je move_rigth
    cmp al, 1Bh ;ESC
        je end_main_loop
ret


end_main_loop:
    mov byte[status_main_loop], 0
ret

move_up:
    mov ax,             [movement_speed]
    sub [global_pos_y], ax
ret

move_down:
    mov ax,             [movement_speed]
    add [global_pos_y], ax
ret

move_left:
    mov ax,             [movement_speed]
    sub [global_pos_x], ax
ret

move_rigth:
    mov ax,             [movement_speed]
    add [global_pos_x], ax
ret