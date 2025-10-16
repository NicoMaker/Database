source c:\mysqlsampledatabase.sql # esegue tutti i comandi presenti nel file


SELECT
    customername,
    city
FROM
    customers
ORDER By
    customername;


DELIMITER $$
CREATE PROCEDURE GetCustomers()
BEGIN
    SELECT
        customername,
        city,
        state,
        postalcode,
        country
    FROM
        customers
    ORDER By
        customername;
END $$
DELIMITER ;

# eliminazione procedura
DROP PROCEDURE GetCustomers

# chiamata procedura
CALL GetCustomers();

# eliminazione con if exists
DROP PROCEDURE IF EXISTS PIPPO;

SHOW warnings;

DELIMITER $$
CREATE PROCEDURE GetEmployess()
BEGIN
    SELECT
        firstname,
        lastname,
        city,
        state,
        country
    FROM
        employees
    INNER JOIN offices USING (officeCode);
END $$
DELIMITER ;

CALL GetEmployess();