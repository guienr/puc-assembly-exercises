; Da título ao programa
TITLE Mensagens
; Divide os códigos e dados lidos em 64kb
.MODEL SMALL
; Início do local de dados onde são declarados as variáveis
.DATA
; Declaração das variáveis
MSG1 DB "Mensagem 1.$"
MSG2 DB 10,13,"Mensagem 2.$"
; Início do código onde estão as instruções do programa
.CODE
; Início das instruções do programa
MAIN PROC
; Permite o acesso às variáveis definidas em .DATA, aponta o ponteiro para DATA e guarda o conteúdo em AX, depois guarda o conteúdo de AX em DS
MOV AX,@DATA
MOV DS,AX
; Exibe na tela a string MSG1 por meio da função 9, LEA está carregando o endereço de MSG1 e a função é executada por meio de INT 21h
MOV AH,9
LEA DX,MSG1
INT 21h
; Exibe na tela a string MSG2 por meio da função 9, LEA está carregando o endereço de MSG2 e a função é executada por meio de INT 21h
MOV AH,9
LEA DX,MSG2
INT 21h
; Finaliza o programa
MOV AH,4Ch
INT 21h
MAIN ENDP
END MAIN