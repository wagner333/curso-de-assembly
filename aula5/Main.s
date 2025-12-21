%include "bibliotecaE.s"

section .data
   v1 dw '5', LF, NULL 

section .text

global _start

_start:
   call converte_valor
   call mostrar_valor
   mov eax, SYS_EXIT
   mov ebx, RET_EXIT
   int SYS_CALL

converte_valor:
   lea esi, [v1]
   mov ecx, 0x3
   call string_to_int
   add eax, 0x2
   ret
mostrar_valor:
   call int_to_string
   call saidaResultado
   ret

;função
;string para inteiro
; entrada: ESI (valor) ECX (base)
; saída: EAX (resultado)

string_to_int:
  xor ebx, ebx        ; limpa EBX (acumulador do resultado)

.next_char:
  movzx eax, byte [esi]
  inc esi
  sub al, '0'
  imul ebx, 0xA
  add ebx, eax
  loop .next_char
  mov eax, ebx
  ret
  


;inteiro para string
; entrada: inteiro em EAX
; sida: BUFFER (valor de ECX) TAM_BUFFER (tamanho em EDX)

int_to_string:
  lea esi, [BUFFER]
  add esi, 0x9
  mov byte [esi], 0xA
  mov ebx, 0xA
.next_digit:
   xor edx, edx
   div ebx
   add dl, '0'
   dec esi
   mov [esi], dl
   test eax, eax
   jnz .next_digit
   ret