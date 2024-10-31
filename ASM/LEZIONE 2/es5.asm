section .data
    msg_multiplo4 db "Il numero è multiplo di 4", 0
    msg_non_multiplo4 db "Il numero non è multiplo di 4", 0

section .text
    global _start

_start:
    mov eax, 8              ; Inserisce un numero
    and eax, 3              ; Verifica se gli ultimi 2 bit sono 0
    jz multiplo4            ; Salta a multiplo4 se eax & 3 == 0
    jmp non_multiplo4       ; Altrimenti salta a non_multiplo4

multiplo4:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_multiplo4
    int 0x80
    jmp fine

non_multiplo4:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_non_multiplo4
    int 0x80

fine:
    mov eax, 1
    int 0x80                ; Esce dal programma