section .data
LF        equ 0xA
NULL      equ 0x0
SYS_CALL  equ 0x80

SYS_EXIT  equ 0x1
SYS_READ  equ 0x3
SYS_WRITE equ 0x4

STD_IN    equ 0x0
STD_OUT   equ 0x1

msg db "Digite a opcao:", LF
db "[1] Soma", LF
db "[2] Subtracao", LF
db "[3] Multiplicacao", LF
db "[4] Divisao", LF
msg_len equ $ - msg

prompt db "> "
prompt_len equ $ - prompt

msg_n1 db "Digite o primeiro numero: "
len_n1 equ $ - msg_n1

msg_n2 db "Digite o segundo numero: "
len_n2 equ $ - msg_n2

msg_res db "Resultado: "
len_res equ $ - msg_res


section .bss
    option resb 4   ; option and newline
    num1 resb 8     ; buffer for first number (ASCII)
    num2 resb 8     ; buffer for second number (ASCII)
    resultado resb 12 ; result string buffer


section .text

global _start

_start:
    ; Mostrar menu
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, msg
    mov edx, msg_len
    int SYS_CALL

    ; Mostrar prompt
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, prompt
    mov edx, prompt_len
    int SYS_CALL

    ; Ler opcao
    mov eax, SYS_READ
    mov ebx, STD_IN
    mov ecx, option
    mov edx, 4
    int SYS_CALL

    ; Comparar opcao
    cmp byte [option], '1'
    je soma

    cmp byte [option], '2'
    je subtracao

    cmp byte [option], '3'
    je multiplicacao

    cmp byte [option], '4'
    je divisao

    jmp fim

soma:
    ; pedir num1
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, msg_n1
    mov edx, len_n1
    int SYS_CALL

    ; ler num1 (até 8 bytes)
    mov eax, SYS_READ
    mov ebx, STD_IN
    mov ecx, num1
    mov edx, 8
    int SYS_CALL
    mov esi, eax        ; bytes lidos

    ; converter ASCII -> numero em ebx
    xor ebx, ebx        ; ebx = 0 (num1)
    mov edi, num1
parse_num1:
    cmp esi, 0
    je parse1_done
    mov al, [edi]
    cmp al, 0xA        ; newline
    je parse1_done
    cmp al, 0xD        ; CR
    je parse1_done
    movzx eax, al
    sub eax, '0'
    imul ebx, ebx, 10
    add ebx, eax
    inc edi
    dec esi
    jmp parse_num1
parse1_done:

    ; pedir num2
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, msg_n2
    mov edx, len_n2
    int SYS_CALL

    ; ler num2
    mov eax, SYS_READ
    mov ebx, STD_IN
    mov ecx, num2
    mov edx, 8
    int SYS_CALL
    mov esi, eax        ; bytes lidos

    ; converter ASCII -> numero em ecx
    xor ecx, ecx        ; ecx = 0 (num2)
    mov edi, num2
parse_num2:
    cmp esi, 0
    je parse2_done
    mov al, [edi]
    cmp al, 0xA
    je parse2_done
    cmp al, 0xD
    je parse2_done
    movzx eax, al
    sub eax, '0'
    imul ecx, ecx, 10
    add ecx, eax
    inc edi
    dec esi
    jmp parse_num2
parse2_done:

    ; soma: ebx + ecx -> eax
    mov eax, ebx
    add eax, ecx
    jmp print_result_from_eax

subtracao:
    ; pedir num1
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, msg_n1
    mov edx, len_n1
    int SYS_CALL

    mov eax, SYS_READ
    mov ebx, STD_IN
    mov ecx, num1
    mov edx, 8
    int SYS_CALL
    mov esi, eax

    xor ebx, ebx
    mov edi, num1
    jmp parse_num1_sub
parse_num1_sub:
    cmp esi, 0
    je parse1_sub_done
    mov al, [edi]
    cmp al, 0xA
    je parse1_sub_done
    cmp al, 0xD
    je parse1_sub_done
    movzx eax, al
    sub eax, '0'
    imul ebx, ebx, 10
    add ebx, eax
    inc edi
    dec esi
    jmp parse_num1_sub
parse1_sub_done:

    ; pedir num2
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, msg_n2
    mov edx, len_n2
    int SYS_CALL

    mov eax, SYS_READ
    mov ebx, STD_IN
    mov ecx, num2
    mov edx, 8
    int SYS_CALL
    mov esi, eax

    xor ecx, ecx
    mov edi, num2
parse2_sub:
    cmp esi, 0
    je parse2_sub_done
    mov al, [edi]
    cmp al, 0xA
    je parse2_sub_done
    cmp al, 0xD
    je parse2_sub_done
    movzx eax, al
    sub eax, '0'
    imul ecx, ecx, 10
    add ecx, eax
    inc edi
    dec esi
    jmp parse2_sub
parse2_sub_done:

    ; subtracao: ebx - ecx -> eax (signed)
    mov eax, ebx
    sub eax, ecx
    jmp print_result_from_eax

multiplicacao:
    ; pedir num1
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, msg_n1
    mov edx, len_n1
    int SYS_CALL

    mov eax, SYS_READ
    mov ebx, STD_IN
    mov ecx, num1
    mov edx, 8
    int SYS_CALL
    mov esi, eax

    xor ebx, ebx
    mov edi, num1
parse_num1_mul:
    cmp esi, 0
    je parse1_mul_done
    mov al, [edi]
    cmp al, 0xA
    je parse1_mul_done
    cmp al, 0xD
    je parse1_mul_done
    movzx eax, al
    sub eax, '0'
    imul ebx, ebx, 10
    add ebx, eax
    inc edi
    dec esi
    jmp parse_num1_mul
parse1_mul_done:

    ; pedir num2
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, msg_n2
    mov edx, len_n2
    int SYS_CALL

    mov eax, SYS_READ
    mov ebx, STD_IN
    mov ecx, num2
    mov edx, 8
    int SYS_CALL
    mov esi, eax

    xor ecx, ecx
    mov edi, num2
parse_num2_mul:
    cmp esi, 0
    je parse2_mul_done
    mov al, [edi]
    cmp al, 0xA
    je parse2_mul_done
    cmp al, 0xD
    je parse2_mul_done
    movzx eax, al
    sub eax, '0'
    imul ecx, ecx, 10
    add ecx, eax
    inc edi
    dec esi
    jmp parse_num2_mul
parse2_mul_done:

    ; multiplicacao: eax = ebx * ecx
    mov eax, ebx
    imul eax, ecx
    jmp print_result_from_eax

divisao:
    ; pedir num1
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, msg_n1
    mov edx, len_n1
    int SYS_CALL

    mov eax, SYS_READ
    mov ebx, STD_IN
    mov ecx, num1
    mov edx, 8
    int SYS_CALL
    mov esi, eax

    xor ebx, ebx
    mov edi, num1
parse_num1_div:
    cmp esi, 0
    je parse1_div_done
    mov al, [edi]
    cmp al, 0xA
    je parse1_div_done
    cmp al, 0xD
    je parse1_div_done
    movzx eax, al
    sub eax, '0'
    imul ebx, ebx, 10
    add ebx, eax
    inc edi
    dec esi
    jmp parse_num1_div
parse1_div_done:

    ; pedir num2
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, msg_n2
    mov edx, len_n2
    int SYS_CALL

    mov eax, SYS_READ
    mov ebx, STD_IN
    mov ecx, num2
    mov edx, 8
    int SYS_CALL
    mov esi, eax

    xor ecx, ecx
    mov edi, num2
parse_num2_div:
    cmp esi, 0
    je parse2_div_done
    mov al, [edi]
    cmp al, 0xA
    je parse2_div_done
    cmp al, 0xD
    je parse2_div_done
    movzx eax, al
    sub eax, '0'
    imul ecx, ecx, 10
    add ecx, eax
    inc edi
    dec esi
    jmp parse_num2_div
parse2_div_done:

    ; check division by zero
    cmp ecx, 0
    jne do_div
    ; if zero, set eax to 0 and print
    mov eax, 0
    jmp print_result_from_eax
do_div:
    mov eax, ebx
    cdq
    idiv ecx
    jmp print_result_from_eax

; rotina: converte inteiro em EAX para string em `resultado` e escreve
; entrada: EAX = valor (signed)
print_result_from_eax:
    ; salvar algumas regs usadas (não estritamente necessário aqui but safer)
    ; lidar com sinal
    xor edi, edi    ; flag sinal
    cmp eax, 0
    jge .pr_pos
    neg eax
    mov edi, 1      ; sinal negativo
.pr_pos:
    ; converter EAX (unsigned now) para string reversa em resultado+11
    mov ebx, 10
    lea esi, [resultado + 11]
    mov ecx, 0      ; count
    cmp eax, 0
    jne .pr_loop
    mov byte [esi], '0'
    dec esi
    inc ecx
    jmp .pr_done
.pr_loop:
    xor edx, edx
    div ebx         ; eax / 10 -> eax, remainder em edx
    add dl, '0'
    mov [esi], dl
    dec esi
    inc ecx
    cmp eax, 0
    jne .pr_loop
.pr_done:
    ; se negativo, adicionar '-'
    cmp edi, 0
    je .pr_nosign
    mov byte [esi], '-'
    dec esi
    inc ecx
.pr_nosign:
    ; after building digits we left ESI pointing to the byte before the first digit
    ; mostrar "Resultado: "
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, msg_res
    mov edx, len_res
    int SYS_CALL

    ; compute start pointer and length for result now (start = ESI + 1)
    lea ecx, [esi + 1]
    lea edx, [resultado + 12]
    sub edx, ecx

    ; escrever resultado (pointer in ecx, length in edx)
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    int SYS_CALL

    jmp fim


fim:
    mov eax, SYS_EXIT
    xor ebx, ebx
    int SYS_CALL
