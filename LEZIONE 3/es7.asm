section .data
array db -3, 5, -6, 8, -2

section .text
global _start

_start:
    mov ecx, 5            ; Numero di elementi
    mov esi, array        ; Puntatore all'array
    xor ebx, ebx          ; Contatore di numeri negativi

neg_count_loop:
    mov al, [esi]         ; Carica l'elemento corrente
    cmp al, 0             ; Verifica se è negativo
    jge skip_count        ; Salta se positivo o zero

    inc ebx               ; Incrementa il contatore di negativi

skip_count:
    inc esi               ; Passa all'elemento successivo
    dec ecx               ; Decrementa il contatore
    jnz neg_count_loop    ; Continua finché ci sono elementi

    mov eax, 1
    xor ebx, ebx
    int 0x80
