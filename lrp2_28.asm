TITLE EX28

; Define o modelo de memória como 'SMALL' (código e dados em um único segmento de 64KB)
.MODEL SMALL

; Define o tamanho da pilha como 100h bytes
.STACK 100

; --- SEÇÃO DE DADOS (.DATA) ---
.DATA
; Mensagens para interação com o usuário (DB = Define Byte)
; 13 = Carriage Return (retorno de carro), 10 = Line Feed (nova linha)
MSG1 DB 13, 10, "Digite o numero(0 ou 1, max 16 bits, Enter para parar): $"
MSG2 DB 13, 10, "Saida: $"
MSG3 DB 13, 10, "Caractere invalido, digite novamente $"

; --- SEÇÃO DE CÓDIGO (.CODE) ---
.CODE
MAIN PROC
    ; Inicializa o Segmento de Dados (Data Segment - DS)
    MOV AX, @DATA ; Move o endereço do segmento de dados para AX
    MOV DS, AX    ; Move de AX para DS

    CALL ENTRADAB

    CALL SAIDAH

MOV AX, 4CH         ; Função 4CH (Terminar Programa)
INT 21h
MAIN ENDP

ENTRADAB PROC
    MOV CX, 16          ; Inicializa o contador de loop para 16 bits (tamanho do BX)

NUMB:
    ; Pede o dígito binário
    MOV AH, 09h
    LEA DX, MSG1
    INT 21h

    ; Lê o caractere (dígito)
    MOV AH, 01h
    INT 21h

    CMP AL, 13          ; Verifica se o usuário pressionou ENTER (ASCII 13)
    JE FIMEB            ; Se sim, finaliza a entrada

    ; Validação do caractere
    CMP AL, "0"
    JE COLOCAB
    CMP AL, "1"
    JE COLOCAB

    ; Se for inválido (não é '0', '1' ou ENTER)
    MOV AH, 09h
    LEA DX, MSG3
    INT 21h
    JMP NUMB            ; Pede o dígito novamente (não decrementa CX)

COLOCAB:
    SHL BX, 1           ; LOGICA CORRIGIDA: Desloca BX para a esquerda 1 bit (Multiplica por 2) para abrir espaço.
    AND AL, 0Fh         ; Converte o caractere ASCII ('0' ou '1') para o valor numérico (0 ou 1).
    OR BL, AL           ; Adiciona o novo bit na posição menos significativa (BL).

    LOOP NUMB           ; Decrementa CX e salta para NUMB se CX != 0

FIMEB:
    RET                 ; Retorna para o chamador
ENTRADAB ENDP

SAIDAH PROC
    ; --- ROTINA CORRIGIDA: Mais simples e correta ---
    MOV AH, 09h
    LEA DX, MSG2
    INT 21h

    PUSH BX             ; Salva o valor original de BX
    MOV CX, 4           ; Loop para 4 nibbles (dígitos hex)

IMPRIMIR_NIBBLE:
    ROL BX, 4           ; Rotação de 4 bits: Traz o próximo nibble para a posição DL
    
    MOV DL, BL          ; Copia o byte baixo (BL)
    AND DL, 0Fh         ; Isola o nibble de interesse (os 4 bits mais baixos)
    
    ; Conversão para ASCII
    CMP DL, 9           ; É um número (0-9)?
    JBE E_NUMERO        ; Se sim, pula

    ; Se é letra (A-F)
    ADD DL, "A"         ; Adiciona o ASCII de 'A'
    SUB DL, 10          ; Subtrai 10 para ajustar (e.g., 10 + 'A' - 10 = 'A')
    JMP IMPRIME

E_NUMERO:
    OR DL, 30h         ; Adiciona o ASCII de '0' (e.g., 9 + '0' = '9')

IMPRIME:
    MOV AH, 02h
    INT 21h             ; Imprime o caractere
    
    LOOP IMPRIMIR_NIBBLE

    ; Imprime o sufixo 'h'
    MOV AH, 02h
    MOV DL, "h"
    INT 21h
    
    POP BX              ; Restaura o valor original de BX
    RET
SAIDAH ENDP

END MAIN