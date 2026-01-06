TITLE 0102_4 ; Da titulo ao programa

.MODEL SMALL ; Divide os códigos e dados lidos em 64kb

; Início do local onde são declarado as variáveis
.DATA
; Declaração de variáveis
MSG1 DB "Digite o primeiro numero: $"
MSG2 DB 13, 10, "Digite o segundo numero: $"
MSG3 DB 13, 10, "O maior numero e $"
MSG4 DB 13, 10, "O menor numero e $"
MSG5 DB 13, 10, "Os numeros digitados sao iguais$"
MSG6 DB 13, 10, "Os caracteres digitados nao sao numeros$"

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

    ; Função que exibe na tela a string
    MOV AH, 09h
    MOV DX, OFFSET MSG2
    INT 21h

    ; Le um caractere do teclado e salva o caractere lido em AL
    MOV AH, 01h
    INT 21h
    MOV CL, AL ; Move o conteudo de AL para CL

    CMP BL, 48 ; Compara o numero com BL
    JB NAO_NUM ; Se for menor pula para o rotulo

    CMP BL, 57 ; Compara o numero com BL
    JA NAO_NUM ; Se for maior pula para o rotulo

    CMP CL, 48 ; Compara o numero com CL
    JB NAO_NUM ; Se for menor pula para o rotulo

    CMP CL, 57 ; Compara o numero com CL
    JA NAO_NUM ; Se for maior pula para o rotulo

    CMP BL, CL ; Compara BL com CL 
    JE IGUAL ; Se for igual pula para o rotulo
    JA MAIOR_B ; Se for maior pula para o rotulo
    JB MAIOR_C ; Se for menor pula para o rotulo

    IGUAL: ; Define um rotulo
    ; Função que exibe na tela a string
    MOV AH, 09h
    MOV DX, OFFSET MSG5
    INT 21h

    JMP FINAL ; Pula incondicionamente para o rotulo

    MAIOR_B: ; Define um rotulo
    ; Função que exibe na tela a string
    MOV AH, 09h
    MOV DX, OFFSET MSG3
    INT 21h

    ; Exibe o caracter
    MOV DL, BL
    MOV AH, 02h
    INT 21h

    ; Função que exibe na tela a string
    MOV AH, 09h
    MOV DX, OFFSET MSG4
    INT 21h
    
    ; Exibe o caracter
    MOV DL, CL
    MOV AH, 02h
    INT 21h

    JMP FINAL ; Pula incondicionalmente para o rotulo

    MAIOR_C: ; Define um rotulo

    ; Função que exibe na tela a string
    MOV AH, 09h
    MOV DX, OFFSET MSG3
    INT 21h

    ; Exibe o caracter
    MOV DL, CL
    MOV AH, 02h
    INT 21h

    ; Função que exibe na tela a string
    MOV AH, 09h
    MOV DX, OFFSET MSG4
    INT 21h
    
    ; Exibe o caracter
    MOV DL, BL
    MOV AH, 02h
    INT 21h

    JMP FINAL ; Pula incondicionalmente para o rotulo

    NAO_NUM: ; Define um rotulo
    ; Função que exibe na tela a string
    MOV AH, 09h
    MOV DX, OFFSET MSG6
    INT 21h

    FINAL: ; Define um rotulo

; Finaliza o programa
MOV AH, 4CH
INT 21h
MAIN ENDP
END MAIN