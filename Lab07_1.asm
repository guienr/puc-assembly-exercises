TITLE lab7_ex1 ; Da titulo ao programa

.MODEL SMALL ; Divide os códigos e dados lidos em 64kb

.STACK 100h ; Define o tamanho da pilha

; Início do local onde são declarado as variáveis
.DATA
; Declaração de variáveis
MSG1 DB "Digite o dividendo: $"
MSG2 DB 13, 10, "Digite o divisor: $"
MSG3 DB 13, 10, "Quociente: $"
MSG4 DB 13, 10, "Resto: $"
MSG5 DB 13, 10, "O divisor é maior que o dividendo$"

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
    AND BL, 0Fh ; Transforma o caracter de ASCII para numero

    ; Função que exibe na tela a string
    MOV AH, 09h
    MOV DX, OFFSET MSG2
    INT 21h

    ; Le um caractere do teclado e salva o caractere lido em AL
    MOV AH, 01h
    INT 21h
    MOV CL, AL ; Move o conteudo de AL para CL
    AND CL, 0Fh ; Transforma o caracter de ASCII para numero

    CMP BL, CL ; Compara CL com BL
    JB MAIOR ; Se for menor vai para o rotulo

    MOV AL, 0 ; Move 0 para o conteudo AL

    DIVISAO: ; Define um rotulo
    SUB BL, CL ; Subtrai O valor CL de BL
    INC AL ; Incrementa 1 em AL

    CMP BL, CL ; Compara CL com BL
    JAE DIVISAO ; Se for maior ou igual pula para divisão

    MOV CL, AL ; Move o conteudo de AL para BL
    ADD BL, "0" ; Transforma o numero em ASCII
    ADD CL, "0" ; Transforma o numero em ASCII

    ; Função que exibe na tela a string
    MOV AH, 09h
    MOV DX, OFFSET MSG3
    INT 21h

    ; Exibe o caracter
    MOV AH, 02h
    MOV DL, CL
    INT 21h

    ; Função que exibe na tela a string
    MOV AH, 09h
    MOV DX, OFFSET MSG4
    INT 21h

    ; Exibe o caracter
    MOV AH, 02h
    MOV DL, BL
    INT 21h

    JMP FINAL ; Pula incondicionalmente para o rotulo

    MAIOR: ; Define um rotulo
    ; Função que exibe na tela a string
    MOV AH, 09h
    MOV DX, OFFSET MSG5
    INT 21h

    FINAL: ; Define um rotulo

; Finaliza o programa
MOV AH, 4CH
INT 21h
MAIN ENDP
END MAIN