source c: \ mysqlsampledatabase.sql # esegue tutti i comandi presenti nel file
SELECT
    customername,
    city
FROM
    customers
ORDER By
    customername;

DELIMITER $ $ CREATE PROCEDURE GetCustomers() BEGIN
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

END $ $ DELIMITER;

# eliminazione procedura
DROP PROCEDURE GetCustomers # chiamata procedura
CALL GetCustomers();

# eliminazione con if exists
DROP PROCEDURE IF EXISTS PIPPO;

SHOW warnings;

DELIMITER $ $ CREATE PROCEDURE GetEmployess() BEGIN
SELECT
    firstname,
    lastname,
    city,
    state,
    country
FROM
    employees
    INNER JOIN offices USING (officeCode);

END $ $ DELIMITER;

CALL GetEmployess();

DELIMITER / / CREATE PROCEDURE GetOfficeByCountry(in countryName varchar(255)) BEGIN
SELECT
    *
FROM
    offices
WHERE
    country = countryName;

END / / DELIMITER;

CALL GetOfficeByCountry('USA');

DELIMITER / / CREATE PROCEDURE GetOfficeByCountries(IN countryList VARCHAR(255)) BEGIN
SET
    @query = CONCAT(
        'SELECT * FROM offices WHERE country IN (''',
        REPLACE(countryList, ',', ''','''),
        ''')'
    );

PREPARE stmt
FROM
    @query;

EXECUTE stmt;

DEALLOCATE PREPARE stmt;

END / / DELIMITER;

CALL GetOfficeByCountries('USA,France,Japan');