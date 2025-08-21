; Da título ao programa de Eco
TITLE Eco
; Divide os códigos e dados lidos em 64kb
.MODEL SMALL
; Início do código onde estão as instruções do programa
.CODE
; Início das instruções do programa
MAIN PROC
; Exibe o caracter ? na tela, move a variável "?" para DL e a função é executada por INT 21h
MOV AH,2
MOV DL,"?"
INT 21h
; Lê um caracter do teclado e salva o caracter lido em AL, a função é executada pela função INT 21h
MOV AH,1
INT 21h
; Copia o caracter lido para BL
MOV BL,AL
; Exibe o caracter Line Feed (move o cursor para a linha seguinte)
MOV AH,2
MOV DL,10 ; O código ASC do caracter Line Feed é 10 (0Ah)
INT 21h ; Executa a função
; Exibe o caracter Carriage Return (move o cursor para o canto esquerdo da tela)
MOV AH,2
MOV DL,13 ; O código ASC do caracter Carriage Return é 13 (0Dh)
INT 21h ; Executa a função
; Exibe o caracter lido (salvo em BL)
MOV AH,2
MOV DL,BL ; Move o conteúdo de BL para DL
INT 21h ; Executa a função
; Finaliza o programa
MOV AH,4Ch
INT 21h
MAIN ENDP
END MAIN