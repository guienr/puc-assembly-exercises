TITLE 6_EX7

.MODEL SMALL

.CODE 
MAIN PROC

    MOV CX, 94
    MOV BL, "!"

    PRINT:

    MOV AH, 02h
    MOV DL, 13
    INT 21h
    MOV DL, 10
    INT 21h
    MOV DL, BL
    INT 21h

    INC BL

    LOOP PRINT

MOV AH, 4CH
INT 21h
MAIN ENDP
END MAIN