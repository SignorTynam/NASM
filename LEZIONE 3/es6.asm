section .data
m dd 4                   ; Dividendo
d dd 2                   ; Divisore

section .text
global _start

_start:
    mov eax, [m]          ; Carica il dividendo
    mov ebx, [d]          ; Carica il divisore
    xor ecx, ecx          ; Inizializza il quoziente

div_loop:
    sub eax, ebx          ; Sottrai il divisore dal dividendo
    jl end_div            ; Esci se il risultato è negativo
    inc ecx               ; Incrementa il quoziente
    jmp div_loop          ; Ripeti il ciclo

end_div:
    mov eax, 1
    xor ebx, ebx
    int 0x80
