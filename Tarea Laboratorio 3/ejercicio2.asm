org     100h
section .text

        ; Limpiar registros
        XOR AX, AX
        XOR SI, SI

        MOV byte BL, 8d ; Cantidad de dígitos que tiene el carnet
        MOV word CX, 8d ; Contador del LOOP, se resta -1 a CX en cada iteración

        ; Se guarda digito por digito del carnet en los segmentos 200h 
        MOV byte [200h], 0d
        MOV byte [201h], 0d
        MOV byte [202h], 0d
        MOV byte [203h], 6d
        MOV byte [204h], 7d
        MOV byte [205h], 2d
        MOV byte [206h], 1d
        MOV byte [207h], 8d

        jmp iterar
iterar:
        ADD AL, [200h + SI] ; se usa direccionamiento con índice para acceder a cada valor según la iteración
        INC SI ; incrementar el contador
        LOOP iterar ; llamamos la etiqueta iterar
dividir:
        DIV BL ; Se divide entre la cantidad guardada, en este caso 8
        MOV [20Bh], AL
        jmp exit
exit:
        int 20h