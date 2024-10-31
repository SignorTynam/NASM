section .data
    msg db "Numero pari", 10, 0    ; Messaggio con newline e terminatore nullo
    variabile db 0
section .text
global _start

_start:
    xor ecx, ecx                   ; Inizializza il contatore a 0

do_while_loop:
    mov [variabile], ecx
    test ecx, 1                    ; Verifica se il numero è pari (bit 0 uguale a 0)
    jnz skip_print                 ; Salta se il numero è dispari

    ; Stampa il messaggio
    mov eax, 4                     ; Chiamata di sistema per scrivere
    mov ebx, 1                     ; Scrivi su stdout
    mov edx, 12                    ; Lunghezza del messaggio (12 caratteri)
    mov ecx, msg                   ; Indirizzo del messaggio
    int 0x80

    mov ecx, [variabile]

skip_print:
    inc ecx                        ; Incrementa il contatore
    cmp ecx, 10                    ; Controlla se ha raggiunto 10
    jle do_while_loop              ; Ripeti il ciclo se non ha ancora raggiunto 10

    ; Fine del programma
    mov eax, 1                     ; Chiamata di sistema per uscire
    xor ebx, ebx
    int 0x80
