# Lezione 3: I cicli in NASM
## Obiettivo della Lezione
- Imparare a utilizzare diversi tipi di cicli in NASM per creare sezioni di codice che si ripetono, sfruttando istruzioni di salto, confronti, contatori e istruzioni specifiche per loop (``LOOP``, ``TEST``, ``JMP``). 
- Esploreremo anche come costruire manualmente vari tipi di cicli (e.g., ``while``, ``for``, ``do-while``), approfondendo l'uso delle istruzioni NASM fondamentali per il controllo del flusso.

## Prerequisiti
Conoscenza di:
- Registri (``EAX``, `EBX`, `ECX`, etc.)
- Istruzioni di salto (`JMP`, `JE`, `JNE`, ecc.)
- Confronti con `CMP` e `TEST`
- Contatori e gestione di incrementi/decrementi

## Lezione registrata
> Lezione registrata: [Lezione 3 - I ciclo in NASM]()

## 1. Introduzione ai Cicli in Assembly
I cicli consentono di **ripetere** una sequenza di istruzioni **fino a quando una certa condizione è vera** o per un numero di volte definito. A differenza dei linguaggi di alto livello, **NASM non dispone di costrutti specifici per i cicli** (`while`, `for`, `do-while`). Pertanto, dobbiamo utilizzare salti condizionali e confronti per creare cicli.

## 2. Istruzioni di Confronto e Salto in NASM
Prima di creare i cicli, è fondamentale conoscere alcune istruzioni che gestiscono i confronti e i salti condizionali:

### Principali Istruzioni di Confronto
- ```assembly
  cmp operando1, operando2
  ``` 
    confronta `operando1` con `operando2`. Non modifica gli operandi, ma imposta i flag del processore, come il flag zero (ZF) se gli operandi sono uguali.

- ```assembly
  test operando1, operando2
  ```
  esegue un `AND` logico tra gli operandi e imposta i flag. Serve per verificare se un registro è zero senza alterarne il valore.

### Principali Istruzioni di Salto
- ``jmp <label>``: salto incondizionato a ``<label>``.
- ``je <label>``: salto se i valori confrontati con ``cmp`` sono uguali.
- ``jne <label>:`` salto se i valori confrontati con ``cmp`` sono diversi.
- ``jl <label> / jge <label>``: salto se ``operando1`` < ``operando2`` o se ``operando1`` >= ``operando2`` (per confronti con segno).
- ``jb <label> / jae <label>``: salto se ``operando1`` < ``operando2`` o se ``operando1`` >= ``operando2`` (per confronti senza segno).

## 3. Ciclo ``while`` in NASM
Il ciclo ``while`` ripete un blocco di codice finché una condizione è vera. Ecco come tradurlo in NASM:

### Esempio 1: Ciclo ``while`` con `cmp` e `jmp`
```assembly
section .text
    global _start

_start:
    mov eax, contatore       ; Carica il valore di contatore in eax

ciclo_while:
    cmp eax, 0               ; Controlla se il contatore è 0
    je fine_ciclo            ; Esce dal ciclo se eax è 0

    ; Corpo del ciclo
    ; Qui eseguiremo il corpo del ciclo

    dec eax                  ; Decrementa il contatore di 1
    jmp ciclo_while          ; Torna all'inizio del ciclo

fine_ciclo:
    mov eax, 1               ; syscall per terminare il programma
    int 0x80
```

### Esempio 2: Ciclo `while` con `test`
```assembly
section .data
    flag db 1                ; Flag per il ciclo

section .text
    global _start

_start:
    mov al, [flag]           ; Carica il valore del flag

ciclo_test:
    test al, al              ; Verifica se al è diverso da zero
    je fine_ciclo            ; Esce dal ciclo se al è zero

    ; Corpo del ciclo

    dec al                   ; Decrementa `al`
    jmp ciclo_test           ; Ritorna all'inizio del ciclo

fine_ciclo:
    mov eax, 1               ; syscall per terminare
    int 0x80
```

In questo esempio, `test al, al` è una comoda alternativa a `cmp al, 0` per controllare se un valore è zero, senza alterare il registro `al`.

## 4. Ciclo ``for`` in NASM
Un ciclo ``for`` è un ciclo con una condizione iniziale, un ``test`` e un'incremento. Simuliamolo in NASM con ``ECX`` come contatore.

### Esempio: Ciclo ``for`` con contatore (`ECX`)
```assembly
section .data
    limite db 5              ; Numero di iterazioni

section .text
    global _start

_start:
    xor eax, eax             ; Contatore iniziale (i = 0)

ciclo_for:
    cmp ecx, [limite]        ; Confronta ecx con limite
    jge fine_ciclo_for       ; Se ecx >= limite, esce dal ciclo

    ; Corpo del ciclo

    inc ecx                  ; Incrementa ecx
    jmp ciclo_for            ; Torna all'inizio del ciclo

fine_ciclo_for:
    mov eax, 1               ; syscall per terminare
    int 0x80
```

## 5. Ciclo ``do-while`` in NASM
Il ciclo ``do-while`` esegue il corpo almeno una volta. Lo simuliamo saltando direttamente al corpo la prima volta.
```assembly
section .data
    contatore dd 3           ; Numero di iterazioni

section .text
    global _start

_start:
    mov eax, [contatore]       ; Carica il contatore

ciclo_do_while:
    ; Corpo del ciclo

    dec eax                  ; Decrementa il contatore
    cmp eax, 0               ; Verifica se è zero
    jne ciclo_do_while       ; Continua se diverso da zero

fine_ciclo_do_while:
    mov eax, 1               ; syscall per terminare
    int 0x80
```

## 6. Ciclo con ``LOOP`` in NASM
NASM include un'istruzione specifica per i cicli chiamata ``LOOP``, che utilizza il registro ``ECX`` come contatore. ``LOOP`` decrementa `ECX` e salta alla label indicata finché `ECX` non diventa zero.

### Esempio: Ciclo ``LOOP``
```assembly
section .data
    contatore dd 5           ; Numero di iterazioni

section .text
    global _start

_start:
    mov ecx, [contatore]       ; Carica `contatore` in `ecx`

ciclo_loop:
    ; Corpo del ciclo

    loop ciclo_loop          ; Decrementa ecx e ripete se ecx != 0

fine_ciclo_loop:
    mov eax, 1               ; syscall per terminare
    int 0x80
```

**Nota:** Questo ciclo è efficiente quando si desidera ripetere un’azione un numero noto di volte, dato che ``LOOP`` riduce la necessità di confronti e salti espliciti.

## 7. Esercizi
### #1: Ciclo ``while`` con ``TEST``
Crea un ciclo ``while`` che utilizzi l'istruzione ``TEST`` per controllare un flag. Il ciclo deve continuare finché il flag non raggiunge zero. Ogni iterazione decrementa il flag di 1. Suggerimenti:
- Imposta un registro con un valore di inizio (es. 5).
- Usa `TEST` per verificare se il registro è zero.
- Decrementa il registro a ogni iterazione.

### #2: Simulare un ciclo ``for`` con ``LOOP``
Crea un ciclo che conta da 0 a 10 e mostra ciascun numero sullo schermo. Usa ``LOOP`` per gestire il contatore e stampa ogni numero ad ogni iterazione. Suggerimenti:
- Inizia da 0 e usa un ciclo che incrementa fino a 10.
- Usa ``LOOP`` e un contatore in un registro come ``ECX``.
- Mostra il numero corrente a ogni iterazione.

### #3: Ciclo ``do-while`` per numeri pari
Scrivi un ciclo ``do-while`` che incrementa un contatore fino a 10, ma stampa solo i numeri pari. Utilizza ``TEST`` per verificare la parità. Suggerimenti:
- Usa un ciclo ``do-while`` con `cmp` e `jne` per uscire quando il contatore raggiunge 10.
- Usa `TEST` per verificare la parità, stampando solo i numeri pari.

### #4: Somma dei numeri positivi in un array
Crea un ciclo che attraversa un array di 5 elementi, sommando solo i numeri positivi. Utilizza `cmp` per verificare se il numero è positivo o negativo. Suggerimenti:
- Dichiarare un array con valori positivi e negativi.
- Usa `cmp` per controllare il segno del numero e somma solo quelli positivi.
- Usa un ciclo per scorrere l'array elemento per elemento.

### #5: Moltiplicazione tramite somma ripetuta
Scrivi un ciclo che, dato un numero `n`, calcoli `n * 3` usando solo addizioni ripetute. Suggerimenti:
- Usa un ciclo che esegue `add` ripetutamente per accumulare il valore `n` tre volte.
- Utilizza un registro per mantenere il risultato finale.

#### Spiegazione della soluzione
In NASM, puoi definire variabili con direttive diverse a seconda del tipo di dati (e quindi della quantità di memoria) che vuoi allocare. La differenza tra ``db`` e ``dd`` è legata alla dimensione del dato e all'operazione che stai cercando di eseguire.
- ``db`` (define byte): riserva 1 byte (8 bit) in memoria. Questo tipo è usato per valori tra `0` e `255` o per caratteri ASCII.
- ``dd`` (define doubleword): riserva 4 byte (32 bit) in memoria, permettendo di gestire interi a 32 bit, il formato standard nei registri come ``EAX``, ``EBX``, `ECX`, ecc.

    > Se definisci ``n`` con ``db``, stai dicendo a NASM di riservare solo 1 byte. Tuttavia, quando carichi il valore in ``eax`` con ``mov eax, [n]``, stai dicendo al processore di leggere 4 byte, perché ``eax`` è un registro a 32 bit (4 byte). Se `n` fosse definito con ``db``, questo creerebbe un'incoerenza: il programma cercherebbe di leggere 4 byte, ma in memoria è stato riservato solo 1 byte per `n`. Questo può portare a risultati non previsti, come leggere dati extra dalla memoria che non fanno parte del valore originale di `n`.

In NASM, scrivere `mov eax, n` non funziona come previsto perché l'istruzione verrebbe interpretata in modo diverso rispetto a `mov eax, [n]`.
- `mov eax, [n]:` Le parentesi quadre `[]` indicano un accesso al valore memorizzato in memoria all'indirizzo dell'etichetta `n`. Quindi, `mov eax, [n]` carica nel registro `eax` il valore di `n` (nel nostro caso, 5).
- Invece, ``mov eax, n:`` significa caricare nel registro eax l'indirizzo dell'etichetta `n` (cioè il puntatore a `n`, non il valore 5). Questo è utile quando devi lavorare con l’indirizzo in sé, ma in questo caso non vogliamo l’indirizzo, bensì il valore memorizzato all'indirizzo di `n`.

    > **Perché mov eax, n non funziona qui?** Nel contesto del codice, ti serve il valore di `n` (cioè 5) per eseguire l'operazione di moltiplicazione tramite somma ripetuta. Se usassi `mov eax, n,` otterresti l'indirizzo di `n`, non il valore. Di conseguenza, il ciclo non farebbe le addizioni corrette. Quindi, si usa sempre `mov eax, [n]` quando desideriamo il valore memorizzato a un indirizzo, come in questo esempio.

### #6: Divisione usando sottrazioni ripetute
Dato un numero `m` e un divisore `d`, calcola `m / d` usando solo sottrazioni ripetute, restituendo il quoziente. Suggerimenti:
- Usa un ciclo che sottrae `d` da `m` finché `m` non è minore di `d`.
- Conta il numero di sottrazioni eseguite.

### #7: Conteggio dei numeri negativi in un array
Crea un programma che attraversi un array e conti il numero di elementi negativi presenti. Suggerimenti:
- Dichiarare un array con numeri positivi e negativi.
- Usa `cmp` per verificare il segno del numero e incrementa un contatore se il numero è negativo.

### #8: Calcolo della potenza usando moltiplicazioni ripetute
Scrivi un programma che calcoli $a^b$ usando solo moltiplicazioni ripetute, dato un numero base ``a`` e un esponente ``b``. Suggerimenti:
- Usa un ciclo che moltiplica `a` per sé stesso `b` volte.
- Mantieni il risultato in un registro.
