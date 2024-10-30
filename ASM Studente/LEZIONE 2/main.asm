section .data
    msg_pari db "Il numero e' pari", 0
    msg_dispari db "Il numero e' dispari", 0

section .text
    global _start

_start:
    mov eax, 8
    and eax, 1
    jz pari
    jnz dispari
    

pari:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_pari
    mov edx, 17
    int 0x80
    jmp exit

dispari:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_dispari
    mov edx, 20
    int 0x80

exit:
    mov eax, 1
    int 0x80