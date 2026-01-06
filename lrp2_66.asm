TITLE EX66

.MODEL SMALL

.STACK 100

.DATA
MSG DB "esta eh uma mensagem $"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    CALL MAIUSCULO

    CALL IMPRIMIR

MOV AH, 4CH
INT 21h
MAIN ENDP

MAIUSCULO PROC
    XOR BX, -1
    XOR CX, CX

    CONVERTE:

    INC BX
    
    CMP [MSG+BX], 32
    JE CONVERTE

    CMP [MSG+BX], 36
    JE FIMC

    AND [MSG+BX], 0DFh
    JMP CONVERTE

    FIMC:

    RET
MAIUSCULO ENDP

IMPRIMIR PROC
    MOV AH, 09h
    LEA DX, MSG
    INT 21h

    RET
IMPRIMIR ENDP

END MAIN