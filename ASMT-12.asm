TITLE EXPOENTE BASE 2

.MODEL SMALL

.STACK 100

LER MACRO
    MOV AH, 01h
    INT 21h
ENDM

PULA MACRO
    MOV AH, 02h
    MOV DL, 13
    INT 21h
    MOV DL, 10
    INT 21h
ENDM

PRINT MACRO V
    MOV AH, 02h
    MOV DL, V
    INT 21h
ENDM

.CODE
MAIN PROC

    LNUM:
    MOV AL, BL
    MOV CL, 10
    MUL CL
    MOV BL, AL
    LER
    CMP AL, 13
    JE EXP
    AND AL, 0Fh
    ADD BL, AL

    JMP LNUM

    EXP:
    LER
    AND AL, 0Fh
    MOV CL, AL
    DEC CL

    XOR DX, DX
    XOR AX, AX
    MOV AL, BL
    CONTA:
    MUL BL
    LOOP CONTA

    MOV CX, 3
    DIGITOS:
    MOV BX, 10
    DIV BX
    PUSH DX
    LOOP DIGITOS

    PULA
    MOV CX, 3
    ESCREVE:
    POP DX
    OR DL, 30h
    PRINT DL
    LOOP ESCREVE

    MOV AH, 4CH
    INT 21h
MAIN ENDP
END MAIN