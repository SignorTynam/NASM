section .data
base dd 3                 ; Base
exp dd 4                  ; Esponente

section .text
global _start

_start:
    mov eax, [base]       ; Carica la base
    mov ecx, [exp]        ; Carica l'esponente
    mov ebx, eax          ; Inizializza il risultato

power_loop:
    dec ecx               ; Decrementa l'esponente
    jz end_power          ; Esce se l'esponente è zero
    imul ebx, eax         ; Moltiplica il risultato per la base
    jmp power_loop        ; Ripeti il ciclo

end_power:
    mov eax, 1
    xor ebx, ebx
    int 0x80
