%include 'bibliotecaE.s'

section .data
    array: dd 10,20,30,40,50
section .text

global _start

_start:
    mov EAX, [array + 4 * 4]
    call int_to_string
    call saidaResultado

   mov EAX, SYS_EXIT
   mov EBX, RET_EXIT
   int SYS_CALL