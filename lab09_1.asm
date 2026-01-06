TITLE INVERSAO VETOR ; Da titulo ao programa

.MODEL SMALL ; Divide os códigos e dados lidos em 64kb

; Início do local onde são declarado as variáveis
.DATA
; Declaração de variáveis
MSG1 DB 13, 10, "Digite o valor da posição do vetor: $"
MSG2 DB 13, 10, "Vetor: $"
VETOR DB ?, ?, ?, ?, ?, ?, ?

; Início do código onde estão as instruções
.CODE
; Define a função principal
MAIN PROC
    ; Permite o acesso as variaveis definidas em .DATA
    MOV AX, @DATA
    MOV DS, AX

    CALL LERV ; Chama a função de leitura

    CALL INVERTERV ; Chama a função de inversão

    CALL IMPRIMIRVI ; Chama a função de impressão

MOV AH, 4CH ; Encerra a função principal
INT 21h
MAIN ENDP

LERV PROC ; Define a função

    XOR BX, BX ; Zera BX
    MOV CX, 7 ; Move o 7 para o conteudo de CX
    LEITURA: ; Define um rotulo

    MOV AH, 09h ; Função que exibe uma string
    LEA DX, MSG1
    INT 21h

    MOV AH, 01h ; Função que le um caracter
    INT 21h

    MOV VETOR[BX], AL ; Move o valor que esta em AL para a posição do vetor

    INC BX ; Incrementa 1 a BX

    LOOP LEITURA ; Decrementa 1 de CX, se CX não for igual a 0 pula para o rotulo

    RET ; Retorna para a função principal
LERV ENDP ; Finaliza a função

INVERTERV PROC ; Define a função
    XOR DX, DX ; Zera DX
    XOR BX, BX ; Zera BX
    MOV CX, 7 ; Move o 7 para o conteudo de CX

    PILHA: ; Define um rotulo

    MOV DL, VETOR[BX] ; Move o valor da posição do vetor para DL
    PUSH DX ; Coloca o valor de DX no topo da pilha
    INC BX ; Incrementa 1 a BX

    LOOP PILHA ; Decrementa 1 de CX, se CX não for igual a 0 pula para o rotulo

    XOR DX, DX ; Zera DX
    XOR BX, BX ; Zera BX
    MOV CX, 7 ; Move o 7 para o conteudo de CX

    INVERTE: ; Define um rotulo

    POP DX ; Retira o conteudo do topo da pilha e joga em DX
    MOV VETOR[BX], DL ; Move o conteudo de DL para o conteudo da posição do vetor
    INC BX ; Incrementa 1 a BX
    
    LOOP INVERTE ; Decrementa 1 de CX, se CX não for igual a 0 pula para o rotulo

    RET ; Retorna para a função principal
INVERTERV ENDP ; Finaliza a função

IMPRIMIRVI PROC ; Define a função

    XOR BX, BX ; Zera BX
    MOV CX, 7 ; Move o 7 para o conteudo de CX

    MOV AH, 09h ; Função que exibe uma string
    LEA DX, MSG2
    INT 21h

    IMPRESSAO: ; Define um rotulo
    MOV DL, VETOR[BX] ; Move o valor da posição do vetor para DL
    MOV AH, 02h ; Função que exibe um caracter
    INT 21h
    INC BX ; Incrementa 1 a BX
    LOOP IMPRESSAO ; Decrementa 1 de CX, se CX não for igual a 0 pula para o rotulo

    RET ; Retorna para a função principal
IMPRIMIRVI ENDP ; Finaliza a função

END MAIN ; Encerra o programa