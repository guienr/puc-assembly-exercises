TITLE MATRIZ, MEDIA ARITMETICA, RESTO

.MODEL SMALL

.STACK 100

.DATA
M DB 1, 2, 3
  DB 1, 2, 3
  DB 1, 2, 3

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA SI, M
    CALL MEDIA

    LEA SI, M
    CALL MF

    LEA SI, M
    CALL PRINT

    MOV AH, 4CH
    INT 21h
MAIN ENDP

MEDIA PROC
    XOR AX, AX
    XOR DX, DX
    XOR BX, BX
    MOV CH, 3

    LINHA1:
    XOR SI, SI
    MOV CL, 3

    COLUNA1:
    ADD AL, [BX+SI]
    INC SI
    DEC CL

    CMP CL, 0
    JNE COLUNA1

    DEC CH
    ADD BX, 3
    CMP CH, 0
    JNE LINHA1

    MOV DL, 9
    DIV DL

    RET
MEDIA ENDP

MF PROC
    XOR DX, DX
    XOR BX, BX
    MOV DH, AL
    MOV CH, 3

    LINHA2:
    XOR SI, SI

    COLUNA2:
    MOV AL, DH
    XOR AH, AH
    MOV CL, [BX+SI]
    DIV CL
    MOV [BX+SI], AH
    INC SI

    CMP SI, 3
    JNE COLUNA2

    DEC CH
    ADD BX, 3
    CMP CH, 0
    JNE LINHA2

    RET
MF ENDP

PRINT PROC
    XOR AX, AX
    XOR DX, DX
    XOR BX, BX
    MOV CH, 3

    LINHA3:
    XOR SI, SI
    MOV CL, 3
    MOV AH, 02h
    MOV DL, 13
    INT 21h
    MOV DL, 10
    INT 21h

    COLUNA3:
    MOV DL, [BX+SI]
    OR DL, 30h
    INT 21h
    MOV DL, 32
    INT 21h
    INC SI
    DEC CL

    CMP CL, 0
    JNE COLUNA3

    DEC CH
    ADD BX, 3
    CMP CH, 0
    JNE LINHA3

    MOV DL, 9
    DIV DL
    RET
PRINT ENDP

END MAIN