TITLE EX 13c

.MODEL SMALL

.STACK 100h

.DATA
    MSG1 DB 13, 10, "Digite um numero para B: $"
    RB   DB 13, 10, "Resultado B: $"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    CALL LER
    CALL CONTAS
    CALL IMPRIMIR

    MOV AH, 4Ch
    INT 21h
MAIN ENDP

LER PROC
    VERIFICA1:
        MOV AH, 09h
        LEA DX, MSG1
        INT 21h

        MOV AH, 01h
        INT 21h

        CMP AL, '0'
        JB VERIFICA1         ; Se AL < '0', repete
        CMP AL, '9'
        JA VERIFICA1         ; Se AL > '9', repete

        MOV BL, AL           ; Armazena o caractere válido

        RET
LER ENDP


CONTAS PROC
    ; 1. Converte ASCII de B para número
    AND BL, 0Fh              ; B agora é um número (0-9)

    ; 2. Calcula (3 * B) + 7
    MOV AL, 3
    MOV AH, 00h              ; Limpa AH para garantir que MUL funcione corretamente
    MUL BL                  ; AX = AL * BL (3 * B). AX agora tem até 34.
    ADD AL, 7               ; Adiciona 7 ao byte baixo de AX.

    ; 3. Converte o resultado de 8 bits em AX (3*B + 7) para dois dígitos ASCII
    MOV BL, 10               ; Divisor para obter dezenas e unidades
    DIV BL                   ; AL = Quociente (Dezenas); AH = Resto (Unidades)

    ; Converte Dezenas e Unidades para ASCII
    OR AL, 30h               ; AL = Dígito das Dezenas (ASCII)
    OR AH, 30h               ; AH = Dígito das Unidades (ASCII)

    ; Armazena os dois dígitos para impressão. Usaremos uma nova variável na seção .DATA
    ; Supondo que você adicione na seção .DATA: RESULTADO DB 2 DUP('$')
    ; Ou, mais simples, armazene temporariamente em registradores B e C.
    MOV BH, AL               ; BH = Dígito das Dezenas (ASCII)
    MOV BL, AH               ; BL = Dígito das Unidades (ASCII)

    RET
CONTAS ENDP

IMPRIMIR PROC
    ; Imprime a mensagem inicial
    MOV AH, 09h
    LEA DX, RB
    INT 21h

    ; Imprime o dígito das DEZENAS
    MOV AH, 02h
    MOV DL, BH               ; BH tem o dígito das dezenas
    INT 21h

    ; Imprime o dígito das UNIDADES
    MOV AH, 02h
    MOV DL, BL               ; BL tem o dígito das unidades
    INT 21h

    RET
IMPRIMIR ENDP

END MAIN