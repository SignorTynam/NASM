section .data
    msg_fine_ciclo db "Il ciclo e' finito", 10, 0 ; Messaggio finale con newline

section .text
global _start

_start:
    mov ecx, 11               ; Imposta il contatore a 11 per contare da 0 a 10
    xor ebx, ebx              ; Inizializza ebx a 0 come contatore

for_loop:
    cmp ebx, ecx
    je end_for_loop           ; Esci quando ebx raggiunge 11

    inc ebx                   ; Incrementa il contatore
    LOOP for_loop             ; Ripeti il ciclo

end_for_loop:
    ; Scrive il messaggio finale
    mov eax, 4                ; Chiamata di sistema per scrivere
    mov ebx, 1                ; Scrivi su stdout
    mov ecx, msg_fine_ciclo   ; Indirizzo del messaggio
    mov edx, 19               ; Lunghezza del messaggio
    int 0x80                  ; Interrompe per eseguire la chiamata di sistema

    ; Uscita dal programma
    mov eax, 1
    xor ebx, ebx
    int 0x80
