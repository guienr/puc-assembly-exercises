TITLE P2PASSADO_EX2

.MODEL SMALL

.STACK 100

.DATA
M DB 1, 2, 3, 4
  DB 1, 2, 3, 4
  DB 1, 2, 3, 4
  DB 1, 2, 3, 4

.CODE
MAIN PROC
  MOV AX, @DATA
  MOV DS, AX

  CALL TROCA

  CALL IMPRIMIR

MOV AH, 4CH
INT 21h  
MAIN ENDP

TROCA PROC
  XOR DX, DX
  MOV CX, 4
  XOR BX, BX
  MOV SI, 1

  PILHA1:
  MOV DL, M[BX+SI]
  PUSH DX
  ADD BX, 4
  LOOP PILHA1

  MOV SI, 0
  MOV DI, 1
  MOV CX, 4
  XOR BX, BX

  C2:
  MOV AL, M[BX+SI]
  MOV M[BX+DI], AL
  ADD BX, 4
  LOOP C2

  MOV CX, 4
  MOV BX, 12
  MOV SI, 0
  XOR DX, DX

  C1:
  POP DX
  MOV M[BX+SI], DL
  SUB BX, 4
  LOOP C1

  XOR DX, DX
  MOV CX, 4
  XOR BX, BX
  MOV SI, 3

  PILHA2:
  MOV DL, M[BX+SI]
  PUSH DX
  ADD BX, 4
  LOOP PILHA2

  MOV SI, 2
  MOV DI, 3
  MOV CX, 4
  XOR BX, BX

  C4:
  MOV AL, M[BX+SI]
  MOV M[BX+DI], AL
  ADD BX, 4
  LOOP C4

  MOV CX, 4
  MOV BX, 12
  MOV SI, 2
  XOR DX, DX
  
  C3:
  POP DX
  MOV M[BX+SI], DL
  SUB BX, 4
  LOOP C3

  RET
TROCA ENDP

IMPRIMIR PROC
  XOR CX, CX
  MOV CH, 4
  XOR BX, BX
  
  LINHA:
  XOR SI, SI
  MOV AH, 02h
  MOV DL, 13
  INT 21h
  MOV DL, 10
  INT 21h

  COLUNA:
  MOV DL, M[BX+SI]
  OR DL, 30h
  MOV AH, 02h
  INT 21h
  MOV DL, 32
  INT 21h
  INC SI
  CMP SI, 4
  JNE COLUNA
  
  SUB CH, 1
  CMP CH, 0
  JE FIM
  JMP LINHA

  FIM:

  RET
IMPRIMIR ENDP

END MAIN