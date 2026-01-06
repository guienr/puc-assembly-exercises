TITLE 6_EX5

.MODEL SMALL

.DATA
MSG1 DB "Digite o numero que deseja que seja multplicado: $"
MSG2 DB 13, 10, "Digite a quantidade de vezes que deseja que seja multiplicado: $"
MSG3 DB 13, 10, "Resultado: $"

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
    SUB BL, "0"

    MOV AH, 09h
    MOV DX, OFFSET MSG2
    INT 21h

    MOV AH, 01h
    INT 21h
    MOV CL, AL
    SUB CL, "0"

    MOV AL, 0

    MULTIPLICAR:

    ADD AL, BL

    LOOP MULTIPLICAR

    MOV BL, AL
    ADD BL, "0"

    MOV AH, 09h
    MOV DX, OFFSET MSG3
    INT 21h

    MOV AH, 02h
    MOV DL, BL
    INT 21h

MOV AH, 4CH
INT 21h
MAIN ENDP
END MAIN