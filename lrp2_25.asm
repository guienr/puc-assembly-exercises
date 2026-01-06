TITLE EX25

.MODEL SMALL

.DATA
MSG1 DB "Digite um caracter: $"
MSG2 DB 13, 10, "Numero binario: $"
MSG3 DB 13, 10, "Quantidade de 1s: $"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AH, 09h
    LEA DX, MSG1
    INT 21h

    MOV AH, 01h
    INT 21h
    MOV BL, AL

    MOV CX, 8

    MOV AH, 09h
    LEA DX, MSG2
    INT 21h

    NUMB:

    ROL BL, 1
    JNC BIT_ZERO

    MOV AH, 02h
    MOV DL, "1"
    INT 21h
    INC BH
    JMP FIM_NUMB

    BIT_ZERO:
    MOV AH, 02h
    MOV DL, "0"
    INT 21h

    FIM_NUMB:
    LOOP NUMB

    OR BH, 30h

    MOV AH, 09h
    LEA DX, MSG3
    INT 21h

    MOV AH, 02h
    MOV DL, BH
    INT 21h

MOV AH, 4CH
INT 21h
MAIN ENDP
END MAIN