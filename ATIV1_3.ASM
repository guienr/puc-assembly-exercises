TITLE ativ3
.MODEL SMALL

.DATA
MSG1 DB "Digite um caractere:$"
MSG2 DB 13, 10, "O caractere digitado foi:$"

.CODE
MAIN PROC
MOV AX, @DATA
MOV DS, AX

; Mostra a mensagem 1
MOV AH,9
LEA DX,MSG1
INT 21h

; Le a variável
MOV AH,1
INT 21h

MOV BL,AL

; Mostra a mensagem 2
MOV AH,9
LEA DX,MSG2
INT 21h

; Exibe o caracter
MOV AH,2
MOV DL,BL
INT 21h

; Finaliza o programa
MOV AH,4Ch
INT 21h
MAIN ENDP
END MAIN