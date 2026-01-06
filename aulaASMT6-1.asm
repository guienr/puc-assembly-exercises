TITLE 06_EX1

.MODEL SMALL

.DATA
MSG1 DB 13, 10, "Digite a primeira letra maiuscula: $"
MSG2 DB 13, 10, "Digite a segunda letra maiuscula: $"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AH, 02h
    MOV DL, "?"
    INT 21h

    PRIMEIRO:

    MOV AH, 09h
    MOV DX, OFFSET MSG1
    INT 21h

    MOV AH, 01h
    INT 21h
    MOV BL, AL

    CMP BL, "A"
    JB PRIMEIRO

    CMP BL, "Z"
    JA PRIMEIRO

    SEGUNDO:

    MOV AH, 09h
    MOV DX, OFFSET MSG2
    INT 21h

    MOV AH, 01h
    INT 21h
    MOV CL, AL

    CMP AL, "A"
    JB SEGUNDO

    CMP AL, "Z"
    JA SEGUNDO

    MOV AH, 02h
    MOV DL, 13
    INT 21h
    MOV DL, 10
    INT 21h

    MOV AH, 02h
    MOV DL, BL
    INT 21h

    MOV AH, 02h
    MOV DL, 13
    INT 21h
    MOV DL, 10
    INT 21h

    MOV AH, 02h
    MOV DL, CL
    INT 21h

MOV AH, 4CH
INT 21h
MAIN ENDP
END MAIN