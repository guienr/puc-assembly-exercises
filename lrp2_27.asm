TITLE EX27

; Define o modelo de memória como 'SMALL' (código e dados em um único segmento de 64KB)
.MODEL SMALL

; Define o tamanho da pilha como 100h bytes
.STACK 100

; --- SEÇÃO DE DADOS (.DATA) ---
.DATA
; Mensagens para interação com o usuário (DB = Define Byte)
; 13 = Carriage Return (retorno de carro), 10 = Line Feed (nova linha)
MSG1 DB 13, 10, "Digite o numero(0 a F, max 4 digitos, Enter para parar): $"
MSG2 DB 13, 10, "Saida: $"
MSG3 DB 13, 10, "Caractere invalido, digite novamente $"

; --- SEÇÃO DE CÓDIGO (.CODE) ---
.CODE
MAIN PROC
    ; Inicializa o Segmento de Dados (Data Segment - DS)
    MOV AX, @DATA ; Move o endereço do segmento de dados para AX
    MOV DS, AX    ; Move de AX para DS

    CALL ENTRADAH

    CALL SAIDAB

MOV AX, 4CH         ; Função 4CH (Terminar Programa)
INT 21h
MAIN ENDP

ENTRADAH PROC
    MOV CX, 4           ; Inicializa o contador para 4 dígitos hex (4 * 4 bits = 16 bits)

NUMH:
    ; Pede o dígito hexadecimal
    MOV AH, 09h
    LEA DX, MSG1
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

SAIDAB PROC
    MOV AH, 09h
    LEA DX, MSG2
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

END MAIN