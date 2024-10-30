section .data
    num1 db 5
    num2 db 10
    result db 0

section .text
    global _start

_start:
    mov al, [num1]       ; Carica num1 in AL
    add al, [num2]       ; Somma num2
    mov [result], al     ; Salva il risultato
    ; Termina il programma
    mov eax, 1
    xor ebx, ebx
    int 0x80
