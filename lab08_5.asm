TITLE EXTRA ; Da titulo ao programa

.MODEL SMALL ; Divide os códigos e dados lidos em 64kb

; Início do local onde são declarado as variáveis
.DATA
; Declaração de variáveis
MSG1 DB 13, 10, "Digite b para entrada de um numero binario e h para a entrada de um numero hexadecimal: $"
MSG2 DB 13, 10, "Digite 0 ou 1 para o numero binario: $"
MSG3 DB 13, 10, "Digite um numero de 0 a 9 ou A a F para o numero hexadecinal: $"
MSG4 DB 13, 10, "Numero: $"
MSG5 DB 13, 10, "Digite b para saida de um numero binario e h para a saida de um numero hexadecimal: $"

; Início do código onde estão as instruções
.CODE 

MAIN PROC ; Define a função principal
; Permite o acesso as variaveis definidas em .DATA
MOV AX, @DATA
MOV DS, AX

ESCOLHA1: ; Define o rotulo
MOV AH, 09h ; Função que exibe uma string
MOV DX, OFFSET MSG1
INT 21h

MOV AH, 01h ; Função que le um caracter
INT 21h

CMP AL, "b" ; Compara o valor de AL com o caracter b
JNE NOT_B ; Se for não for igual pula para o rotulo
CALL LEITURABIN ; Chama a função de leitura
JMP CONTINUA ; Salta incondicionalmente pra o rotulo

NOT_B:
CMP AL, "h" ; Compara o valor de AL com o caracter h
JNE ESCOLHA1 ; Se for não for igual pula para o rotulo
CALL LEITURAH ; Chama a função de leitura

CONTINUA: ; Define o rotulo

ESCOLHA2: ; Define o rotulo
MOV AH, 09h ; Função que exibe uma string
MOV DX, OFFSET MSG5
INT 21h

MOV AH, 01h ; Função que le um caracter
INT 21h

CMP AL, "b" ; Compara o valor de AL com o caracter b
JNE NOTB ; Se for não for igual pula para o rotulo
CALL IMPRIMIRBIN ; Chama a função de impressão
JMP FINAL ; Salta incondicionalmente pra o rotulo

NOTB:
CMP AL, "h" ; Compara o valor de AL com o caracter h
JNE ESCOLHA2 ; Se for não for igual pula para o rotulo
CALL IMPRIMIRH ; Chama a função de impressão

FINAL:

MAIN ENDP ; Encerra a função principal
MOV AH, 4CH
INT 21h

LEITURABIN PROC ; Define a função
MOV CX, 16 ; Move 16 para o conteudo de CX

LER_BIN: ; Define um rotulo
MOV AH, 09h ; Função que exibe uma string
MOV DX, OFFSET MSG2
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
LEITURABIN ENDP ; Finaliza a função

IMPRIMIRBIN PROC ; Define a função

MOV AH, 09h ; Função que exibe uma string
MOV DX, OFFSET MSG4
INT 21h

MOV CX, 16 ; Move 16 para o conteudo de CX

IMP_BIN: ; Define um rotulo

ROL BX, 1 ; Rotaciona o bit mais significativo para o final 

JC MOSTRA_1 ; Se CF = 1, pula para imprimir "1"
JMP MOSTRA_0 ; Senão, imprime "0"

MOSTRA_1: ; Define um rotulo
MOV DL, '1' ; Caractere "1"
JMP IMPRIME1 ; Salta incondicionalmente pra o rotulo

MOSTRA_0: ; Define um rotulo
MOV DL, '0'  ; Caractere "0"

IMPRIME1: ; Define um rotulo
MOV AH, 02h ; Função que exibe um caracter
INT 21h

LOOP IMP_BIN ; Decrementa 1 de CX, se o conteudo de CX não for 0 pula para o rotulo

RET ; Retorna para a função principal
IMPRIMIRBIN ENDP ; Finaliza a função

LEITURAH PROC ; Define a função

MOV CX, 4 ; Move 4 para o conteudo de CX

LER_HEX: ; Define um rotulo
MOV AH, 09h ; Função que exibe uma string
MOV DX, OFFSET MSG3
INT 21h

MOV AH, 01h ; Função que le um caracter
INT 21h

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
CMP AL, "F" ; Compara o valor de AL com o codigo ASCII de A
JBE ADICIONAR_LETRA ; ; Se for menor ou igual pula para o rotulo
JMP LER_HEX ; Salta incondicionalmente pra o rotulo

ADICIONAR_NUM: ; Define um rotulo

SUB AL, "0" ; Transforma o conteudo de AL de ASCII para numero
SHL BX, 4 ; Move os bits quatro casas para a esquerda
OR BL, AL ; Faz um OR entre BL e AL

LOOP LER_HEX ; Decrementa 1 de CX, se o conteudo de CX não for 0 pula para o rotulo
JMP ENCERRAR ; Salta incondicionalmente pra o rotulo

ADICIONAR_LETRA: ; Define um rotulo

SUB AL, 'A' ; Subtrai o numero ASCII de A pelo conteudo de AL
ADD AL, 10 ; Soma 10 a AL
SHL BX, 4 ; Move os bits quatro casas para a esquerda
OR BL, AL ; Faz um OR entre BL e AL

LOOP LER_HEX ; Decrementa 1 de CX, se o conteudo de CX não for 0 pula para o rotulo

ENCERRAR: ; Define um rotulo

RET ; Retorna para a função principal
LEITURAH ENDP ; Finaliza a função

IMPRIMIRH PROC ; Define a função

MOV AH, 09h ; Função que exibe uma string
MOV DX, OFFSET MSG4
INT 21h 

MOV CX, 4 ; 16 bits → 4 nibbles

IMP_HEX: ; Define um rotulo
ROL BX, 4 ; Move o próximo nibble para os 4 bits mais baixos

MOV DL, BL ; Move o conteudo de BL para DL
AND DL, 0Fh ; Isola o nibble

CMP DL, 9 ; Compara o conteudo de DL com 9
JBE CONVERTE_NUM ; Se ≤ 9, é número
ADD DL, "A" ; Soma o valor de ASCII de A para DL
SUB DL, 10 ; Ajusta para letras A–F
JMP IMPRIME2 ; Salta incondicionalmente pra o rotulo

CONVERTE_NUM: ; Define um rotulo
ADD DL, '0' ; Converte para ASCII

IMPRIME2: ; Define um rotulo
MOV AH, 02h ; Função que imprime caractere
INT 21h            

LOOP IMP_HEX ; Decrementa 1 de CX, se o conteudo de CX não for 0 pula para o rotulo

MOV AH, 02h ; Função que imprime caractere
MOV DL, "h"
INT 21h

RET ; Retorna para a função principal
IMPRIMIRH ENDP ; Finaliza a função

END MAIN ; Encerra o programa