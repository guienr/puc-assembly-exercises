title alfabeto 4 ; Da titulo ao programa

.model small ; Divide os códigos e dados lidos em 64kb
.stack 100h ; Define o tamanho da pilha

; Início do local onde são declarado as variáveis
.data
; Declaração de variáveis
pulalinha db 13, 10, "$"

; Início do código onde estão as instruções
.code
main proc

; Permite o acesso as variaveis definidas em .DATA
    mov ax, @data
    mov ds, ax

    mov al, 'a' ; armazena o código ascii do caracter a em al
    mov cx, 26 ; armazena 26 no contador
    mov bx, 0 ; armazena 0 no contador de letras por linha

; Define o rotulo
print_letra:

; Exibe o caracter
    mov ah, 02h
    mov dl, al
    int 21h

    inc al ; increnta 1 ao código ascii em al
    inc bx ; increnta 1 no contador bx

    cmp bx, 4 ; compara o conteúdo de bx com 4
    jne continuar ; se o conteúdo não for igual a 4, ele pula para o rotulo continuar

    ; armazena o conteúdo de ax em bx
    mov bx, ax

    ; Exibe na tela a string para pular uma linha após 4 letras
    mov ah, 09h
    mov dx, offset pulalinha
    int 21h

    mov ax, bx ; armazena o conteúdo guardado em bx para ax
    mov bx, 0 ; reinicia contador de letras por linha armazenando 0 em bx

; Define o rotulo
continuar:
    loop print_letra ; decrementa 1 do contador e enquanto for diferente de zero pulara para o rotulo

; Finaliza o programa
mov ah, 4Ch
int 21h
main endp
end main