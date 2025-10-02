CREATE USER ADDRESS 'user' IDENTIFIED BY 'password'; # Crea un nuovo utente
ALTER USER 'utente' IDENTIFIED BY 'nuova_password'; # Cambia la password di un utente esistente4

GRANT ALL ON *.* TO 'user' WITH GRANT OPTION; # Concede tutti i privilegi su tutti i database e tabelle all'utente



SHOW DATABASE; #mostra i database esistenti
USE DATABASE; #usi database

SELECT DATABASES(); #mostra il database in uso
SELECT USERS(); #mostra gli utenti esistenti

SHOW TABLES; #mostra le tabelle esistenti nel database in uso