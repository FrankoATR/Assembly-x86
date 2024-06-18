org 100h
section .text

MOV AH,  12d
MOV BH, 244d

MOV CH, 12d
MOV CL, 244d


MOV AL, AH

ADD AL, AH ;r = 24d -> 18h

MOV [200h], AL

;Suma que genere acarreo
ADC  AH, BH

ADC AH, AL ;r = 19 porque adc acarrea la bandera

;Resta s/c
SUB CL, CH

SBB CL, AL

int 20h