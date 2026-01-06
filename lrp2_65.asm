TITLE EX65

.MODEL SMALL

.STACK 100

.DATA
V DB 1, 2, 3, 4, 5

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    CALL INVERTER

    CALL IMPRIMIR

MOV AH, 4CH
INT 21h
MAIN ENDP

INVERTER PROC
    XOR BX, BX
    MOV CX, 5
    XOR AX, AX

    PILHA:
    MOV AL, [V+BX]
    PUSH AX
    INC BX
    LOOP PILHA

    XOR BX, BX
    MOV CX, 5
    INV:
    XOR AX, AX
    POP AX
    MOV [V+BX], AL
    INC BX
    LOOP INV

    RET
INVERTER ENDP

IMPRIMIR PROC
    XOR AX, AX
    XOR BX, BX
    MOV CX, 5
    IMP:
    MOV AH, 02h
    MOV DL, [V+BX]
    OR DL, 030h
    INT 21h
    MOV DL, 32
    INT 21h

    INC BX
    LOOP IMP

    RET
IMPRIMIR ENDP

END MAIN