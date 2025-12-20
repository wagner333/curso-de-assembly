segment .data

  LF        equ 0xA   ; Line Feed
  NULL      equ 0xD   ; Final da String
  SYS_CALL  equ 0x80  ; Envia informacao ao SO

  ; ----- EAX -----
  SYS_EXIT  equ 0x1   ; Codigo de chamada para finalizar
  SYS_READ  equ 0x3   ; Operacao de leitura
  SYS_WRITE equ 0x4   ; Operacao de escrita

  ; ----- EBX -----
  RET_EXIT  equ 0x0   ; Operacao realizada com Sucesso
  STD_IN    equ 0x0   ; Entrada padrao
  STD_OUT   equ 0x1   ; Saida padrao

section .data

    msg db "Hello, World!", LF, NULL
    tam equ $ - msg
    other_msg db "Voce nao digitou Wagner.", LF, NULL
    other_msg_len equ $ - other_msg
    wagner_msg db "Ola, Wagner!", LF, NULL
    wagner_msg_len equ $ - wagner_msg
    clear db 0x1B, "[2J", 0x1B, "[H", NULL ; comando para limpar a tela
    clean_len equ $ - clear
    
section .bss
  name resb 20   ; reserva 20 bytes para o nome

section .text
    
global _start


_start:
    ;mostrar hello world
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, msg
    mov edx, tam
    int SYS_CALL
    ;enviar valor
    mov eax, SYS_READ
    mov ebx, STD_IN
    mov ecx, name
    mov edx, 0xA
    int SYS_CALL
    ;mostrar nome
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, name
    mov edx, 0xA
    int SYS_CALL
    
    mov al, [name]     ; pega o primeiro caractere digitado
    cmp al, 'w'        ; compara com 'W'
    je is_wagner       ; se igual, pula
    jmp not_wagner     ; se diferente, pula
      
    not_wagner:
        mov eax, SYS_WRITE
        mov ebx, STD_OUT
        mov ecx, clear
        mov edx, clean_len
        int SYS_CALL
        ;mostrar outro nome
        mov eax, SYS_WRITE
        mov ebx, STD_OUT
        mov ecx, other_msg
        mov edx, other_msg_len
        int SYS_CALL
        jmp final
    is_wagner:
        mov eax, SYS_WRITE
        mov ebx, STD_OUT
        mov ecx, clear
        mov edx, clean_len
        int SYS_CALL
        ;mostrar wagner
        mov eax, SYS_WRITE
        mov ebx, STD_OUT
        mov ecx, wagner_msg
        mov edx, wagner_msg_len
        int SYS_CALL
        jmp final
final:
    ;final program
    mov eax, SYS_EXIT
    mov ebx, RET_EXIT
    int SYS_CALL