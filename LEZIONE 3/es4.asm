section .data
array db 3, -2, 5, -4, 6

section .text
global _start

_start:
    mov ecx, 5            ; Numero di elementi
    mov esi, array        ; Puntatore all'array
    xor ebx, ebx          ; Somma dei numeri positivi

sum_loop:
    mov al, [esi]         ; Carica il prossimo elemento
    cmp al, 0             ; Verifica se è positivo
    jl skip_add           ; Salta se negativo

    add ebx, eax          ; Somma il numero positivo a ebx

skip_add:
    inc esi               ; Passa all'elemento successivo
    dec ecx               ; Decrementa il contatore
    jnz sum_loop          ; Continua finché ci sono elementi

    mov eax, 1
    xor ebx, ebx
    int 0x80
