segment .data
  LF        equ 0xA
  SYS_CALL  equ 0x80
  SYS_EXIT  equ 0x1
  SYS_READ  equ 0x3
  SYS_WRITE equ 0x4
  RET_EXIT  equ 0x0
  STD_IN    equ 0x0
  STD_OUT   equ 0x1
section .data
    msg_par   db "O numero e par.", LF
    len_par   equ $ - msg_par
    msg_impar db "O numero e impar.", LF
    len_impar equ $ - msg_impar
section .text
global _start
_start:
    mov eax, 3        ; troque aqui: 2 (par), 7 (ímpar)
    test eax, 1       ; testa último bit
    jz eh_par         ; zero → par
eh_impar:
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, msg_impar
    mov edx, len_impar
    int SYS_CALL
    jmp fim

eh_par:
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, msg_par
    mov edx, len_par
    int SYS_CALL

fim:
    mov eax, SYS_EXIT
    mov ebx, RET_EXIT
    int SYS_CALL
