section .data
    msg_even db "Il numero e' pari", 0
    msg_odd db "Il numero e' dispari", 0

section .text
    global _start

_start:
    mov eax, 7              ; Sostituisci con il numero da verificare
    and eax, 1              ; Verifica il bit meno significativo
    jz pari                 ; Salta a "pari" se il numero è pari
    jmp dispari             ; Altrimenti salta a "dispari"

pari:
    ; Codice per stampare "Il numero è pari"
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_even
    int 0x80
    jmp fine

dispari:
    ; Codice per stampare "Il numero è dispari"
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_odd
    int 0x80

fine:
    mov eax, 1
    int 0x80                ; Esci dal programma
