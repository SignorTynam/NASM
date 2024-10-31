section .data
    msg_positive db "Il numero e' positivo", 0
    msg_negative db "Il numero e' negativo", 0
    msg_zero db "Il numero e' zero", 0

section .text
    global _start

_start:
    mov eax, -5             ; Sostituisci con il numero da verificare
    cmp eax, 0              ; Confronta EAX con zero
    je numero_zero          ; Salta a numero_zero se EAX == 0
    jg numero_positivo      ; Salta a numero_positivo se EAX > 0
    jl numero_negativo      ; Salta a numero_negativo se EAX < 0

numero_positivo:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_positive
    int 0x80
    jmp fine

numero_negativo:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_negative
    int 0x80
    jmp fine

numero_zero:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_zero
    int 0x80

fine:
    mov eax, 1
    int 0x80                ; Esci dal programma