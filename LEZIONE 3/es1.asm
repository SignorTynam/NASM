section .text
global _start

_start:
    mov ecx, 5            ; Inizializza il flag a 5

while_loop:
    test ecx, ecx         ; Verifica se il flag è zero
    je end_loop           ; Esci dal ciclo se è zero

    dec ecx               ; Decrementa il flag
    jmp while_loop        ; Ripeti il ciclo

end_loop:
    mov eax, 1            ; Chiamata di sistema per uscire
    xor ebx, ebx
    int 0x80
