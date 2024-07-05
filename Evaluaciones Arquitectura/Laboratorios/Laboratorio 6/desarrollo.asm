org 100h
section .text

setup:
  MOV SI, 90d ; Columna inicial
  MOV DI, 70d ; Fila inicial

main:
  CALL IniciarModoVideo
  CALL EncenderPixel
  CALL EsperarTecla

INT 20H


IniciarModoVideo:
  MOV AH, 0h
  MOV AL, 12h      ; Modo gráfico 640x480, 16 colores
  INT 10h
RET


EncenderPixel:
  MOV AH, 0Ch       ; Función del BIOS para poner un píxel
  MOV AL, 0100b     ; Color del píxel (rojo)
  MOV BH, 0         ; Página de video 0
  MOV CX, SI        ; Coordenada X
  MOV DX, DI        ; Coordenada Y
  INT 10h           ; Enciende el píxel

  INC SI            ; Incrementa la columna
  CMP SI, 190d      ; Compara la columna actual con el límite de 190
  JNE EncenderPixel ; Continúa en la misma fila si no se alcanza el límite

  ; Al alcanzar el límite de la fila, prepara la siguiente fila
  INC DI            ; Incrementa la fila
  MOV SI, 90d       ; Reinicia la columna al inicio para la nueva fila

  CMP DI, 120d      ; Compara la fila actual con el límite de 120
  JNE EncenderPixel ; Si no se alcanza el límite, continúa dibujando la fila
RET               ; Termina la función cuando el rectángulo está completo


EsperarTecla:
  MOV AH, 00h
  INT 16h        ; Lee una tecla del teclado
RET