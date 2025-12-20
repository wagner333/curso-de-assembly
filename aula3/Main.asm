; =========================
;  DEFINIÇÕES E CONSTANTES
; =========================
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


; =========================
;  DADOS DO PROGRAMA
; =========================
section .data 
   ; db  -> define byte       (1 byte)
   ; dw  -> define word       (2 bytes)
   ; dd  -> define doubleword (4 bytes)
   ; dq  -> define quadword   (8 bytes)
   ; resp -> nome da variavel

   x dw 50              ; valor de X (4 bytes)
   y dw 70              ; valor de Y (4 bytes)

   msg  db "X Maior q Y", LF, NULL
   tam  equ $ - msg

   msg2 db "Y Maior q X", LF, NULL
   tam2 equ $ - msg2


; =========================
;  CÓDIGO
; =========================
section .text
global _start

_start:
  ; dword -> serve para trabalhar com inteiros (4 bytes)
  ; ele faz a operacao com 4 bytes de cada vez

  mov EAX, DWORD [x]   ; carrega X
  mov EBX, DWORD [y]   ; carrega Y

  ; comparacao em assembly
  cmp EAX, EBX
  jg maior             ; se X > Y, pula para "maior"

  ; -------------------------
  ; Y maior que X
  ; -------------------------
  mov EAX, SYS_WRITE
  mov EBX, STD_OUT
  mov ECX, msg2
  mov EDX, tam2
  int SYS_CALL

  jmp final            ; pula para o final do programa


  ; =========================
  ;  INSTRUÇÕES DE DESVIO
  ; =========================
  ; je  -> igual              (==)
  ; jg  -> maior              (>)
  ; jl  -> menor              (<)
  ; jle -> menor ou igual     (<=)
  ; jge -> maior ou igual     (>=)
  ; jne -> diferente          (!=)
  ;
  ; goto do assembly -> jmp


maior:
  ; -------------------------
  ; X maior que Y
  ; -------------------------
  mov EAX, SYS_WRITE
  mov EBX, STD_OUT
  mov ECX, msg
  mov EDX, tam
  int SYS_CALL

  jmp final


final:
  ; =========================
  ;  FINAL DO PROGRAMA
  ; =========================
  mov EAX, SYS_EXIT
  mov EBX, RET_EXIT
  int SYS_CALL
