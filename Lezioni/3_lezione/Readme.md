[Vai al File principale](../../Readme.md)

# 3 Lezione 02 Ottobre 2025

## Cofigurazione DB in MySql e tabelle

- metti tabelle applicazione collegate non a utente root

  - privileggi con tbaelle che decido io
    - quando mi connetto al db

- DB rimane conforme
  - se rimangono regole di integrità
  - isolamento
    - transazioni in paralleo in questo momento
      - transizioni a se
        - no temporanei (DBMS)
  - durabilità
    - dati permanenti e persistere a guasti

### Proprietà ACID di un DBMS

1. **Atomicità (A)**

   - Ogni transazione è indivisibile: o viene eseguita completamente, o non viene eseguita affatto.
   - Se c’è un errore, il DB torna allo stato precedente (rollback).

2. **Consistenza (C)**

   - Il **DB rimane conforme** se rispettate tutte le regole di **integrità** definite (vincoli, chiavi primarie/esterne, domini, trigger, ecc.).
   - Dopo ogni transazione, il DB deve passare da uno stato consistente a un altro stato consistente.

3. **Isolamento (I)**

   - Le transazioni in parallelo **non devono interferire** tra loro.
   - Ogni transazione deve sembrare eseguita **da sola** (serializzabilità).
   - Evita fenomeni temporanei come:

     - letture sporche (_dirty read_),
     - letture non ripetibili,
     - phantom read.

4. **Durabilità (D)**

   - Una volta confermata (**commit**), la transazione è **permanente**.
   - I dati devono persistere anche in caso di guasto del sistema.
   - Il DBMS usa log delle transazioni, checkpoint e meccanismi di recovery.

## Comandi SQL

- [file sql](SQL/file.sql)
