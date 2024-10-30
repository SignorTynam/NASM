# Lezione 1: Introduzione a NASM (Netwide Assembler) - Appunti per il Professore

## Obiettivi della lezione
- Introdurre il linguaggio Assembly e NASM.
- Familiarizzare lo studente con la sintassi e la struttura base di un programma NASM.
- Creare e analizzare un programma semplice: "Hello, World!".
- Introdurre i registri principali e le operazioni base di manipolazione dati.
- Offrire esercizi pratici per consolidare le competenze di base.

---

## 1. Introduzione a NASM e all'Assembly

### 1.1 Cos'è NASM?
- **NASM** (Netwide Assembler) è un assembler open-source per l'architettura x86 (32-bit) e x86_64 (64-bit). È molto usato in quanto consente di scrivere programmi a basso livello che dialogano direttamente con l’hardware.
- **Scopo dell’Assembly**:
  - Il linguaggio Assembly è un linguaggio di basso livello che permette di accedere e controllare direttamente l'hardware.
  - Viene compilato in istruzioni macchina, ovvero le istruzioni base che la CPU può eseguire.
  - Rispetto ai linguaggi di alto livello (come Java o Python), l'Assembly è meno portabile e più complesso, ma è molto più efficiente e offre un controllo preciso su ogni aspetto delle operazioni CPU.
  - **Vantaggi**: Massimo controllo sulla CPU, alta efficienza, e uso diretto delle risorse hardware.
  - **Svantaggi**: Maggiore complessità, non portabilità, difficoltà nella manutenzione e debug.

### 1.2 Architettura x86 a 32-bit
- NASM supporta diverse architetture, ma in questa lezione ci concentreremo su x86 a **32-bit**, che richiede una buona comprensione dei **registri** e del funzionamento della **memoria**.
- **CPU e Memoria**: 
  - La CPU è il cervello del computer, mentre la memoria è dove vengono memorizzati dati e istruzioni.
  - La CPU può accedere ai dati in memoria, modificarli e fare calcoli.

#### Concetti Principali
- **Registri**: Piccole celle di memoria veloci nella CPU, usate per calcoli e manipolazioni di dati.
  - **EAX, EBX, ECX, EDX**: Sono i principali registri di uso generale in x86. Ognuno ha una funzione specifica nelle operazioni.
  - **EAX**: Accumulatore, spesso usato per calcoli e risultati.
  - **EBX**: Base, può contenere puntatori o dati generici.
  - **ECX**: Contatore, utile nei loop e operazioni iterative.
  - **EDX**: Usato per estendere le operazioni di moltiplicazione/divisione.
- **Stack e memoria**: Lo **stack** è un’area di memoria che funziona in modo **LIFO** (Last In, First Out), usata per gestire variabili locali e ritorni di funzione.

---

## 2. Sintassi e Struttura di un Programma NASM

### 2.1 Sezioni di un Programma
In un programma NASM, di solito troverai tre sezioni principali:

1. **.data**: Memorizza variabili e dati statici, come stringhe o valori numerici.
   
   ```assembly
     section .data
     message db "Hello, World!", 0 ; definisce una stringa terminata da 0
   ```
2. **.bss**: Memorizza variabili non inizializzate. Ad esempio:
   
    ```assembly
      section .bss
      temp resb 1 ; riserva 1 byte per la variabile temp
    ```
3. **.text**: Dove si trova il codice eseguibile. Questa sezione inizia con global _start, che indica l’inizio del programma:
   
    ```assembly
      section .text
      global _start
      _start:
    ```

### 2.2 Istruzioni Base
- **mov**: Copia un valore da una sorgente a una destinazione.
  
    ```assembly
      mov eax, 5 ; carica 5 in EAX
      mov ebx, eax ; carica il valore di EAX in EBX
    ```
- **add e sub**: Somma e sottrae.

    ```assembly
      add eax, 3 ; aggiunge 3 al valore in EAX
      sub eax, 2 ; sottrae 2 da EAX
    ```

#### Esempio Completo
```assembly
section .data
num1 db 10
num2 db 20

section .text
global _start
_start:
    mov al, [num1]    ; carica il valore di num1 in AL
    add al, [num2]    ; somma al valore di num2
    mov [num1], al    ; salva il risultato in num1
```

### 2.3 Commenti e Macro
- **Commenti**: Usa ; per aggiungere spiegazioni.

    ```assembly
      mov eax, 5 ; assegnare 5 a EAX
    ```
- **Macro**: Codice riutilizzabile. Ad esempio:
  
    ```assembly
      %macro display 0
          mov eax, 4
          mov ebx, 1
          mov ecx, msg
          mov edx, 13
          int 0x80
      %endmacro
    ```

---


## 3. Primo Programma: "Hello, World!"

Ecco un programma completo:
```assembly
section .data
    msg db "Hello, World!", 0

section .text
global _start
_start:
    mov eax, 4          ; syscall sys_write
    mov ebx, 1          ; stdout
    mov ecx, msg        ; messaggio
    mov edx, 13         ; lunghezza
    int 0x80            ; syscall
    mov eax, 1          ; syscall sys_exit
    xor ebx, ebx        ; uscita
    int 0x80            ; syscall
```
**Analisi dettagliata**:

### Sezione .data
- **``section .data``**: Questa sezione è utilizzata per dichiarare le variabili statiche e i dati inizializzati.
- **``msg db "Hello, World!", 0``**:
  - ``msg``: È il nome della variabile che conterrà la stringa.
  - ``db``: Sta per **"define byte"**, ed è un'istruzione che alloca spazio per un byte o più.
  - ``"Hello, World!"``: È la stringa che vogliamo stampare.
  - ``0``: Questo è il carattere null (null terminator), che indica la fine della stringa. È importante per le funzioni che leggono la stringa, poiché sanno quando fermarsi.

### Sezione .text
- **``section .text``**: Questa sezione contiene il codice eseguibile del programma.
- **``global _start``**: Indica al linker che **``_start``** è l'etichetta di inizio del programma, quindi è il punto di ingresso per l'esecuzione.
- **``_start:``**: Questo è il punto di partenza del programma. Tutto il codice successivo verrà eseguito a partire da qui.

### Istruzioni di sistema
- **``mov eax, 4``**: 
  - Questo comando **carica il valore 4 nel registro EAX.** Il numero 4 corrisponde al codice della ``syscall`` per ``sys_write``, che viene utilizzata per scrivere dati su un file descriptor.
- **``mov ebx, 1``**: 
  - Qui **stiamo caricando il valore 1 nel registro EBX.** 1 rappresenta il file descriptor per ``stdout (standard output)``, che è dove vogliamo inviare la nostra stringa.
- **`mov ecx, msg`**: 
  - Questo comando carica **l'indirizzo della stringa msg nel registro ECX.** Questo registro ora punta ai dati che vogliamo scrivere.
- **`mov edx, 13`**: 
  - In questo caso, **stiamo caricando 13 nel registro EDX,** che rappresenta la lunghezza della stringa da scrivere. Dobbiamo specificare al sistema operativo quanti byte vogliamo scrivere.
- **`int 0x80`**: 
  - Questa è **una chiamata di interruzione al kernel Linux.** Indica al sistema operativo di eseguire la ``syscall`` specificata nei registri (``sys_write`` in questo caso). Il sistema scrive la stringa msg su ``stdout`` (lo schermo).

### Uscita dal programma
- **``mov eax, 1``**: 
  - Qui **stiamo caricando 1 nel registro EAX**, il che indica al sistema operativo di eseguire ``sys_exit``, che chiude il programma.
- **`xor ebx, ebx`**: 
  - Questa istruzione **azzera EBX**, impostando il codice di uscita a **0**. Utilizziamo ``xor`` qui perché è un modo veloce per azzerare un registro.
- **`int 0x80`**: 
  - Ancora una volta, eseguiamo una chiamata di interruzione per dire al sistema operativo di chiudere il programma utilizzando il codice di uscita fornito in ``EBX``.


Ecco un programma completo:
```assembly
section .data
    msg db "Hello, World!", 0

section .text
global _start
_start:
    mov eax, 4          ; syscall sys_write
    mov ebx, 1          ; stdout
    mov ecx, msg        ; messaggio
    mov edx, 13         ; lunghezza
    int 0x80            ; syscall
    mov eax, 1          ; syscall sys_exit
    xor ebx, ebx        ; uscita
    int 0x80            ; syscall
```
**Analisi dettagliata**:
- `mov eax, 4`: Imposta eax per scrivere.
- `mov ebx, 1`: Usa ebx per scrivere in stdout.
- `int 0x80`: Esegue l’interrupt.

---

## 4. Registri e Manipolazione Dati

### 4.1 Registri Principali
- **EAX, EBX, ECX, EDX** sono usati per vari calcoli e operazioni:
  
    ```assembly
      mov eax, 5 ; carica 5 in EAX
      mov ebx, 3 ; carica 3 in EBX
      add eax, ebx ; somma EBX a EAX
    ```

### 4.2 Operazioni Base
- **Esercizio**:
  - **1**: Carica 10 in ``EAX``, somma 20.
  - **2**: Scambia ``EAX`` con ``EBX``.

---


## 5. Esercizi Guidati
1. **Somma di due numeri**: Scrivere un programma che somma due numeri.
2. **Swap**: Programma che scambia i valori tra EAX e EBX.
3. **Prodotto di due numeri**: Scrivere un programma che calcola il prodotto di due numeri.
4. **Divisione**: Scrivere un programma che divide due numeri e stampa il quoziente.
5. **Incremento**: Scrivere un programma che incrementa un numero dato di 5.
6. **Stampa un numero**: Scrivere un programma che stampa un numero intero dato.

### Soluzioni agli esercizi
1. **Somma di due numeri**:
```assembly
section .data
    num1 db 5
    num2 db 10
    result db 0

section .text
global _start
_start:
    mov al, [num1]       ; Carica num1 in AL
    add al, [num2]       ; Somma num2
    mov [result], al     ; Salva il risultato
    ; Termina il programma
    mov eax, 1
    xor ebx, ebx
    int 0x80
```

2. **Swap**
```assembly
section .text
global _start
_start:
    mov eax, 5          ; carica 5 in EAX
    mov ebx, 10         ; carica 10 in EBX
    ; Scambia i valori
    xchg eax, ebx       ; EAX ora contiene 10, EBX ora contiene 5
    ; Termina il programma
    mov eax, 1
    xor ebx, ebx
    int 0x80
```

3. **Prodotto di due numeri**
```assembly
section .data
    num1 db 3
    num2 db 4
    result db 0

section .text
global _start
_start:
    mov al, [num1]       ; Carica num1 in AL
    mov bl, [num2]       ; Carica num2 in BL
    mul bl               ; Moltiplica AL per BL (AL = AL * BL)
    mov [result], al     ; Salva il risultato
    ; Termina il programma
    mov eax, 1
    xor ebx, ebx
    int 0x80
```

4. **Divisione**
```assembly
section .data
    num1 db 20
    num2 db 4
    result db 0

section .text
global _start
_start:
    mov al, [num1]       ; Carica num1 in AL
    mov bl, [num2]       ; Carica num2 in BL
    xor ah, ah           ; Azzerare AH per divisione
    div bl               ; Divide AL per BL (AL = AL / BL)
    mov [result], al     ; Salva il quoziente
    ; Termina il programma
    mov eax, 1
    xor ebx, ebx
    int 0x80
```

5. **Incremento**
```assembly
section .data
    num db 5
    result db 0

section .text
global _start
_start:
    mov al, [num]        ; Carica il numero in AL
    add al, 5            ; Incrementa di 5
    mov [result], al     ; Salva il risultato
    ; Termina il programma
    mov eax, 1
    xor ebx, ebx
    int 0x80
```

6. **Stampa un numero**
```assembly
section .data
    num db 42
    result db 'Number: ', 0

section .text
global _start
_start:
    ; Stampa il messaggio
    mov eax, 4          ; syscall sys_write
    mov ebx, 1          ; stdout
    mov ecx, result     ; messaggio
    mov edx, 8          ; lunghezza del messaggio
    int 0x80            ; syscall

    ; Stampa il numero
    mov al, [num]       ; Carica il numero in AL
    add al, '0'         ; Converte in carattere ASCII
    mov [num], al       ; Salva
    ; Termina il programma
    mov eax, 1
    xor ebx, ebx
    int 0x80
```

## Cosa vedremo la prossima volta?
- Approfondimento sui **sistemi a 32-bit** e **64-bit**.
- Introduzione alle **chiamate di funzione**.
- Gestione della **memoria** e dello **stack** in Assembly.
