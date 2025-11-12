-- ESERCIZIO 7: Procedura per eliminare tutti gli ordini di un cliente
CREATE PROCEDURE DeleteCustomerOrders(
    IN p_CustomerID INT,
    OUT p_TotalDeleted DECIMAL(10, 2)
)
BEGIN
    DECLARE totalAmount DECIMAL(10, 2);
    SELECT IFNULL(SUM(Amount), 0) INTO totalAmount FROM Orders WHERE CustomerID = p_CustomerID;
    DELETE FROM Orders WHERE CustomerID = p_CustomerID;
    SET p_TotalDeleted = totalAmount;
END;

CALL DeleteCustomerOrders(1, @TotaleEliminato);
SELECT @TotaleEliminato AS TotaleOrdiniEliminati;



-- ESERCIZIO 10: Trigger che impedisce l'eliminazione di un cliente con ordini esistenti
CREATE TRIGGER PreventCustomerDeletionWithOrders
BEFORE DELETE ON Customers
FOR EACH ROW
BEGIN
    DECLARE orderCount INT;
    SELECT COUNT(*) INTO orderCount FROM Orders WHERE CustomerID = OLD.CustomerID;
    IF orderCount > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ERRORE: Impossibile eliminare il cliente perché esistono ancora ordini associati.';
    END IF;
END;

SELECT * FROM Customers;
SELECT * FROM Orders;
DELETE FROM Customers WHERE CustomerID = 1;
CALL DeleteCustomerOrders(2, @TotaleEliminato);
DELETE FROM Customers WHERE CustomerID = 2;
SHOW TRIGGERS FROM CustomerOrders;


