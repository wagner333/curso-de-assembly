
global _start

extern somar
extern subtrair
extern multiplicar
extern dividir

section .text

_start:
    ; somar(10, 5)
    mov edi, 10
    mov esi, 5
    call somar
    ; retorno em RAX

    ; subtrair(10, 5)
    mov edi, 10
    mov esi, 5
    call subtrair

    ; multiplicar(10, 5)
    mov edi, 10
    mov esi, 5
    call multiplicar

    ; dividir(10, 5)
    mov edi, 10
    mov esi, 5
    call dividir

    ; exit(0)
    mov eax, 60
    xor edi, edi
    syscall
    section .note.GNU-stack noalloc noexec nowrite progbits

