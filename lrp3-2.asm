TITLE LISTA REVISAO EX2

.MODEL SMALL

.STACK

.DATA
VET DB 1, 2, 3, 4, 5, 6, 7
N EQU 7

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    CLD

    XOR DX, DX
    MOV CX, N
    MOV BL, 2

    CALL VERIFICA

    OR DL, 30h
    OR DH, 30h

    MOV AH, 02h
    INT 21h
    MOV DL, 13
    INT 21h
    MOV DL, 10
    INT 21h
    MOV DL, DH
    INT 21h

MOV AH, 4CH
INT 21h
MAIN ENDP

VERIFICA PROC

    LEA SI, VET

    CONTA:
    XOR AX, AX
    LODSB
    DIV BL
    CMP AH, 1
    JE IMPAR

    INC DL
    JMP FIM

    IMPAR:
    INC DH

    FIM:
    LOOP CONTA

    RET
VERIFICA ENDP

END MAIN