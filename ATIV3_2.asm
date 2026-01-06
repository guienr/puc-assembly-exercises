TITLE Caractere; Da titulo ao programa

.MODEL SMALL ; Divide os códigos e dados lidos em 64kb

.STACK 100h ; Define o tamanho da pilha

; Início do local onde são declarado as variáveis
.DATA
; Declaração de variáveis
MSG1 DB 10,13,"Digite um caractere: $"
MSG2 DB 10,13,"O caractere digitado e um numero$"
MSG3 DB 10,13,"O caractere digitado e uma letra$"
MSG4 DB 10,13,"O caractere digitado e desconhecido$"
MSG5 DB 10,13,"Digite ESC para finalizar o programa: $"
MSG6 DB 10,13,"Fim do programa$"

; Início do código onde estão as instruções
.CODE
MAIN PROC

; Permite o acesso as variaveis definidas em .DATA
MOV AX,@DATA
MOV DS,AX

; Define o rotulo CARACTERE
CARACTERE:
; Exibe na tela a string MSG1
MOV AH,9
MOV DX, OFFSET MSG1
INT 21h

; Le um caractere do teclado e salva o caractere lido em AL
MOV AH,1
INT 21h
; Copia o caractere lido para BL
MOV BL,AL

; Compara o caractere em BL com o valor 48
CMP BL,48
; Se o caractere em BL for menor que 48, salta para o rotulo DESCONHECIDO
JB DESCONHECIDO

; Compara o caractere em BL com o valor 58
CMP BL,58
; Se o caractere em BL for menor que 58 e maior ou igual a 48, salta para o rotulo NUMERO
JL NUMERO

; Compara o caractere em BL com o valor 65
CMP BL,65
; Se o caractere em BL for menor que 65 e maior ou igual a 58, salta para o rotulo DESCONHECIDO
JB DESCONHECIDO

; Compara o caractere em BL com o valor 91
CMP BL,91
; Se o caractere em BL for menor que 91 e maior ou igual a 65, salta para o rotulo LETRA
JB LETRA

; Compara o caractere em BL com o valor 97
CMP BL,97
; Se o caractere em BL for menor que 97 e maior ou igual a 91, salta para o rotulo DESCONHECIDO
JB DESCONHECIDO

; Compara o caractere em BL com o valor 123
CMP BL,123
; Se o caractere em BL for menor que 123 e maior ou igual a 97, salta para o rotulo LETRA
JB LETRA
; Se o caractere em BL for maior ou igual a 123, salta para o rotulo DESCONHECIDO
JAE DESCONHECIDO

; Define o rotulo NUMERO
NUMERO:
; Exibe na tela a string MSG2
MOV AH,9
MOV DX, OFFSET MSG2
INT 21h
; Salta para o rotulo SAIDA
JMP SAIDA

; Define o rotulo LETRA
LETRA: 
; Exibe na tela a string MSG3
MOV AH,9
MOV DX, OFFSET MSG3
INT 21h
; Salta para o rotulo SAIDA
JMP SAIDA

; Define o rotulo DESCONHECIDO
DESCONHECIDO:
; Exibe na tela a string MSG4
MOV AH,9
MOV DX, OFFSET MSG4
INT 21h
; Salta para o rotulo SAIDA
JMP SAIDA

; Define o rotulo SAIDA
SAIDA:
; Exibe na tela a string MSG5
MOV AH,9
MOV DX, OFFSET MSG5
INT 21h

; Le um caractere do teclado e salva o caractere lido em AL
MOV AH,1
INT 21h
; Copia o caractere lido para BL
MOV BL,AL

; Compara o caractere em BL com o valor 27, numero correspondente ao codigo ASCII de ESC
CMP BL,27
; Se o conteudo em BL nao for igual a 27, ele salta para o rotulo CARACTERE
JNE CARACTERE

; Define o rotulo FIM
FIM:
; Exibe na tela a string MSG6
MOV AH,9
MOV DX, OFFSET MSG6
INT 21h
; Finaliza o programa
MOV AH,4Ch
INT 21h
MAIN ENDP
END MAIN