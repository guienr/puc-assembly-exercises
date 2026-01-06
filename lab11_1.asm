TITLE Matriz ; Define o título do programa

.MODEL SMALL ; Define o modelo de memória como SMALL, com o código e os dados tendo um segmento de 64KB cada

.STACK 100 ; Aloca 100 bytes para a pilha

.DATA ; Início do segmento de dados, onde as variáveis são declaradas

N EQU 4 ; Define uma constante simbólica N com o valor 4 (tamanho da matriz N x N)

; Declara e inicializa a matriz 4x4
MATRIZ DB 'O','A','B','C'
       DB 'D','O','E','F'
       DB 'G','H','O','I'
       DB 'J','K','L','O'

MATRIZTROCA DB N DUP (N DUP(?)) ; Declara e aloca espaço para a matriz destino, onde o resultado será armazenado

PULA_LINHA DB 10,13,'$' ; String para pular linha

.CODE ; Início do segmento de código
MAIN PROC ; Início do procedimento principal

MOV AX,@DATA ; Carrega o endereço do segmento de dados no registrador AX
MOV DS,AX ; Define o registrador de segmento de dados com o endereço carregado

LEA DX, PULA_LINHA
MOV AH,09h ; Define a função para imprimir string e pular linha
INT 21h

LEA BX,MATRIZ
CALL LE_MATRIZ ; Chama a função de leitura de matriz 

LEA DX, PULA_LINHA
MOV AH,09h ; Define a função para imprimir string e pular linha
INT 21h

CALL IMP_MATRIZ ; Chama a função de impressão de matriz 

LEA DX, PULA_LINHA
MOV AH,09h ; Define a função para imprimir string e pular linha
INT 21h

CALL TROCA_MATRIZ ; Chama a função de troca dos elementos da matriz

LEA BX,MATRIZTROCA ; Carrega o endereço da matriz resultante (MATRIZTROCA) em BX.
CALL IMP_MATRIZ ; Chama a função de impressão de matriz

MOV AH,4CH ; Define a função que encerra o programa
INT 21h
MAIN ENDP ; Fim do procedimento principal

; Procedimento para Imprimir Matriz 
IMP_MATRIZ PROC
; Imprime uma matriz N X N
; Entrada: BX tem o offset da matriz
; Saida: matriz impressa na tela
PUSH AX ; Salva os registradores na pilha
PUSH BX
PUSH CX
PUSH DX
PUSH SI

MOV CH,N ; CH (contador de linha) = N (4)
L1: ; Início do loop de linhas
XOR SI,SI ; SI (offset de coluna) = 0
MOV CL,N ; CL (contador de coluna) = N (4)
MOV AH,02h ; Função que imprime um caractere

L2: 
MOV DL, [BX][SI] ; Carrega o byte na posição [BX + SI] em DL.
OR DL,30h ; Converte número para ASCII
INT 21h
INC SI ; Incrementa o offset da coluna
DEC CL ; Decrementa 1 a CL
JNZ L2 ; Loop L2 enquanto CL não for zero

LEA DX, PULA_LINHA 
MOV AH,09h ; Define a função para imprimir string e pular linha
INT 21h

ADD BX,N ; Avança o ponteiro BX para o início da próxima linha
DEC CH ; Decrementa 1 a CH
JNZ L1 ; Loop L1 enquanto CH não for zero 

POP SI
POP DX
POP CX
POP BX
POP AX
; Restaura os registradores salvos
RET ; Retorna para a função principal
IMP_MATRIZ ENDP ; Fim do procedimento IMP_MATRIZ

; Procedimento para Ler Matriz
LE_MATRIZ PROC
; Le uma matriz N X N 
; Entrada: BX tem o offset da matriz
; Saida: Matriz lida armazenada na memória
PUSH AX
PUSH BX
PUSH CX
PUSH DX
PUSH SI
; Salva os registradores

MOV CH,N ; CH (contador de linha) = N (4)
L111: ; Loop de linhas
XOR SI,SI ; SI (offset de coluna) = 0
MOV CL,N ; CL (contador de coluna) = N (4)
MOV AH,01h ; Função que le um caractere

L222: 
INT 21H
AND AL,0Fh ; Converte o código ASCII para numero
MOV [BX][SI],AL ; Armazena o valor lido na matriz
INC SI ; Incrementa o offset da coluna
DEC CL ; Decrementa 1 a CL
JNZ L222 ; Loop de colunas enquanto CL não for zero

LEA DX, PULA_LINHA
MOV AH,09h ; Define a função para imprimir string e pular linha
INT 21h

ADD BX,N ; Vai para a próxima linha
DEC CH ; Decrementa 1 a CH
JNZ L111 ; Loop de linhas enquanto CH não for zero 

POP SI
POP DX
POP CX
POP BX
POP AX
; Restaura os registradores
RET ; Retorna para a função principal
LE_MATRIZ ENDP ; Fim do procedimento LE_MATRIZ

; Procedimento para Trocar Elementos da Matriz
TROCA_MATRIZ PROC
; Troca elementos de cima na diagonal principal com as debaixo
; Entrada: matriz
; Saida: matriztroca

PUSH BX
PUSH CX
PUSH DX
PUSH SI
PUSH DI
; Salva os registradores

; Diagonal se mantem (Copia a diagonal principal)
MOV CX,N ; Loop 4 vezes
XOR BX,BX ; BX = 0, offset da linha
XOR SI,SI ; SI = 0 offset da coluna

DIAGONAL:
MOV DL,MATRIZ [BX][SI] ; Carrega M[BX+SI] (diagonal) em DL
MOV MATRIZTROCA[BX][SI],DL ; Copia para T[BX+SI]
INC SI ; Avança a coluna para o próximo

ADD BX,N ; Avança a linha para o próximo
LOOP DIAGONAL ; Loop até que CX seja igual a zero

; LINHA 12 para LINHA 0 (Copia M[0, 1..3] para T[3, 0..2])
MOV CX,N
DEC CX ; CX = 3 (loop 3 vezes, colunas 1, 2, 3)
XOR BX,BX ; BX = 0 (offset da linha de ORIGEM: 0)
MOV SI,1 ; SI = 1 (coluna de ORIGEM: M[0, 1])
XOR DI,DI ; DI = 0 (coluna de DESTINO: T[3, 0])

T0:
MOV DL, MATRIZ[BX][SI] ; DL = M[0, SI] (elementos A, B, C)
MOV MATRIZTROCA [BX+12][DI],DL ; T[12+DI] = DL (Copia para a linha 3, colunas 0, 1, 2)
INC SI ; Incrementa 1 a SI
INC DI ; Incrementa 1 a DI
LOOP T0 ; Loop até que CX seja igual a zero

; LINHA 0 para LINHA 12 (Copia M[3, 0..2] para T[0, 1..3])
MOV CX,N 
DEC CX ; CX = 3
MOV BX,12 ; BX = 12 (offset da linha de ORIGEM: 3)
XOR SI,SI ; SI = 0 (coluna de ORIGEM: M[3, 0])
MOV DI,1 ; DI = 1 (coluna de DESTINO: T[0, 1])

T1:
MOV DL, MATRIZ[BX][SI] ; DL = M[12, SI] (elementos J, K, L)
MOV MATRIZTROCA [BX-12][DI],DL ; T[0+DI] = DL (Copia para a linha 0, colunas 1, 2, 3)
INC SI ; Incrementa 1 a SI
INC DI ; Incrementa 1 a DI
LOOP T1 ; Loop até que CX seja igual a zero

; COLUNA 4,0 PARA para 8,3 E VICE-VERSA (Troca M[1, 0] com M[2, 3])
MOV BX,4 ; BX = 4 (offset da linha 1)
XOR SI,SI ; SI = 0 (coluna 0)
MOV DI,3 ; DI = 3 (coluna 3)

MOV DL, MATRIZ[BX][SI] ; DL = M[4, 0] (Elemento D)
MOV MATRIZTROCA[BX+4][DI],DL ; T[8, 3] = D. (Elemento na Linha 2, Coluna 3)

MOV DL, MATRIZ[BX+4][DI] ; DL = M[8, 3] (Elemento I)
MOV MATRIZTROCA[BX][SI],DL ; T[4, 0] = I. (Elemento na Linha 1, Coluna 0)

; LINHA 4 PARA LINHA 8 (Copia M[1, 2..3] para T[2, 0..1])
MOV CX,N
DEC CX ; Decrementa 1 de CX
DEC CX ; Decrementa 1 de CX
; CX = 2 (loop 2 vezes, colunas 2, 3)
MOV BX,4 ; BX = 4 (offset da linha de ORIGEM: 1)
MOV SI,2 ; SI = 2 (coluna de ORIGEM: 2)
XOR DI,DI ; DI = 0 (coluna de DESTINO: 0)

T2:
MOV DL, MATRIZ[BX][SI]
; DL = M[4, SI] (elementos E, F).
MOV MATRIZTROCA [BX+4][DI],DL
; T[8+DI] = DL (Copia para a linha 2, colunas 0, 1).
INC SI ; Incrementa 1 a SI
INC DI ; Incrementa 1 a DI
LOOP T2 ; Loop até que CX seja igual a zero

; LINHA 8 PARA LINHA 4 (Copia M[2, 0..1] para T[1, 2..3])
MOV CX,N
DEC CX ; Decrementa 1 de CX
DEC CX ; Decrementa 1 de CX
; CX = 2
MOV BX,8 ; BX = 8 (offset da linha de ORIGEM: 2)
XOR SI,SI ; SI = 0 (coluna de ORIGEM: 0)
MOV DI,2 ; DI = 2 (coluna de DESTINO: 2)

T3:
MOV DL, MATRIZ[BX][SI] ; DL = M[8, SI] (elementos G, H)
MOV MATRIZTROCA [BX-4][DI],DL ; T[4+DI] = DL (Copia para a linha 1, colunas 2, 3)
INC SI ; Incrementa 1 a SI
INC DI ; Incrementa 1 a DI
LOOP T3 ; Loop até que CX seja igual a zero

POP DI
POP SI
POP DX
POP CX
POP BX
; Restaura os registradores 

RET ; Retorna para a função principal
TROCA_MATRIZ ENDP ; Fim do procedimento TROCA_MATRIZ

END MAIN ; Fim do programa 