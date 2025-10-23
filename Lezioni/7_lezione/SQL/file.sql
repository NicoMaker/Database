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

-- ====================================================================================
-- PROCEDURA: OperationCalendar
-- OBIETTIVO: Eseguire un'operazione di "UPSERT" (INSERT o UPDATE) per una singola data
--            nella tabella 'calendars'.
-- FUNZIONAMENTO:
-- 1. Accetta una data (`dt`) come parametro.
-- 2. Controlla se la data esiste già nella tabella.
-- 3. Se non esiste, la inserisce insieme alle sue parti estratte (giorno, mese, etc.).
-- 4. Se esiste già, la aggiorna per garantire la coerenza dei dati.
-- ====================================================================================
CREATE DEFINER=`root`@`localhost` PROCEDURE `OperationCalendar`(
    -- Parametro di input: la data da inserire o aggiornare.
    IN dt DATE
)
BEGIN
    -- Controlla se non esiste già un record per la data fornita.
    -- `SELECT 1` è un modo efficiente per verificare l'esistenza senza recuperare dati.
    IF NOT EXISTS (SELECT 1 FROM calendars WHERE fulldate = dt) THEN
        -- Se la data non esiste, esegue un'operazione di INSERIMENTO.
        INSERT INTO calendars (
            fulldate,
            day,
            month,
            quarter,
            year
        )
        VALUES (
            dt, -- La data completa.
            EXTRACT(DAY FROM dt), -- Estrae il giorno dalla data.
            EXTRACT(MONTH FROM dt), -- Estrae il mese.
            EXTRACT(QUARTER FROM dt), -- Estrae il trimestre.
            EXTRACT(YEAR FROM dt) -- Estrae l'anno.
        );
    ELSE
        -- Se la data esiste già, esegue un'operazione di AGGIORNAMENTO.
        -- Questo garantisce che i dati derivati (giorno, mese, etc.) siano sempre corretti.
        UPDATE calendars
        SET 
            day = EXTRACT(DAY FROM dt), -- Aggiorna il giorno.
            month = EXTRACT(MONTH FROM dt), -- Aggiorna il mese.
            quarter = EXTRACT(QUARTER FROM dt), -- Aggiorna il trimestre.
            year = EXTRACT(YEAR FROM dt) -- Aggiorna l'anno.
        WHERE fulldate = dt; -- La clausola WHERE è fondamentale per aggiornare solo il record corretto.
    END IF;
END$$

-- Cambia nuovamente il delimitatore per la procedura successiva.
DELIMITER $$

-- ====================================================================================
-- PROCEDURA: Calendar
-- OBIETTIVO: Gestire un intervallo di date nella tabella 'calendars', eseguendo
--            operazioni di inserimento, aggiornamento o cancellazione.
-- FUNZIONAMENTO:
-- 1. Accetta una data di inizio, una data di fine e un carattere per l'azione.
-- 2. Itera su ogni giorno dell'intervallo specificato.
-- 3. Se l'azione è 'D', cancella il record per la data corrente.
-- 4. Altrimenti, chiama la procedura `OperationCalendar` per inserire o aggiornare
--    il record per la data corrente.
-- ====================================================================================
CREATE DEFINER=`root`@`localhost` PROCEDURE `Calendar`(
    IN startDate DATE, -- Parametro di input: la data da cui iniziare l'operazione.
    IN endDate DATE,   -- Parametro di input: la data in cui terminare l'operazione.
    IN action CHAR(1)  -- Parametro di input: definisce l'azione da compiere.
                       -- 'D' per cancellare (DELETE).
                       -- Qualsiasi altro valore (o NULL) per inserire/aggiornare.
)
BEGIN
    -- Dichiara una variabile locale per tenere traccia della data corrente nel ciclo.
    DECLARE currentDate DATE;
    -- Inizializza la data corrente con la data di inizio fornita.
    SET currentDate = startDate;

    -- Inizia un ciclo WHILE che continua finché la data corrente è minore o uguale alla data di fine.
    WHILE currentDate <= endDate DO
        -- Controlla il valore del parametro 'action'.
        IF action = 'D' THEN
            -- Se l'azione è 'D', cancella il record corrispondente alla data corrente.
            DELETE FROM calendars 
            WHERE fulldate = currentDate;
        ELSE
            -- Se l'azione non è 'D', chiama la procedura `OperationCalendar`.
            -- Questo eseguirà un inserimento o un aggiornamento per la data corrente.
            CALL OperationCalendar(currentDate);
        END IF;

        -- Incrementa la data corrente di un giorno per passare alla prossima iterazione del ciclo.
        SET currentDate = DATE_ADD(currentDate, INTERVAL 1 DAY);
    END WHILE;
END $$

-- Reimposta il delimitatore standard a punto e virgola.
DELIMITER ;


-- Esempi di chiamata della procedura `Calendar` per testare le funzionalità di inserimento/aggiornamento e cancellazione.4
-- inserimento/aggiornamento
CALL Calendar('2025-01-01', '2025-01-10', 'I');
-- cancellazione
CALL Calendar('2025-01-01', '2025-01-10', 'D');

SELECT * from calendars;