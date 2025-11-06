CREATE DATABASE IF NOT EXISTS CustomerOrders;

USE CustomerOrders;

# Creazione della tabella clienti 
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(100),
    Email VARCHAR(100),
    JoinDate DATE
);

# Creazione della tabella ordini CREATE TABLE Orders (
OrderID INT PRIMARY KEY AUTO_INCREMENT,
CustomerID INT,
OrderDate DATE,
Amount DECIMAL(10, 2),
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

# Creazione della tabella dei log CREATE TABLE OrderLogs (
LogID INT PRIMARY KEY AUTO_INCREMENT,
OrderID INT,
LogMessage VARCHAR(255),
LogDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

# INSERIMENTO DATI: Inserimento dei dati nella tabella Customers
INSERT INTO
    Customers (CustomerName, Email, JoinDate)
VALUES
    ('Alice Rossi', 'alice@example.com', '2022-01-15'),
    ('Bob Bianchi', 'bob@example.com', '2023-03-10'),
    ('Carla Verdi', 'carla@example.com', '2021-06-21');

# Inserimento dei dati nella tabella Orders
INSERT INTO
    Orders (CustomerID, OrderDate, Amount)
VALUES
    (1, '2023-01-10', 100.50),
    (1, '2023-02-15', 200.00),
    (2, '2023-03-20', 150.75),
    (3, '2023-04-05', 300.00),
    (2, '2023-05-12', 450.25);

-- ============================================
-- ESERCIZIO 1: Funzione per calcolare il totale ordini di un cliente
-- ============================================

DELIMITER $$
CREATE FUNCTION GetCustomerTotalOrders(p_CustomerID INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10, 2);

    SELECT IFNULL(SUM(Amount), 0)
    INTO total
    FROM Orders
    WHERE CustomerID = p_CustomerID;

    RETURN total;
END $$
DELIMITER ;

-- ESEMPIO DI UTILIZZO
SELECT GetCustomerTotalOrders(1) AS TotaleOrdiniCliente1;

-- ============================================
-- ESERCIZIO 2: Procedura per elencare tutti gli ordini di un cliente
-- ============================================

DELIMITER $$
CREATE PROCEDURE GetCustomerOrders(IN p_CustomerID INT)
BEGIN
    SELECT
        o.OrderID,
        c.CustomerName,
        o.OrderDate,
        o.Amount
    FROM
        Orders o
        INNER JOIN Customers c ON o.CustomerID = c.CustomerID
    WHERE
        o.CustomerID = p_CustomerID
    ORDER BY
        o.OrderDate ASC;
END $$
DELIMITER ;

-- ESEMPIO DI UTILIZZO
CALL GetCustomerOrders(1);

-- ============================================
-- ESERCIZIO 3: Procedura per aggiungere un nuovo ordine e mostrare il totale aggiornato
-- ============================================

DELIMITER $$
CREATE PROCEDURE AddNewOrder(
    IN p_CustomerID INT,
    IN p_OrderDate DATE,
    IN p_Amount DECIMAL(10, 2)
)
BEGIN
    DECLARE v_NewOrderID INT;
    DECLARE v_Total DECIMAL(10, 2);

    -- Inserisce il nuovo ordine
    INSERT INTO Orders (CustomerID, OrderDate, Amount)
    VALUES (p_CustomerID, p_OrderDate, p_Amount);

    -- Recupera l'ID dell'ordine appena inserito
    SET v_NewOrderID = LAST_INSERT_ID();

    -- Calcola il totale aggiornato
    SET v_Total = GetCustomerTotalOrders(p_CustomerID);

    -- Inserisce un log informativo
    INSERT INTO OrderLogs (OrderID, LogMessage)
    VALUES (
        v_NewOrderID,
        CONCAT('Nuovo ordine aggiunto per il cliente ', p_CustomerID, '. Totale aggiornato: €', v_Total)
    );

    -- Mostra il totale aggiornato
    SELECT v_Total AS TotaleAggiornato;
END $$
DELIMITER ;

-- ESEMPIO DI UTILIZZO
CALL AddNewOrder(1, '2025-11-06', 150.75);

-- ============================================
-- ESERCIZIO 4: Funzione per ottenere il totale medio degli ordini di un cliente
-- ============================================

DELIMITER $$
CREATE FUNCTION GetAverageOrderTotal(CustomerIDInput INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE avgTotal DECIMAL(10, 2);

    SELECT AVG(Amount)
    INTO avgTotal
    FROM Orders
    WHERE CustomerID = CustomerIDInput;

    RETURN IFNULL(avgTotal, 0.00);
END $$
DELIMITER ;

-- ESEMPIO DI UTILIZZO
SELECT GetAverageOrderTotal(1) AS MediaOrdiniCliente1;

-- ============================================
-- ESERCIZIO 5: Procedura per aggiungere un nuovo cliente
-- ============================================

DELIMITER $$
CREATE PROCEDURE AddNewCustomer(
    IN p_CustomerName VARCHAR(100),
    IN p_Email VARCHAR(100),
    IN p_JoinDate DATE
)
BEGIN
    INSERT INTO Customers (CustomerName, Email, JoinDate)
    VALUES (p_CustomerName, p_Email, p_JoinDate);
END $$
DELIMITER ;

-- ESEMPIO DI UTILIZZO
CALL AddNewCustomer('Mario Rossi', 'mario.rossi@example.com', '2025-11-06');

-- ============================================
-- ESERCIZIO 6: Procedura per aggiornare l'email di un cliente
-- ============================================

DELIMITER $$
CREATE PROCEDURE UpdateCustomerEmail(
    IN p_CustomerID INT,
    IN p_NewEmail VARCHAR(100)
)
BEGIN
    UPDATE Customers
    SET Email = p_NewEmail
    WHERE CustomerID = p_CustomerID;
END $$
DELIMITER ;

-- ESEMPIO DI UTILIZZO
CALL UpdateCustomerEmail(1, 'nuovo.indirizzo@example.com');

-- ============================================
-- ESERCIZIO 7: Procedura per eliminare tutti gli ordini di un cliente e restituire il totale eliminato
-- ============================================

DELIMITER $$
CREATE PROCEDURE DeleteCustomerOrders(
    IN p_CustomerID INT,
    OUT p_TotalDeleted DECIMAL(10,2)
)
BEGIN
    DECLARE totalAmount DECIMAL(10,2);

    -- Calcola il totale degli ordini del cliente
    SELECT IFNULL(SUM(Amount), 0)
    INTO totalAmount
    FROM Orders
    WHERE CustomerID = p_CustomerID;

    -- Elimina gli ordini del cliente
    DELETE FROM Orders
    WHERE CustomerID = p_CustomerID;

    -- Restituisce il totale eliminato
    SET p_TotalDeleted = totalAmount;
END $$
DELIMITER ;

-- ESEMPIO DI UTILIZZO
CALL DeleteCustomerOrders(1, @TotaleEliminato);
SELECT @TotaleEliminato AS TotaleOrdiniEliminati;