POTENCIA PROC ; Define a função para multiplicar por uma potencia de 2
; Entrada AX o numero e CX a potencia
SHL AX,CL ;Multiplica um numero pela potencia de dois
; Saida AX o resultado
RET ; Retorna a função principal
POTENCIA ENDP ; Encerra a função para multiplicar por uma potencia de 2