section .data
    ; Riserviamo 26 byte per memorizzare i caratteri da A a Z
    alphabet db 26 dup(0)

section .text
    global _start

_start:
    ; Imposta i registri per iniziare il ciclo
    mov ecx, 26           ; Numero di caratteri da memorizzare
    mov al, 'A'           ; Carattere iniziale (A)
    mov edi, alphabet     ; Indirizzo di destinazione in memoria

loop_start:
    mov [edi], al         ; Memorizza il carattere corrente in memoria
    inc al                ; Passa al carattere successivo (incrementa ASCII di 1)
    inc edi               ; Passa alla posizione successiva nell'array
    loop loop_start       ; Decrementa ECX e ripete fino a quando ECX = 0

exit:
    mov eax, 1            ; Chiamata di sistema per uscire (sys_exit)
    xor ebx, ebx
    int 0x80
