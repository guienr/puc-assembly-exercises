TITLE 

.MODEL SMALL

.STACK 100

PRINT MACRO STR
    MOV AH, 09h
    LEA DX, STR
    INT 21h
ENDM

PULA MACRO
    MOV AH, 02h
    MOV DL, 13
    INT 21h
    MOV DL, 10
    INT 21h
ENDM

.DATA
STR1 DB "12345$"
STR2 DB 5 DUP(?)
N EQU 5

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX

    STD

    LEA SI, STR1+4
    LEA DI, STR2

    MOV CX, N

    CALL INVERTER

    PRINT STR1
    PULA
    PRINT STR2

    MOV AH, 4CH
    INT 21h
MAIN ENDP

INVERTER PROC

    INV:
    MOVSB
    ADD DI, 2
    LOOP INV

    INC DI
    XOR AL, AL
    MOV AL, "$"
    STOSB

    RET
INVERTER ENDP


END MAIN