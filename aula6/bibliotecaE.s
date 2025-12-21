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

segment .text



;saida no termin da string
mst_saida:
  call tamanho_string
  mov EAX, SYS_WRITE
  mov EBX, STD_OUT
  int SYS_CALL
  ret

;calcula o tamanho da string
;entrada valor da string em ECX
;saida tamanho em EDX
tamanho_string:
  ; ECX = pointer to string (input)
  ; EDX = counter (output)
  xor edx, edx        ; edx = 0
.next_char:
  cmp byte [ecx + edx], NULL
  jz .finaliza
  inc edx
  jmp .next_char

.finaliza:
  ret