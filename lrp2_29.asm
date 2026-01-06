TITLE EX29

; Define o modelo de memória como 'SMALL' (código e dados em um único segmento de 64KB)
.MODEL SMALL

; Define o tamanho da pilha como 100h bytes
.STACK 100

; --- SEÇÃO DE DADOS (.DATA) ---
.DATA
; Mensagens para interação com o usuário (DB = Define Byte)
; 13 = Carriage Return (retorno de carro), 10 = Line Feed (nova linha)
MSG1 DB 13, 10, "Digite o numero 1(0 ou 1, max 16 bits, Enter para parar): $"
MSG2 DB 13, 10, "Soma: $"
MSG3 DB 13, 10, "Caractere invalido, digite novamente $"
MSG4 DB 13, 10, "Digite o numero 2(0 ou 1, max 16 bits, Enter para parar): $"

; --- SEÇÃO DE CÓDIGO (.CODE) ---
.CODE
MAIN PROC
    ; Inicializa o Segmento de Dados (Data Segment - DS)
    MOV AX, @DATA ; Move o endereço do segmento de dados para AX
    MOV DS, AX    ; Move de AX para DS

    CALL ENTRADAB

    CALL SOMA

MOV AX, 4CH         ; Função 4CH (Terminar Programa)
INT 21h
MAIN ENDP

ENTRADAB PROC
    MOV CX, 8          ; Inicializa o contador de loop para 16 bits (tamanho do BX)
    XOR BX, BX

NUMB1:
    ; Pede o dígito binário
    MOV AH, 09h
    LEA DX, MSG1
    INT 21h

    ; Lê o caractere (dígito)
    MOV AH, 01h
    INT 21h

    CMP AL, 13          ; Verifica se o usuário pressionou ENTER (ASCII 13)
    JE PROXNUMB            ; Se sim, finaliza a entrada

    ; Validação do caractere
    CMP AL, "0"
    JE COLOCAB1
    CMP AL, "1"
    JE COLOCAB1

    ; Se for inválido (não é '0', '1' ou ENTER)
    MOV AH, 09h
    LEA DX, MSG3
    INT 21h
    JMP NUMB1            ; Pede o dígito novamente (não decrementa CX)

COLOCAB1:
    SHL BX, 1           ; LOGICA CORRIGIDA: Desloca BX para a esquerda 1 bit (Multiplica por 2) para abrir espaço.
    AND AL, 0Fh         ; Converte o caractere ASCII ('0' ou '1') para o valor numérico (0 ou 1).
    OR BL, AL           ; Adiciona o novo bit na posição menos significativa (BL).

    LOOP NUMB1           ; Decrementa CX e salta para NUMB se CX != 0

PROXNUMB: 

    MOV CX, 8
    XOR DX, DX

NUMB2:
     ; Pede o dígito binário
    PUSH DX
    MOV AH, 09h
    LEA DX, MSG4
    INT 21h
    POP DX

    ; Lê o caractere (dígito)
    MOV AH, 01h
    INT 21h

    CMP AL, 13          ; Verifica se o usuário pressionou ENTER (ASCII 13)
    JE FIMEB            ; Se sim, finaliza a entrada

    ; Validação do caractere
    CMP AL, "0"
    JE COLOCAB2
    CMP AL, "1"
    JE COLOCAB2

    ; Se for inválido (não é '0', '1' ou ENTER)
    PUSH DX
    MOV AH, 09h
    LEA DX, MSG3
    INT 21h
    POP DX
    JMP NUMB2            ; Pede o dígito novamente (não decrementa CX)

COLOCAB2:
    SHL DX, 1           ; LOGICA CORRIGIDA: Desloca BX para a esquerda 1 bit (Multiplica por 2) para abrir espaço.
    AND AL, 0Fh         ; Converte o caractere ASCII ('0' ou '1') para o valor numérico (0 ou 1).
    OR DL, AL           ; Adiciona o novo bit na posição menos significativa (BL).

    LOOP NUMB2           ; Decrementa CX e salta para NUMB se CX != 0


FIMEB:
    RET                 ; Retorna para o chamador
ENTRADAB ENDP

SOMA PROC

    XOR CX, CX
    MOV BH, BL
    ADD BH, DL

    XOR DX, DX

    MOV AH, 09h
    LEA DX, MSG2
    INT 21h

    MOV CX, 8

    PRINTS:

    SHL BH, 1
    JNC BITS_ZERO

    MOV AH, 02h
    MOV DL, "1"
    INT 21h

    JMP LOOP_PRINT

    BITS_ZERO:

    MOV AH, 02h
    MOV DL, "0"
    INT 21h

    LOOP_PRINT:

    LOOP PRINTS

    RET
SOMA ENDP

END MAIN