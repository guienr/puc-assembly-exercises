TITLE CONTA CARACTERES

.MODEL SMALL

.STACK 100

.DATA
STRING DB "poliedro$"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    CLD
    LEA SI, STRING

    XOR CX, CX

    CONTAGEM:
    LODSB
    CMP AL, "$"
    JE FINAL
    INC CX
    JMP CONTAGEM

    FINAL:
    OR CL, 30h
    MOV AH, 02h
    MOV DL, CL
    INT 21h
    MOV AH, 4CH
    INT 21h
MAIN ENDP
END MAIN