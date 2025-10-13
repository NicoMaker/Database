# Studenti ordinati per nome
SELECT * FROM students ORDER BY firstname ASC;

# corsi con nomi unici
SELECT DISTINCT coursename FROM courses;

# contare il numero di iscritti per ogni corso 
SELECT 
    (SELECT CourseName FROM Courses c WHERE c.CourseID = e.CourseID) AS CourseName,
    COUNT(e.StudentID) AS NumeroIscritti
FROM Enrollments e
GROUP BY e.CourseID
ORDER BY CourseName;


# selezionare gli studenti con voto superiore a 80 ordinato in modo decrescente 
SELECT 
    (SELECT s.FirstName FROM Students s WHERE s.StudentID = e.StudentID) AS FirstName,
    (SELECT s.LastName FROM Students s WHERE s.StudentID = e.StudentID) AS LastName,
    e.Grade
FROM Enrollments e
WHERE e.Grade > 80
ORDER BY e.Grade DESC;


# selezionare i corsi con più di 2 iscrizioni e ordinati per nome
SELECT *
FROM Courses
WHERE CourseID IN (
    SELECT CourseID
    FROM Enrollments
    GROUP BY CourseID
    HAVING COUNT(StudentID) > 2
)
ORDER BY CourseName;


# selezionare gli studenti che non hanno punteggi (null) e ordinati per cognome
SELECT *
FROM Students
WHERE StudentID IN (
    SELECT StudentID
    FROM Enrollments
    WHERE Grade IS NULL
)
ORDER BY LastName;

# selezionare i corsi che iniziano per C ordinati per nome
SELECT *
FROM Courses
WHERE CourseName LIKE 'C%'
ORDER BY CourseName;

# contare il numero di corsi in cui ogni studente e' iscritto

SELECT 
    (SELECT s.FirstName FROM Students s WHERE s.StudentID = e.StudentID) AS FirstName,
    (SELECT s.LastName FROM Students s WHERE s.StudentID = e.StudentID) AS LastName,
    COUNT(e.CourseID) AS NumeroCorsi
FROM Enrollments e
GROUP BY e.StudentID
ORDER BY NumeroCorsi DESC;

# Selezionare gli studenti e concatenare il loro nome e cognome
SELECT 
    CONCAT(FirstName, ' ', LastName) AS FullName
FROM Students;

# trova gli studenti con la media dei voti superiori a 75, ordinato per media decrescente
SELECT 
    (SELECT s.FirstName FROM Students s WHERE s.StudentID = e.StudentID) AS FirstName,
    (SELECT s.LastName FROM Students s WHERE s.StudentID = e.StudentID) AS LastName,
    ROUND(AVG(e.Grade), 0) AS Media
FROM Enrollments e
GROUP BY e.StudentID
HAVING Media > 75
ORDER BY Media DESC;

# selezionare corsi e il numero di studenti iscritti, ordinati per numero crescente
SELECT 
    (SELECT c.CourseName FROM Courses c WHERE c.CourseID = e.CourseID) AS CourseName,
    COUNT(e.StudentID) AS NumeroIscritti
FROM Enrollments e
GROUP BY e.CourseID
ORDER BY NumeroIscritti ASC;

# trova i corsi con il punteggio massimo degli studenti
SELECT 
    (SELECT c.CourseName FROM Courses c WHERE c.CourseID = e.CourseID) AS CourseName,
    ROUND(MAX(e.Grade), 0)  AS MaxGrade
FROM Enrollments e
GROUP BY e.CourseID
ORDER BY MaxGrade DESC;

# seleziona gli studenti con punteggi medi inferiori a 60
SELECT 
    (SELECT s.FirstName FROM Students s WHERE s.StudentID = e.StudentID) AS FirstName,
    (SELECT s.LastName FROM Students s WHERE s.StudentID = e.StudentID) AS LastName,
    ROUND(AVG(e.Grade), 0) AS Media
FROM Enrollments e
GROUP BY e.StudentID
HAVING Media < 60;

# contare il numero totale di corsi disponibili
SELECT COUNT(*) AS NumeroCorsi
FROM Courses;

# Seleziona corsi con nomi distinti e conteggio delle iscrizioni.
SELECT
    (SELECT c.CourseName FROM Courses c WHERE c.CourseID = e.CourseID) AS CourseName,
    COUNT(e.StudentID) AS NumeroIscritti
FROM Enrollments e
GROUP BY e.CourseID
ORDER BY NumeroIscritti DESC;

# Trova gli studenti che sono iscritti in corsi con punteggio medio superiore a 70.