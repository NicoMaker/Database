SELECT
    *
FROM
    students;

SELECT
    class,
    COUNT(*)
FROM
    students
GROUP by
    CLASS;

SELECT
    COUNT(*)
FROM
    students;

SELECT
    jobtitle,
    COUNT(*)
FROM
    employees
GROUP BY
    jobtitle;

SELECT
    jobtitle as ruolo,
    COUNT(*)
FROM
    employees
WHERE
    jobtitle = 'Web Developer'
GROUP BY
    jobtitle;

SELECT
    name,
    jobtitle,
    salary
FROM
    employees
WHERE
    salary >= 3500;

SELECT
    name,
    jobtitle,
    salary
FROM
    employees
GROUP BY
    name,
    jobtitle,
    salary
HAVING
    salary >= 3500;

SELECT
    salary,
    COUNT(*) AS num_employees
FROM
    employees
GROUP BY
    salary
HAVING
    salary >= 3500;

SELECT
    a
FROM
    students
ORDER BY
    age DESC;

SELECT
    age,
    COUNT(*) AS total_students
FROM
    students
GROUP BY
    age
ORDER BY
    age DESC;

SELECT
    age,
    GROUP_CONCAT (CONCAT (firstname, ' ', lastname) SEPARATOR ', ') AS students,
    COUNT(*) AS total_students
FROM
    students
GROUP BY
    age
ORDER BY
    age DESC;

SELECT
    age,
    COUNT(*) AS total_students
FROM
    students
GROUP BY
    age
ORDER BY
    age DESC
LIMIt
    2;

SELECT
    CONCAT (firstname, ' ', lastname) AS full_name
FROM
    students;

SELECT
    NOW () AS data_ora_completa,
    CURDATE () AS data_corrente,
    CURTIME () AS ora_corrente;

SELECT
    NOW () AS data_ora_completa,
    CURRENT_DATE() AS data_corrente,
    CURRENT_TIME() AS ora_corrente;

SELECT
    *
FROM
    orders
WHERE
    orderdate = '2025-10-02 16:00:41';

INSERT INTO
    teachers (teacherid, name, phone)
VALUES
    (6, 'Giulia Rossi', '3216549870'),
    (7, 'Luca Bianchi', '9876543210'),
    (8, 'Martina Verdi', '4567891230'),
    (9, 'Alessandro Neri', '7891234560'),
    (10, 'Francesca Conti', '6543219870'),
    (11, 'Davide Russo', '1237894560'),
    (12, 'Chiara Ferrari', '3219876540'),
    (13, 'Matteo Esposito', '9871236540'),
    (14, 'Sara Galli', '4561237890'),
    (15, 'Andrea Romano', '7894561230');

CREATE TABLE
    students2 (
        studentid INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
        firstname VARCHAR(40) NOT NULL,
        lastname VARCHAR(40) NOT NULL,
        class VARCHAR(20),
        age INT
    );

INSERT INTO
    students2
SELECT
    *
FROM
    students;

DELETE FROM students2;

INSERT INTO
    students2 (firstname, lastname, age)
SELECT
    firstname,
    lastname,
    age + 1
FROM
    students;