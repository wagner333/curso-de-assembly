global main

extern somar
extern subtrair
extern multiplicar
extern dividir
extern printf

section .data
    fmt db "Resultado: %ld", 10, 0

section .text

main:
    push rbp
    mov rbp, rsp

    ; -------- somar(10, 5) --------
    mov edi, 10          ;edi para o 1º argumento
    mov esi, 5             ;esi para o 2º argumento
    call somar            ; RAX = retorno
    mov rsi, rax          ; 2º argumento do printf
    lea rdi, [rel fmt]    ; 1º argumento do printf
    xor eax, eax          ; ABI: limpa RAX para variadic
    call printf

    ; -------- subtrair(10, 5) --------
    mov edi, 10
    mov esi, 5
    call subtrair

    mov rsi, rax
    lea rdi, [rel fmt]
    xor eax, eax
    call printf

    ; -------- multiplicar(10, 5) --------
    mov edi, 10
    mov esi, 5
    call multiplicar

    mov rsi, rax
    lea rdi, [rel fmt]
    xor eax, eax
    call printf

    ; -------- dividir(10, 5) --------
    mov edi, 10
    mov esi, 5
    call dividir

    mov rsi, rax
    lea rdi, [rel fmt]
    xor eax, eax
    call printf

    ; return 0
    mov eax, 0
    xor edx, edx
    leave
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
