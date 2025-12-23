%include "bibliotecaE.s"

section .data
    msg db "Fibonacci", 10, 0
    msg_len equ $ - msg

    quantidade dd 5
    n          dd 1

section .text
    global _start

_start:
    ; escreve mensagem inicial (sys_write)
    mov eax, SYS_WRITE        ; SYS_WRITE
    mov ebx, STD_OUT        ; STDOUT
    mov ecx, msg
    mov edx, msg_len
    int 0x80

    ; inicializa fibonacci
    mov ecx, 0        ; a = 0
    mov edx, 1        ; b = 1
    xor ebx, ebx      ; contador = 0
    mov esi, [quantidade] ; total termos

.loop_fib:
    cmp ebx, esi
    jge .fim_fib

    ; imprime termo atual (a) - int_to_string espera EAX com valor
    mov eax, ecx
    call int_to_string
    call saidaResultado
    ; calcula proximo (next = a + b; a = b; b = next)
    mov eax, ecx
    add eax, edx
    mov ecx, edx
    mov edx, eax
    inc ebx
    jmp .loop_fib

.fim_fib:
    mov eax, SYS_EXIT
    xor ebx, ebx
    int 0x80

