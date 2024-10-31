section .text
global _start
_start:
    mov eax, 5          ; carica 5 in EAX
    mov ebx, 10         ; carica 10 in EBX
    ; Scambia i valori
    xchg eax, ebx       ; EAX ora contiene 10, EBX ora contiene 5
    ; Termina il programma
    mov eax, 1
    xor ebx, ebx
    int 0x80