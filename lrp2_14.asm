TITLE EX14

.MODEL SMALL

.DATA
MSG1 DB 13, 10, "A SOMA DE $"
MSG2 DB " E $"
MSG3 DB " EH $"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AH, 02h
    MOV DL, "?"
    INT 21h

    MOV AH, 01h
    INT 21h

    MOV BL, AL
    AND BL, 0Fh

    VERIFICA:
    MOV AH, 01h
    INT 21h

    MOV BH, AL
    AND AL, 0Fh

    ADD AL, BL
    CMP AL, 9
    JA VERIFICA

    MOV CL, AL

    OR BL, 30h
    OR BH, 30h
    OR CL, 30h

    MOV AH, 09h
    LEA DX, MSG1
    INT 21h

    MOV AH, 02h
    MOV DL, BL
    INT 21h

    MOV AH, 09h
    LEA DX, MSG2
    INT 21h

    MOV AH, 02h
    MOV DL, BH
    INT 21h

    MOV AH, 09h
    LEA DX, MSG3
    INT 21h

    MOV AH, 02h
    MOV DL, CL
    INT 21h

MOV AH, 4CH
INT 21h
MAIN ENDP
END MAIN