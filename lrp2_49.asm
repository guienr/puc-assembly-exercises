TITLE EX49

.MODEL SMALL

.STACK 100

.DATA
MSG1 DB 13, 10, "Digite uma letra maiuscula: $"
MSG2 DB 13, 10, "Letras em ordem alfabetica: $"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV CX, 2

    LER:
    MOV AH, 09h
    LEA DX, MSG1
    INT 21h

    MOV AH, 01h
    INT 21h

    SHL BX, 8
    XOR AH, AH
    MOV BL, AL

    LOOP LER

    CMP BH, BL
    JAE ORDEM1
    JB ORDEM2

    ORDEM1:
    MOV AH, 09h
    LEA DX, MSG2
    INT 21h

    MOV AH, 02h
    MOV DL, BL
    INT 21h
    MOV DL, BH
    INT 21h
    JMP FIM

    ORDEM2:
    MOV AH, 09h
    LEA DX, MSG2
    INT 21h

    MOV AH, 02h
    MOV DL, BH
    INT 21h
    MOV DL, BL
    INT 21h

    FIM:

MOV AH, 4CH
INT 21h
MAIN ENDP
END MAIN