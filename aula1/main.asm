.global _start

section  .data

hello_msg   db  'Hello, World!', 0xA
hello_len  equ  $ - hello_msg

section   .text


_start:

    mov    rax, 1              ; syscall: write
    mov    rdi, 1              ; file descriptor: stdout
    mov    rsi, hello_msg      ; pointer to message
    mov    rdx, hello_len      ; message length
    
    syscall                    ; invoke operating system to do the write
    push rax

    ;exit to program
    mov    rax, 60             ; syscall: exit
    xor    rdi, rdi            ; exit code 0
    syscall                    ; invoke operating system to exit

