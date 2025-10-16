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

