.MODEL small, c
.STACK
.DATA
    txt db 'Soy un mensaje$'
.CODE
    .STARTUP
    MOV AH, 0Fh
    INT 10h
    MOV AH, 0
    INT 10h

    LEA DX, txt
    MOV AH, 9
    INT 21h
.EXIT
END