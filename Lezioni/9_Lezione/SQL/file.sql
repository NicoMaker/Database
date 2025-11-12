CREATE TABLE students3 (
    studentid SMALLINT(5),
    firstname VARCHAR(20)
);

alter table students3 rename students4;

alter table students4 ADD lastname NVARCHAR (30);

ALTER TABLE students4
RENAME COLUMN firstname TO nome,
RENAME COLUMN lastname TO cognome;

alter table students4 modify COLUMN nome nvarchar (40) NOT NULL;

insert into subjects (title) values ('English');

DELETE FROM subjects WHERE subjectid = 7;

ALTER TABLE subjects MODIFY COLUMN title VARCHAR(50) UNIQUE;

alter table teachers
add column subjectid INT(11) NOT NULL DEFAULT(1);

ALTER TABLE teachers
ADD CONSTRAINT fk_subjectid FOREIGN KEY (subjectid) REFERENCES subjects (subjectid);

-- Crea un nuovo utente 'maker' che può connettersi solo localmente, con la password 'maker1234'.
-- NOTA: La sintassi originale '->;' è stata corretta con il terminatore standard ';'.
CREATE USER 'maker'@'localhost' IDENTIFIED BY 'maker1234';

-- Crea un nuovo utente 'authorized' che può connettersi solo localmente, con la password 'auth1234'.
CREATE USER 'authorized'@'localhost' IDENTIFIED BY 'auth1234';

-- Assegna all'utente 'maker' i permessi per leggere (SELECT) e creare (CREATE) oggetti
-- su tutte le tabelle (*) del database 'school'.
GRANT SELECT, CREATE ON school.* TO 'maker'@'localhost';

-- Assegna all'utente 'authorized' gli stessi permessi (SELECT, CREATE)
-- su tutte le tabelle del database 'school'.
GRANT SELECT, CREATE ON school.* TO 'authorized'@'localhost';