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

    CMP AL, 13 ; Compara o código ASCII do caracter digitado com o código ASCII de cr
    JE FINAL ; Se o caracter for igual pula para o rotulo FINAL

    INC CX ; Adiciona 1 a CX

    JMP RECEBE_CARACTER ; Se o caracter nao for igual pula para o rotulo RECEBE_CARACTER

    FINAL: ; Define o rotulo

    CMP CX, 0 ; Compara o contador CX com zero
    JE TERMINO ; Se for igual pula para o rotulo TERMINO

    ; Função que exibe o caracter
    MOV AH, 02h
    MOV DL, "*"
    INT 21h

    DEC CX ; Decrementa 1 de CX

    CMP CX, 0 ; Compara o contador CX com zero
    JNE FINAL ; Se nao for igual pula para o rotulo FINAL

    TERMINO: ; Define o rotulo

; Finaliza o programa
MOV AH, 4CH
INT 21h
MAIN ENDP
END MAIN