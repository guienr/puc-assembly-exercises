TITLE Numero ; Da titulo ao programa

.MODEL SMALL ; Divide os códigos e dados lidos em 64kb

.STACK 100h ; Define o tamanho da pilha

; Início do local onde são declarado as variáveis
.DATA

; Declaração de variáveis
MSG1 DB "Digite um caractere: $"
SIM DB 10,13,"O caractere digitado e um numero.$"
NAO DB 10,13,"O caractere digitado nao e um numero.$"

; Início do código onde estão as instruções
.CODE
MAIN PROC

; Permite o acesso as variaveis definidas em .DATA
MOV AX,@DATA
MOV DS,AX
; Exibe na tela a string MSG1 ("Digite um caractere: ")
MOV AH,9
MOV DX,OFFSET MSG1
INT 21h
; Le um caractere do teclado e salva o caractere lido em AL
MOV AH,1
INT 21h
; Copia o caractere lido para BL
MOV BL,AL
; Compara o caractere em BL com o valor 48 (codigo ASCII do caractere "0")
CMP BL,48
; Se o caractere em BL for menor que 48 ("0"), salta para o rotulo NAOENUMERO
JB NAOENUMERO
; Compara o caractere em BL com o valor 57 (codigo ASCII do caractere "9")
CMP BL,57
; Se o caractere em BL for maior que 57 ("9"), salta para o rotulo NAOENUMERO
JA NAOENUMERO
; Se chegou ate aqui, exibe na tela dizendo que o caracter e um numero
MOV AH,9
MOV DX,OFFSET SIM
INT 21h
; Salta para o rotulo FIM
JMP FIM
; Define o rotulo NAOENUMERO
NAOENUMERO:
; Exibe na tela dizendo que o caractere nao e um numero
MOV AH,9
MOV DX,OFFSET NAO
INT 21h
; Define o rotulo FIM
FIM:
; Finaliza o programa
MOV AH,4Ch
INT 21h
MAIN ENDP
END MAIN


; d) O programa recebe um caracter do usuário e compara-o vendo se é menor que o código ASCII 48 que é o número 0 e se é maior que o código ASCII 57 que representa o
; número 9 em decimal, se o caracter não for um número entre 0 e 9, o programa da um jump para o rótulo NAOENUMERO e exibe na tela dizendo que um caracter não é um
; número, caso seja um número o programa continua e exibe a mensagem dizendo que é um número e salta para o final do programa