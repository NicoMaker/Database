-- Imposta un nuovo delimitatore per consentire la definizione delle stored procedure.
DELIMITER $ $ -- Elimina le procedure se esistono già per evitare errori durante la creazione.
DROP PROCEDURE IF EXISTS GetCustomerLevel_v1 $ $ DROP PROCEDURE IF EXISTS GetCustomerLevel_v2 $ $ -- ====================================================================================
-- VERSIONE 1: GetCustomerLevel_v1
-- Questa procedura è basata sul primo blocco di codice.
-- Funzionamento:
-- 1. Accetta un ID cliente (`pCustomerNumber`) e un parametro di output (`pCustomerLevel`).
-- 2. Calcola il livello del cliente (PLATINUM, GOLD, SILVER) in base al `creditLimit`.
-- 3. Assegna il risultato SOLO al parametro di output `pCustomerLevel`.
-- 4. Non restituisce un set di risultati visibile (nessuna SELECT finale).
--    Il valore di output deve essere recuperato tramite una variabile di sessione.
-- ====================================================================================
CREATE DEFINER = `root` @`localhost` PROCEDURE `GetCustomerLevel_v1`(
    IN pCustomerNumber INT,
    OUT pCustomerLevel VARCHAR(20)
) BEGIN DECLARE credit DECIMAL(10, 2) DEFAULT 0;

-- Recupera il limite di credito del cliente.
SELECT
    creditLimit INTO credit
FROM
    customers
WHERE
    customerNumber = pCustomerNumber;

-- Assegna il livello in base al credito.
IF credit > 50000 THEN
SET
    pCustomerLevel = 'PLATINUM';

ELSEIF credit > 10000 THEN -- La condizione `credit <= 50000` è implicita
SET
    pCustomerLevel = 'GOLD';

ELSE
SET
    pCustomerLevel = 'SILVER';

END IF;

END $ $ -- ====================================================================================
-- VERSIONE 2: GetCustomerLevel_v2
-- Questa procedura è basata sul secondo blocco di codice.
-- Funzionamento:
-- 1. Accetta un ID cliente (`pCustomerNumber`) e un parametro di output (`pCustomerLevel`).
-- 2. Calcola il livello del cliente (PLATINUM, GOLD, SILVER) in base al `creditLimit`.
-- 3. Assegna il risultato al parametro di output `pCustomerLevel`.
-- 4. In aggiunta, esegue una SELECT finale per mostrare a video sia il livello calcolato
--    che il limite di credito, fornendo un riscontro immediato.
-- ====================================================================================
CREATE DEFINER = `root` @`localhost` PROCEDURE `GetCustomerLevel_v2`(
    IN pcustomerNumber INT,
    OUT pCustomerLevel VARCHAR(20)
) BEGIN DECLARE credit DECIMAL(10, 2) DEFAULT 0;

-- Recupera il limite di credito del cliente.
SELECT
    creditLimit INTO credit
FROM
    customers
WHERE
    customerNumber = pcustomerNumber;

-- Assegna il livello in base al credito.
IF credit > 50000 THEN
SET
    pCustomerLevel = 'PLATINUM';

ELSEIF credit > 10000 THEN -- La condizione `credit <= 50000` è implicita
SET
    pCustomerLevel = 'GOLD';

ELSE
SET
    pCustomerLevel = 'SILVER';

END IF;

-- A differenza della v1, questa SELECT restituisce un set di risultati
-- visibile immediatamente dopo la chiamata.
SELECT
    pCustomerLevel AS CustomerLevel,
    credit AS CreditLimit;

END $ $ -- Reimposta il delimitatore predefinito.
DELIMITER;

-- ====================================================================================
-- PROCEDURA: GetCustomerShipping
-- Funzionamento:
-- 1. Accetta un ID cliente (`pCustomerNumber`) e restituisce un tempo di spedizione (`pShipping`).
-- 2. Recupera il paese del cliente dalla tabella `customers`.
-- 3. Utilizza un'istruzione CASE per determinare il tempo di spedizione in base al paese:
--    - 'USA': '2-day Shipping'
--    - 'Canada': '3-day Shipping'
--    - Altri paesi: '5-day Shipping'
-- 4. Assegna il risultato al parametro di output `pShipping`.
-- ====================================================================================
DELIMITER $ $ CREATE PROCEDURE `GetCustomerShipping`(
    IN pCustomerNumber INT,
    OUT pShipping VARCHAR(50)
) BEGIN DECLARE customerCountry VARCHAR(100);

SELECT
    country INTO customerCountry
FROM
    customers
WHERE
    customerNumber = pCustomerNumber;

CASE
    customerCountry
    WHEN 'USA' THEN
    SET
        pShipping = '2-day Shipping';

WHEN 'Canada' THEN
SET
    pShipping = '3-day Shipping';

ELSE
SET
    pShipping = '5-day Shipping';

END CASE
;

END $ $ DELIMITER;

-- ====================================================================================
-- PROCEDURA: GetDeliveryStatus
-- OBIETTIVO: Calcolare e restituire lo stato di consegna di un ordine.
-- NOTA: Questa versione assegna un messaggio specifico per i ritardi superiori a 5 giorni.
-- ====================================================================================
CREATE DEFINER = `root` @`localhost` PROCEDURE `GetDeliveryStatus`(
    IN pOrderNumber INT,
    OUT pDeliveryStatus VARCHAR(100)
) BEGIN -- Dichiara una variabile locale per memorizzare la differenza in giorni.
-- Inizializzata a NULL per gestire i casi in cui la data di spedizione non è presente.
DECLARE waitingDay INT DEFAULT NULL;

-- Calcola la differenza in giorni tra la data richiesta e la data di spedizione.
-- La funzione DATEDIFF(date1, date2) restituisce (date1 - date2).
-- Un valore > 0 indica un anticipo, un valore < 0 indica un ritardo.
SELECT
    DATEDIFF(requireddate, shippeddate) INTO waitingDay -- Memorizza il risultato nella variabile.
FROM
    orders
WHERE
    ordernumber = pOrderNumber;

-- Assegna un messaggio di stato al parametro di output 'pDeliveryStatus'
-- utilizzando un'istruzione CASE basata sul valore di 'waitingDay'.
SET
    pDeliveryStatus = CASE
        -- Se 'waitingDay' è NULL (ordine non ancora spedito).
        WHEN waitingDay IS NULL THEN 'Nessuna informazione' -- Se la spedizione è avvenuta con almeno 1 giorno di anticipo.
        WHEN waitingDay >= 1 THEN 'Consegna in tempo' -- Se la spedizione è avvenuta esattamente il giorno richiesto.
        WHEN waitingDay = 0 THEN 'Consegna in orario' -- Se il ritardo è di 1 giorno.
        WHEN waitingDay < 0
        AND waitingDay >= -1 THEN 'Consegna in ritardo' -- Se il ritardo è compreso tra 2 e 5 giorni.
        WHEN waitingDay < -1
        AND waitingDay >= -5 THEN 'Consegna molto in ritardo' -- Per tutti gli altri casi (ritardo superiore a 5 giorni), fornisce un messaggio specifico.
        ELSE 'Consegna estremamente in ritardo'
    END;

END $ $ -- Fine della procedura.
DELIMITER;

-- Reimposta il delimitatore a ';'.
CALL GetDeliveryStatus(10165, @status);

SELECT
    @status;

-- ====================================================================================
-- PROCEDURA: GetDeliveryStatus_original (Versione Originale)
-- OBIETTIVO: Calcolare e restituire lo stato di consegna di un ordine.
-- NOTA: Questa versione non gestisce in modo specifico i ritardi superiori a 5 giorni.
-- ====================================================================================
CREATE DEFINER = `root` @`localhost` PROCEDURE `GetDeliveryStatus_original`(
    IN pOrderNumber INT,
    OUT pDeliveryStatus VARCHAR(100)
) BEGIN -- Dichiara una variabile locale per memorizzare la differenza in giorni.
DECLARE waitingDay INT DEFAULT NULL;

-- Calcola la differenza in giorni tra la data richiesta e quella di spedizione
SELECT
    DATEDIFF(requireddate, shippeddate) INTO waitingDay -- Memorizza il risultato nella variabile.
FROM
    orders
WHERE
    ordernumber = pOrderNumber;

-- Determina lo stato della consegna in base ai giorni di differenza
SET
    pDeliveryStatus = CASE
        -- Se 'waitingDay' è NULL (ordine non ancora spedito).
        WHEN waitingDay IS NULL THEN 'Nessuna informazione' -- Se la spedizione è avvenuta con almeno 1 giorno di anticipo.
        WHEN waitingDay >= 1 THEN 'Consegna in tempo' -- Se la spedizione è avvenuta esattamente il giorno richiesto.
        WHEN waitingDay = 0 THEN 'Consegna in orario' -- Se il ritardo è di 1 giorno.
        WHEN waitingDay < 0
        AND waitingDay >= -1 THEN 'Consegna in ritardo' -- Se il ritardo è compreso tra 2 e 5 giorni.
        WHEN waitingDay < -1
        AND waitingDay >= -5 THEN 'Consegna molto in ritardo' -- Per tutti gli altri casi (es. ritardo > 5 giorni), restituisce un messaggio generico.
        -- Questo può essere impreciso, poiché un ritardo è un'informazione, non un'assenza di essa.
        ELSE 'Nessuna informazione'
    END;

END;

-- ====================================================================================
-- TABELLA: calendars
-- OBIETTIVO: Creare una tabella di dimensioni temporali per facilitare le query
--            basate su periodi (giorno, mese, trimestre, anno).
-- Utilizzo: Utile in scenari di data warehousing e reporting per aggregare dati
--           su base temporale senza dover estrarre le parti della data al volo.
-- ====================================================================================
CREATE TABLE calendars (
    id INT AUTO_INCREMENT PRIMARY KEY,
    -- ID univoco auto-incrementante per ogni record del calendario.
    fulldate DATE UNIQUE,
    -- La data completa (es. '2024-10-26'), con vincolo di unicità.
    day TINYINT NOT NULL,
    -- Il giorno del mese (da 1 a 31).
    month TINYINT NOT NULL,
    -- Il mese dell'anno (da 1 a 12).
    quarter TINYINT NOT NULL,
    -- Il trimestre dell'anno (da 1 a 4).
    year INT NOT NULL -- L'anno (es. 2024).
);

-- ====================================================================================
-- PROCEDURA: InsertCalendar
-- OBIETTIVO: Inserire una nuova riga nella tabella 'calendars' a partire da una data.
-- FUNZIONAMENTO:
-- 1. Accetta una data (`dt`) come parametro di input.
-- 2. Utilizza la funzione EXTRACT() per derivare giorno, mese, trimestre e anno.
-- 3. Inserisce la data completa e le sue parti calcolate nella tabella 'calendars'.
-- ====================================================================================
DELIMITER $ $ CREATE PROCEDURE `InsertCalendar`(IN dt DATE) BEGIN
INSERT INTO
    calendars(
        fulldate,
        day,
        month,
        quarter,
        year
    )
VALUES
(
        dt,
        EXTRACT(
            DAY
            FROM
                dt
        ),
        EXTRACT(
            MONTH
            FROM
                dt
        ),
        EXTRACT(
            QUARTER
            FROM
                dt
        ),
        EXTRACT(
            YEAR
            FROM
                dt
        )
    );

END $ $ DELIMITER;





-- Imposta il delimitatore di istruzioni su "$ $" invece del punto e virgola standard.
-- Questo serve per poter usare il punto e virgola all'interno del corpo della procedura
-- senza che il comando venga terminato prematuramente.
END $ $ DELIMITER;

-- Crea una procedura memorizzata chiamata "LoadCalendar"
-- definita dall'utente 'root' sul server localhost.
CREATE DEFINER=`root`@`localhost` PROCEDURE `LoadCalendar`(
    startDate DATE,  -- Data di inizio
    day INT          -- Numero di giorni da elaborare
)
BEGIN

    -- Dichiara una variabile contatore inizializzata a 1
    DECLARE counter INT DEFAULT 1;
    
    -- Dichiara una variabile data (dt) inizializzata alla data di partenza
    DECLARE dt DATE DEFAULT startDate;

    -- Inizia un ciclo che si ripete finché counter è minore o uguale al numero di giorni specificato
    WHILE counter <= day DO

        -- Chiama un’altra procedura chiamata "InsertCalendar" passando la data corrente (dt)
        -- Si presume che questa procedura inserisca un record nel calendario per quella data
        CALL InsertCalendar(dt);

        -- Incrementa il contatore di 1
        SET counter = counter + 1;

        -- Incrementa la data di un giorno
        SET dt = DATE_ADD(dt, INTERVAL 1 DAY);

    -- Fine del ciclo
    END WHILE;

-- Fine del corpo della procedura
END $ $

-- Reimposta il delimitatore standard al punto e virgola
DELIMITER ;


CALL `classicmodels`.`LoadCalendar`('2024-01-01', 31);
SELECT * FROM calendars;


CREATE DEFINER=`root`@`localhost` PROCEDURE `OperationCalendar`(
    IN dt DATE
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM calendars WHERE fulldate = dt) THEN
        -- La data non esiste → considerata creazione ('C')
        INSERT INTO calendars (
            fulldate,
            day,
            month,
            quarter,
            year
        )
        VALUES (
            dt,
            EXTRACT(DAY FROM dt),
            EXTRACT(MONTH FROM dt),
            EXTRACT(QUARTER FROM dt),
            EXTRACT(YEAR FROM dt)
        );
    ELSE
        -- La data esiste → considerata aggiornamento ('I')
        UPDATE calendars
        SET 
            day = EXTRACT(DAY FROM dt),
            month = EXTRACT(MONTH FROM dt),
            quarter = EXTRACT(QUARTER FROM dt),
            year = EXTRACT(YEAR FROM dt)
        WHERE fulldate = dt;
    END IF;
END $ $

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Calendar`(
    IN startDate DATE,
    IN endDate DATE,
    IN action CHAR(1) -- 'D' = delete, NULL o altro = insert/update automatico
)
BEGIN
    DECLARE currentDate DATE;
    SET currentDate = startDate;

    WHILE currentDate <= endDate DO
        IF action = 'D' THEN
            -- Cancella fisicamente la data
            DELETE FROM calendars 
            WHERE fulldate = currentDate;
        ELSE
            -- Inserimento o aggiornamento automatico con tipo deciso internamente
            CALL OperationCalendar(currentDate);
        END IF;

        SET currentDate = DATE_ADD(currentDate, INTERVAL 1 DAY);
    END WHILE;
END $$

DELIMITER ;
