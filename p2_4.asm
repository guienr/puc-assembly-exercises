TITLE P2PASSADO_EX4

.MODEL SMALL

.STACK 100

.DATA
MSG1 DB 13, 10, "Entre com um numero binario(0 ou 1): $"
MSG2 DB 13, 10, "Espelhado: $"

.CODE
MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    CALL ENTRADA

    CALL ESPELHA

    CALL SAIDA

MOV AH, 4CH
INT 21h
MAIN ENDP

ENTRADA PROC

    MOV CX, 8
    XOR BX, BX
    
    NUMB:

    MOV AH, 09h
    LEA DX, MSG1
    INT 21h

    MOV AH, 01h
    INT 21h

    AND AL, 0Fh
    SHL BL, 1
    ADD BL, AL

    LOOP NUMB
    
    RET
ENTRADA ENDP

ESPELHA PROC
    MOV CX, 8
    XOR DX, DX

    ESPE:
    SHR BL, 1
    JNC ZERO

    SHL DX, 1
    ADD DX, 1
    JMP FIME

    ZERO:
    SHL DX, 1

    FIME:
    LOOP ESPE

    MOV BH, DL

    RET
ESPELHA ENDP

SAIDA PROC

    MOV CX, 8

    MOV AH, 09h
    LEA DX, MSG2
    INT 21h

    IMPB:
    SHL BH, 1
    JNC ZEROI

    MOV AH, 02h
    MOV DL, "1"
    INT 21h
    JMP FIMI

    ZEROI:
    MOV AH, 02h
    MOV DL, "0"
    INT 21h
    
    FIMI:
    LOOP IMPB

    RET
SAIDA ENDP

END MAIN