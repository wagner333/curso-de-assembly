section .text

global Fibonacci

Fibonacci:
  mov eax, 1
  mov r8d, 1
  mov r9d, 1

calcular:
  sub edi, 1
  cmp edi, 0
  je fim
  mov eax, r8d
  add eax, r9d


trocar:
  mov r8d, r9d
  mov r9d, eax
  jmp calcular

fim:
  ret
