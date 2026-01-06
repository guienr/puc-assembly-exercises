TITLE EX30

.MODEL SMALL

.STACK 100

.DATA
MSG1 DB 13, 10, "Digite o numero decimal(dividendo): $"
MSG2 DB 13, 10, "Resto: $"
MSG3 DB 13, 10, "Quociente: $"
MSG4 DB 13, 10, "Digite o divisor: $"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    XOR CX, CX
    MOV CX, 3

    NUMD:

    MOV AH, 09h
    LEA DX, MSG1
    INT 21h

    MOV AH, 01h
    INT 21h

    CMP CX, 1
    JE UNIDADE

    AND AX, 000Fh
    MOV DL, 10
    MUL DL
    ADD BL, AL
    JMP FINALIZAD

    UNIDADE:
    AND AX, 000Fh
    ADD BL, AL

    FINALIZAD:

    LOOP NUMD

    FIMD:

    MOV AH, 09h
    LEA DX, MSG4
    INT 21h

    MOV AH, 01h
    INT 21h
    
    XOR CX, CX
    AND AL, 0Fh
    MOV CL, AL

    XOR AX, AX
    MOV AX, BX
    DIV CL
    MOV BH, AH
    MOV BL, AL
    OR BX, 3030h

    MOV AH, 09h
    LEA DX, MSG2
    INT 21h

    MOV AH, 02h
    MOV DL, BH
    INT 21h

    MOV AH, 09h
    LEA DX, MSG3
    INT 21h

    CMP AL, 9
    JA IMPRIMIR2

    MOV AH, 02h
    MOV DL, BL
    INT 21h
    JMP FIM

    IMPRIMIR2:
    MOV CL, 10

    MOV AL, BL
    DIV CL
    


    FIM: 

MOV AH, 4CH
INT 21h
MAIN ENDP
END MAIN