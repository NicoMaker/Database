CREATE TABLE students3 (
    -- Definisce una tabella chiamata 'students3'
    studentid SMALLINT(5),
    -- Colonna 'studentid' di tipo SMALLINT con lunghezza massima di 5 cifre
    firstname VARCHAR(20)
    -- Colonna 'firstname' di tipo VARCHAR con lunghezza massima di 20 caratteri
);

-- Rinomina la tabella 'students3' in 'students4'
alter table students3 rename students4;

-- Aggiunge una colonna 'lastname' di tipo NVARCHAR con lunghezza massima di 30 caratteri alla tabella 'students4'
alter table students4 ADD lastname NVARCHAR (30);

ALTER TABLE students4
-- Rinomina le colonne 'firstname' in 'nome' e 'lastname' in 'cognome' nella tabella 'students4'
RENAME COLUMN firstname TO nome,
RENAME COLUMN lastname TO cognome;

-- Modifica la colonna 'nome' nella tabella 'students4' impostandola come NVARCHAR con lunghezza massima di 40 caratteri e vincolo NOT NULL
alter table students4 modify COLUMN nome nvarchar (40) NOT NULL;

-- Inserisce un nuovo valore 'English' nella colonna 'title' della tabella 'subjects'
insert into subjects (title) values ('English');

-- Elimina la riga dalla tabella 'subjects' dove 'subjectid' è uguale a 7
DELETE FROM subjects WHERE subjectid = 7;

-- Modifica la colonna 'title' nella tabella 'subjects' impostandola come VARCHAR con lunghezza massima di 50 caratteri e vincolo UNIQUE
ALTER TABLE subjects MODIFY COLUMN title VARCHAR(50) UNIQUE;

alter table teachers
-- Aggiunge una colonna 'subjectid' di tipo INT con lunghezza massima di 11 cifre, vincolo NOT NULL e valore predefinito 1 alla tabella 'teachers'
add column subjectid INT(11) NOT NULL DEFAULT(1);

ALTER TABLE teachers
-- Aggiunge un vincolo di chiave esterna 'fk_subjectid' alla tabella 'teachers' che fa riferimento alla colonna 'subjectid' della tabella 'subjects'
ADD CONSTRAINT fk_subjectid FOREIGN KEY (subjectid) REFERENCES subjects (subjectid);

-- Crea un nuovo utente 'maker' che può connettersi solo localmente, con la password 'maker1234'
-- NOTA: La sintassi originale '->;' è stata corretta con il terminatore standard ';'
CREATE USER 'maker' @'localhost' IDENTIFIED BY 'maker1234';

-- Crea un nuovo utente 'authorized' che può connettersi solo localmente, con la password 'auth1234'
CREATE USER 'authorized' @'localhost' IDENTIFIED BY 'auth1234';

-- Assegna all'utente 'maker' i permessi per leggere (SELECT) e creare (CREATE) oggetti su tutte le tabelle (*) del database 'school'
GRANT SELECT, CREATE ON school.* TO 'maker' @'localhost';

-- Assegna all'utente 'authorized' gli stessi permessi (SELECT, CREATE) su tutte le tabelle del database 'school'
GRANT SELECT, CREATE ON school.* TO 'authorized' @'localhost';