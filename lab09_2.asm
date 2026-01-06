TITLE MANIPULAÇÃO DE MATRIZES ; Da titulo ao programa

.MODEL SMALL ; Divide os códigos e dados lidos em 64kb

; Início do local onde são declarado as variáveis
.DATA
; Declaração de variáveis
MATRIZ4X4 DB 1,2,3,4
          DB 4,3,2,1
          DB 5,6,7,8
          DB 8,7,6,5

; Início do código onde estão as instruções
.CODE
; Define a função principal
MAIN PROC
    ; Permite o acesso as variaveis definidas em .DATA
    MOV AX, @DATA
    MOV DS, AX

    CALL IMPRIMIRM ; Chama a função de impressão

MOV AH, 4CH ; Encerra a função principal
INT 21h
MAIN ENDP

IMPRIMIRM PROC ; Define a função

    XOR BX, BX ; Zera BX
    MOV CH, 4 ; Move o 4 para o conteudo de CH

    MOV AH, 02h ; Função que exibe um caracter
    LINHA: ; Define um rotulo
    MOV DL, 13 ; Pula para a linha debaixo
    INT 21h
    MOV DL, 10
    INT 21h
    MOV CL, 4 ; Move o 4 para o conteudo de CL
    MOV SI, 0 ; Move 0 para o conteudo de SI

    COLUNA: ; Define um rotulo
    MOV DL, MATRIZ4X4[BX+SI] ; Move o conteudo da determinada posição da matriz para DL
    OR DL, 30h ; Transforma o conteudo de numero para ASCII
    INT 21h
    MOV DL, 20h ; Da um espaço
    INT 21h
    INC SI ; Incrementa 1 a SI
    DEC CL ; Decrementa 1 de CL
    JNZ COLUNA ; Se CL não for igual a zero, pula para o rotulo

    ADD BX, 4 ; Adiciona 4 a BX
    DEC CH ; Decrementa 1 de  CH
    JNZ LINHA ; Se CH não for igual a zero, pula para o rotulo

    RET ; Retorna para a função principal
IMPRIMIRM ENDP ; Finaliza a função

END MAIN ; Encerra o programa