TITLE FAZER UM PROGRAMA QUE LE UMA STRING E IMPRIME

.MODEL SMALL

.STACK 100

IMP_VET MACRO VETOR, TAMANHO
    LEA DX, VETOR
    MOV AH, 09h
    INT 21h
ENDM

PULA_LINHA MACRO
    MOV DL, 13
    MOV AH, 2
    INT 21h
    MOV DL, 10
    INT 21h
ENDM

IMP_POR_LODSB MACRO VETOR, TAMANHO
    ; 1. Configura o ponteiro de origem (SI)
    LEA SI, VETOR
    
    ; 2. Configura o contador (CX) usando o parâmetro da macro
    MOV CX, TAMANHO 
    
    ; 3. Define a função de impressão de caractere fora do loop (mais eficiente)
    MOV AH, 02h 
    
    VOLTA:
    LODSB        ; Carrega byte de [DS:SI] para AL e incrementa SI
    MOV DL, AL   ; Move o caractere (em AL) para DL para impressão
    INT 21h      ; Imprime o caractere (usando AH=02h)
    LOOP VOLTA   ; Decrementa CX e salta para VOLTA se CX != 0
ENDM

.DATA
TAM EQU 6
STR1 DB 6 DUP(?), "$"
STR2 DB 6 DUP(?), "$"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX

    CLD

    LEA DI, STR1

    MOV CX, TAM
    MOV AH, 01h
    LE_N:
    INT 21h
    STOSB
    LOOP LE_N

    PULA_LINHA

    LEA SI, STR1
    LEA DI, STR2

    IMP_VET STR1, TAM
    PULA_LINHA
    IMP_VET STR2, TAM
    PULA_LINHA

    MOV CX, TAM
    REP MOVSB

    IMP_VET STR2, TAM
    PULA_LINHA

    IMP_POR_LODSB STR2, TAM

    MOV AH, 4CH
    INT 21h
MAIN ENDP
END MAIN