TITLE EX7

.MODEL SMALL

.STACK 100

.DATA
MSG DB "Digite um caracter: $"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    CARACTER:

    MOV AH, 02h
    MOV DL, 13
    INT 21h
    MOV DL, 10
    INT 21h

    MOV AH, 09h
    MOV DX, OFFSET MSG
    INT 21h

    MOV AH, 01h
    INT 21h

    CMP AL, "1"
    JAE NUM

    CMP AL, "0"
    JE FINAL
    JB CARACTER

    NUM:
    CMP AL, "9"
    JA CARACTER

    MOV BL, AL
    MOV AH, 02h
    MOV DL, 13
    INT 21h
    MOV DL, 10
    INT 21h
    MOV DL, BL
    INT 21h
    JMP CARACTER

    FINAL:
    MOV BL, AL
    MOV AH, 02h
    MOV DL, 13
    INT 21h
    MOV DL, 10
    INT 21h
    MOV DL, BL
    INT 21h

MOV AH, 4CH
INT 21H
MAIN ENDP
END MAIN