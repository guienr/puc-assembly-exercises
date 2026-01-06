TITLE WHILE ; Da titulo ao programa

.MODEL SMALL ; Divide os códigos e dados lidos em 64kb

; Início do local onde são declarado as variáveis
.DATA
MSG DB "Digite um caracter: $" ; Declaração de variáveis

; Início do código onde estão as instruções
.CODE
MAIN PROC

    ; Permite o acesso as variaveis definidas em .DATA
    MOV AX, @DATA
    MOV DS, AX

    MOV CX, 0 ; Zera o contador CX

    RECEBE_CARACTER: ; Define o rotulo

    ; Função que exibe o caracter sendo utilizada para pular linha
    MOV AH, 02h
    MOV DL, 13
    INT 21h
    MOV DL, 10
    INT 21h

    ; Função que exibe na tela a string
    MOV AH, 09h
    MOV DX, OFFSET MSG
    INT 21h

    ; Le um caractere do teclado e salva o caractere lido em AL
    MOV AH, 01h
    INT 21h

    INC CX ; Adiciona 1 a CX

    CMP AL, 13 ; Compara o código ASCII do caracter digitado com o código ASCII de cr
    JE FINAL ; Se o caracter for igual pula para o rotulo FINAL

    JMP RECEBE_CARACTER ; Se o caracter nao for igual pula para o rotulo RECEBE_CARACTER

    FINAL: ; Define o rotulo
    ; Função que exibe o caracter
    MOV AH, 02h
    MOV DL, "*"
    INT 21h

    DEC CX ; Decrementa 1 de CX

    CMP CX, 0 ; Compara o contador CX com 0
    JNE FINAL ; Se não for igual pula para o rotulo FINAL

; Finaliza o programa
MOV AH, 4CH
INT 21h
MAIN ENDP
END MAIN

; A diferença é que no programa da parte 1 se o caracter digitado é o cr, ele já finaliza o programa sem acrescentar um ao contador e imprimir o "*", e ele nunca conta
; o cr na hora de imprimir a quantidade de "*" no final, já neste programa da parte 2 o se o caracter digitado for cr, ele irá rodar pelo menos uma vez acrescentando um
; ao contador e imprimir o "*", além disso, ao digitar cr após vários outros caracteres ele também contará no contador para imprimir o "*".