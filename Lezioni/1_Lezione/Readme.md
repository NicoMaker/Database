[Vai al File principale](../../Readme.md)

# 1 Lezione 18 Settembre 2025

## Database Relazionali

- che sono in relzione tra loro e si possono collegare delle tabelle con i dati
- Tabelle e dati -> in relazione tra di loro

- Correlazione tra tabelle

## Relazione

- Tabelle collegate tra di loro
- Tabelle è sottoinsieme del prodotto cartesiano di due domini
- chiamati anche attributi (campi)

## Sistema Informativo (informatico)

- organizzazione di info che vedo quando leggo i dati -> in base a cosa cerco mi da info
- Disponizione degli strumenti che agiscono sui nostri dati -> dati in funzione a cosa serve

- Dati con senso -> informazioni

- Strumenti e dati per gestire le inforazioni in modo rapido ed efficace (orgaaizzatare e grstire dati e fare analisi)
- Gestire i dati in modo efficace e disponibile e bello

## Informazione

- Insieme di dati che hannio significato
  - contene dati
- Elenco di dati
- Informazione dopo elaborazione

## Dati

- elementi del record -> creano informazioni -> dati che esistono dentro
- Informazione prima elaborazione
- Dati

  - diversi tipi di dato

- Dati
  - fondamentali per otteneri i dati da non perdere
    - mantenere dati con analisi
      - Dati predittive con analisi
      - dati in modo persistente
        - velocità e non riscrivi dati
        - approcio strutturato con SW
          - DBMS (database manage system)
          - DBRMS (Relational Database Management System)
  - Fare backup periodico

## Database Management System (DBMS)

### 📖 Definizione

Un **Database Management System (DBMS)** è un software che permette di **creare, gestire, organizzare e interrogare** un **database**, garantendo **sicurezza, integrità ed efficienza** nell’accesso ai dati.
Funziona come un intermediario tra **utente/applicazione** e **database**.

Creazione strumenti di gestione dati -> DDL

## 🎯 Funzioni principali

- **DDL (Data Definition Language):** definizione di tabelle, viste, indici (`CREATE`, `ALTER`, `DROP`).
- **DML (Data Manipulation Language):** inserimento, modifica, eliminazione e lettura dei dati (`INSERT`, `UPDATE`, `DELETE`, `SELECT`).
- **DCL (Data Control Language):** gestione degli accessi e permessi (`GRANT`, `REVOKE`).
- **TCL (Transaction Control Language):** gestione delle transazioni con proprietà **ACID** (`COMMIT`, `ROLLBACK`, `SAVEPOINT`).

## 🛠 Componenti

- **Motore di archiviazione** (storage engine)
- **Query processor** (interpreta e ottimizza query)
- **Gestore delle transazioni**
- **Gestore della sicurezza**
- **Catalogo/Dictionary dei metadati**

## 🔑 Vantaggi

- ✅ Riduzione ridondanza dei dati
- ✅ Integrità e consistenza
- ✅ Sicurezza e controllo accessi
- ✅ Backup e recovery
- ✅ Accesso concorrente da più utenti
- ✅ Indipendenza tra dati e applicazioni

## ⚠️ Svantaggi

- ❌ Costo elevato
- ❌ Complessità di gestione
- ❌ Richiede risorse hardware/software
- ❌ Potenziali vulnerabilità se non configurato bene

## 🏷 Tipi di DBMS

1. **Gerarchico** – struttura ad albero
2. **Reticolare** – relazioni a grafo
3. **Relazionale (RDBMS)** – tabelle e chiavi (es. MySQL, PostgreSQL)
4. **A oggetti** – integra concetti OOP
5. **NoSQL** – non relazionali, usati nei Big Data (es. MongoDB)
6. **Distribuiti** – su più server (es. Google Spanner)

## 📌 Esempi di DBMS

- **Relazionali:** MySQL, PostgreSQL, Oracle DB, SQL Server
- **NoSQL:** MongoDB, Cassandra, CouchDB, Neo4j
- **Embedded:** SQLite

## 🏛 Architettura a 3 livelli

1. **Interno (fisico):** come i dati sono salvati sul disco
2. **Concettuale (logico):** struttura logica (tabelle, relazioni)
3. **Esterno (vista utente):** rappresentazione personalizzata dei dati

## DDL (Data Definition Language)

### 📖 Definizione

Il **Data Definition Language (DDL)** è una componente del linguaggio SQL che serve a **definire e gestire la struttura** di un database.
Con DDL si creano, modificano ed eliminano gli oggetti del database (tabelle, indici, viste, schemi, utenti, ecc.).

DDL -> dati e strumenti di gestione

## 🎯 Funzioni principali del DDL

1. **Creare oggetti** del database (tabelle, indici, viste, schemi).
2. **Modificare oggetti** già esistenti (aggiungere colonne, cambiare vincoli, rinominare).
3. **Eliminare oggetti** quando non sono più necessari.
4. **Definire vincoli di integrità** (primary key, foreign key, unique, check, not null).

## 🔑 Comandi principali del DDL

### 1. `CREATE`

Usato per **creare** nuovi oggetti nel database.

- **Tabella:**

```sql
CREATE TABLE Studenti (
    ID INT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Cognome VARCHAR(50) NOT NULL,
    Eta INT CHECK (Eta >= 18)
);
```

- **Indice:**

```sql
CREATE INDEX idx_nome ON Studenti(Nome);
```

- **Vista:**

```sql
CREATE VIEW VistaStudenti AS
SELECT Nome, Cognome FROM Studenti WHERE Eta >= 18;
```

### 2. `ALTER`

Usato per **modificare** oggetti esistenti.

- Aggiungere una colonna:

```sql
ALTER TABLE Studenti ADD Email VARCHAR(100);
```

- Modificare il tipo di dato:

```sql
ALTER TABLE Studenti ALTER COLUMN Eta SMALLINT;
```

- Eliminare una colonna:

```sql
ALTER TABLE Studenti DROP COLUMN Email;
```

### 3. `DROP`

Usato per **eliminare** oggetti dal database.

- Eliminare tabella:

```sql
DROP TABLE Studenti;
```

- Eliminare vista:

```sql
DROP VIEW VistaStudenti;
```

- Eliminare indice:

```sql
DROP INDEX idx_nome;
```

### 4. `TRUNCATE`

Usato per **svuotare** una tabella eliminando tutti i record, ma mantenendo la struttura.

```sql
TRUNCATE TABLE Studenti;
```

## 🛠 Vincoli gestiti dal DDL

- **PRIMARY KEY:** identifica univocamente ogni record.
- **FOREIGN KEY:** mantiene integrità referenziale tra tabelle.
- **UNIQUE:** assicura valori unici nella colonna.
- **NOT NULL:** impedisce valori nulli.
- **CHECK:** applica condizioni logiche sui valori.

## 🏷 Caratteristiche del DDL

- Le modifiche sono **automaticamente salvate** (auto-commit).
- Gestisce la **struttura**, non i dati (quello è compito del DML).
- È strettamente legato alla definizione dei **metadati** nel catalogo del DBMS.

## Differenza tra DBMS e RDBMS

### DBMS (Database Management System)

- È un software che permette di **creare, gestire e manipolare** un database.
- I dati possono essere organizzati in **file, record, gerarchie o tabelle semplici**.
- Non sempre gestisce le **relazioni** tra i dati.
- Offre funzionalità base di archiviazione, ricerca e modifica.

**Esempi:** Microsoft Access, dBase.

### RDBMS (Relational Database Management System)

- È un **tipo di DBMS** basato sul **modello relazionale**.
- I dati sono organizzati in **tabelle (relazioni)** con righe (tuple) e colonne (attributi).
- Supporta **chiavi primarie, chiavi esterne e vincoli di integrità**.
- Gestisce le proprietà **ACID** (Atomicità, Consistenza, Isolamento, Durabilità).
- Permette query avanzate con **SQL** e relazioni tra più tabelle.

**Esempi:** MySQL, PostgreSQL, Oracle DB, SQL Server.

## Tabella comparativa

| Caratteristica          | DBMS                          | RDBMS                     |
| ----------------------- | ----------------------------- | ------------------------- |
| **Modello dati**        | File, gerarchico o reticolare | Relazionale (tabelle)     |
| **Relazioni tra dati**  | Non sempre supportate         | Supportate (PK, FK)       |
| **Integrità dei dati**  | Limitata                      | Garantita da vincoli      |
| **Transazioni (ACID)**  | Non sempre garantite          | Sempre garantite          |
| **Normalizzazione**     | Non applicata                 | Applicata                 |
| **Accesso multiutente** | Limitato                      | Avanzato                  |
| **Esempi**              | MS Access, dBase              | MySQL, Oracle, SQL Server |

## DB

- collezione di dati per ottenre info

  - gestione di dati che contengono i dati

- Insieme organizzato dei dati organizzati e formattati in modo che uno ha più utenti il posso accedere in modo concordato (relazioni)con dati di tipo in base all'opzione corretto e il tipo

  - consultazione dei dati in tempo reale
    - blocchi

- Poca gestione file system -> privo -> aggiungi tu i dati -> mettere qualsiasi cosa

## Database non relazionali

- puoi mettwere dati di qualsiasi tipo

## Database relazionali

- puoi mettwere dati solo del tipo dicharato

## DBMS

- grande quantità di dati e persistenti

  - riservatezza ed affidabilità dei dati
    - con vincoli d'identità

- vincoli di integrità

  - posso eliminare solo in determinati casi
    - se cancelli dati del primitivo elimini anche principlae e se no prima cancelli vincoli e poi quello principale

- Dati che prendo dati .> da un alra opzione a un altra tabella

  - utwnti comunicano con DBMS -> con area di sorage permanente
    - gestisce info in modo tabellare
      - cominicano con il file system

- Gestisione scalbailità informazioni

  - Cluster
    - unico db grande
      - crea dati all'utente per quello che serve
        - gestione dati grandi
          - relazioni o tabelle

- Struttura Software

  - vedo i dati in modo astratto
    - dati che voglio rappresentare

- traduce dati e li gestisce nel dato in modo corretto -> trovi dati all'interno del file

### Funzioni

#### Gestire una transazione

- se comincia deve funzionare corretamente sia prima che dopo la transazioe
- deve funzioanre tutto

#### Capacità di recupero

- riprendere i dati dei guasti senza perdere i dati (mantenendo info non salvare)
- Controllo affidabilità -> uso log

### Articolazione

#### livelli di astrazione

- descrive come estracco i dati quello che mi serve da dove ci sono tutti i dati (schema esterno)

  - query
  - dati che riesco a estrarre e vedere i dati

  - logica (dati completi)

  - astrazione -> dati come sono salvati nel hd

#### Modello Concettuale

- descrive come estratto i dati quello che mi serve da dove ci sono tutti i dati (schema esterno)
- descrizione dato come funziona il metodo
  - schema sturttura
    - trasformi in logica poi quando è tutto ok

#### Modello Logico

- tabelle a struttura fissa per tenere i dati (modello relazionale)

  - campi tabelle lunghezza fissa

- Modello per capire che concetto che funzioni il modello concettuale

- in base a db che voglio usare
  - R>elazionale
  - Non relazionale

##### Forme Normale

- regole in sequenza che tolgono problemi nel db
- regole per aggiornare i proprio dati e miglorare il db
  - lo devi fare in automatico
- modellare eventuali vincoli e integrità dei dati e restrizione dati (numeri)

##### 1. Creazione tabella a struttura fissa

```sql
CREATE TABLE Impiegati (
    ID INT,            -- intero a lunghezza fissa
    Nome CHAR(20),     -- stringa di 20 caratteri fissi
    Cognome CHAR(20),  -- stringa di 20 caratteri fissi
    Stipendio INT,     -- intero a lunghezza fissa
    Reparto CHAR(15)   -- stringa di 15 caratteri fissi
);
```

##### 2. Inserimento dati iniziali

```sql
INSERT INTO Impiegati (ID, Nome, Cognome, Stipendio, Reparto)
VALUES
(1, 'Mario', 'Rossi', 2000, 'Amministrazione'),
(2, 'Lucia', 'Bianchi', 2500, 'Vendite'),
(3, 'Marco', 'Verdi', 2200, 'IT'),
(4, 'Anna', 'Neri', 2100, 'Marketing'),
(5, 'Giulia', 'Esposito', 2300, 'Finanza');
```

##### 3. Tabella fisica con valori già inseriti

| ID  | Nome   | Cognome  | Stipendio | Reparto         |
| --- | ------ | -------- | --------- | --------------- |
| 1   | Mario  | Rossi    | 2000      | Amministrazione |
| 2   | Lucia  | Bianchi  | 2500      | Vendite         |
| 3   | Marco  | Verdi    | 2200      | IT              |
| 4   | Anna   | Neri     | 2100      | Marketing       |
| 5   | Giulia | Esposito | 2300      | Finanza         |

> Nota: ogni campo `CHAR` occupa **tutta la lunghezza dichiarata**, quindi `"Mario"` è memorizzato come `"Mario               "` (20 caratteri, con spazi extra).

##### 4. Aggiungere una colonna

```sql
ALTER TABLE Impiegati
ADD DataAssunzione DATE;
```

Aggiornare i dati della nuova colonna:

```sql
UPDATE Impiegati
SET DataAssunzione = '2023-01-15'
WHERE ID = 1;

UPDATE Impiegati
SET DataAssunzione = '2022-05-20'
WHERE ID = 2;

UPDATE Impiegati
SET DataAssunzione = '2021-08-10'
WHERE ID = 3;

UPDATE Impiegati
SET DataAssunzione = '2023-03-01'
WHERE ID = 4;

UPDATE Impiegati
SET DataAssunzione = '2022-11-05'
WHERE ID = 5;
```

##### 5. Modificare colonne esistenti

Cambiare lunghezza del campo `Nome` da 20 a 30:

```sql
ALTER TABLE Impiegati
MODIFY Nome CHAR(30);
```

Cambiare tipo di dato `Stipendio` in decimale:

```sql
ALTER TABLE Impiegati
MODIFY Stipendio DECIMAL(8,2);
```

##### 6. Aggiornare dati già inseriti

Cambiare stipendio di Marco:

```sql
UPDATE Impiegati
SET Stipendio = 2300
WHERE Nome = 'Marco';
```

Cambiare reparto di Lucia:

```sql
UPDATE Impiegati
SET Reparto = 'Marketing'
WHERE Nome = 'Lucia';
```

##### 7. Tabella fisica finale (con dati aggiornati)

| ID  | Nome   | Cognome  | Stipendio | Reparto         | DataAssunzione |
| --- | ------ | -------- | --------- | --------------- | -------------- |
| 1   | Mario  | Rossi    | 2000.00   | Amministrazione | 2023-01-15     |
| 2   | Lucia  | Bianchi  | 2500.00   | Marketing       | 2022-05-20     |
| 3   | Marco  | Verdi    | 2300.00   | IT              | 2021-08-10     |
| 4   | Anna   | Neri     | 2100.00   | Marketing       | 2023-03-01     |
| 5   | Giulia | Esposito | 2300.00   | Finanza         | 2022-11-05     |

> Qui ogni campo `CHAR` occupa **tutta la lunghezza dichiarata**, quindi `"Mario"` è memorizzato come `"Mario                         "` (30 caratteri ora).

##### Modello Relazionale

1. **Tabella (o relazione)**

   - È come un foglio di calcolo, con **righe** e **colonne**.
   - Ogni tabella rappresenta un insieme di entità dello stesso tipo (ad esempio “Utenti” o “Prodotti”).
   - funzione con molte tabelle utilizzo con delle chiavi

2. **Riga (o tupla)**

   - È un singolo record della tabella, cioè un’istanza di entità.
   - Esempio: un utente specifico con nome, cognome, email ed età.

3. **Colonna (o attributo)**

   - È una caratteristica dell’entità.
   - Esempio: “Nome”, “Cognome”, “Età”.

4. **Chiave primaria**

   - È un attributo (o combinazione di attributi) che identifica in modo univoco ogni riga della tabella.
   - Esempio: l’ID di un utente.

5. **Dati (o istanze)**

   - Sono i valori concreti che inseriamo nelle righe della tabella.
   - Esempio: Luca, Rossi, 25, [luca@email.com](mailto:luca@email.com).

Se volessimo rappresentare tutto **senza altre tabelle**, possiamo solo avere **una tabella autonoma** con dati direttamente dentro:

**Esempio concettuale:**

| ID  | Nome   | Cognome | Età |
| --- | ------ | ------- | --- |
| 1   | Luca   | Rossi   | 25  |
| 2   | Maria  | Bianchi | 30  |
| 3   | Giulia | Verdi   | 28  |

- Ogni riga è un’istanza.
- Ogni colonna è un attributo.
- ID è la chiave primaria.

- dati a struttura variabile e dati messi in ordine corretto

  - ordine irrelevante

- dati costruiti in base all'opzione corretta e il tipo e in modo corretto dei dati in modo coinciso e corretto
  - istanze
    - schema fisso
      - con istanze corrette
  - omogenei

##### Modello Relazionale (concetti base)

1. Tabella (o relazione)

   - È come un foglio di calcolo, con righe e colonne.
   - Ogni tabella rappresenta un insieme di entità dello stesso tipo (ad esempio “Utenti” o “Prodotti”).

2. Riga (o tupla)

   - È un singolo record della tabella, cioè un’istanza di entità.
   - Esempio: un utente specifico con nome, cognome, email ed età.

3. Colonna (o attributo)

   - È una caratteristica dell’entità.
   - Esempio: “Nome”, “Cognome”, “Età”.

4. Chiave primaria

   - È un attributo (o combinazione di attributi) che identifica in modo univoco ogni riga della tabella.
   - Esempio: l’ID di un utente.

5. Dati (o istanze)
   - Sono i valori concreti che inseriamo nelle righe della tabella.
   - Esempio: Luca, Rossi, 25, luca@email.com.

##### Esempio concettuale di una tabella autonoma

| ID  | Nome   | Cognome | Età |
| --- | ------ | ------- | --- |
| 1   | Luca   | Rossi   | 25  |
| 2   | Maria  | Bianchi | 30  |
| 3   | Giulia | Verdi   | 28  |

- Ogni riga è un’istanza.
- Ogni colonna è un attributo.
- ID è la chiave primaria.

##### Modello relazionale con più tabelle

###### Tabelle principali

**Tabella Studenti**
| ID_Studente | Nome | Cognome |
|-------------|--------|---------|
| 1 | Luca | Rossi |
| 2 | Maria | Bianchi |
| 3 | Giulia | Verdi |

**Tabella Corsi**
| ID_Corso | Nome_Corso | Docente |
|----------|--------------|---------------|
| 101 | Matematica | Prof. Neri |
| 102 | Informatica | Prof. Bianchi |
| 103 | Storia | Prof. Rossi |

**Tabella Iscrizioni (relazione molti-a-molti)**
| ID_Studente | ID_Corso |
|-------------|----------|
| 1 | 101 |
| 1 | 102 |
| 2 | 102 |
| 3 | 101 |
| 3 | 103 |

**Tabella Professori**
| ID_Professore | Nome | Cognome |
|---------------|-----------|----------|
| 1 | Carlo | Neri |
| 2 | Anna | Bianchi |
| 3 | Marco | Rossi |

**Tabella Esami**
| ID_Esame | ID_Studente | ID_Corso | Voto |
|----------|-------------|----------|------|
| 1 | 1 | 101 | 28 |
| 2 | 1 | 102 | 30 |
| 3 | 2 | 102 | 26 |
| 4 | 3 | 101 | 24 |
| 5 | 3 | 103 | 29 |

##### Concetti chiave

- Chiave primaria: identifica univocamente una riga nella tabella (es. ID_Studente o ID_Corso).
- Chiave esterna: collega tabelle diverse (es. ID_Studente in Iscrizioni fa riferimento alla tabella Studenti).
- Relazione molti-a-molti: una tabella ponte come Iscrizioni permette di associare più studenti a più corsi.

##### Come funziona

- Ogni studente può iscriversi a più corsi.
- Ogni corso può avere più studenti iscritti.
- Le informazioni sono normalizzate: non ripetiamo dati inutilmente, ma li colleghiamo tramite ID.

## Chiavi

### Primaria

- Modulo principale che gestisce i dati della tabella.
- Compiti principali:

  - **Raccogliere i dati**: centralizza le informazioni provenienti da diverse fonti.
  - **Identificare ogni dato**: assegna un identificatore unico (ID) per distinguere ogni elemento.
  - **Organizzare i dati**: prepara la struttura in modo che la tabella possa essere popolata correttamente.
  - **Fornire accesso controllato**: permette la lettura, l’inserimento o la modifica dei dati in maniera coerente.

### Esterne

- Moduli o fonti di dati esterni al modulo principale.
- Compiti principali:

  - **Fornire dati aggiuntivi**: possono essere API, file JSON, database esterni, ecc.
  - **Essere integrabili facilmente**: devono poter essere richiamati e uniti ai dati della primaria senza conflitti.
  - **Mantenere la separazione delle responsabilità**: non gestiscono direttamente la tabella, ma forniscono solo informazioni da elaborare.

## Relazioni n a n

Quando lavoriamo con i database, spesso dobbiamo collegare **due tabelle** in modo che un elemento di una tabella possa essere collegato a **più elementi dell’altra tabella**, e viceversa. Questo tipo di relazione si chiama **n a n**.

### Pensiamoci con un esempio pratico

Immagina di avere due tabelle:

1. **Studenti**: contiene i dati degli studenti
2. **Corsi**: contiene i dati dei corsi disponibili

Un singolo studente può iscriversi a **più corsi**, e un singolo corso può avere **più studenti** iscritti.

> Qui non basta usare una colonna “ID corso” nella tabella studenti, perché uno studente potrebbe avere più corsi.
> Non basta usare una colonna “ID studente” nella tabella corsi, perché un corso potrebbe avere più studenti.

Quindi dobbiamo creare una **terza tabella**, chiamata spesso **tabella di collegamento** (o junction table), per gestire la relazione n a n.

### Struttura della tabella di collegamento

La tabella di collegamento avrà almeno due colonne:

- `StudenteID` → riferimento allo studente
- `CorsoID` → riferimento al corso

Ogni riga della tabella rappresenta **un’iscrizione** di uno studente a un corso.

**Esempio di dati:**

| StudenteID | CorsoID |
| ---------- | ------- |
| 1          | 101     |
| 1          | 102     |
| 2          | 101     |
| 3          | 103     |

> Così possiamo vedere che:
>
> - Lo studente 1 è iscritto ai corsi 101 e 102
> - Il corso 101 ha gli studenti 1 e 2

## Legami

Nei database, quando lavoriamo con più tabelle, **i legami servono a collegare le informazioni tra di loro**. Questi legami permettono di evitare duplicazioni e di organizzare i dati in modo efficiente.

Esistono diversi tipi di legami principali:

1. **Uno a uno (1:1)**

   - Ogni record di una tabella corrisponde a **un solo record** nell’altra tabella.
   - Esempio: ogni persona ha **un solo passaporto** e ogni passaporto appartiene **a una sola persona**.

2. **Uno a molti (1\:N)**

   - Un record di una tabella può essere collegato a **più record** di un’altra tabella, ma ogni record della seconda tabella è collegato a **un solo record** della prima.
   - Esempio: un insegnante può avere **più studenti**, ma ogni studente ha **un solo insegnante** principale.

3. **Molti a molti (N\:N)**

   - Ogni record di una tabella può essere collegato a **più record** dell’altra tabella e viceversa.
   - Esempio: gli studenti possono iscriversi **a più corsi**, e ogni corso può avere **più studenti**.
   - Per gestire questo legame serve una **tabella di collegamento** (junction table), che registra ogni abbinamento tra record delle due tabelle.

## Modelli Relazionali

- chiavi e legami

  - attraverso valori

- istanze nella reòazione
  - lecite con alcuni vincoli
    - intrarelazionali
      - stessa tabella
    - chiave
      - non ha senso per la mia logica
        - ogni tabella con chiave primaria
    - tra relazioni diverse
      - cardinalità
      - integrità
      - tra tabelle diverse

## Superchiavi

- insiemi di attributi che identificano in maniera univoca il record di una tabella

- tra superchiave

  - deido primaria

- chiave

  - non ammette null

- superchiave
  - si

  - se superchiave -> può diventare indice 

  - per ogni relazione esiste una superchiave (si)

## NULL

- valore attributo
  - dato non conosciuyo
    - separara in tabelle in modo corretto
