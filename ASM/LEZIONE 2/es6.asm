section .data
    msg_bit_set db "Il bit è stato impostato", 0

section .text
    global _start

_start:
    mov eax, 4              ; EAX è 00000100 in binario
    or eax, 2               ; Esegue OR con 00000010
    ; Ora EAX è 00000110 in binario, il bit 2 è impostato
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_bit_set
    int 0x80                ; Stampa "Il bit è stato impostato"
    mov eax, 1
    int 0x80                ; Esce dal programma