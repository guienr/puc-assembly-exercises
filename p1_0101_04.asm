TITLE 0101_4

.MODEL SMALL

.STACK 100h

.DATA
MSG1 DB "Digite o dividendo: $"
MSG2 DB 13, 10, "O numero e par$"
MSG3 DB 13, 10, "O numero e impar$"
MSG4 DB 13, 10, "O caracter digitado nao e um numero$"


.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AH, 09h
    MOV DX, OFFSET MSG1
    INT 21h

    MOV AH, 01h
    INT 21h
    MOV BL, AL

    MOV CL, 2

    CMP BL, 48
    JB NAO_NUM

    CMP BL, 57
    JA NAO_NUM

    SUB BL, "0"

    CMP BL, 1
    JE IMPAR

    DIVISAO:
    SUB BL, CL

    CMP BL, CL
    JAE DIVISAO

    CMP BL, 1
    JE IMPAR

    CMP BL, 0
    JE PAR

    PAR:
    MOV AH, 09h
    MOV DX, OFFSET MSG2
    INT 21h

    MOV AH, 02h
    MOV DL, BL
    INT 21h

    JMP FINAL

    IMPAR:
    MOV AH, 09h
    MOV DX, OFFSET MSG3
    INT 21h

    MOV AH, 02h
    MOV DL, BL
    INT 21h

    JMP FINAL

    NAO_NUM:
    MOV AH, 09h
    MOV DX, OFFSET MSG4
    INT 21h

    FINAL:

MOV AH, 4CH
INT 21h
MAIN ENDP
END MAIN