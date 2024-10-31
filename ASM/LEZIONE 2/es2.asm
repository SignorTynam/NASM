section .data
    msg_greater db "Numero maggiore di 100", 0
    msg_not_greater db "Numero minore o uguale a 100", 0

section .text
    global _start

_start:
    mov eax, 75             ; Sostituisci con il numero da verificare
    cmp eax, 100            ; Confronta EAX con 100
    jg maggiore             ; Salta a maggiore se EAX > 100
    jmp non_maggiore        ; Altrimenti salta a non_maggiore

maggiore:
    ; Codice per stampare "Numero maggiore di 100"
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_greater
    int 0x80
    jmp fine

non_maggiore:
    ; Codice per stampare "Numero minore o uguale a 100"
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_not_greater
    int 0x80

fine:
    mov eax, 1
    int 0x80                ; Esci dal programma