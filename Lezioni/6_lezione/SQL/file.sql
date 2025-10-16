-- Esegue uno script SQL da un file esterno per creare e popolare il database 'classicmodels'.
-- NOTA: Il comando 'source' è specifico del client a riga di comando di MySQL.
-- In altri client SQL (come DBeaver, DataGrip, etc.), potrebbe essere necessario caricare ed eseguire il file .sql manualmente.
source c:\mysqlsampledatabase.sql;

-- Seleziona il nome e la città di tutti i clienti, ordinandoli alfabeticamente per nome.
SELECT
    customername,
    city
FROM
    customers
ORDER By
    customername;

-- Cambia il delimitatore da ';' a '$$' per permettere la definizione della stored procedure come un unico blocco.
DELIMITER $$
-- Crea una stored procedure chiamata 'GetCustomers' che non accetta parametri.
CREATE PROCEDURE GetCustomers()
BEGIN
    -- La procedura seleziona nome, città, stato, codice postale e paese dalla tabella 'customers'.
    SELECT
        customername,
        city,
        state,
        postalcode,
        country
    FROM
        customers
    -- I risultati sono ordinati per nome del cliente.
    ORDER By
        customername;
END$$
-- Reimposta il delimitatore predefinito a ';'.
DELIMITER ;

/*
 * === SPIEGAZIONE PROCEDURA: GetCustomers ===
 * Funzionamento: Questa è una procedura semplice che non accetta parametri.
 * Il suo scopo è eseguire una singola query (SELECT) per estrarre un elenco completo di clienti dalla tabella `customers`, ordinando i risultati per nome.
 */
-- Eliminazione della procedura 'GetCustomers'.
DROP PROCEDURE GetCustomers;

-- Chiamata della procedura 'GetCustomers' per visualizzare i risultati.
CALL GetCustomers();

-- Eliminazione della procedura 'PIPPO' solo se esiste, per evitare errori.
DROP PROCEDURE IF EXISTS PIPPO;

-- Mostra eventuali avvisi (warnings) generati dall'ultimo comando eseguito.
SHOW warnings;

-- Cambia il delimitatore per definire una nuova procedura.
DELIMITER $$
/*
 * === SPIEGAZIONE PROCEDURA: GetEmployees ===
 * Funzionamento: La procedura recupera una lista di dipendenti arricchita con i dati della loro sede di lavoro.
 * Per fare ciò, esegue un INNER JOIN tra la tabella `employees` e la tabella `offices` utilizzando la colonna comune `officeCode`. Non richiede parametri.
 */
-- Crea una stored procedure chiamata 'GetEmployees' (nome corretto da 'GetEmployess').
CREATE PROCEDURE GetEmployees()
BEGIN
    -- Seleziona i dati dei dipendenti e li unisce con le informazioni della sede (offices)
    -- utilizzando la colonna comune 'officeCode'.
    SELECT
        firstname,
        lastname,
        city,
        state,
        country
    FROM
        employees
        INNER JOIN offices USING (officeCode);
END$$
-- Reimposta il delimitatore.
DELIMITER ;

-- Chiama la procedura per ottenere l'elenco dei dipendenti con i dettagli della loro sede.
CALL GetEmployees();

-- Cambia il delimitatore per definire una procedura con parametri.
DELIMITER //
/*
 * === SPIEGAZIONE PROCEDURA: GetOfficeByCountry ===
 * Funzionamento: Questa procedura è parametrica e accetta un valore in input (parametro IN).
 * Riceve il nome di un paese (`countryName`) e lo utilizza nella clausola WHERE per filtrare e restituire solo le sedi (`offices`) situate in quel paese.
 */
-- Crea una procedura che accetta un parametro di input (IN) 'countryName'.
CREATE PROCEDURE GetOfficeByCountry(IN countryName VARCHAR(255))
BEGIN
    -- Seleziona tutte le sedi che corrispondono al paese passato come parametro.
    SELECT *
    FROM offices
    WHERE country = countryName;
END//
-- Reimposta il delimitatore.
DELIMITER ;
-- Chiama la procedura per trovare tutte le sedi negli 'USA'.
CALL GetOfficeByCountry('USA');

-- Cambia il delimitatore.
DELIMITER //
/*
 * === SPIEGAZIONE PROCEDURA: GetOfficeByCountries ===
 * Funzionamento: Questa procedura dimostra l'uso di SQL dinamico per costruire una query "al volo".
 * Accetta una stringa contenente una lista di paesi separati da virgola (es. 'USA,France,Japan').
 * Internamente, costruisce una query SELECT completa come stringa, la prepara e la esegue. Questo permette di creare query flessibili basate su input variabili.
 */
-- Crea una procedura che accetta una lista di paesi come stringa (es. 'USA,France').
CREATE PROCEDURE GetOfficeByCountries(IN countryList VARCHAR(255))
BEGIN
    -- Costruisce una query SQL dinamicamente come stringa.
    -- @query è una variabile di sessione.
    SET @query = CONCAT(
        'SELECT * FROM offices WHERE country IN (''',
        REPLACE(countryList, ',', ''','''), -- Sostituisce le virgole per creare una lista SQL valida.
        ''')'
    );

    -- Prepara l'istruzione SQL dalla stringa.
    PREPARE stmt FROM @query;
    -- Esegue l'istruzione preparata.
    EXECUTE stmt;
    -- Rilascia le risorse dell'istruzione preparata.
    DEALLOCATE PREPARE stmt;
END//
-- Reimposta il delimitatore.
DELIMITER ;
-- Chiama la procedura per cercare le sedi in 'USA', 'France' e 'Japan'.
CALL GetOfficeByCountries('USA,France,Japan');

-- Cambia il delimitatore.
DELIMITER $$
/*
 * === SPIEGAZIONE PROCEDURA: GetOrderByStatus ===
 * Funzionamento: Questa procedura accetta un parametro in input (IN `OrderStatus`) e restituisce un valore in output (OUT `total`).
 * Conta il numero di ordini che hanno un determinato stato (es. 'Shipped') e, invece di mostrare il risultato, lo assegna alla variabile di output `total` usando la sintassi `INTO`.
 * Il valore può essere poi recuperato nella sessione che ha chiamato la procedura.
 */
-- Crea una procedura con un parametro di input 'OrderStatus' e un parametro di output 'total'.
CREATE PROCEDURE GetOrderByStatus(
    IN OrderStatus VARCHAR(25),
    OUT total INT
) BEGIN
    -- Conta il numero di ordini con lo stato specificato.
    SELECT COUNT(orderNumber)
    INTO total -- Assegna il risultato al parametro di output 'total'.
    FROM orders
    WHERE status = OrderStatus;
END$$
-- Reimposta il delimitatore.
DELIMITER ;
-- Chiama la procedura per contare gli ordini con stato 'Shipped'.
-- Il risultato verrà memorizzato nella variabile di sessione @total.
CALL GetOrderByStatus('Shipped', @total);
-- Seleziona e visualizza il valore della variabile @total.
SELECT @total;