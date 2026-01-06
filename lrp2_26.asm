TITLE EX26

.MODEL SMALL

.DATA
MSG1 DB 13, 10, "Digite um caracter: $"
MSG2 DB 13, 10, "Codigo ASCII em hexadecimal desse caractere vale: $"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LER:

    MOV AH, 09h
    LEA DX, MSG1
    INT 21h

    MOV AH, 01h
    INT 21h

    CMP AL, 13
    JE FIM

    MOV BH, AL
    SHR BH, 4
    AND BH, 0Fh
    MOV BL, AL
    AND BL, 0Fh

    MOV AH, 09h
    LEA DX, MSG2
    INT 21h

    CMP BH, 9
    JBE CONVERTEN1
    JA CONVERTEL1

    CONVERTEN1:
    OR BH, 30h
    JMP NUM2

    CONVERTEL1:
    ADD BH, "A"
    SUB BH, 10

    NUM2:
    CMP BL, 9
    JBE CONVERTEN2
    JA CONVERTEL2

    CONVERTEN2:
    OR BL, 30h
    JMP IMPRIME

    CONVERTEL2:
    ADD BL, "A"
    SUB BL, 10

    IMPRIME:

    MOV AH, 02h
    MOV DL, BH
    INT 21h
    MOV DL, BL
    INT 21h
    MOV DL, "h"
    INT 21h
    JMP LER

    FIM:

MOV AH, 4CH
INT 21h
MAIN ENDP
END MAIN