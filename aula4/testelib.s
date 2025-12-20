%include "Main.s"
section .text
global _start
_start:
    lea esi, [BUFFER] ; Load effective address
    add esi, 0x9
    mov byte[esi], 0xA ; Null-terminate the string
    
      ; escreve "abacate" ao contrário

    dec esi
    mov dl, 0x65        ; 'e'
    mov [esi], dl

    dec esi
    mov dl, 0x74        ; 't'
    mov [esi], dl

    dec esi
    mov dl, 0x61        ; 'a'
    mov [esi], dl

    dec esi
    mov dl, 0x63        ; 'c'
    mov [esi], dl

    dec esi
    mov dl, 0x61        ; 'a'
    mov [esi], dl

    dec esi
    mov dl, 0x62        ; 'b'
    mov [esi], dl

    dec esi
    mov dl, 0x61        ; 'a'
    mov [esi], dl

    call saida

    mov eax, SYS_EXIT
    mov ebx, RET_EXIT
    int SYS_CALL
