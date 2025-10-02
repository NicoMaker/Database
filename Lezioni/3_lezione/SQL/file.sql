CREATE USER ADDRESS 'user' IDENTIFIED BY 'password';

# Crea un nuovo utente
ALTER USER 'utente' IDENTIFIED BY 'nuova_password';

# Cambia la password di un utente esistente4
GRANT ALL ON *.* TO 'user' WITH GRANT OPTION;

# Concede tutti i privilegi su tutti i database e tabelle all'utente
SHOW DATABASE;

#mostra i database esistenti
USE DATABASE;

#usi database
SELECT
    DATABASE();

#mostra il database in uso
SELECT
    USER();

#mostra gli utenti esistenti
SHOW TABLES;

#mostra le tabelle esistenti nel database in uso
SELECT
    *
FROM
    nome_tabella;

#mostra il contenuto della tabella
Select
    nome
FROM
    USER;

#mostra il contenuto della colonna nome della tabella USER
CREATE DATABASE NomeDatabase;

#crea un database
DROP DATABASE NomeDatabase;

#elimina un database
CREATE TABLE students (
    id INT NOT NULL PRIMARY KEY,
    -- Identificativo univoco dello studente
    name VARCHAR(400) NOT NULL,
    -- Nome e cognome (max 400 caratteri)
    class VARCHAR(20) NOT NULL,
    -- Classe frequentata (es. "3A", "4B")
    age INT -- Età (può essere NULL se non inserita)
);

CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    -- ID univoco generato automaticamente
    name VARCHAR(100) NOT NULL,
    -- Nome studente (max 100 caratteri)
    class VARCHAR(20) NOT NULL,
    -- Classe frequentata
    age INT CHECK (age > 0) -- Età deve essere positiva
);

DESCRIPE nome_tabella;

#mostra la struttura della tabella
ALTER TABLE
    students DROP COLUMN name,
ADD
    COLUMN firstname VARCHAR(40) NOT NULL,
ADD
    COLUMN lastname VARCHAR(40) NOT NULL;

INSERT INTO
    students (id, firstname, lastname, class, age)
VALUES
    (1, 'Luca', 'Rossi', '3A', 17),
    (2, 'Giulia', 'Bianchi', '2B', 16),
    (3, 'Marco', 'Verdi', '1C', 15),
    (4, 'Sofia', 'Neri', '3A', 17),
    (5, 'Alessandro', 'Russo', '2B', 16),
    (6, 'Martina', 'Ferrari', '1C', 15),
    (7, 'Davide', 'Conti', '3A', 18),
    (8, 'Elena', 'Galli', '2B', 16),
    (9, 'Federico', 'Costa', '1C', 15),
    (10, 'Chiara', 'Fontana', '3A', 17);

INSERT INTO
    students (lastname, firstname, class, age, id)
VALUES
    ('Romano', 'Valentina', '1A', 15, 11),
    ('Marini', 'Tommaso', '2C', 16, 12),
    ('Moretti', 'Giorgia', '3B', 17, 13),
    ('Esposito', 'Matteo', '1B', 15, 14),
    ('Bellini', 'Francesca', '2A', 16, 15),
    ('Barbieri', 'Lorenzo', '3C', 18, 16),
    ('Rinaldi', 'Alice', '1A', 15, 17),
    ('Galli', 'Riccardo', '2C', 16, 18),
    ('Ferraro', 'Beatrice', '3B', 17, 19),
    ('Fabbri', 'Andrea', '1B', 15, 20);


#svuota la tabella e resetta AUTO_INCREMENT
TRUNCATE TABLE students;