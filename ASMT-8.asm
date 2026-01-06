TITLE LE IMPRIME STRING

.MODEL SMALL

.STACK 100

.DATA
STRING DB 50 DUP(?)

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX

    CLD

    LEA DI, STRING

    MOV CX, 49
    
    LER:

    MOV AH, 01h
    INT 21h

    CMP AL, 13
    JE FINAL

    STOSB
    LOOP LER

    FINAL:
    
    MOV AL, "$"
    STOSB

    MOV AH, 09h
    LEA DX, STRING
    INT 21h

    MOV AH, 4CH
    INT 21h
MAIN ENDP
END MAIN