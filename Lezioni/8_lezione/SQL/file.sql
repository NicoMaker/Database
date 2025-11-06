-- ====================================================================================
-- FUNZIONE: CustomerLevel
-- OBIETTIVO: Calcolare e restituire il livello di un cliente (PLATINUM, GOLD, SILVER)
--            in base al suo limite di credito.
-- ====================================================================================
-- La parola chiave DETERMINISTIC indica a MySQL che la funzione restituirà sempre
-- lo stesso risultato per gli stessi parametri di input. Questo aiuta l'ottimizzatore di query.
CREATE FUNCTION CustomerLevel (
    -- Parametro di input: il limite di credito del cliente.
    credit DECIMAL(10, 2)
) RETURNS VARCHAR(20) -- Specifica che la funzione restituirà una stringa di massimo 20 caratteri.
DETERMINISTIC BEGIN -- Dichiara una variabile locale per memorizzare il livello del cliente calcolato.
DECLARE customerlevel VARCHAR(20);

-- Inizia una struttura condizionale per determinare il livello.
-- NOTA: La logica originale presentava un errore. È stata corretta per funzionare correttamente.
-- La condizione per 'GOLD' (credit <= 5000 AND credit >= 10000) era impossibile da soddisfare.
-- Se il credito è maggiore di 50000, il cliente è PLATINUM.
IF credit > 50000 THEN
SET
    customerlevel = 'PLATINUM';

-- Se il credito è compreso tra 10000 e 50000 (inclusi), il cliente è GOLD.
-- La condizione `credit <= 50000` è implicita grazie all'IF precedente.
ELSEIF credit > 10000 THEN
SET
    customerlevel = 'GOLD';

-- In tutti gli altri casi (credito inferiore o uguale a 10000), il cliente è SILVER.
ELSE
SET
    customerlevel = 'SILVER';

END IF;

-- Restituisce il valore della variabile 'customerlevel'.
RETURN customerlevel;

END -- Seleziona il nome di ogni cliente e calcola il suo livello chiamando la funzione CustomerLevel.
SELECT
    customerName,
    -- Seleziona la colonna 'customerName'.
    CustomerLevel (creditLimit) -- Chiama la funzione 'CustomerLevel' per ogni riga, passando il valore della colonna 'creditLimit'.
    -- Il risultato della funzione verrà mostrato in una seconda colonna.
FROM
    customers -- Specifica che i dati devono essere letti dalla tabella 'customers'.
ORDER BY
    customerName;

-- Ordina i risultati in ordine alfabetico basandosi sul nome del cliente.
CREATE DEFINER = `root` @`localhost` PROCEDURE `GetCustomerLevel2`(
    IN p_customerNumber INT,
    OUT p_customerLevel VARCHAR(20)
) BEGIN
SELECT
    CustomerLevel(creditLimit) INTO p_customerLevel
FROM
    customers
WHERE
    customers.customerNumber = p_customerNumber;

END $ $ DELIMITER $ $ CALL GetCustomerLevel2(103, @level);

SELECT
    @level;

-- ====================================================================================
-- PROCEDURA: GetAllCustomerLevels
-- OBIETTIVO: Restituire un elenco di TUTTI i clienti con il loro rispettivo livello.
-- FUNZIONAMENTO:
-- 1. Seleziona l'ID, il nome e il livello di ogni cliente.
-- 2. Utilizza la funzione `CustomerLevel` per calcolare il livello in base al `creditLimit`.
-- 3. Restituisce un set di risultati (una tabella) con tutti i clienti e i loro livelli.
-- ====================================================================================
CREATE PROCEDURE `GetAllCustomerLevels`() BEGIN
SELECT
    customerNumber,
    customerName,
    CustomerLevel(creditLimit) AS customerLevel
FROM
    customers
ORDER BY
    customerName;

END $ $ DELIMITER;

CALL GetAllCustomerLevels();

CREATE TABLE employees_audit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employeeNumber INT NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    changedat DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
);

CREATE DEFINER = `root` @`localhost` TRIGGER `employees_BEFORE_UPDATE` BEFORE
UPDATE
    ON `employees` FOR EACH ROW
INSERT INTO
    employees_audit
SET
    action = 'update',
    employeeNumber = OLD.employeeNumber,
    lastname = OLD.lastname,
    changedat = NOW();

show triggers;

CREATE DEFINER = CURRENT_USER TRIGGER `classicmodels`.`employees_audit_BEFORE_UPDATE` BEFORE
UPDATE
    ON `employees_audit` FOR EACH ROW BEGIN
UPDATE
    employees
SET
    lastname = 'Phan'
WHERE
    employeeNumber = 1056;

END
Select
    *
from
    employees_audit;