section .text
global _start

_start:
    ; Obtener el contador de tiempo del sistema
    rdtsc                  ; Lee el Time Stamp Counter en EDX:EAX
    mov ebx, eax           ; Mueve el valor bajo del contador a ebx

    ; Aplicar un algoritmo simple para generar un número pseudoaleatorio
    mov eax, ebx           ; Mueve la semilla a eax
    mov ecx, 0x343FD      ; Multiplicador (por ejemplo, 214013)
    mov edx, 0x269EC3     ; Incremento (por ejemplo, 2531011)
    mul ecx                ; Multiplica eax por ecx
    add eax, edx           ; Suma el incremento
    mov ebx, eax           ; Mueve el resultado de nuevo a ebx

    ; ebx ahora contiene un número pseudoaleatorio
    ; Aquí puedes agregar más lógica para usar el número aleatorio

    ; Salida del programa (Linux)
    mov eax, 1             ; syscall: exit
    xor ebx, ebx           ; código de salida 0
    int 0x80               ; Interrupción del sistema
