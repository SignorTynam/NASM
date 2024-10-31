# Corso di Netwide Assembly (NASM)

## Le lezioni ottenute
- **Lezione 1:** Introduzione a NASM (Ottenuta il *29 Ottobre 2024*)
- **Lezione 2:** I salti condizionali in NASM (Ottenuta il *30 Ottobre 2024*)
- **Lezione 3:** I cicli in NASM (Ottenuta il *31 Ottobre 2024*)

## Informazioni importanti

1. Il link della pagina Git: [Pagina Git](https://github.com/SignorTynam/NASM/tree/main)
2. Il link della playlist su YouTube: [Il linguaggio Assembly (NASM) - YouTube](https://www.youtube.com/playlist?list=PLYO89vdz7M66gHXwksj2oCRjLg9pdt_Ze)
3. Il link della riunione Microsoft Teams: [Microsoft Teams Meeting](https://teams.microsoft.com/l/meetup-join/19:meeting_MzY3NTE3NTctOTQxNC00NGQ3LWIzYzQtODVmOWEyMjJhOWEy@thread.v2/0?context=%7B%22Tid%22:%22e99647dc-1b08-454a-bf8c-699181b389ab%22,%22Oid%22:%22cb57021c-611d-4909-a520-d4db3584864b%22%7D)


## Eseguire NASM in Visual Studio Code (Architettura a 32 Bit)

Per eseguire NASM (Netwide Assembler) su un’architettura a 32 bit in Visual Studio Code, segui questi passaggi:

### Passo 1: Installare NASM
1. **Scarica NASM** dal sito ufficiale: [NASM Download](https://www.nasm.us/).
2. **Installa NASM** in base al tuo sistema operativo:
   - **Windows**: Scarica il file `.exe` e aggiungi NASM al tuo PATH.
   - **Linux**: Utilizza il gestore di pacchetti, ad esempio `sudo apt install nasm`.
   - **macOS**: Installa con Homebrew: `brew install nasm`.

### Passo 2: Installare Visual Studio Code e l'Estensione Assembly
1. Scarica **Visual Studio Code** se non lo hai già fatto da [Visual Studio Code](https://code.visualstudio.com/).
2. Apri VS Code, vai su **Estensioni** e installa **x86 and x86_64 Assembly** di Daniel Imms per il supporto alla sintassi NASM.

### Passo 3: Configurare il File NASM
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

### Passo 4: Compilare e Collegare il File NASM
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

### Passo 5: Eseguire l'Eseguibile
Esegui l'eseguibile inserendo:
   ```bash
   ./hello
   ```
## Visualizzare i registri in Visual Studio Code (Ubuntu)
### Installa gli Strumenti Necessari
Se non l'hai già fatto, assicurati di avere installato NASM e GDB:
```bash
sudo apt update
sudo apt install nasm gdb
```

### Assembla il Codice
Usa il seguente comando per assemblare il tuo file ``main.asm`` con simboli di debug:
```bash
nasm -f elf main.asm -o main.o -g
```
### Collega il File Oggetto: 
Collega il file oggetto per creare un eseguibile. L'opzione ``-m elf_i386`` specifica l'output a 32 bit:
```bash
ld -m elf_i386 -o main main.o -g
```

### Avvia GDB
Lancia GDB con il tuo eseguibile:
```bash
gdb ./main
```

### Imposta un Punto di Interruzione
Nella console di GDB, imposta un punto di interruzione ```a _start```:
```gdb
(gdb) break _start
```

### Esegui il Programma
Inizia l'esecuzione del tuo programma:
```gdb
(gdb) run
```

### Esegui Passo-Passo
Dopo aver raggiunto il punto di interruzione, puoi eseguire il codice passo-passo:
```gdb
(gdb) step
```
### Visualizza i Registri
Una volta eseguite le istruzioni, controlla i valori dei registri:
```gdb
(gdb) info registers
```