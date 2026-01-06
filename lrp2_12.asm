TITLE EX 12

.MODEL SMALL

.DATA
MSG DB "Digite um caracter: $"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    CALL LER

    CALL IMPRIMIR

MOV AH, 4CH
INT 21h
MAIN ENDP

LER PROC
    MOV AH, 09h
    LEA DX, MSG
    INT 21h

    MOV AH, 01h
    INT 21h

    MOV CL, AL

    RET
LER ENDP

IMPRIMIR PROC
    MOV AH, 02h
    MOV DL, 13
    INT 21h
    MOV AH, 02h
    MOV DL, 10
    INT 21h
    MOV AH, 02h
    MOV DL, 42
    INT 21h
    MOV AH, 02h
    MOV DL, CL
    INT 21h
    MOV AH, 02h
    MOV DL, 42
    INT 21h

    RET
IMPRIMIR ENDP

END MAIN