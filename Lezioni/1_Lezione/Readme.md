[Vai al File principale](../../Readme.md)

# 1 Lezione 18 Settembre 2025

## Database Relazionali

- che sono in relzione tra loro e si possono collegare delle tabelle con i dati
- Tabelle e dati -> in relazione tra di loro

- Correlazione tra tabelle

## Relazione

- Tabelle collegate tra di loro
- Tabelle è sottoinsieme del prodotto cartesiano di due domini

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

