org 100h

section .text

        ;Limpiar registros
        XOR CX, CX
        XOR AX, AX

        MOV byte CL, 5d; Se guarda el número del factorial, en este caso 5
        MOV byte AL, 1d;

        jmp multiplicar

multiplicar:
        MUL CX ; se resta -1 a CX en cada iteración y se multiplica con el resultado guardado en AX ( CX*AX), 
                ; el resultado se guarda en AX 
                
        ;IF( CL == 0)
        CMP CL, 00 
        JE salto ; se salta a guardar el registro
        ; Else
        LOOP multiplicar ; llamamos a la etiqueta de nuevo
salto:  
        MOV [20BH], AL; 
        jmp exit
exit:
        int 20h