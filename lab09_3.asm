TITLE SOMA DE MATRIZES ; Da titulo ao programa

.MODEL SMALL ; Divide os códigos e dados lidos em 64kb

; Início do local onde são declarado as variáveis
.DATA
; Declaração de variáveis
MSG1 DB 13, 10, "Digite um valor de 0 a 6 da matriz nesta posição: $"
MSG2 DB 10, 13, 10, "MATRIZ: $"
MSG3 DB 13, 10, "SOMA: $"
MSG4 DB 13, 10, "Numero invalido, digite novamente outro numero$"
MATRIZ4X4 DB ?,?,?,?
          DB ?,?,?,?
          DB ?,?,?,?
          DB ?,?,?,?

; Início do código onde estão as instruções
.CODE
; Define a função principal
MAIN PROC
    ; Permite o acesso as variaveis definidas em .DATA
    MOV AX, @DATA
    MOV DS, AX

    CALL LERM ; Chama a função de leitura

    CALL IMPRIMIRM; Chama a função de impressão

    CALL SOMAM ; Chama a função de soma

MOV AH, 4CH ; Encerra a função principal
INT 21h
MAIN ENDP

LERM PROC ; Define a função

    XOR BX, BX ; Zera BX
    MOV CH, 4 ; Move o 4 para o conteudo de CH

    LINHA1: ; Define um rotulo
    MOV SI, 0 ; Move 0 para o conteudo de SI
    MOV CL, 4 ; Move o 4 para o conteudo de CL

    COLUNA1: ; Define um rotulo
    MOV AH, 09h ; Função que exibe uma string
    LEA DX, MSG1
    INT 21h

    MOV AH, 01h ; Função que le um caracter
    INT 21h

    CMP AL, "0" ; Compara o conteudo de AL com o caracter 0
    JB ERRO ; Se for menor pula para o rotulo

    CMP AL, "6" ; Compara o conteudo de AL com o caracter 6
    JA ERRO ; Se for maior pula para o rotulo

    JMP CERTO ; Pula incondicionamente para o rotulo

    ERRO: ; Define um rotulo
    MOV AH, 09h ; Função que exibe uma string
    LEA DX, MSG4
    INT 21h
    JMP COLUNA1 ; Pula incondicionamente para o rotulo
 
    CERTO: ; Define um rotulo
    AND AL, 0Fh ; Transforma o caracter de ASCII para numero
    MOV MATRIZ4X4[BX+SI], AL ; Move o conteudo de AL para o conteudo da determinada posição da matriz
    INC SI ; Incrementa 1 a SI
    DEC CL ; Decrementa 1 de CL
    JNZ COLUNA1 ; Se CL não for igual a zero, pula para o rotulo

    ADD BX, 4 ; Adiciona 4 a BX
    DEC CH ; Decrementa 1 de CH
    JNZ LINHA1 ; Se CH não for igual a zero, pula para o rotulo

    RET ; Retorna para a função principal
LERM ENDP ; Finaliza a função

IMPRIMIRM PROC ; Define a função

    XOR BX, BX ; Zera BX
    MOV CH, 4 ; Move o 4 para o conteudo de CH

    MOV AH, 09h ; Função que exibe uma string
    LEA DX, MSG2
    INT 21h

    MOV AH, 02h ; Função que exibe um caracter
    LINHA2: ; Define um rotulo
    MOV DL, 13 ; Pula para a linha debaixo
    INT 21h
    MOV DL, 10
    INT 21h
    MOV CL, 4 ; Move o 4 para o conteudo de CL
    MOV SI, 0 ; Move 0 para o conteudo de SI

    COLUNA2: ; Define um rotulo
    MOV DL, MATRIZ4X4[BX+SI] ; Move o conteudo da determinada posição da matriz para DL
    OR DL, 30h ; Transforma o conteudo de DL de numero para ASCII
    INT 21h
    MOV DL, 20h ; Da um espaço
    INT 21h
    INC SI ; Incrementa 1 a SI
    DEC CL ; Decrementa 1 de CL
    JNZ COLUNA2 ; Se CL não for igual a zero, pula para o rotulo

    ADD BX, 4 ; Adiciona 4 a BX
    DEC CH ; Decrementa 1 de CH
    JNZ LINHA2 ; Se CH não for igual a zero, pula para o rotulo

    RET ; Retorna para a função principal
IMPRIMIRM ENDP ; Finaliza a função

SOMAM PROC ; Define a função

    XOR DX, DX ; Zera X
    XOR BX, BX ; Zera BX
    MOV CH, 4 ; Move o 4 para o conteudo de CH

    LINHA3: ; Define um rotulo
    MOV SI, 0 ; Move 0 para o conteudo de SI
    MOV CL, 4 ; Move o 4 para o conteudo de CL

    COLUNA3: ; Define um rotulo

    MOV AL, MATRIZ4X4[BX+SI] ; Move o conteudo da determinada posição da matriz para AL
    ADD DL, AL ; Soma o conteudo de AL com DL

    CMP DL, 9 ; Compara o conteudo de DL com 9
    JA DEZENA ; Se for maior pula para o rotulo
    JMP CONTINUAR ; Pula incondicionamente para o rotulo

    DEZENA: ; Define um rotulo
    SUB DL, 10 ; Subtrai 10 de DL
    INC DH ; Incrementa 1 a DH

    CONTINUAR: ; Define um rotulo
    
    INC SI ; Incrementa 1 a SI
    DEC CL ; Decrementa 1 de CL
    JNZ COLUNA3 ; Se CL não for igual a zero, pula para o rotulo

    ADD BX, 4 ; Adiciona 4 a BX
    DEC CH ; Decrementa 1 de CH
    JNZ LINHA3 ; Se CH não for igual a zero, pula para o rotulo

    OR DH, 30h ; Transforma o conteudo de DH de numero para ASCII
    OR DL, 30h ; Transforma o conteudo de DL de numero para ASCII

    MOV CL, DL ; Move o conteudo de DL para CL
    MOV CH, DH ; Move o conteudo de DH para CH

    MOV AH, 09h ; Função que exibe uma string
    LEA DX, MSG3
    INT 21h

    MOV AH, 02h ; Função que exibe um caracter
    MOV DL, CH
    INT 21h
    MOV DL, CL
    INT 21h

    RET ; Retorna para a função principal
SOMAM ENDP ; Finaliza a função

END MAIN ; Encerra o programa