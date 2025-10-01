[Vai al File principale](../../Readme.md)

# 2 Lezione 01 Ottobre 2025

## Db opzioni

- ottimizzato
- semplice
- efficente e sicuro

## con chiavi vinvoli di integrita

cancelli i dati collegati a lui

## Relazione N - N

- Schema concettuale
  - obbligati a creare nuova tabella di transito con chiave primaria
    - incremento e no attributo esterno

## Normalizzazione DB

- dimminuire la possibilità di incruenze sui dati

- più applichi forme normali
  - livello di incomprensione quasi si sistema

### 1. Prima Forma Normale (1NF)

- Ogni tabella deve avere **valori atomici** (nessuna lista o gruppo ripetuto).
- Ogni riga deve rappresentare un’entità distinta.

- ogni tabella deve avere la sua chiave primaria

**Esempio non 1NF:**

| Studente | Telefono       |
| -------- | -------------- |
| Luca     | 333123, 340555 |

**Corretto (1NF):**

| Studente | Telefono |
| -------- | -------- |
| Luca     | 333123   |
| Luca     | 340555   |

Perfetto 👍 allora te lo riscrivo partendo da `###`, così manteniamo la stessa struttura uniforme delle altre forme normali.

### 2. Seconda Forma Normale (2NF)

- Deve essere già in **1NF**.
- Nessuna colonna non chiave deve dipendere solo da **parte** della chiave primaria (utile quando la chiave è composta).

#### 🔴 Esempio non 2NF

Immagina una tabella **DettagliOrdine** con chiave primaria composta da (`IDOrdine`, `IDProdotto`):

| IDOrdine | IDProdotto | NomeProdotto | Quantità |
| -------- | ---------- | ------------ | -------- |
| 101      | P01        | Penna        | 10       |
| 101      | P02        | Quaderno     | 5        |
| 102      | P01        | Penna        | 3        |

👉 Problema:

- La chiave primaria è **composta** da (`IDOrdine`, `IDProdotto`).
- `NomeProdotto` dipende solo da **IDProdotto**, non dall’intera chiave.
- Questo genera ridondanza (es. “Penna” ripetuto più volte).

#### ✅ Corretto (2NF)

Separiamo le informazioni in due tabelle:

**Tabella Ordini_Prodotti (relazione tra ordini e prodotti)**

| IDOrdine | IDProdotto | Quantità |
| -------- | ---------- | -------- |
| 101      | P01        | 10       |
| 101      | P02        | 5        |
| 102      | P01        | 3        |

**Tabella Prodotti**

| IDProdotto | NomeProdotto |
| ---------- | ------------ |
| P01        | Penna        |
| P02        | Quaderno     |

👉 Adesso:

- In **Ordini_Prodotti**, ogni attributo dipende dall’intera chiave (`IDOrdine + IDProdotto`).
- In **Prodotti**, `NomeProdotto` dipende solo da `IDProdotto`.
- Abbiamo eliminato la dipendenza parziale e la ridondanza.

### 3. Terza Forma Normale (3NF)

- Deve essere già in 2NF.
- Nessuna colonna non chiave deve dipendere da un’altra colonna non chiave (**no dipendenze transitive**).

**Esempio non 3NF:**

| Studente | Matricola | Facoltà    |
| -------- | --------- | ---------- |
| Luca     | 123       | Ingegneria |

Se `Facoltà` dipende da `Matricola`, allora non è 3NF.

**Corretto (3NF):**

- Tabella Studenti: (Matricola, NomeStudente, IDFacoltà)
- Tabella Facoltà: (IDFacoltà, NomeFacoltà)

### 4. Forma Normale di Boyce-Codd (BCNF)

- Variante più rigorosa della 3NF.
- Ogni determinante in una dipendenza funzionale deve essere una chiave candidata.

**Esempio non BCNF:**

| Corso | Docente | Aula |

- Ogni corso ha un docente, ma ogni docente ha un’aula fissa → rischio inconsistenze.

**Corretto (BCNF):**

- Tabella Corso-Docente: (Corso, Docente)
- Tabella Docente-Aula: (Docente, Aula)

### 5. Quarta Forma Normale (4NF)

- Deve essere in BCNF.
- Elimina le **dipendenze multivalore** (quando un’entità è legata a più insiemi indipendenti di valori).

**Esempio non 4NF:**

| Studente | Lingua   | Sport  |
| -------- | -------- | ------ |
| Luca     | Inglese  | Calcio |
| Luca     | Francese | Calcio |
| Luca     | Inglese  | Basket |
| Luca     | Francese | Basket |

→ Qui si moltiplicano combinazioni inutili.

**Corretto (4NF):**

- Tabella Studente-Lingue: (Studente, Lingua)
- Tabella Studente-Sport: (Studente, Sport)
