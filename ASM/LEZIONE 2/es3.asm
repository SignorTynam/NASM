section .data
    msg_num1_greater db "Numero1 e' maggiore di Numero2", 0
    msg_num2_greater db "Numero2 e' maggiore di Numero1", 0
    msg_equal db "I numeri sono uguali", 0

section .text
    global _start

_start:
    mov eax, 30             ; Sostituisci con il valore di Numero1
    mov ebx, 25             ; Sostituisci con il valore di Numero2
    cmp eax, ebx            ; Confronta EAX e EBX
    je uguali               ; Salta a uguali se sono uguali
    jg num1_maggiore        ; Salta a num1_maggiore se Numero1 > Numero2
    jl num2_maggiore        ; Salta a num2_maggiore se Numero1 < Numero2

num1_maggiore:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_num1_greater
    int 0x80
    jmp fine

num2_maggiore:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_num2_greater
    int 0x80
    jmp fine

uguali:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_equal
    int 0x80

fine:
    mov eax, 1
    int 0x80                ; Esci dal programma