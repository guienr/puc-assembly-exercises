TITLE ENTRADA_SAIDA_NUM

; Define o modelo de memória como 'SMALL' (código e dados em um único segmento de 64KB)
.MODEL SMALL

; Define o tamanho da pilha como 100h bytes
.STACK 100

; --- SEÇÃO DE DADOS (.DATA) ---
.DATA
; Mensagens para interação com o usuário (DB = Define Byte)
; 13 = Carriage Return (retorno de carro), 10 = Line Feed (nova linha)
MSG1 DB 13, 10, "Digite b(binario), h(hexadecimal) ou d(decimal) para o tipo de entrada do numero: $"
MSG2 DB 13, 10, "Digite b(binario), h(hexadecimal) ou d(decimal) para o tipo de saida do numero: $"
MSG3 DB 13, 10, "Caractere invalido, digite novamente $"
MSG4 DB 13, 10, "Digite o numero(0 ou 1, max 16 bits, Enter para parar): $"
MSG5 DB 13, 10, "Digite o numero(0 a F, max 4 digitos, Enter para parar): $"
MSG6 DB 13, 10, "Digite o numero(0 a 9, Enter para parar): $"
MSG7 DB 13, 10, "Saida: $"
MSG8 DB 13, 10, "Digite + ou - para o sinal do numero: $"

; --- SEÇÃO DE CÓDIGO (.CODE) ---
.CODE
MAIN PROC
    ; Inicializa o Segmento de Dados (Data Segment - DS)
    MOV AX, @DATA ; Move o endereço do segmento de dados para AX
    MOV DS, AX    ; Move de AX para DS

    XOR BX, BX    ; Inicializa o registrador BX com zero. BX será o acumulador do número.

; --- ESCOLHA DO TIPO DE ENTRADA ---
ESCOLHA_ENT:
    ; Exibe a mensagem MSG1 (Pede o tipo de entrada: b/h/d)
    MOV AH, 09h         ; Função 09h (Imprimir String)
    LEA DX, MSG1        ; Carrega o endereço da string em DX
    INT 21h             ; Chama a interrupção do DOS

    ; Lê um caractere (com echo)
    MOV AH, 01h         ; Função 01h (Ler Caractere com Echo)
    INT 21h             ; O caractere lido fica em AL

    ; Compara a entrada com as opções (suporte a maiúsculas e minúsculas)
    CMP AL, "b"
    JE EB
    CMP AL, "h"
    JE EH
    CMP AL, "d"
    JE ED
    CMP AL, "B"
    JE EB
    CMP AL, "H"
    JE EH
    CMP AL, "D"
    JE ED

    ; Caso seja um caractere inválido
    MOV AH, 09h         ; Imprime a mensagem de erro MSG3
    LEA DX, MSG3
    INT 21h
    JMP ESCOLHA_ENT     ; Volta para o início da escolha

EB:
    CALL ENTRADAB       ; Chama a rotina de entrada Binária
    JMP ESCOLHA_SAI
EH:
    CALL ENTRADAH       ; Chama a rotina de entrada Hexadecimal
    JMP ESCOLHA_SAI
ED:
    CALL ENTRADAD       ; Chama a rotina de entrada Decimal

; --- ESCOLHA DO TIPO DE SAÍDA ---
ESCOLHA_SAI:
    ; Exibe a mensagem MSG2 (Pede o tipo de saída: b/h/d)
    MOV AH, 09h
    LEA DX, MSG2
    INT 21h

    ; Lê um caractere (com echo)
    MOV AH, 01h
    INT 21h

    ; Compara a saída com as opções (suporte a maiúsculas e minúsculas)
    CMP AL, "b"
    JE SB
    CMP AL, "h"
    JE SH
    CMP AL, "d"
    JE SD
    CMP AL, "B"
    JE SB
    CMP AL, "H"
    JE SH
    CMP AL, "D"
    JE SD

    ; Caso seja um caractere inválido
    MOV AH, 09h
    LEA DX, MSG3
    INT 21h
    JMP ESCOLHA_SAI     ; Volta para o início da escolha

SB:
    CALL SAIDAB         ; Chama a rotina de saída Binária
    JMP FINAL
SH:
    CALL SAIDAH         ; Chama a rotina de saída Hexadecimal
    JMP FINAL
SD:
    CALL SAIDAD         ; Chama a rotina de saída Decimal

FINAL:
    ; Termina o programa e retorna ao DOS
    MOV AX, 4CH         ; Função 4CH (Terminar Programa)
    INT 21h
MAIN ENDP

; ---------------------------------
;     ROTINAS DE ENTRADA
; ---------------------------------

ENTRADAB PROC
    MOV CX, 16          ; Inicializa o contador de loop para 16 bits (tamanho do BX)

NUMB:
    ; Pede o dígito binário
    MOV AH, 09h
    LEA DX, MSG4
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

ENTRADAH PROC
    MOV CX, 4           ; Inicializa o contador para 4 dígitos hex (4 * 4 bits = 16 bits)

NUMH:
    ; Pede o dígito hexadecimal
    MOV AH, 09h
    LEA DX, MSG5
    INT 21h

    ; Lê o caractere
    MOV AH, 01h
    INT 21h

    CMP AL, 13
    JE FIMEH            ; Se ENTER, finaliza a entrada

    ; Validação: Checa '0'-'9'
    CMP AL, "0"
    JB ERROH            ; Se for menor que '0'
    CMP AL, "9"
    JBE COLOCAHN        ; Se estiver entre '0' e '9'

    ; Validação: Checa 'A'-'F'
    CMP AL, "A"
    JB ERROH            ; Se for menor que 'A' (e maior que '9')
    CMP AL, "F"
    JBE COLOCAHL        ; Se estiver entre 'A' e 'F'

    ; Validação: Checa 'a'-'f' (suporte a minúsculas)
    CMP AL, "a"
    JB ERROH            ; Se for menor que 'a' (e maior que 'F')
    CMP AL, "f"
    JBE COLOCAHL_MIN    ; Se estiver entre 'a' e 'f'

ERROH:
    MOV AH, 09h
    LEA DX, MSG3
    INT 21h
    JMP NUMH            ; Pede de novo (não decrementa CX)

COLOCAHN:               ; Lógica para dígitos '0'-'9'
    SHL BX, 4           ; LOGICA CORRIGIDA: Multiplica BX por 16 (4 bits) para abrir espaço.
    AND AL, 0Fh         ; Converte ASCII para valor (e.g., '9' -> 9)
    OR BL, AL           ; Adiciona o novo nibble na parte baixa (BL)
    JMP PROXIMO_H       ; Pula a lógica de conversão de letras

COLOCAHL:               ; Lógica para dígitos 'A'-'F'
    SHL BX, 4
    SUB AL, "A"         ; 'A' - 'A' = 0
    ADD AL, 10          ; 0 + 10 = 10 (valor 10)
    OR BL, AL
    JMP PROXIMO_H

COLOCAHL_MIN:           ; Lógica para dígitos 'a'-'f'
    SHL BX, 4
    SUB AL, "a"         ; 'a' - 'a' = 0
    ADD AL, 10          ; 0 + 10 = 10 (valor 10)
    OR BL, AL
    ; Cai naturalmente em PROXIMO_H

PROXIMO_H:
    LOOP NUMH           ; Decrementa CX e salta para NUMH se CX != 0

FIMEH:
    RET
ENTRADAH ENDP

ENTRADAD PROC
    XOR BX, BX          ; Zera o acumulador BX
    MOV DH, 0           ; DH guarda o sinal. 0 = Positivo, 80h = Negativo

SINAL:
    ; Pede o sinal
    MOV AH, 09h
    LEA DX, MSG8
    INT 21h

    ; Lê o sinal
    MOV AH, 01h
    INT 21h

    CMP AL, "+"
    JE NUMD
    CMP AL, "-"
    JE NEGA

    ; Se inválido
    MOV AH, 09h
    LEA DX, MSG3
    INT 21h
    JMP SINAL

NEGA:
    MOV DH, 80h         ; Guarda o bit de sinal em DH (será aplicado em BH no final)
    
NUMD:
    ; Pede o dígito decimal
    MOV AH, 09h
    LEA DX, MSG6
    INT 21h

    ; Lê o dígito
    MOV AH, 01h
    INT 21h

    CMP AL, 13          ; Verifica se é ENTER
    JE FIMED

    ; Validação: Checa '0'-'9'
    CMP AL, "0"
    JAE VERIFICAD
    JMP ERROD
    
VERIFICAD:
    CMP AL, "9"
    JBE COLOCAD

ERROD:
    MOV AH, 09h
    LEA DX, MSG3
    INT 21h
    JMP NUMD

COLOCAD:
    ; --- LOGICA CORRIGIDA: (BX = BX * 10) + Digito ---
    
    AND AL, 0Fh         ; Converte ASCII do dígito para valor numérico (0-9)
    MOV AH, 0           ; Zera AH (para que AX = o valor do dígito)
    
    PUSH AX             ; Salva o dígito lido na pilha
    
    MOV AX, BX          ; AX = Valor atual acumulado (ex: 12)
    MOV CX, 10          ; Divisor/Multiplicador
    MUL CX              ; AX = AX * CX (AX = 12 * 10 = 120). DX:AX = resultado (DX = 0)
    MOV BX, AX          ; BX = 120 (Salva o resultado da multiplicação)
    
    POP AX              ; AX = Digito lido (ex: 3)
    
    ADD BX, AX          ; BX = BX + AX (BX = 120 + 3 = 123)
    ; ----------------------------------------------------
    
    JMP NUMD            ; Pede o próximo dígito

FIMED:
    OR BH, DH           ; Aplica o bit de sinal de DH em BH
    RET
ENTRADAD ENDP

; ---------------------------------
;     ROTINAS DE SAIDA
; ---------------------------------

SAIDAB PROC
    MOV AH, 09h
    LEA DX, MSG7
    INT 21h

    PUSH BX             ; Salva o valor original de BX antes de ser destruído
    MOV CX, 16          ; Contador de 16 bits

IMPRIMIRB:
    SHL BX, 1           ; Desloca o bit mais à esquerda (MSB) para a Carry Flag
    JNC BIT_ZERO        ; Se Carry Flag = 0 (Não houve carry), é '0'

    ; Se Carry Flag = 1
    MOV AH, 02h
    MOV DL, "1"
    INT 21h
    JMP FIMIB

BIT_ZERO:
    ; Se Carry Flag = 0
    MOV AH, 02h
    MOV DL, "0"
    INT 21h

FIMIB:
    LOOP IMPRIMIRB      ; Decrementa CX e repete até CX=0

    POP BX              ; Restaura o valor original de BX
    RET
SAIDAB ENDP

SAIDAH PROC
    ; --- ROTINA CORRIGIDA: Mais simples e correta ---
    MOV AH, 09h
    LEA DX, MSG7
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

SAIDAD PROC
    MOV AH, 09h
    LEA DX, MSG7
    INT 21h

    ; Checa e trata o sinal
    TEST BH, 80h        ; Testa se o bit de sinal customizado está ativo
    JNZ NEGATIVO        ; Se JNZ (diferente de zero), é negativo

    ; Positivo
    MOV AH, 02h
    MOV DL, "+"
    INT 21h
    JMP NUMDI

NEGATIVO:
    MOV AH, 02h
    MOV DL, "-"
    INT 21h
    AND BH, 7Fh         ; CORREÇÃO CRÍTICA: Zera o bit de sinal (80h) em BH.
                        ; O valor em BX agora é o valor absoluto para a divisão.

NUMDI:
    MOV CX, 0           ; CX = Contador de dígitos
    MOV AX, BX          ; AX = Valor a converter (dividendo)
    MOV BX, 10          ; BX = Divisor
    
    ; Trata o caso especial de BX ser 0 para imprimir "0"
    CMP AX, 0
    JNE CONVERTED
    PUSH '0'            ; Coloca '0' na pilha
    INC CX              ; CX = 1
    JMP PRINTD_INICIO   ; Pula para a impressão

CONVERTED:
    XOR DX, DX          ; DX:AX é o dividendo. Zera DX (para divisão 16-bit, onde DX é a parte alta).
    DIV BX              ; DX:AX / 10. AX = Quociente, DX = Resto (o dígito)
    PUSH DX             ; Salva o dígito (resto) na pilha
    INC CX
    
    CMP AX, 0           ; Quociente (AX) chegou a 0?
    JNE CONVERTED       ; Se não, continua dividindo

; Imprime os dígitos (da pilha, para ordem correta: do mais significativo para o menos)
PRINTD_INICIO:
PRINTD:
    POP DX              ; Tira o dígito da pilha
    ADD DL, '0'         ; Converte o número (0-9) para ASCII ('0'-'9')
    MOV AH, 02h
    INT 21h             ; Imprime o caractere
    LOOP PRINTD         ; Decrementa CX e repete até todos os dígitos serem impressos

    RET
SAIDAD ENDP

END MAIN