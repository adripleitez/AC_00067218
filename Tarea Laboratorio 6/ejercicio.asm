; Hacer un programa que permita utilizar una clave de acceso
; MAIN
	org 	100h

	section	.text

	; imprimir msg1
	mov 	DX, msg1
	call  	EscribirCadena

	; leer frase del teclado
	mov 	BP, frase
	call  	LeerCadena

    ; limpiar el contador
    xor SI, SI 

    call	compararCadenas

	int 	20h

	section	.data
 
 ; Definición de variables y constantes
clave 	db 	"hello", "$"
msg1	db	"Digita la clave: ", "$"
msg2 	db 	"BIENVENIDO", "$"
msg3 	db 	"INCORRECTO", "$"
frase 	times 	 6 	db	" " 
noCaracteres equ 5	

; FUNCIONES

; Leer un carácter de la entrada
EsperarTecla:
        mov     AH, 01h         
        int     21h
        ret
; Leer cadena de texto desde el teclado
LeerCadena:
        xor     SI, SI          ; SI = 0
while:  
        call    EsperarTecla    ; retorna un caracter en AL
        cmp     AL, 0x0D        ; comparar AL con caracter EnterKey
        je      exit            ; si se oprimió la tecla Enter entonces se termina el while
        mov     [BP+SI], AL   	; guardar caracter en memoria
        inc     SI              
        jmp     while  
exit:
        mov byte [BP + SI], "$" ; para agregar el $ al final
        ret   
compararCadenas:
        cmp SI, noCaracteres    ; contraseña debe ser de cinco caracteres por lo que se compara con este largo definido
        je  esIgual             ; si se llega a la última posición significa que todos los caracteres de la cadena son iguales a la contraseña
        mov AL, [clave + SI]    ; se recorre la cadena de la llave en la posición que lleve SI
	    cmp [BP + SI], AL	    ; se compara con el caracter de la frase ingresada que este en la posición de SI guardada en la direccion BP 
        jne noIgual             ; si un caracter es diferente entonces salta a la cadena de incorrecto
        inc SI
        jmp compararCadenas     ; while
esIgual:
    	mov 	DX, msg2        ; Para escribir el mensaje de Bienvenido
    	jmp 	EscribirCadena
noIgual:
    	mov 	DX, msg3        ; Para escribir el mensaje de Incorrecto
    	jmp 	EscribirCadena
EscribirCadena:
    	mov 	AH, 09h
    	int 	21h
    	ret
