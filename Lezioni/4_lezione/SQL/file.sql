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
    *
FROM
    students
ORDER BY
    age DESC;

