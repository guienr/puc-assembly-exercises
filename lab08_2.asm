TITLE FOR_EX2 ; Da titulo ao programa

.MODEL SMALL ; Divide os códigos e dados lidos em 64kb

; Início do local onde são declarado as variáveis
.DATA
; Declaração de variáveis
MSG1 DB 13, 10, "Digite 0 ou 1 para o numero binario: $"
MSG2 DB 13, 10, "Numero: $"

; Início do código onde estão as instruções
.CODE 

; Define a função principal
MAIN PROC
; Permite o acesso as variaveis definidas em .DATA
MOV AX, @DATA
MOV DS, AX

CALL LEITURA ; Chama a função de leitura

CALL IMPRIMIR ; Chama a função de impressão

MAIN ENDP ; Encerra a função principal
MOV AH, 4CH
INT 21h

LEITURA PROC ; Define a função
MOV CX, 16 ; Move 16 para o conteudo de CX

LER_BIN: ; Define um rotulo
MOV AH, 09h ; Função que exibe uma string
MOV DX, OFFSET MSG1
INT 21h

MOV AH, 01h ; Função que le um caracter
INT 21h

SUB AL, "0" ; Transforma o conteudo de AL de ASCII para numero

CMP AL, 0 ; Compara o valor de AL com 0
JE ADICIONAR ; Se for igual pula para o rotulo

CMP AL, 1 ; Compara o valor de AL com 1
JE ADICIONAR ; Se for igual pula para o rotulo

JMP LER_BIN ; Salta incondicionalmente pra o rotulo

ADICIONAR: ; Define um rotulo

SHL BX, 1 ; Move os bits uma casa para a esquerda
OR BL, AL ; Faz um OR entre BL e AL

LOOP LER_BIN ; Decrementa 1 de CX, se o conteudo de CX não for 0 pula para o rotulo

RET ; Retorna para a função principal
LEITURA ENDP ; Finaliza a função

IMPRIMIR PROC ; Define a função

MOV AH, 09h ; Função que exibe uma string
MOV DX, OFFSET MSG2
INT 21h

MOV CX, 16 ; Move 16 para o conteudo de CX

IMP_BIN: ; Define um rotulo

ROL BX, 1 ; Rotaciona o bit mais significativo para o final 

JC MOSTRA_1 ; Se CF = 1, pula para imprimir "1"
JMP MOSTRA_0 ; Senão, imprime "0"

MOSTRA_1: ; Define um rotulo
MOV DL, '1' ; Caractere "1"
JMP IMPRIME ; Salta incondicionalmente pra o rotulo

MOSTRA_0: ; Define um rotulo
MOV DL, '0'  ; Caractere "0"

IMPRIME: ; Define um rotulo
MOV AH, 02h ; Função que exibe um caracter
INT 21h

LOOP IMP_BIN ; Decrementa 1 de CX, se o conteudo de CX não for 0 pula para o rotulo

RET ; Retorna para a função principal
IMPRIMIR ENDP ; Finaliza a função

END MAIN ; Encerra o programa