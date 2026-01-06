TITLE EXPOENTE BASE 2

.MODEL SMALL

.STACK 100

LER MACRO
    MOV AH, 01h
    INT 21h
    AND AL, 0Fh
ENDM

PULA MACRO
    MOV AH, 02h
    MOV DL, 13
    INT 21h
    MOV DL, 10
    INT 21h
ENDM

PRINT MACRO V
    MOV AH, 02h
    MOV DL, V
    INT 21h
ENDM

.CODE
MAIN PROC
    LER
    MOV BL, AL
    PULA
    LER 
    MOV CL, AL
    PULA

    EXP:
    SHL BL, 1
    LOOP EXP

    OR BL, 30h

    PRINT BL

    MOV AH, 4CH
    INT 21h
MAIN ENDP
END MAIN