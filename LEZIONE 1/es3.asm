section .data
    num1 db 3
    num2 db 4
    result db 0

section .text
global _start
_start:
    mov al, [num1]       ; Carica num1 in AL
    mov bl, [num2]       ; Carica num2 in BL
    mul bl               ; Moltiplica AL per BL (AL = AL * BL)
    mov [result], al     ; Salva il risultato
    ; Termina il programma
    mov eax, 1
    xor ebx, ebx
    int 0x80