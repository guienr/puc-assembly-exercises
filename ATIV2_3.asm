; Da título ao programa
TITLE Soma

; Divide os códigos e dados lidos em 64kb
.MODEL SMALL

; Início do local onde são declarado as variáveis
.DATA
; Declaração de variáveis
msg1 DB "Digite um primeiro numero: $"
msg2 DB 13, 10, "Digite um segundo numero: $"
msg3 DB 13, 10, "A soma dos dois numeros eh: $"


; Início do código onde estão as instruções
.CODE
MAIN PROC
    
; Inicializa DS com endereço do segmento de dados
MOV AX, @DATA
MOV DS, AX

MOV AH,9 ; Função que imprime uma string
LEA DX,msg1 ; Carrega o endereço de memória da variável
INT 21h ; Execução da função

MOV AH,1 ; Função que lê um único caractere 
INT 21h ; Execução da função
SUB AL, 30h ; Converte ASCII para número

MOV BL,AL ; Copia o conteúdo de AL para BL

MOV AH,9 ; Função que imprime uma string
LEA DX,msg2 ; Carrega o endereço de memória da variável
INT 21h ; Execução da função

MOV AH,1 ; Função que lê um único caractere 
INT 21h ; Execução da função
SUB AL, 30h ; Converte ASCII para número

ADD BL, AL ; Soma o primeiro número com o segundo

MOV AH,9 ; Função que imprime uma string
LEA DX,msg3 ; Carrega o endereço de memória da variável
INT 21h ; Execução da função

MOV AH,2 ; Função que exibe o caracter
MOV DL,BL ; Copia o conteúdo de BL para DL
ADD DL, 30h ; Converte número para ASCII
INT 21h ; Execução da função

; Finalização do programa
MOV AH,4Ch
INT 21h
MAIN ENDP
END MAIN