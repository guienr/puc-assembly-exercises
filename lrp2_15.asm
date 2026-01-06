TITLE EX15

.MODEL SMALL

.DATA
MATRIZ DB 10 DUP ("*")
       DB 10 DUP ("*")
       DB 10 DUP ("*")
       DB 10 DUP ("*")
       DB 10 DUP ("*")
       DB 10 DUP ("*")
       DB 10 DUP ("*")
       DB 10 DUP ("*")
       DB 10 DUP ("*")
       DB 10 DUP ("*")
       
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV CH, 10
    MOV BX, 0

    LINHA:
    MOV SI, 0
    MOV AH, 02h
    MOV DL, 13
    INT 21h
    MOV DL, 10
    INT 21h 

    COLUNA:
    MOV AH, 02h
    MOV DL, MATRIZ[BX+SI]
    INT 21h
    MOV DL, 32
    INT 21h
    INC SI
    CMP SI, 10
    JNE COLUNA

    ADD BX, 10
    DEC CH
    JNZ LINHA

MOV AH, 4CH
INT 21h
MAIN ENDP
END MAIN