DELIMITER $$

CREATE TRIGGER trg_update_total_after_insert
AFTER INSERT ON OrderDetails
FOR EACH ROW
BEGIN
    UPDATE PurchaseOrders
    SET TotalAmount = (
        SELECT SUM(Quantity * Unit_Price)
        FROM OrderDetails
        WHERE PO_Number = NEW.PO_Number
    )
    WHERE PO_Number = NEW.PO_Number;
END$$

DELIMITER ;
