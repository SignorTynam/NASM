section .data
    msg_equal db "I valori sono uguali", 0
    msg_not_equal db "I valori sono diversi", 0

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
    int 0x80            ; Stampa "I valori sono uguali"