MAIMIN PROC ; Define a função para transformar a letra maiuscula para minuscula
; Entrada BX tem OFFSET do vetor de minuscula e AL a letra maiuscula
SUB AL, 41h ; Subtrai AL pelo valor ASCII correspondente a 'A'
XLAT ; Usa o valor em AL como índice (offset) na tabela de endereços apontada por BX, e substitui o valor em AL pelo byte encontrado naquela posição da tabela (BX + AL)
; Saida AL a letra transformada em minuscula
RET ; Retorna a função principal
MAIMIN ENDP ; Encerra a função para transformar maiuscula para minuscula

END MAIN ; Finaliza o programa