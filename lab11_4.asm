TITLE Matriz ; Define o título do programa

.MODEL SMALL
; Define o modelo de memória como SMALL, o código e os dados são divididos em um único segmento de 64KB

.STACK 100h
; Aloca 256 bytes para a pilha do programa

.DATA ; Início do segmento de dados, onde as variáveis são declaradas
N EQU 3 ; Define uma constante simbólica N com o valor 3, as matrizes serão 3x3

; Declara e aloca espaço para a Matriz 1 (3x3), '?' não inicializado
MATRIZ1 DB N DUP (N DUP(?))

; Declara e aloca espaço para a Matriz 2 (3x3)
MATRIZ2 DB N DUP (N DUP(?))

; Declara e aloca espaço para a Matriz Resultado da Soma (3x3)
MATRIZSOMA DB N DUP (N DUP(?))

; String para pular
PULA_LINHA DB 10,13,'$'

; Início do segmento de código
.CODE
; Início do procedimento principal
MAIN PROC
MOV AX,@DATA ; Carrega o endereço do segmento de dados no registrador AX
MOV DS,AX ; Define o registrador de segmento de dados com o endereço carregado.

; Leitura da MATRIZ1
LEA BX,MATRIZ1 ; Carrega o endereço da MATRIZ1 em BX
CALL LE_MATRIZ ; Chama o procedimento para ler a MATRIZ1

LEA DX, PULA_LINHA
MOV AH,09h ; Imprime uma nova linha
INT 21h

; Impressão da MATRIZ1
LEA BX,MATRIZ1 ; Carrega o endereço da MATRIZ1 em BX 
CALL IMP_MATRIZ ; Chama o procedimento para imprimir a MATRIZ1

LEA DX, PULA_LINHA
MOV AH,09h ; Imprime uma nova linha
INT 21h

; Leitura da MATRIZ2
LEA BX,MATRIZ2 ; Carrega o endereço da MATRIZ2 em BX
CALL LE_MATRIZ ; Chama o procedimento para ler a MATRIZ2

LEA DX, PULA_LINHA
MOV AH,09h ; Imprime uma nova linha
INT 21h

; Impressão da MATRIZ2
LEA BX,MATRIZ2 ; Carrega o endereço da MATRIZ2 em BX
CALL IMP_MATRIZ ; Chama o procedimento para imprimir a MATRIZ2

LEA DX, PULA_LINHA
MOV AH,09h ; Imprime uma nova linha
INT 21h

; Soma das Matrizes
CALL SOMA_MATRIZ ; Chama o procedimento para somar MATRIZ1 e MATRIZ2, armazenando o resultado em MATRIZSOMA

LEA DX, PULA_LINHA
MOV AH,09h ; Imprime uma nova linha 
INT 21h

; Impressão da Matriz Soma
LEA BX,MATRIZSOMA ; Carrega o endereço da MATRIZSOMA em BX
CALL IMP_MATRIZ ; Imprime a matriz resultante

; Finalização do Programa
MOV AH,4CH ; Define a função para encerrar o programa
INT 21h
MAIN ENDP ; Fim do procedimento principal


IMP_MATRIZ PROC
; Imprime uma matriz N X N
; Entrada: BX tem o offset da matriz
; Saida: matriz impressa

PUSH AX
PUSH BX
PUSH CX
PUSH DX
PUSH SI
; Salva os registradores na pilha

MOV CH,N ; CH (contador de linhas) = N (3)
; Início do loop de linhas
L1: 
XOR SI,SI ; SI (offset de coluna) = 0
MOV CL,N ; CL (contador de colunas) = N (3)
MOV AH,02h ; Função para imprimir caractere em DL
L2: 
MOV DL, [BX][SI] ; Carrega o byte na posição [BX + SI] (elemento da matriz) em DL
OR DL,30h ; Converte o valor numérico (0-9) armazenado em byte para seu código ASCII correspondente ('0'-'9')
; O dígito '0' em ASCII é 30H. Ex: 5 OR 30H = 35H (ASCII para '5').
INT 21h
INC SI ; Avança para o próximo elemento na linha
DEC CL ; Decrementa 1 de CL
JNZ L2
; Loop L2 (colunas) enquanto CL não for zero

LEA DX, PULA_LINHA
MOV AH,09h ; Imprime a nova linha
INT 21h

ADD BX,N ; Avança o ponteiro BX para o início da próxima linha
DEC CH ; Decrementa 1 de CH
JNZ L1
; Loop L1 (linhas) enquanto CH não for zero

POP SI
POP DX
POP CX
POP BX
POP AX
; Restaura os registradores salvos
RET ; Retorna para a função principal
IMP_MATRIZ ENDP ; Encerra a função de impressão da matriz

LE_MATRIZ PROC
; Le uma matriz N X N
; Entrada: BX tem o offset da matriz
; Saida: matriz lida

PUSH AX
PUSH BX
PUSH CX
PUSH DX
PUSH SI
; Salva os registradores

MOV CH,N ; CH (contador de linhas) = N (3)
L111: ; Loop de linhas
XOR SI,SI ; Limpa o conteúdo de SI
MOV CL,N ; CL (contador de colunas) = N (3)
MOV AH,01h ; Função que le um caractere e armazena em AL
L222: ; Loop de colunas
INT 21h 
AND AL,0Fh ; Converte o código ASCII do dígito lido (30h-39h) para seu valor numérico (0h-9h)
MOV [BX][SI],AL ; Armazena o valor numérico (0-9) na matriz
INC SI ; Avança para o próximo elemento na linha
DEC CL ; Decrementa 1 de CL
JNZ L222
; Loop de colunas

LEA DX, PULA_LINHA
MOV AH,09h ; Imprime uma nova linha 
INT 21h

ADD BX,N ; Vai para a próxima linha
DEC CH ; Decrementa 1 de CH
JNZ L111
; Loop de linhas

POP SI
POP DX
POP CX
POP BX
POP AX
; Restaura os registradores
RET ; Retorna para a função principal
LE_MATRIZ ENDP ; Encerra a função de leitura da matriz

SOMA_MATRIZ PROC
; Soma duas matrizes N X N: MATRIZ1 e MATRIZ2
; Entrada: MATRIZ1 e MATRIZ2
; Saida: Matriz soma armazenada em MATRIZSOMA

PUSH AX
PUSH BX
PUSH CX
PUSH DX
PUSH SI
; Salva os registradores

MOV CH,N ; CH (contador de linhas) = N (3)
XOR BX,BX ; BX = 0 (BX será usado como offset de linha: 0, 3, 6)
L11: ; Loop de linhas
XOR SI,SI ; SI = 0 (SI será usado como offset de coluna: 0, 1, 2)

MOV CL,N ; CL (contador de colunas) = N (3)
L22: ; Loop de colunas
MOV DL, MATRIZ1[BX][SI] ; DL = M1[BX+SI] (Carrega o elemento de M1)
ADD DL, MATRIZ2[BX][SI] ; DL = DL + M2[BX+SI] (Soma com o elemento correspondente de M2. A soma de dois dígitos de 0-9 resulta em um byte de 0-18, o que cabe em DL)
MOV MATRIZSOMA[BX][SI],DL ; Armazena o resultado da soma (valor numérico) em MATRIZSOMA
INC SI ; Próxima coluna
DEC CL ; Decrementa 1 de CL
JNZ L22
; Loop L22 (colunas)

ADD BX,N ; Avança o offset de linha (BX = BX + N)
DEC CH ; Decrementa 1 de CH
JNZ L11
; Loop L11 (linhas)

POP SI
POP CX
POP BX
POP AX
; Restaura os registradores salvos
RET ; Retorna para a função principal
SOMA_MATRIZ ENDP ; Fim do procedimento SOMA_MATRIZ

END MAIN ; Fim do programa