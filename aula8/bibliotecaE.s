segment .data
  LF        equ 0xA  ; Line Feed
  NULL      equ 0x0  ; Final da String (NUL)
  SYS_CALL  equ 0x80 ; Envia informacao ao SO
  ; EAX
  SYS_EXIT  equ 0x1  ; Codigo de chamada para finalizar
  SYS_READ  equ 0x3  ; Operacao de leitura
  SYS_WRITE equ 0x4  ; Operacao de escrita
  ; EBX
  RET_EXIT  equ 0x0  ; Operacao realizada com Sucesso
  STD_IN    equ 0x0  ; Entrada padrao
  STD_OUT   equ 0x1  ; Saida padrao

  TAM_BUFFER equ 0xA

segment .bss
BUFFER  resb  0x4

segment .text

string_to_int:
  ; ---- converter ASCII para inteiro ----
    xor eax, eax        ; resultado final
    xor ebx, ebx
    mov esi, num


int_to_string:
  lea esi, [BUFFER]
  add esi, 0x9
  mov byte[esi], 0xA
  mov ebx, 0xA

.prox_digito:
  xor edx, edx
  div ebx
  add dl, '0'
  dec esi
  mov [esi],dl
  test eax,eax
  jnz .prox_digito
  ret

saidaResultado:
  mov eax, SYS_WRITE
  mov ebx, STD_OUT
  mov ecx, BUFFER
  mov edx, TAM_BUFFER
  int SYS_CALL
  ret