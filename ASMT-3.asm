TITLE ENCONTRE A POSIÇÃO K DO MAIOR ELEMENTO I E TROQUE A[K] POR A[I], ORDENE O VETOR CRESCENTEMENTE

.MODEL SMALL

.STACK 100h

.DATA 
N EQU 7
A DB 1, 4, 3, 8, 2, 7, 5

.CODE

PULA_LINHA MACRO
    MOV AH, 02h
    MOV DL, 13
    INT 21h
    MOV DL, 10
    INT 21h
ENDM

SALVA_REG MACRO
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
ENDM

RECUPERA_REG MACRO
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
ENDM

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AH, 09h
    LEA DX, A
    INT 21h

    PULA_LINHA

    LEA SI, A
    CALL ORDENA

    MOV AH, 09h
    LEA DX, A
    INT 21h

    MOV AH, 4CH
    INT 21h
MAIN ENDP

ORDENA PROC
    SALVA_REG
    
    MOV CX, N
    MOV BX, 1

CRESCENTE:
    
    MOV SI, BX
    MOV AL, [SI] 

ARRUMA:
    CMP SI, 0           ; Verifica se SI é > 0 (limite inferior do array)
    JE FINAL_INTERNO    ; Se SI == 0, a inserção está completa

    ; Compara o valor 'pivot' (AL) com o elemento anterior A[SI-1]
    CMP AL, [SI-1]
    JAE FINAL_INTERNO   ; Se AL >= A[SI-1], não precisa mover mais para trás (já está ordenado)

    ; Move o elemento maior (A[SI-1]) para a direita (A[SI])
    MOV AH, [SI-1]     ; AH = A[SI-1] (elemento maior)
    MOV [SI], AH       ; A[SI] = A[SI-1] (move para a direita)

    DEC SI              ; Move para a próxima posição de comparação (SI - 1)
    JMP ARRUMA

FINAL_INTERNO:
    ; Insere o valor original (AL) na posição correta
    MOV [SI], AL
    
    INC BX              ; Passa para o próximo elemento a ser inserido
    LOOP CRESCENTE      ; Decrementa CX e volta para CRESCENTE se CX != 0

    RECUPERA_REG

    RET
ORDENA ENDP

END MAIN