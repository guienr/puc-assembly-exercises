ESPELHA PROC ; Define a função para espelhar um numero
; Entrada BL tem o numero
PUSH AX ; Guarda o valor dos registradores na pilha
PUSH CX

MOV CL,1 ; Move 1 para o conteudo de CL
MOV CH,8 ; Move 8 para o conteudo de CH

ESPE: ; Define o rotulo
SHL BL,CL ; Move CL (1) bits para a esquerda
RCR AL,CL ; Move CL (1) bits para a direita, o valor que estava no CF vai para o MSB e o numero que sai vai para CF
DEC CH ; Decrementa 1 de CH
JNZ ESPE ; Se CH não for igual a zero pula para o rótulo
MOV BL,AL ; Move o conteúdo de AL para BL
POP CX ; Recupera o valor dos resgistradores salvos na pilha
POP AX
; Saida BL tem o numero espelhado
RET ; Retorna afunção principal
ESPELHA ENDP ; Encerra a função para espelhar um numero