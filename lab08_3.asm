TITLE WHILE_EX3 ; Da titulo ao programa

.MODEL SMALL ; Divide os códigos e dados lidos em 64kb

; Início do local onde são declarado as variáveis
.DATA
; Declaração de variáveis
MSG1 DB 13, 10, "Digite um numero de 0 a 9 ou A a F para o numero hexadecinal: $"
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

MOV BX, 0 ; Zera o conteudo de BX

CALL LEITURA ; Chama a função de leitura

CALL IMPRIMIR ; Chama a função de impressão

MAIN ENDP ; Encerra a função principal
MOV AH, 4CH
INT 21h


LEITURA PROC ; Define a função

MOV CX, 4 ; Move 4 para o conteudo de CX

LER_HEX: ; Define um rotulo
MOV AH, 09h ; Função que exibe uma string
MOV DX, OFFSET MSG1
INT 21h

MOV AH, 01h ; Função que le um caracter
INT 21h

CMP AL, 13 ; Compara o valor de AL com CR
JE ENCERRAR ; Se for igual pula para o rotulo

CMP AL, "0" ; Compara o valor de AL com o codigo ASCII de 0
JAE CONFERE_NUM ; Se for maior ou igual pula para o rotulo
JMP LER_HEX ; Salta incondicionalmente pra o rotulo

CONFERE_NUM: ; Define um rotulo
CMP AL, "9" ; Compara o valor de AL com o codigo ASCII de 9
JBE ADICIONAR_NUM ; Se for menor ou igual pula para o rotulo

CMP AL, "A" ; Compara o valor de AL com o codigo ASCII de A
JAE CONFERE_LETRA ; Se for maior ou igual pula para o rotulo
JMP LER_HEX ; Salta incondicionalmente pra o rotulo

CONFERE_LETRA: ; Define um rotulo
CMP AL, "F" ; Compara o valor de AL com o codigo ASCII de F
JBE ADICIONAR_LETRA ; Se for menor ou igual pula para o rotulo
JMP LER_HEX ; Salta incondicionalmente pra o rotulo

ADICIONAR_NUM: ; Define um rotulo

SUB AL, "0" ; Transforma o conteudo de AL de ASCII para numero
SHL BX, 4 ; Move os bits quatro casas para a esquerda
OR BL, AL ; Faz um OR entre BL e AL

SUB CX, 1 ; Subtrau 1 de CX
CMP CX, 0 ; Compara o valor de CX com 0
JNE LER_HEX ; Se não for igual pula para o rotulo
JMP ENCERRAR ; Salta incondicionalmente pra o rotulo

ADICIONAR_LETRA: ; Define um rotulo

SUB AL, 'A' ; Subtrai o codigo ASCII de A em AL
ADD AL, 10 ; Soma 10 a AL
SHL BX, 4 ; Move os bits quatro casas para a esquerda
OR BL, AL ; Faz um OR entre BL e AL

SUB CX, 1 ; Subtrau 1 de CX
CMP CX, 0 ; Compara o valor de CX com 0
JNE LER_HEX ; Se não for igual pula para o rotulo

ENCERRAR: ; Define um rotulo

RET ; Retorna para a função principal
LEITURA ENDP ; Finaliza a função

IMPRIMIR PROC ; Define a função

MOV AH, 09h ; Função que exibe uma string
MOV DX, OFFSET MSG2
INT 21h 

MOV CX, 4 ; 16 bits → 4 nibbles

IMP_HEX: ; Define um rotulo
ROL BX, 4 ; Move o próximo nibble para os 4 bits mais baixos

MOV DL, BL ; Move o conteudo de BL para DL
AND DL, 0Fh ; Isola o nibble 

CMP DL, 9 ; Compara o valor de DL com 9
JBE CONVERTE_NUM ; Se ≤ 9, é número
ADD DL, "A" ; Adiciona o valor de ASCII para DL 
SUB DL, 10 ; ajusta para letras A–F
JMP IMPRIME ; Salta incondicionalmente pra o rotulo

CONVERTE_NUM: ; Define um rotulo
ADD DL, '0' ; Converte para ASCII

IMPRIME: ; Define um rotulo
MOV AH, 02h ; Função que imprime um caracter
INT 21h 

LOOP IMP_HEX ; Decrementa 1 de CX, se o conteudo de CX não for 0 pula para o rotulo

MOV AH, 02h ; Função que imprime um caracter
MOV DL, "h"
INT 21h

RET ; Retorna para a função principal
IMPRIMIR ENDP ; Finaliza a função

END MAIN ; Encerra o programa