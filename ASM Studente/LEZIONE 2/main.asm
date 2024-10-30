section .data
    msg_equal db "I valori sono uguali", 0

section .text
    global _start

_start:
    mov eax, 5
    mov ebx, 5
    cmp eax, ebx        ; Confronta EAX e EBX
    je valori_uguali    ; Salta a valori_uguali se ZF è impostata

valori_uguali:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_equal
    mov edx, 20
    int 0x80            ; Stampa "I valori sono uguali"

    mov eax, 1
    int 0x80