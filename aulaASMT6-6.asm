TITLE 6_EX6

.MODEL SMALL

.STACK 100h

.DATA
MSG1 DB "Digite o dividendo: $"
MSG2 DB 13, 10, "Digite o divisor: $"
MSG3 DB 13, 10, "Quociente: $"
MSG4 DB 13, 10, "Resto: $"
MSG5 DB 13, 10, "O divisor é maior que o dividendo$"


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

    CMP BL, CL
    JB MAIOR

    MOV AL, 0

    DIVISAO:
    SUB BL, CL
    INC AL

    CMP BL, CL
    JAE DIVISAO

    MOV CL, AL
    ADD BL, "0"
    ADD CL, "0"

    MOV AH, 09h
    MOV DX, OFFSET MSG3
    INT 21h

    MOV AH, 02h
    MOV DL, CL
    INT 21h

    MOV AH, 09h
    MOV DX, OFFSET MSG4
    INT 21h

    MOV AH, 02h
    MOV DL, BL
    INT 21h

    JMP FINAL

    MAIOR:
    MOV AH, 09h
    MOV DX, OFFSET MSG5
    INT 21h

    FINAL:

MOV AH, 4CH
INT 21h
MAIN ENDP
END MAIN