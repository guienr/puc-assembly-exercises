TITLE lab7_ex2 ; Da titulo ao programa

.MODEL SMALL ; Divide os códigos e dados lidos em 64kb

; Início do local onde são declarado as variáveis
.DATA
; Declaração de variáveis
MSG1 DB "Digite o numero que deseja que seja multplicado: $"
MSG2 DB 13, 10, "Digite a quantidade de vezes que deseja que seja multiplicado: $"
MSG3 DB 13, 10, "Resultado: $"

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
    MOV BL, AL ; Move o conteudo de AL pra BL
    SUB BL, "0" ; Transforma o caracter em ASCII para numero

    ; Função que exibe na tela a string
    MOV AH, 09h
    MOV DX, OFFSET MSG2
    INT 21h

    ; Le um caractere do teclado e salva o caractere lido em AL
    MOV AH, 01h
    INT 21h
    MOV CL, AL ; Move o conteudo de AL para CL
    SUB CL, "0" ; Transforma o caracter em ASCII para numero

    MOV AL, 0 ; Move 0 para o conteudo de AL

    MULTIPLICAR: ; Define um rotulo

    ADD AL, BL ; Soma os conteudos de AL e BL e guarda em AL

    LOOP MULTIPLICAR ; Faz um loop decrementando 1 de CX ate que seja zero

    MOV BL, AL ; Move o conteudo de AL para BL
    ADD BL, "0" ; Transforma o numero para ASCII

    ; Função que exibe na tela a string
    MOV AH, 09h
    MOV DX, OFFSET MSG3
    INT 21h

    ; Exibe um caracter
    MOV AH, 02h
    MOV DL, BL
    INT 21h

; Finaliza o programa
MOV AH, 4CH
INT 21h
MAIN ENDP
END MAIN