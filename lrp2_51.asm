TITLE EX58

.MODEL SMALL

.STACK 100

.DATA
MSG1 DB 13, 10, "Digite o numero hexadecimal(0 a 9 ou A a F): $"
MSG2 DB 13, 10, "Numero em decimal: $"
MSG3 DB 13, 10, "Digite 'S' para continuar ou qualquer outra tecla para encerrar: $"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    INICIO:

    XOR BX, BX

    CALL LER
    
    CALL IMPRIMIR

    CALL ESCOLHA

    CMP AL, "S"
    JE INICIO

MOV AH, 4CH
INT 21h
MAIN ENDP

LER PROC

    MOV CX, 4

    LERH:
    MOV AH, 09h
    LEA DX, MSG1
    INT 21h

    MOV AH, 01h
    INT 21h

    CMP AL, '0'
    JB LERH           ; menor que '0', inválido

    CMP AL, '9'
    JBE COLOCARN      ; entre '0' e '9'

    CMP AL, 'A'
    JB LERH           ; menor que 'A', inválido

    CMP AL, 'F'
    JBE COLOCARL      ; entre 'A' e 'F'
    JMP LERH          ; maior que 'F', inválido

    COLOCARN:
    AND AX, 000Fh
    SHL BX, 4
    ADD BX, AX
    JMP FIMLH

    COLOCARL:
    SUB AL, "A"
    ADD AL, 10
    XOR AH, AH
    SHL BX, 4
    ADD BX, AX

    FIMLH:

    LOOP LERH
    
    RET
LER ENDP

IMPRIMIR PROC

    XOR CX, CX
    MOV AX, BX
    MOV BX, 10
    DIVISAO:
    XOR DX, DX
    DIV BX
    PUSH DX
    INC CX
    CMP AX, 0
    JNE DIVISAO

    MOV AH, 09h
    LEA DX, MSG2
    INT 21h
    IMPD:
    POP DX
    OR DL, 30h
    MOV AH, 02h
    INT 21h
    LOOP IMPD

    RET
IMPRIMIR ENDP

ESCOLHA PROC
    MOV AH, 09h
    LEA DX, MSG3
    INT 21h

    MOV AH, 01h
    INT 21h

    RET
ESCOLHA ENDP

END MAIN