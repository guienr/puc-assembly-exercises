TITLE EX 13b

.MODEL SMALL

.DATA 
MSG1 DB "Digite um numero para A: $"
MSG2 DB 13, 10, "Digite um numero para B: $"
RC DB 13, 10, "Resultado C: $"

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
    AND BL, 0Fh
    AND BH, 0Fh
    ADD BH, BL
    MOV CL, BH
    OR CL, 30h

    RET
CONTAS ENDP

IMPRIMIR PROC
    MOV AH, 09h
    LEA DX, RC
    INT 21h
    
    MOV AH, 02h
    MOV DL, CL
    INT 21h

    RET
IMPRIMIR ENDP

END MAIN