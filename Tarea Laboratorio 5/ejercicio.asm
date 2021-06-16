org 100h

    section .text
    xor AX, AX
    xor SI, SI
    xor BX, BX
    XOR CX, CX
    xor DX, DX

    MOV SI, 0
    MOV DI, 0d

    MOV byte [200h], 10 ; fila inicial
    MOV DL, 20 ; columna en la que se mostrará el cursor

    call modotexto
    jmp ITERAR

    modotexto: 
        MOV AH, 0h ; activa modo texto
        MOV AL, 03h ; modo gráfico deseado
        INT 10h
        RET

    ITERAR:
        call movercursor 

        CMP byte [cadena+SI], 32d ; En caso de ser espacio, salta de fila
        JZ  moverfila
        MOV CL, [cadena+SI] ;Colocar en CL el caracter actual de la cadena
        call escribircaracter

        INC SI ; SE SUMA 1 PARA PASAR AL SIGUIENTE CARACTER
        INC DL ; SE SUMA 1 PARA MOVER COLUMNA
        INC DI 
        CMP DI, len ; Comparación de DI con el tamanio de la cadena
        JB ITERAR ; si DI es menor sigue iterando.
        jmp esperartecla ; de caso contrario, que salte a esperar tecla.

    movercursor:
        MOV AH, 02h ; posiciona el cursor en pantalla.
        MOV BH, 0h
        MOV byte DH, [200h] ; posicionar la fila en el ultimo registro guardado
        INT 10h
        RET

    moverfila:
        ADD byte [200h], 2d ; saltar fila
        MOV DL, 20  ; regresar a columna inicial
        INC SI
        INC DI
        CMP DI, len ; Comparación de DI con el tamanio de la cadena
        JB ITERAR 
        jmp esperartecla

    escribircaracter:
        CMP byte [cadena + SI], 32d ; en caso de ser espacio, regresar
        JZ regresar

        MOV AH, 0Ah ; escribe caracter en pantalla 
        MOV AL, CL 
        MOV BH, 0h 
        MOV CX, 1h ; número de veces a escribir el caracter
        INT 10h
        RET

    esperartecla:
        MOV AH, 00h ; espera buffer del teclado para avanzar en la siguiente instrucción
        INT 16h
    exit:
        int 20h
    
    regresar:
        ret

    section .data

    cadena DB 'Adriana Sofia Pleitez Perez '
    len DB  $-cadena;