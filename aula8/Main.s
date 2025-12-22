%include "bibliotecaE.s"

section .text

global _start

_start:
   ;função de resto

   mov edx, 0x0
   mov eax, 0xA ; decimal 10
   mov ebx, 0x2
   div ebx  ; EAX => EAX / EBX
   mov eax, edx

   call int_to_string
   call saidaResultado


saida:
   mov EAX, SYS_EXIT
   int SYS_CALL
   ret
