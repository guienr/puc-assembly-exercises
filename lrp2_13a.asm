TITLE EX 13a

.MODEL SMALL

.DATA 
MSG1 DB 13, 10, "Digite um numero para A: $"
MSG2 DB 13, 10, "Digite um numero para B: $"
RA DB 13, 10, "Resultado A: $"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    CALL LER

    CALL CONTAS

    CALL IMPRIMIR

MOV AH, 4CH
INT 21h
MAIN ENDP


LER PROC

    VERIFICA1:
    MOV AH, 09h
    LEA DX, MSG1
    INT 21h
    MOV AH, 01h
    INT 21h
    CMP AL, "0"
    JAE VERIFICA2
    JMP VERIFICA1

    VERIFICA2:
    CMP AL, "9"
    JA VERIFICA1

    MOV BL, AL

    VERIFICA3:
    MOV AH, 09h
    LEA DX, MSG2
    INT 21h
    MOV AH, 01h
    INT 21h

    CMP AL, "0"
    JAE VERIFICA4
    JMP VERIFICA3

    VERIFICA4:
    CMP AL, "9"
    JA VERIFICA3

    MOV BH, AL

    RET
LER ENDP 

CONTAS PROC

    CMP BL, BH
    JAE CONTINUA
    XCHG BL, BH
    CONTINUA:
    SUB BL, BH
    OR BL, 30h

    RET
CONTAS ENDP 

IMPRIMIR PROC
    MOV AH, 09h
    LEA DX, RA
    INT 21h
    
    MOV AH, 02h
    MOV DL, BL
    INT 21h

    RET
IMPRIMIR ENDP

END MAIN