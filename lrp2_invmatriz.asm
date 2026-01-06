TITLE TREINO

.MODEL SMALL

.STACK 100

.DATA
M DB 1, 2, 3, 4
  DB 5, 6, 7, 8
  DB 9, 1, 2, 3
  DB 4, 5, 6, 7

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    XOR DX, DX
    XOR BX, BX

    MOV BL, M[0+0]
    MOV DL, M[0+3]
    MOV M[0+3], BL
    MOV M[0+0], DL

    MOV BL, M[4+1]
    MOV DL, M[4+2]
    MOV M[4+2], BL
    MOV M[4+1], DL

    MOV BL, M[8+1]
    MOV DL, M[8+2]
    MOV M[8+2], BL
    MOV M[8+1], DL

    MOV BL, M[12+0]
    MOV DL, M[12+3]
    MOV M[12+3], BL
    MOV M[12+0], DL

    MOV CH, 4
    XOR BX, BX

    LINHA:
    MOV AH, 02h
    MOV DL, 13
    INT 21h
    MOV DL, 10
    INT 21h
    XOR SI, SI

    COLUNA:
    MOV AH, 02h
    MOV DL, M[BX+SI]
    OR DL, 30h
    INT 21h
    MOV DL, 32
    INT 21h
    INC SI

    CMP SI, 3
    JBE COLUNA

    ADD BX, 4
    DEC CH
    JNZ LINHA

MOV AH, 4CH
INT 21h
MAIN ENDP
END MAIN