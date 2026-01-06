POTENCIA PROC ; Define a função para dividir por uma potencia de 2
; Entrada AX o numero e CX a potencia
SHR AX,CL ; Divide um numero pela potencia de dois
; Saida AX o resultado
RET ; Retorna a função principal
POTENCIA ENDP ; Encerra a função que divide por uma potencia de 2