-- ====================================================================================
-- FUNZIONE: CustomerLevel
-- OBIETTIVO: Calcolare e restituire il livello di un cliente (PLATINUM, GOLD, SILVER)
--            in base al suo limite di credito.
-- ====================================================================================

-- La parola chiave DETERMINISTIC indica a MySQL che la funzione restituirà sempre
-- lo stesso risultato per gli stessi parametri di input. Questo aiuta l'ottimizzatore di query.
CREATE FUNCTION CustomerLevel(
    -- Parametro di input: il limite di credito del cliente.
    credit DECIMAL(10, 2)
) 
RETURNS VARCHAR(20) -- Specifica che la funzione restituirà una stringa di massimo 20 caratteri.
DETERMINISTIC 
BEGIN 
    -- Dichiara una variabile locale per memorizzare il livello del cliente calcolato.
    DECLARE customerlevel VARCHAR(20);

    -- Inizia una struttura condizionale per determinare il livello.
    -- NOTA: La logica originale presentava un errore. È stata corretta per funzionare correttamente.
    -- La condizione per 'GOLD' (credit <= 5000 AND credit >= 10000) era impossibile da soddisfare.
    
    -- Se il credito è maggiore di 50000, il cliente è PLATINUM.
    IF credit > 50000 THEN
        SET customerlevel = 'PLATINUM';
    
    -- Se il credito è compreso tra 10000 e 50000 (inclusi), il cliente è GOLD.
    -- La condizione `credit <= 50000` è implicita grazie all'IF precedente.
    ELSEIF credit > 10000 THEN
        SET customerlevel = 'GOLD';
    
    -- In tutti gli altri casi (credito inferiore o uguale a 10000), il cliente è SILVER.
    ELSE
        SET customerlevel = 'SILVER';
    END IF;

    -- Restituisce il valore della variabile 'customerlevel'.
    RETURN customerlevel;
END