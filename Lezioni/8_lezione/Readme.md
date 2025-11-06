[Vai al File principale](../../Readme.md)

#  8 Lezione — 06 Novembre 2025

##  Trigger in MySQL

Un **trigger** è un oggetto del database che viene eseguito automaticamente in risposta a determinati eventi su una tabella (come `INSERT`, `UPDATE` o `DELETE`).

I trigger vengono utilizzati per:

* mantenere l’integrità dei dati,
* eseguire controlli automatici,
* aggiornare log o tabelle di storico.

###  Struttura di un Trigger

```sql
CREATE TRIGGER nome_trigger
{BEFORE | AFTER} {INSERT | UPDATE | DELETE}
ON nome_tabella
FOR EACH ROW
BEGIN
    -- Azioni da eseguire
END;
```

### Tipi di Trigger

1. **BEFORE Trigger**
   → Viene eseguito *prima* dell’operazione.
   Utile per **validare o modificare** i dati prima dell’inserimento o aggiornamento.

2. **AFTER Trigger**
   → Viene eseguito *dopo* che l’operazione è stata completata.
   Utile per **registrare eventi** o **aggiornare altre tabelle**.


## Trigger di Riga (FOR EACH ROW)

Questo tipo di trigger viene eseguito **una volta per ogni riga** interessata da un’operazione.

###  Esempio:

```sql
CREATE TRIGGER log_insert
AFTER INSERT ON studenti
FOR EACH ROW
BEGIN
    INSERT INTO log_operazioni (azione, data_operazione)
    VALUES (CONCAT('Inserito studente: ', NEW.nome), NOW());
END;
```

 Qui, ogni volta che viene inserito un nuovo record nella tabella `studenti`, viene registrata un’operazione nel log.


##  Trigger di Linea (o di Statement)

MySQL non supporta nativamente i **trigger di statement** (ovvero eseguiti *una sola volta per l’intero comando SQL*), ma alcuni altri DBMS (come Oracle o SQL Server) sì.
In MySQL, ogni `INSERT`, `UPDATE` o `DELETE` che coinvolge più righe genera tanti eventi quanti sono i record coinvolti.

Esempio concettuale (non valido in MySQL puro):

```sql
CREATE TRIGGER log_batch_update
AFTER UPDATE ON ordini
BEGIN
    INSERT INTO log (descrizione, data_log)
    VALUES ('Aggiornati più ordini', NOW());
END;
```

 In MySQL, per simulare questo comportamento, si può usare una **tabella temporanea** o una **variabile di sessione** per evitare duplicazioni.



## Funzioni in MySQL

Le **funzioni** permettono di incapsulare del codice SQL riutilizzabile che restituisce un valore.
Sono molto utili per calcoli o logiche ripetitive.

### Struttura di una Funzione

```sql
DELIMITER //

CREATE FUNCTION nome_funzione (parametro1 TIPO, parametro2 TIPO)
RETURNS tipo_restituito
DETERMINISTIC
BEGIN
    DECLARE risultato INT;
    SET risultato = parametro1 + parametro2;
    RETURN risultato;
END //

DELIMITER ;
```

### Esempio pratico

```sql
CREATE FUNCTION calcola_eta (anno_nascita INT)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN YEAR(CURDATE()) - anno_nascita;
END;
```

👉 Questa funzione restituisce l’età di una persona in base all’anno di nascita.


## Riepilogo

| Concetto             | Descrizione                    | Esecuzione                        |
| -------------------- | ------------------------------ | --------------------------------- |
| **BEFORE Trigger**   | Eseguito prima dell’operazione | Validazione o modifica dati       |
| **AFTER Trigger**    | Eseguito dopo l’operazione     | Logging o aggiornamento tabelle   |
| **Trigger di Riga**  | Eseguito per ogni record       | MySQL: supportato                 |
| **Trigger di Linea** | Eseguito per ogni query        | MySQL: non supportato nativamente |
| **Funzione**         | Ritorna un valore              | Richiamabile in query o procedure |

## Comandi SQL

 [File SQL](SQL/file.sql)

 ## Esercizi

 [Store Proedure](Exercise)