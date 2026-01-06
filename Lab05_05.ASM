title soma ; Da titulo ao programa

.model small ; Divide os códigos e dados lidos em 64kb
.stack 100h ; Define o tamanho da pilha

; Início do local onde são declarado as variáveis
.data
; Declaração de variáveis
    msg db 'Digite um numero (0-9): $'
    resultado db 'Somatoria: $'
    soma db 0
    pulalinha db 13, 10, '$'
    erro db 'Erro, a soma e maior que 9$'

; Início do código onde estão as instruções
.code
main proc

; Permite o acesso as variaveis definidas em .DATA
    mov ax, @data
    mov ds, ax

    mov cx, 5 ; armazena 5 no contador

; Define rotulo
ler_numero:

; Exibe na tela a string
    mov ah, 09h
    mov dx, offset msg
    int 21h

; função que le um caractere
    mov ah, 01h
    int 21h

    sub al, "0" ; converte ASCII para número subtraindo o conteúdo de al pelo código ascii de 0
    add soma, al ; soma o conteúdo de al com o conteúdo de soma
    cmp soma, 9 ; compara o conteúdo de soma com 9
    ja final_e ; se o conteúdo for maior que 9 pula para o rotulo

 ; Exibe na tela a string para pular uma linha
    mov ah, 09h
    mov dx, offset pulalinha
    int 21h

    loop ler_numero ; decrementa 1 do contador e enquanto for diferente de zero pulara para o rotulo

; Exibe na tela a string "Somatoria: "
    mov ah, 09h
    mov dx, offset resultado
    int 21h

; Converte soma para ASCII somando pelo código ASCII do caracter 0
    mov al, soma
    add al, "0"

;Exibe o caracter na tela
    mov ah, 02h
    mov dl, al
    int 21h
    jmp final_c ; pula para o final do programa estando tudo certo

; Define um rotulo
    final_e:

; Exibe na tela a string para pular uma linha
    mov ah, 09h
    mov dx, offset pulalinha
    int 21h

; Exibe na tela a string de erro
    mov ah, 09h
    mov dx, offset erro
    int 21h

; Define um rotulo
    final_c:

; Finaliza o programa
mov ah, 4Ch
int 21h
main endp
end main