%include "bibliotecaE.s"

section .data

  msg1 db 'parte 1', LF, NULL
  msg2 db 'parte 2', LF, NULL
  msg3 db 'parte 3', LF, NULL
  msg4 db 'parte 4', LF, NULL
  
section .text

global _start

_start:
  mov eax, 0x4
  mov ebx, 0x1
  mov ecx, msg1
  mov edx, 0x1A
  int 0x80

  ;finalizar 
  mov eax, 0x1
  mov ebx, 0x0
  int 0x80
  ret