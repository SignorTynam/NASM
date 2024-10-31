section .data
    num db 5
    result db 0

section .text
global _start
_start:
    mov al, [num]        ; Carica il numero in AL
    add al, 5            ; Incrementa di 5
    mov [result], al     ; Salva il risultato
    ; Termina il programma
    mov eax, 1
    xor ebx, ebx
    int 0x80