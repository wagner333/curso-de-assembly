section .text

global GetValorASM

GetValorASM:
    mov eax, edi ; pega o parametro 'a'
    add eax, 0xA ; adiciona 1
    ret
