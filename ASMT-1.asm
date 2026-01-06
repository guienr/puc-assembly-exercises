TITLE FAZER UM PROGRAMA QUE LEIA UMA FRAÇÃO M/N (M < N E M E N < 9) E IMPRIMA A PARTE DECIMAL, EX 5/7=0.71

.MODEL SMALL

.STACK 100

.DATA
MSG1 DB 13, 10, "Numerador: $"
MSG2 DB 13, 10, "Denominador: $"
R DB 13, 10, "Resultado decimal: $"
M DB ?
N DB ?

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    CALL LER

    CALL DECIMAL

    MOV AH, 4CH
    INT 21h
MAIN ENDP

LER PROC
    PUSH AX
    PUSH DX

    LE1:

    MOV AH, 09h
    LEA DX, MSG1
    INT 21h

    MOV AH, 01h
    INT 21h

    CMP AL, "0"
    JB LE1

    CMP AL, "9"
    JA LE1

    AND AL, 0Fh
    MOV M, AL

    LE2:

    MOV AH, 09h
    LEA DX, MSG2
    INT 21h

    MOV AH, 01h
    INT 21h

    CMP AL, "0"
    JB LE2

    CMP AL, "9"
    JA LE2

    AND AL, 0Fh
    MOV N, AL

    POP DX
    POP AX
    RET
LER ENDP

DECIMAL PROC
    PUSH AX         ; Salva registradores usados
    PUSH CX
    PUSH BX
    PUSH DX

    MOV AH, 09h     ; Imprime "Resultado decimal: "
    LEA DX, R
    INT 21h

    MOV AH, 02h     ; Imprime "0."
    MOV DL, "0"
    INT 21h
    MOV DL, "."
    INT 21h

    ; Inicia o cálculo
    MOV AL, M       ; AL = M (Numerador)
    MOV BL, N       ; BL = N (Denominador, fixo)
    MOV CX, 2       ; Loop para 2 casas decimais

    ; O cálculo começa com AL = M (Numerador). Para a primeira casa, 
    ; o dividendo é M * 10. Para as subsequentes, é o resto * 10.
    
DENOVO:
    ; Passo 1: Multiplicar o numerador atual por 10
    PUSH AX         ; Salva o numerador atual (AL)
    XOR AH, AH       ; Zera AH
    MOV DL, 10      ; Multiplicador
    MUL DL          ; AX = AL * 10 (Novo Dividendo). AL foi o resto do passo anterior.
    POP DX          ; Restaura o Numerador/Resto anterior (Não usado, mas limpa o stack)

    ; Passo 2: Dividir por N
    DIV BL          ; AL = Quociente (Dígito decimal), AH = Resto (Novo numerador)
    
    ; Passo 3: Exibir o dígito (Quociente AL)
    PUSH AX         ; Salva AX (Quociente em AL, Resto em AH)
    MOV DL, AL
    ADD DL, 30h     ; Converte o dígito (0-9) para seu caractere ASCII ('0'-'9')
    MOV AH, 02h
    INT 21h         ; Exibe o dígito decimal
    POP AX          ; Restaura AX

    ; Passo 4: Preparar para a próxima iteração
    MOV AL, AH      ; Move o Resto (AH) para AL (Novo numerador para a próxima volta)

    LOOP DENOVO     ; Decrementa CX, se CX != 0 salta para DENOVO

    POP DX
    POP BX
    POP CX
    POP AX
    RET
DECIMAL ENDP

END MAIN

; ALGORITIMO:
; M * 10 / N
; IMPRIME Q
; Q <- RESTO
; LOOP