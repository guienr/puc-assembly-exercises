TITLE 0101_4 ; Da titulo ao programa

.MODEL SMALL ; Divide os códigos e dados lidos em 64kb

; Início do local onde são declarado as variáveis
.DATA 
; Declaração de variáveis
MSG1 DB "Entre com um numero: $"
MSG2 DB " eh um numero par$"
MSG3 DB " eh um numero impar$"

; Início do código onde estão as instruções
.CODE
MAIN PROC

; Permite o acesso as variaveis definidas em .DATA
MOV AX, @DATA
MOV DS, AX

; Função que exibe na tela a string
MOV AH, 09h
MOV DX, OFFSET MSG1
INT 21h

; Le um caractere do teclado e salva o caractere lido em AL
MOV AH, 01h
INT 21h

MOV BL, AL ; Move o conteudo de AL para BL
AND AL, 0Fh ; Transforma o caracter de ASCII para numero
MOV CL, AL ; Move o conteudo de AL para CL

; Função que exibe o caracter sendo utilizada para pular linha
MOV AH, 02h
MOV DL, 13
INT 21h
MOV DL, 10
INT 21h

AND CL, 01h ; Ve se o numero e par ou impar
JNZ IMPAR ; Se o numero nao for pula para o rotulo
; Exibe o caracter
MOV AH, 02h
MOV DL, BL
INT 21h

; Função que exibe na tela a string
MOV AH, 09h
MOV DX, OFFSET MSG2
INT 21h

JMP FINAL ; Pula incondicionalmente para o rotulo

IMPAR: ; Define um rotulo

; Exibe o caracter
MOV AH, 02h
MOV DL, BL
INT 21h

; Função que exibe na tela a string
MOV AH, 09h
MOV DX, OFFSET MSG3
INT 21h

FINAL: ; Define um rotulo

; Finaliza o programa
MOV AH, 4CH
INT 21h
MAIN ENDP
END MAIN