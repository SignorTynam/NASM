# Eseguire NASM in Visual Studio Code (Architettura a 32 Bit)

Per eseguire NASM (Netwide Assembler) su un’architettura a 32 bit in Visual Studio Code, segui questi passaggi:

## Passo 1: Installare NASM
1. **Scarica NASM** dal sito ufficiale: [NASM Download](https://www.nasm.us/).
2. **Installa NASM** in base al tuo sistema operativo:
   - **Windows**: Scarica il file `.exe` e aggiungi NASM al tuo PATH.
   - **Linux**: Utilizza il gestore di pacchetti, ad esempio `sudo apt install nasm`.
   - **macOS**: Installa con Homebrew: `brew install nasm`.

## Passo 2: Installare Visual Studio Code e l'Estensione Assembly
1. Scarica **Visual Studio Code** se non lo hai già fatto da [Visual Studio Code](https://code.visualstudio.com/).
2. Apri VS Code, vai su **Estensioni** e installa **x86 and x86_64 Assembly** di Daniel Imms per il supporto alla sintassi NASM.

## Passo 3: Configurare il File NASM
1. **Crea un nuovo file** in VS Code e salvalo con estensione `.asm`, ad esempio `hello.asm`.
2. Scrivi il tuo codice NASM nel file. Ecco un semplice esempio per un sistema a 32 bit:

    ```asm
    section .data
        msg db "Hello, World!", 0xA  ; messaggio con newline
        len equ $ - msg              ; lunghezza del messaggio

    section .text
        global _start                ; punto di inizio

    _start:
        mov eax, 4                   ; syscall numero 4 (sys_write)
        mov ebx, 1                   ; file descriptor 1 (stdout)
        mov ecx, msg                 ; indirizzo del messaggio
        mov edx, len                 ; lunghezza del messaggio
        int 0x80                     ; chiamata al kernel

        mov eax, 1                   ; syscall numero 1 (sys_exit)
        xor ebx, ebx                 ; codice di uscita 0
        int 0x80                     ; chiamata al kernel per terminare
    ```

## Passo 4: Compilare e Collegare il File NASM
1. Apri il **terminale** in VS Code selezionando **View > Terminal** o con la scorciatoia **Ctrl + `**.
2. **Compila** il file NASM eseguendo:
    ```bash
    nasm -f elf hello.asm -o hello.o
    ```
   - Il flag `-f elf` specifica il formato di output per Linux a 32 bit, creando un file oggetto (`hello.o`).

3. **Collega il file oggetto** per creare un eseguibile:
    ```bash
    ld -m elf_i386 hello.o -o hello
    ```
   - Il flag `-m elf_i386` specifica un collegamento per architetture a 32 bit, creando un eseguibile chiamato `hello`.

## Passo 5: Eseguire l'Eseguibile
Esegui l'eseguibile inserendo:
   ```bash
   ./hello
