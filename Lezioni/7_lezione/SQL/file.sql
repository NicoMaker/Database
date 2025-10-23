-- Imposta un nuovo delimitatore per consentire la definizione delle stored procedure.
DELIMITER $$

-- Elimina le procedure se esistono già per evitare errori durante la creazione.
DROP PROCEDURE IF EXISTS GetCustomerLevel_v1$$
DROP PROCEDURE IF EXISTS GetCustomerLevel_v2$$

-- ====================================================================================
-- VERSIONE 1: GetCustomerLevel_v1
-- Questa procedura è basata sul primo blocco di codice.
-- Funzionamento:
-- 1. Accetta un ID cliente (`pCustomerNumber`) e un parametro di output (`pCustomerLevel`).
-- 2. Calcola il livello del cliente (PLATINUM, GOLD, SILVER) in base al `creditLimit`.
-- 3. Assegna il risultato SOLO al parametro di output `pCustomerLevel`.
-- 4. Non restituisce un set di risultati visibile (nessuna SELECT finale).
--    Il valore di output deve essere recuperato tramite una variabile di sessione.
-- ====================================================================================
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCustomerLevel_v1`(
    IN pCustomerNumber INT,
    OUT pCustomerLevel VARCHAR(20)
)
BEGIN
    DECLARE credit DECIMAL(10, 2) DEFAULT 0;

    -- Recupera il limite di credito del cliente.
    SELECT creditLimit INTO credit
    FROM customers
    WHERE customerNumber = pCustomerNumber;

    -- Assegna il livello in base al credito.
    IF credit > 50000 THEN
        SET pCustomerLevel = 'PLATINUM';
    ELSEIF credit > 10000 THEN -- La condizione `credit <= 50000` è implicita
        SET pCustomerLevel = 'GOLD';
    ELSE
        SET pCustomerLevel = 'SILVER';
    END IF;
END$$

-- ====================================================================================
-- VERSIONE 2: GetCustomerLevel_v2
-- Questa procedura è basata sul secondo blocco di codice.
-- Funzionamento:
-- 1. Accetta un ID cliente (`pCustomerNumber`) e un parametro di output (`pCustomerLevel`).
-- 2. Calcola il livello del cliente (PLATINUM, GOLD, SILVER) in base al `creditLimit`.
-- 3. Assegna il risultato al parametro di output `pCustomerLevel`.
-- 4. In aggiunta, esegue una SELECT finale per mostrare a video sia il livello calcolato
--    che il limite di credito, fornendo un riscontro immediato.
-- ====================================================================================
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCustomerLevel_v2`(
    IN pcustomerNumber INT,
    OUT pCustomerLevel VARCHAR(20)
)
BEGIN
    DECLARE credit DECIMAL(10, 2) DEFAULT 0;

    -- Recupera il limite di credito del cliente.
    SELECT creditLimit INTO credit
    FROM customers
    WHERE customerNumber = pcustomerNumber;

    -- Assegna il livello in base al credito.
    IF credit > 50000 THEN
        SET pCustomerLevel = 'PLATINUM';
    ELSEIF credit > 10000 THEN -- La condizione `credit <= 50000` è implicita
        SET pCustomerLevel = 'GOLD';
    ELSE
        SET pCustomerLevel = 'SILVER';
    END IF;

    -- A differenza della v1, questa SELECT restituisce un set di risultati
    -- visibile immediatamente dopo la chiamata.
    SELECT pCustomerLevel AS CustomerLevel, credit AS CreditLimit;
END$$

-- Reimposta il delimitatore predefinito.
DELIMITER ;