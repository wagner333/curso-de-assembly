%include "bibliotecaE.s"
section .data
    msg db "Digite um numero: ", LF
    msg_len equ $ - msg

    parmsg db "O numero eh PAR", LF
    tampar equ $ - parmsg

    imparmsg db "O numero eh IMPAR", LF
    tamimpar equ $ - imparmsg

section .bss
    num resb 8          ; buffer seguro

section .text
global _start

_start:
    ; ---- print mensagem ----
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, msg
    mov edx, msg_len
    int 0x80

    ; ---- ler entrada ----
    mov eax, SYS_READ
    mov ebx, STD_IN
    mov ecx, num
    mov edx, 8
    int 0x80

    ; ---- converter ASCII para inteiro ----
    xor eax, eax        ; resultado final
    xor ebx, ebx
    mov esi, num

convert_loop:
    mov bl, [esi]
    cmp bl, LF          ; se '\n', para
    je convert_end
    cmp bl, NULL
    je convert_end

    sub bl, '0'         ; ASCII → número
    imul eax, eax, 10
    add eax, ebx

    inc esi
    jmp convert_loop

convert_end:
    ; ---- verificar par ou ímpar ----
    xor edx, edx
    mov ebx, 2
    div ebx             ; EDX = resto

    cmp edx, 0
    je mostrar_par

mostrar_impar:
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, imparmsg
    mov edx, tamimpar
    int 0x80
    jmp sair

mostrar_par:
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, parmsg
    mov edx, tampar
    int 0x80

sair:
    mov eax, SYS_EXIT
    xor ebx, ebx
    int 0x80
