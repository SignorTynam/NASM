# Lezione 2: I Salti Condizionali in NASM

## Introduzione

I salti condizionali sono istruzioni che consentono di alterare il flusso del programma in base a determinate condizioni. Quando eseguiamo operazioni di confronto o calcolo, il processore imposta delle "flag" (indicatori di stato) che registrano il risultato. I salti condizionali utilizzano queste flag per decidere se eseguire o meno un salto, spostando l'esecuzione del programma a un’altra sezione di codice.

**Principali flag usate nei salti condizionali**:
- **ZF** (Zero Flag): impostata se il risultato di un'operazione è zero.
- **SF** (Sign Flag): impostata se il risultato è negativo.
- **CF** (Carry Flag): impostata se c'è stato un riporto in un'operazione aritmetica.
- **OF** (Overflow Flag): impostata se si verifica un overflow.

## 1. Label in NASM

Un **label** in NASM rappresenta un indirizzo a cui è possibile fare riferimento per eseguire salti. È semplicemente un nome seguito da due punti (`:`) e indica un punto specifico nel codice. I label sono essenziali per creare flussi di controllo con i salti, e i loro nomi devono essere unici e rappresentativi della funzione che svolgono.

**Esempio di Label**:
```nasm
_start:
    mov eax, 1       ; Codice che fa qualcosa
    jmp _end         ; Salta a _end
_continua:
    ; Altro codice qui
_end:
    mov eax, 1
    int 0x80
```

## 2. Le istruzioni ``CMP`` e ``JMP``
In NASM (Netwide Assembler), ``JMP`` e ``CMP`` sono istruzioni fondamentali per il controllo del flusso di un programma.

### Cos'è ``JMP``?
L'istruzione ``JMP`` (Jump) serve per eseguire un salto incondizionato verso un'altra posizione nel codice. Quando il processore incontra un ``JMP``, esegue immediatamente un salto all’indirizzo indicato, continuando l’esecuzione da quel punto senza alcuna condizione. Questa istruzione è utile per creare cicli e cambiare il flusso di esecuzione quando si desidera, indipendentemente da altre condizioni.

**Sintassi di ``JMP``**
```assembly
JMP label
```

- ``label``: è un'etichetta (nome seguito dai due punti, ad esempio ``continua:``) che indica la posizione a cui saltare.

**Esempio di ``JMP``**
```assembly
section .text
    global _start

_start:
    mov eax, 1          ; Inizio
    jmp salta_qui       ; Salta all'etichetta "salta_qui"

salta_qui:
    ; Il programma continua qui dopo il salto
    mov ebx, 2
    mov eax, 1
    int 0x80
```

In questo esempio, l'istruzione ``JMP`` salta_qui porta l'esecuzione direttamente all’etichetta ``salta_qui``, saltando qualsiasi istruzione intermedia.

### Cos'è ``CMP``?
L'istruzione ``CMP`` (Compare) confronta due valori e imposta le "flag" di stato in base al risultato. Tuttavia, ``CMP`` non modifica i valori nei registri; piuttosto, utilizza una sottrazione "nascosta" tra il primo e il secondo operando, registrando il risultato nelle flag. Queste flag (come ``ZF``, ``SF``, ``CF``) servono poi alle istruzioni di salto condizionato per determinare se eseguire o meno un salto.

**Sintassi di ``CMP``**
```nasm
CMP operando1, operando2
```
- ``operando1``: il primo valore da confrontare.
- ``operando2``: il secondo valore da confrontare.

Le principali flag impostate da CMP sono:
- ``ZF`` (Zero Flag): impostata a 1 se operando1 e operando2 sono uguali (risultato zero).
- ``SF`` (Sign Flag): impostata a 1 se il risultato è negativo.
- ``CF`` (Carry Flag): impostata a 1 se c'è stato un riporto nell'operazione, come in un confronto dove operando1 < operando2.

**Esempio di ``CMP`` con salto condizionale**
```nasm
section .data
    msg_equal db "I valori sono uguali", 0
    msg_not_equal db "I valori sono diversi", 0

section .text
    global _start

_start:
    mov eax, 5
    mov ebx, 5
    cmp eax, ebx        ; Confronta EAX e EBX
    je valori_uguali    ; Salta a valori_uguali se ZF è impostata

valori_uguali:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_equal
    int 0x80            ; Stampa "I valori sono uguali"
```

In questo esempio, l'istruzione ``CMP`` confronta ``EAX`` e ``EBX``. Se sono uguali, ``ZF`` viene impostata e l’istruzione ``JE`` (Jump if Equal) esegue un salto all'etichetta ``valori_uguali``.

### Uso Combinato di ``JMP`` e ``CMP``
``JMP`` e ``CMP`` vengono spesso utilizzati insieme per creare condizioni e controllare i flussi del programma. ``CMP`` effettua il confronto, e poi, in base alle flag impostate, il programma può decidere di saltare (con ``JE``, ``JNE``, ``JG``, ecc.) o di proseguire normalmente.


## 3. Principali Salti Condizionali
### ``JE`` (Jump if Equal) e ``JNE`` (Jump if Not Equal)
- ``JE``: salta se i valori confrontati sono uguali, cioè se ``ZF`` è impostata.
- ``JNE``: salta se i valori confrontati NON sono uguali, cioè se ``ZF`` è zero.

**Esempio di Utilizzo di ``JE`` e ``JNE``**
```asembly
section .data
    msg_equal db "I valori sono uguali", 0
    msg_not_equal db "I valori sono diversi", 0

section .text
    global _start

_start:
    mov eax, 5
    mov ebx, 5
    cmp eax, ebx        ; Confronta EAX e EBX
    je valori_uguali    ; Salta a valori_uguali se ZF è impostata
    jne valori_diversi  ; Salta a valori_diversi se ZF è zero

valori_uguali:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_equal
    int 0x80            ; Stampa "I valori sono uguali"
    jmp fine

valori_diversi:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_not_equal
    int 0x80            ; Stampa "I valori sono diversi"

fine:
    mov eax, 1
    int 0x80            ; Esci dal programma
```

### ``JZ`` (Jump if Zero) e ``JNZ`` (Jump if Not Zero)
- ``JZ``: salta se il risultato è zero ``(ZF=1)``.
- ``JNZ``: salta se il risultato è diverso da zero ``(ZF=0)``.

**Esempio di Utilizzo di ``JZ`` e ``JNZ``**
```assembly
section .data
    msg_zero db "Risultato e zero", 0
    msg_not_zero db "Risultato non e zero", 0

section .text
    global _start

_start:
    mov eax, 10
    sub eax, 11                 ; Esegui 10 - 10, che è zero
    jz risultato_zero           ; Salta a risultato_zero se ZF è impostata
    jnz risultato_non_zero

risultato_zero:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_zero
    mov edx, 16
    int 0x80
    jmp exit

risultato_non_zero:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_not_zero
    mov edx, 20
    int 0x80

exit:
    mov eax, 1
    int 0x80
```

### ``JG`` (Jump if Greater) e ``JL`` (Jump if Less)
- `JG`: salta se il valore è maggiore.
- `JL`: salta se il valore è minore.

Questi salti richiedono un confronto CMP tra i due valori prima dell’esecuzione.

**Esempio di ``JG`` e ``JL``.**
```assembly
section .data
    msg_greater db "EAX e' maggiore di EBX", 0
    msg_less db "EAX e' minore di EBX", 0

section .text
    global _start

_start:
    mov eax, 15
    mov ebx, 10
    cmp eax, ebx
    jg maggiore         ; Salta a maggiore se EAX > EBX
    jl minore           ; Salta a minore se EAX < EBX

maggiore:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_greater
    int 0x80            ; Stampa "EAX e' maggiore di EBX"
    jmp fine

minore:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_less
    int 0x80            ; Stampa "EAX e' minore di EBX"

fine:
    mov eax, 1
    int 0x80            ; Esci dal programma
```
---
| Istruzione | Descrizione | Condizione flag |
|---|---|:---|
| JE | Salta se uguale | ZF = 1 |
| JNE | Salta se diverso | ZF = 0 |
| JZ | Salta se zero | ZF = 1 |
| JNZ | Salta se non zero | ZF = 0 |
| JG | Salta se maggiore (signed) | SF = OF, ZF = 0 |
| JL | Salta se minore (signed) | SF ≠ OF |
| JGE | Salta se maggiore o uguale (signed) | SF = OF |
| JLE | Salta se minore o uguale (signed) | SF ≠ OF, ZF = 1 |
---

## 4. Operatori Logici: AND, OR e NOT
In NASM, gli operatori logici ``AND``, ``OR``, e ``NOT`` sono fondamentali per la manipolazione dei bit, spesso usati per verificare, impostare o invertire specifici bit in un valore. Queste istruzioni sono comunemente utilizzate nelle operazioni di controllo del flusso e per implementare operazioni bitwise su registri o variabili.

### Istruzione ``AND``
L’istruzione ``AND`` effettua un'operazione logica ``AND`` bit a bit tra due operandi, conservando solo i bit che sono impostati su 1 in entrambi gli operandi. Viene spesso utilizzata per mascherare (nascondere) o preservare solo determinati bit di un valore.

Sintassi di ``AND``

```assembly
AND operando1, operando2
```

- ``operando1``: l’operando su cui si applica l'operazione.
- ``operando2``: la maschera o il valore con cui si confronta operando1.

**Esempio di ``AND``**
```assembly
section .data
    msg_even db "Il numero è pari", 0
    msg_odd db "Il numero è dispari", 0

section .text
    global _start

_start:
    mov eax, 6              ; Inserisce un valore da verificare
    and eax, 1              ; Verifica il bit meno significativo
    jz numero_pari          ; Salta a numero_pari se eax & 1 == 0
    jmp numero_dispari      ; Altrimenti, salta a numero_dispari

numero_pari:
    ; Codice per stampare "Il numero è pari"
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_even
    int 0x80
    jmp fine

numero_dispari:
    ; Codice per stampare "Il numero è dispari"
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_odd
    int 0x80

fine:
    mov eax, 1
    int 0x80                ; Esce dal programma
```

In questo esempio, il numero viene mascherato con 1 per verificare se è pari o dispari, osservando il bit meno significativo.

### Istruzione ``OR``
L’istruzione ``OR`` esegue un'operazione ``OR`` logica bit a bit tra due operandi, impostando i bit risultanti su 1 quando almeno uno dei bit negli operandi originali è 1. Questa istruzione è spesso usata per impostare specifici bit in un registro o una variabile.

Sintassi di ``OR``
```assembly
OR operando1, operando2
```
- ``operando1``: l’operando su cui si applica l'operazione.
- ``operando2``: il valore con cui si effettua l’operazione OR.

**Esempio di ``OR``**
```assembly
section .text
    global _start

_start:
    mov eax, 0x04           ; Imposta EAX a 0100 in binario
    or eax, 0x02            ; Esegue OR con 0010 in binario
    ; Il risultato sarà 0110 in binario, ovvero 6 in decimale
    ; A questo punto EAX contiene il valore con bit specifici impostati
    ; Per esempio, il bit di 2^1 è ora impostato
    ; Aggiungi ulteriori istruzioni se necessario
    mov eax, 1
    int 0x80                ; Esce dal programma
```

### Istruzione ``NOT``
L’istruzione ``NOT`` esegue un'operazione di negazione bit a bit, invertendo ciascun bit dell’operando. Questa istruzione è utile per ottenere il complemento di un valore, trasformando ogni 1 in 0 e viceversa.

Sintassi di ``NOT``
```assembly
    NOT operando
```
- ``operando``: l’operando su cui applicare il complemento bit a bit.
**Esempio di ``NOT``**

```assembly
section .text
    global _start

_start:
    mov eax, 0x0F           ; Imposta EAX a 00001111 in binario
    not eax                 ; Inverto tutti i bit di EAX
                            ; Ora EAX è 11110000 in binario
                            ; Questo è utile per operazioni di complemento
                            ; Aggiungi ulteriori istruzioni se necessario
    mov eax, 1
    int 0x80                ; Esce dal programma
```

| Istruzione | Operazione | Esempio | Risultato |
|---|---|---|---|
| AND | Bitwise AND | 6 AND 1 | 010 & 001 = 000 |
| OR | Bitwise OR | 4 OR 2 | 100 OR 010 = 110 |
| NOT | Complemento | NOT OF | 00001111 -> 11110000 |

## Esercizi interattivi

### Esercizio 1: Controllo Pari o Dispari
Scrivi un programma che verifichi se un numero è pari o dispari. Usa ``CMP`` e un salto condizionale per decidere quale messaggio stampare. 

Esempio di Output
```Se il numero è pari: "Il numero è pari."
Se il numero è dispari: "Il numero è dispari."
```
Suggerimento
Utilizza ``AND`` per verificare il bit meno significativo (1 per dispari e 0 per pari).

### Esercizio 2: Maggiore di 100?
Scrivi un programma che controlli se un numero è maggiore di 100 e stampi un messaggio appropriato.

Esempio di Output
```
Se numero > 100: "Numero maggiore di 100."
Se numero ≤ 100: "Numero minore o uguale a 100."
```

### Esercizio 3: Confronto tra Due Numeri
Scrivi un programma che confronti due numeri (``numero1`` e ``numero2``) e stampi quale dei due è maggiore o se sono uguali.

Esempio di Output
```
Se numero1 > numero2: "Numero1 è maggiore di Numero2."
Se numero1 < numero2: "Numero2 è maggiore di Numero1."
Se numero1 == numero2: "I numeri sono uguali."
```

### Esercizio 4: Segno Positivo o Negativo
Scrivi un programma che verifichi se un numero è positivo, negativo o zero.

Esempio di Output
```
Se numero > 0: "Il numero è positivo."
Se numero < 0: "Il numero è negativo."
Se numero == 0: "Il numero è zero."
```

### Esercizio 5: Verifica se un numero è multiplo di 4
Scrivi un programma che verifichi se un numero è un multiplo di 4 utilizzando ``AND``.

- **Suggerimento:** Verifica se i due bit meno significativi sono pari a zero.

### Esercizio 6: Imposta un bit specifico usando ``OR``
Scrivi un programma che imposti il bit alla posizione 2 di un numero.