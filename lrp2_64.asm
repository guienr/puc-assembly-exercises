TITLE EX64

.MODEL SMALL

.STACK 100

.DATA
W DW 10, 20, 30, 40, 50, 60, 70, 80, 90, 100
MSG DB "Soma: $"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    CALL SOMA

    CALL IMPRIMIR

MOV AH, 4CH
INT 21h
MAIN ENDP

SOMA PROC

    XOR AX, AX
    MOV CX, 10
    XOR BX, BX

    SOM:
    ADD AX, [W+BX]
    ADD BX, 2
    LOOP SOM

    MOV BX, AX
    
    RET
SOMA ENDP

IMPRIMIR PROC

    MOV AH, 09h
    LEA DX, MSG
    INT 21h

    XOR CX, CX
    MOV AX, BX
    MOV BX, 10

    DIVISAO:

    XOR DX, DX
    DIV BX
    PUSH DX
    INC CX
    CMP AX, 0
    JNE DIVISAO

    IMP:
    POP DX
    OR DL, 30h
    MOV AH, 02h
    INT 21h
    
    LOOP IMP

    RET
IMPRIMIR ENDP

END MAIN