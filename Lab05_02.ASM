title asterisco 2 ; Da titulo ao programa 

.model small ; Divide os códigos e dados lidos em 64kb

; Início do local onde são declarado as variáveis
.data
; Declaração de variáveis
asterisco DB "*"
pulalinha DB 13, 10, "$"

; Início do código onde estão as instruções
.code
main proc

; Permite o acesso as variaveis definidas em .DATA
    mov ax,@data
    mov ds, ax

; usa cx como contador e armazena 50
    mov cx, 50h

; Define rotulo
    print_asterisco:

; Exibe o caracter
    mov ah, 02h
    mov dl, asterisco
    int 21h

; Exibe na tela a string para pular uma linha
    mov ah, 09h
    mov dx, offset pulalinha
    int 21h

    loop print_asterisco ; decrementa 1 do contador e enquanto for diferente de zero pulara para o rotulo

; Finaliza o programa
mov ah, 4Ch
int 21h
main endp
end main