%include "bibliotecaE.s"
section .data
  titulo db "Calculadora", LF, NULL
  opcao1 db "1 - Soma", LF, NULL
  opcao2 db "2 - Subtracao", LF, NULL
  opcao3 db "3 - Multiplicacao", LF, NULL
  opcao4 db "4 - Divisao", LF, NULL
  opcaoS db "> ", NULL
  msg_valor1 db "Digite o primeiro valor: ", NULL
  msg_valor2 db "Digite o segundo valor: ", NULL
  msg_resultado db "Resultado: ", NULL
  msgErro db "Operacao invalida!", LF, NULL
  msg_erro_div db "Erro: Divisao por zero!", LF, NULL
  p1 db "processo de Adicao", LF, NULL
  p2 db "processo de Subtracao", LF, NULL
  p3 db "processo de Multiplicacao", LF, NULL
  p4 db "processo de Divisao", LF, NULL
  newline db LF, NULL
section .bss
  input_valor1 resb 0x10
  input_valor2 resb 0x10
  resultado resb 0x10
  opcao resb 0x2
  num1 resd 1
  num2 resd 1
  resultado_int resd 1

section .text
global _start

_start:
  ; Exibir título
  mov ECX, titulo
  call mst_saida
  mov ECX, newline
  call mst_saida

  ; Exibir opções
  mov ECX, opcao1
  call mst_saida
  mov ECX, opcao2
  call mst_saida
  mov ECX, opcao3
  call mst_saida
  mov ECX, opcao4
  call mst_saida
  mov ECX, newline
  call mst_saida

  ; Exibir prompt
  mov ECX, opcaoS
  call mst_saida

  ; Ler opção
  mov EAX, SYS_READ
  mov EBX, STD_IN
  mov ECX, opcao
  mov EDX, 0x2
  int SYS_CALL

  ; Solicitar primeiro valor
  mov ECX, msg_valor1
  call mst_saida

  ; Ler primeiro valor
  mov EAX, SYS_READ
  mov EBX, STD_IN
  mov ECX, input_valor1
  mov EDX, 0x10
  int SYS_CALL

  ; Solicitar segundo valor
  mov ECX, msg_valor2
  call mst_saida

  ; Ler segundo valor
  mov EAX, SYS_READ
  mov EBX, STD_IN
  mov ECX, input_valor2
  mov EDX, 0x10
  int SYS_CALL

  ; Converter valores para inteiros
  ; Converter primeiro valor
  mov ECX, input_valor1
  call string_to_int
  mov [num1], EAX

  ; Converter segundo valor
  mov ECX, input_valor2
  call string_to_int
  mov [num2], EAX

  ; Verificar qual operação foi escolhida
  mov AL, [opcao]
  cmp AL, '1'
  je soma
  cmp AL, '2'
  je subtracao
  cmp AL, '3'
  je multiplicacao
  cmp AL, '4'
  je divisao

  ; Se nenhuma opção válida
  jmp erro_invalido

soma:
  mov ECX, p1
  call mst_saida
  
  mov EAX, [num1]
  add EAX, [num2]
  mov [resultado_int], EAX
  jmp mostrar_resultado

subtracao:
  mov ECX, p2
  call mst_saida
  
  mov EAX, [num1]
  sub EAX, [num2]
  mov [resultado_int], EAX
  jmp mostrar_resultado

multiplicacao:
  mov ECX, p3
  call mst_saida
  
  mov EAX, [num1]
  mov EBX, [num2]
  imul EBX
  mov [resultado_int], EAX
  jmp mostrar_resultado

divisao:
  mov ECX, p4
  call mst_saida
  
  ; Verificar divisão por zero
  mov EAX, [num2]
  cmp EAX, 0
  je erro_div_zero
  
  mov EAX, [num1]
  cdq  ; Estender sinal de EAX para EDX:EAX
  idiv dword [num2]
  mov [resultado_int], EAX
  jmp mostrar_resultado

erro_div_zero:
  mov ECX, msg_erro_div
  call mst_saida
  jmp saida

erro_invalido:
  mov ECX, msgErro
  call mst_saida
  jmp saida

mostrar_resultado:
  ; Exibir resultado
  mov ECX, msg_resultado
  call mst_saida
  
  ; Converter resultado para string
  mov EAX, [resultado_int]
  mov ECX, resultado
  call int_to_string
  
  ; Exibir o número
  mov ECX, resultado
  call mst_saida
  
  ; Nova linha
  mov ECX, newline
  call mst_saida

saida:
  mov EAX, SYS_EXIT
  mov EBX, RET_EXIT
  int SYS_CALL

; Função: Converter string para inteiro
; Entrada: ECX = endereço da string
; Saída: EAX = valor inteiro
string_to_int:
  xor EAX, EAX
  xor EBX, EBX
  xor EDX, EDX
  
.converter:
  mov BL, [ECX]
  cmp BL, 0xA    ; Verificar se é nova linha
  je .fim
  cmp BL, 0      ; Verificar se é NULL
  je .fim
  cmp BL, '0'
  jb .fim
  cmp BL, '9'
  ja .fim
  
  sub BL, '0'    ; Converter ASCII para número
  imul EAX, 10   ; Multiplicar resultado atual por 10
  add EAX, EBX   ; Adicionar novo dígito
  inc ECX        ; Próximo caractere
  jmp .converter
  
.fim:
  ret

; Função: Converter inteiro para string
; Entrada: EAX = valor inteiro, ECX = endereço do buffer
; Saída: Buffer preenchido com string
int_to_string:
  pushad
  mov EDI, ECX        ; EDI = endereço do buffer
  mov ECX, 10         ; Divisor = 10
  mov ESI, EDI
  add ESI, 9          ; ESI aponta para o final do buffer
  mov byte [ESI], 0   ; Terminador NULL
  
  test EAX, EAX       ; Verificar se é negativo
  jns .positivo
  neg EAX             ; Tornar positivo
  mov byte [EDI], '-' ; Adicionar sinal negativo
  inc EDI
  
.positivo:
  xor EDX, EDX
  div ECX             ; EAX = quociente, EDX = resto
  add DL, '0'         ; Converter para ASCII
  dec ESI
  mov [ESI], DL
  test EAX, EAX       ; Verificar se terminou
  jnz .positivo
  
  ; Copiar resultado para a frente do buffer
  mov ECX, EDI
.copiar:
  mov AL, [ESI]
  mov [ECX], AL
  inc ESI
  inc ECX
  test AL, AL         ; Verificar se encontrou NULL
  jnz .copiar
  
  popad
  ret