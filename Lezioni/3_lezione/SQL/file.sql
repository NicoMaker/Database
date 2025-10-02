CREATE USER ADDRESS 'user' IDENTIFIED BY 'password'; # Crea un nuovo utente
ALTER USER 'utente' IDENTIFIED BY 'nuova_password'; # Cambia la password di un utente esistente4

GRANT ALL ON *.* TO 'user' WITH GRANT OPTION; # Concede tutti i privilegi su tutti i database e tabelle all'utente


SHOW DATABASE; #mostra i database esistenti
USE DATABASE; #usi database

SELECT DATABASE(); #mostra il database in uso
SELECT USER(); #mostra gli utenti esistenti

SHOW TABLES; #mostra le tabelle esistenti nel database in uso

SELECT * FROM nome_tabella; #mostra il contenuto della tabella


Select nome FROM USER; #mostra il contenuto della colonna nome della tabella USER

CREATE DATABASE NomeDatabase; #crea un database
DROP DATABASE NomeDatabase; #elimina un database

CREATE TABLE student(
 id INT NOT NULL PRIMARY KEY,
 name VARCHAR(400) NOT NULL,
 class VARCHAR(20) NOT NULL,
 age INT
);