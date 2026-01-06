title alfabeto ; Da titulo ao programa

.model small ; Divide os códigos e dados lidos em 64kb

; Início do código onde estão as instruções
.code
main proc

mov cx, 26 ; armazena 26 no contador
mov al, "A" ; armazena o código ascii do caracter A em al

; Define um rotulo
print_maiusculos:

; Exibe o caracter
mov ah, 02h
mov dl, al
int 21h

inc al ; increnta 1 ao código ascii em al
loop print_maiusculos ; decrementa 1 do contador e enquanto for diferente de zero pulara para o rotulo

mov cx, 26 ; armazena 26 no contador
mov al, "a" ; armazena o código ascii do caracter a em al

; Define um rotulo
print_minusculos:

; Exibe o caracter
mov ah, 02h
mov dl, al
int 21h

inc al ; increnta 1 ao código ascii em al
loop print_minusculos ; decrementa 1 do contador e enquanto for diferente de zero pulara para o rotulo

; Finaliza o programa
mov ah, 4ch
int 21h
main endp
end main