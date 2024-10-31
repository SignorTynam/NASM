# Lezione 3: I Cicli in NASM
## Obiettivo della Lezione
Imparare a utilizzare diversi tipi di cicli in NASM per creare sezioni di codice che si ripetono, sfruttando istruzioni di salto, confronti, contatori e istruzioni specifiche per loop (``LOOP``, ``TEST``, ``JMP``). Esploreremo anche come costruire manualmente vari tipi di cicli (e.g., ``while``, ``for``, ``do-while``), approfondendo l'uso delle istruzioni NASM fondamentali per il controllo del flusso.

### Prerequisiti
Conoscenza di:
- Registri (``EAX``, `EBX`, `ECX`, etc.)
- Istruzioni di salto (`JMP`, `JE`, `JNE`, etc.)
- Confronti con `CMP` e `TEST`
- Contatori e gestione di incrementi/decrementi

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
section .data
    contatore db 10          ; Valore iniziale del contatore

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
```
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
```
section .data
    limite db 5              ; Numero di iterazioni

section .text
    global _start

_start:
    mov ecx, 0               ; Contatore iniziale (i = 0)

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
    contatore db 3           ; Numero di iterazioni

section .text
    global _start

_start:
    mov eax, contatore       ; Carica il contatore

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
NASM include un'istruzione specifica per i cicli chiamata ``LOOP``, che utilizza il registro ``ECX`` come contatore. ``LOOP`` decrementa ecx e salta alla label indicata finché ecx non diventa zero.

### Esempio: Ciclo ``LOOP``
```
section .data
    contatore db 5           ; Numero di iterazioni

section .text
    global _start

_start:
    mov ecx, contatore       ; Carica `contatore` in `ecx`

ciclo_loop:
    ; Corpo del ciclo

    loop ciclo_loop          ; Decrementa ecx e ripete se ecx != 0

fine_ciclo_loop:
    mov eax, 1               ; syscall per terminare
    int 0x80
```

**Nota:** Questo ciclo è efficiente quando si desidera ripetere un’azione un numero noto di volte, dato che ``LOOP`` riduce la necessità di confronti e salti espliciti.

## 7. Esercizi
1. **Ciclo while con ``TEST``:** Crea un ciclo while che utilizza ``TEST`` per controllare un flag che determina la fine del ciclo. Il flag deve essere decrementato ogni volta fino a raggiungere zero.

2. **Simulare un ciclo for con ``LOOP``:**
Utilizza ``LOOP`` per creare un ciclo che conti da 0 a 10 e mostri ciascun numero sullo schermo.

3. **Controllo di numeri pari con ``do-while``:** Scrivi un ciclo ``do-while`` che incrementa un contatore fino a 10, ma stampa solo i numeri pari. Usa `TEST` per verificare la parità.

4. **Controllo di un array:** Crea un ciclo che attraversa un array di 5 elementi e somma solo i numeri positivi, utilizzando ``cmp`` per verificare i valori positivi e negativi.

5. **Moltiplicazione tramite somma ripetuta:** Scrivi un ciclo che, dato un numero `n`, calcoli il prodotto ``n * 3`` usando solo addizioni ripetute.

