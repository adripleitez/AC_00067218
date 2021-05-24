; Hacer un programa utilizando una o más subrutinas donde, con la ayuda de un arreglo de elementos numéricos con tamaño de 1 byte, 
; se separe los números pares e impares. (100%)

; El arreglo debe contener 10 números y debe estar declarado en la directiva "section .data". 
; Los pares colocarlos en la dirección 0300H y los impares colocarlos a partir de la dirección 0320H. 

; MAIN
        org 100h

        section .text

        ; BP = puntero a array
        MOV BP, array   

        ; Limpiando los registros
        XOR SI, SI
        XOR DI, DI
        XOR BX, BX
        XOR CX, CX
        XOR DX, DX
        MOV BH, 2
        
        ; Llamar a Función para verificar si es par o impar
        call    Function

        int 20h

        section .data

array   db      01,04,03,06,14,9,2,5,7,20  ; arreglo de números
length  equ     $-array

; FUNCIONES

Function:
        XOR AX, AX                      ; Limpiar AX de registros basura de la división.
        CMP SI, length                  ; Antes de realizar la función se verifica si el índice del recorrido ya llego al tamaño del arreglo 
        JE End

        MOV AL, [BP + SI]               ; Se mueve la posición según el valor de SI.
        INC SI                          ; Incrementa en uno el valor de SI.
        MOV BL,AL                       ; Se almacena en BL el valor del dividendo para no perderlo.
        DIV BH                          
        CMP AH, 0                       ; Comparación para ver si el residuo es igual a 0.
        JE Even                         ; If (residuo == 0) Entonces saltamos para guardarlo en el arreglo de pares.
        JA Odd                          ; If (residuo != 0) Entonces saltamos a la etiqueta Odd.
Even:  
        MOV DI, DX                      
        MOV byte [300h + DI], BL        ; Guardamos el valor del número par en la direccion 300h
        INC DI
        MOV DX, DI                      ; Almacenamos el valor de la última posición en el arreglo de Even
        JMP Function
        
Odd:
        MOV DI, CX                      
        MOV byte [320h + DI], BL        ; Guardamos el valor del número par en la direccion 300h
        INC DI
        MOV CX, DI                      ; Se almacena el valor de la última posición en el arreglo de Odd
        JMP Function
End:    
        ret                             ; regresa a MAIN
        
