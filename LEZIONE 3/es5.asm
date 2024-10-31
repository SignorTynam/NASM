section .data
    n dd 5                    ; Numero da moltiplicare

section .text
global _start

_start:
    mov eax, [n]          ; Carica il numero n
    mov ecx, 3            ; Moltiplica per 3 (esegue 3 addizioni)
    xor ebx, ebx          ; Inizializza il risultato

mul_loop:
    add ebx, eax          ; Aggiunge n al risultato
    dec ecx               ; Decrementa il contatore
    jnz mul_loop          ; Ripeti finché ecx non è 0

    mov eax, 1
    xor ebx, ebx
    int 0x80
