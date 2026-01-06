TITLE MULTIPLICACAO MATRIZES

.MODEL SMALL

.STACK 100

PULA MACRO
    MOV AH, 02h
    MOV DL, 13 
    INT 21h
    MOV DL, 10 
    INT 21h
ENDM

.DATA
M1 DB ?, ?, ?
   DB ?, ?, ?
   DB ?, ?, ?
M2 DB ?, ?, ?
   DB ?, ?, ?
   DB ?, ?, ?
MR DB ?, ?, ?
   DB ?, ?, ?
   DB ?, ?, ?

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA SI, M1
    CALL LER

    PULA

    LEA SI, M2
    CALL LER

    LEA SI, M1
    LEA DI, M2
    CALL CONTA

    LEA SI, MR
    CALL PRINT

    MOV AH, 4CH
    INT 21h
MAIN ENDP

LER PROC
    XOR BX, BX
    MOV CH, 3
    
    LINHA:
    PULA
    XOR SI, SI
    MOV CL, 3

    COLUNA:
    MOV AH, 01h
    INT 21h
    AND AL, 0Fh
    MOV [SI], AL

    DEC CL
    CMP CL, 0
    JNE COLUNA

    DEC CH
    ADD BX, 3
    
    CMP CH, 0
    JNE LINHA

    PULA

    RET
LER ENDP

CONTA PROC

    RET
CONTA ENDP

PRINT PROC
    XOR BX, BX
    MOV CH, 3
    
    LINHA:
    PULA
    XOR SI, SI
    MOV CL, 3

    COLUNA:
    MOV AH, 02h
    MOV DL, [SI]
    OR DL, 30h
    INT 21h

    DEC CL
    CMP CL, 0
    JNE COLUNA

    DEC CH
    ADD BX, 3
    
    CMP CH, 0
    JNE LINHA

    PULA

    RET
PRINT ENDP

END MAIN