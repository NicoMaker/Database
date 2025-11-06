# creazione funzione CustomerLevel
CREATE FUNCTION CustomerLevel(credit DECIMAL(10, 2)) RETURNS VARCHAR(20) deterministic BEGIN DECLARE customerlevel VARCHAR(20);

if credit > 5000 then
SET
    customerlevel = 'PLATINUM';

elseif (
    credit <= 5000
    AND credit >= 10000
) THEN
SET
    customerlevel = 'GOLD';

ELSEIF credit < 10000 then
SET
    customerlevel = 'SILVER';

END IF;

RETURN 1;

END