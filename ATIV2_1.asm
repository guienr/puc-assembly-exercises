; Da título ao programa
TITLE letra

; Divide os códigos e dados lidos em 64kb
.MODEL SMALL

; Início do local onde são declarado as variáveis
.DATA
; Declaração de variáveis
MSG1 DB "Digite uma letra minuscula: $" 
MSG2 DB 13, 10, "A letra maiuscula e: $"

; Início do código onde estão as instruções
.CODE
MAIN PROC

; Inicializa DS com endereço do segmento de dados
MOV AX,@DATA
MOV DS, AX

MOV AH,9 ; Função que imprime uma string
LEA DX, MSG1 ; Carrega o endereço de memória da variável
INT 21h ; Execução da função

MOV AH,1 ; função que le um caracter
INT 21h ; Execução da função

; Converte a letra de minúsculo para maiúsculo subtraindo por 32 o número correspondente da letra
SUB AL, 32 

; Copia o conteúdo de AL para BL
MOV BL,AL

MOV AH,9 ; Função que imprime uma string
LEA DX,MSG2 ; Carrega o endereço de memória da variável
INT 21h ; Execução da função

MOV AH,2 ; Função que exibe o caracter maiúsculo
MOV DL,BL ; Copia o conteúdo de BL para DL
INT 21h ; Execução da função

; Finalização do programa
MOV AH,4Ch
INT 21h
MAIN ENDP
END MAIN