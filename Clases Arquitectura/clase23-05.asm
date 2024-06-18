ORG 100h

SECTION .data
    ; Asignasión de valores.
    ; Parte de la división.
    celcius dd 25.0 ; Valor en Celcius
    divisor dd 9.0
    dividendo dd 5.0
    vSum dd 32.0 

SECTION .text
    ; Limpieza de variables.
    XOR EAX, EAX
    XOR EBX, EBX
    XOR ECX, ECX
    XOR EDX, EDX

main:

    CALL celcius_to_farenheit

INT 20h


celcius_to_farenheit:
        ; <Nombre> dd <valor> --> Para crear variables.
    ; FLD --> Sirve para guardar estos valores en una pila.
    ; FSTP --> Sirve para cargar el valor que este dentro de la pila.
    ; F<OperacionAritmetica> --> Realiza la misma operación pero en flotante.

    ; Al colocar e200, deja escribir un numero, haciento el programa "Dinamico".

    FLD DWORD[celcius]
    FLD DWORD[divisor]

    FMUL

    FLD DWORD[dividendo]

    FDIV

    FLD DWORD [vSum]

    FADD

    FSTP DWORD[200h] ; Mete el ultimo valor que encuentra en la pila, a la dirección 200h.
RET