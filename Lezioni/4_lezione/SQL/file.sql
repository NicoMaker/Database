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

UPDATE students
SET
    age = age + 1;

SELECT
    *
FROM
    table1
    JOIN table2;

SELECT
    *
FROM
    table1
    JOIN table2 ON table1.column1 = table2.column2;

SELECT
    name,
    jobtitle,
    title
FROM
    employees
    JOIN projects ON employees.employeeid = projects.employeeid;

SELECT
    c.userid,
    c.name,
    c.phone,
    o.items,
    o.total
FROM
    customers AS c
    JOIN orders AS o ON c.userid = o.userid;

SELECT
    employees.name,
    employees.jobtitle,
    projects.title
FROM
    employees
    LEFT JOIN projects ON employees.employeeid = projects.employeeid;

SELECT
    employees.name,
    employees.jobtitle,
    projects.title
FROM
    employees
    LEFT JOIN projects ON employees.employeeid = projects.employeeid
WHERE
    projects.title IS NULL;

SELECT
    employees.name,
    employees.jobtitle,
    projects.title
FROM
    employees
    LEFT JOIN projects ON employees.employeeid = projects.employeeid
WHERE
    projects.title IS not NULL;

SELECT
    c.name,
    c.phone
FROM
    customers as c
    LEFT JOIN orders as o on c.userid = o.userid
WHERE
    o.userid IS NULL;

SELECT
    o.orderid,
    o.items,
    o.userid
FROM
    orders as o
    LEFT JOIN customers as c on c.userid = o.userid
WHERE
    c.name is null;

SELECT
    o.orderid,
    o.items,
    o.userid
FROM
    orders as o
    LEFT JOIN customers as c on c.userid = o.userid
WHERE
    c.name is null;

SELECT
    o.orderid,
    o.items,
    o.userid
FROM
    customers as c
    RIGHT JOIN orders as o ON c.userid = o.userid
WHERE
    c.name IS NULL;

