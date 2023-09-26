bits 64

section .data
res: dw 0
a:   dw 40
b:   dw 10
c:   dw 5
d:   dw 30
e:   dw 2

section .text
global _start

_start:
    movsx rax, word[a]
    movsx rdi, word[b]
    movsx rcx, word[c]
    movsx rbx, word[d]
    movsx rsi, word[e]

    ; (a + b) ^ 2 кладем в rax
    add rax, rdi
    imul rax

    ; (c - d) ^ 2 кладем в rcx
    sub rcx, rbx
    imul rcx, rcx

    ; a + e ^ 3 - c кладем в rbx
    mov rdi, rsi
    imul rdi, rsi
    imul rdi, rsi
    movsx rsi, word[a]
    add rdi, rsi
    movsx rsi, word[c]
    sub rdi, rsi
    mov rbx, rdi

    ; проверка делителя на 0
    cmp rbx, 0
    je error

    ; считаем знаменатель и делим
    sub rax, rcx
    cqo
    idiv rbx

    ; кладем результат в res
    mov [res], rax
    mov eax, 60
    mov edi, 0
    syscall

error:
    mov eax, 60
    mov edi, 1
    syscall
