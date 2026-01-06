TITLE WHILE_EX1 ; Da titulo ao programa

.MODEL SMALL ; Divide os códigos e dados lidos em 64kb

; Início do local onde são declarado as variáveis
.DATA
; Declaração de variáveis
MSG1 DB 13, 10, "Digite 0 ou 1 para o numero binario: $"
MSG2 DB 13, 10, "Numero: $"

; Início do código onde estão as instruções
.CODE 

MAIN PROC ; Define a função principal
; Permite o acesso as variaveis definidas em .DATA
MOV AX, @DATA
MOV DS, AX

MOV BX, 0 ; Joga 0 para o conteudo de BX

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

SUB AL, "0" ; Transforma o valor de AL de ASCII para numero

CMP AL, 13 ; Compara o valor de AL com CR
JE ENCERRAR ; Se for igual pula para o rotulo

CMP AL, 0 ; Compara o valor de AL com 0
JE ADICIONAR ; Se for igual pula para o rotulo

CMP AL, 1 ; Compara o valor de AL com 1
JE ADICIONAR ; Se for igual pula para o rotulo

JMP LER_BIN ; Salta incondicionalmente pra o rotulo

ADICIONAR: ; Define o rotulo

SHL BX, 1 ; Move os bits uma casa para a esquerda
OR BL, AL ; Faz um OR entre BL e AL

SUB CX, 1 ; Subtrai 1 de CX
CMP CX, 0 ; Compara o valor de CX com 0
JNE LER_BIN ; Se nao for igual a zero pula para o rotulo

ENCERRAR: ; Define o rotulo

RET ; Retorna para a função principal
LEITURA ENDP ; Encerra a função

IMPRIMIR PROC ; Define a função

MOV AH, 09h ; Função que exibe uma string
MOV DX, OFFSET MSG2
INT 21h

MOV CX, 16 ; Move 16 para o conteudo de CX

IMP_BIN: ; Define o rotulo

ROL BX, 1 ; Rotaciona o bit mais significativo para o final 

JC MOSTRA_1 ; Se CF = 1, pula para imprimir "1"
JMP MOSTRA_0 ; Senão, imprime "0"

MOSTRA_1: ; Define o rotulo
MOV DL, '1' ; Caractere "1"
JMP IMPRIME ; Pula incondicionamente para o rotulo

MOSTRA_0: ; Define o rotulo
MOV DL, '0' ; Caractere "0"

IMPRIME: ; Define o rotulo
MOV AH, 02h ; Função que exibe o caracter 
INT 21h

LOOP IMP_BIN ; Decrementa 1 de CX, se o conteudo de CX não for 0 pula para o rotulo

RET ; Retorna para a função principal
IMPRIMIR ENDP ; Finaliza a função

END MAIN ; Encerra o programa