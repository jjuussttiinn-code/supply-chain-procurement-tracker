DELIMITER $$

CREATE PROCEDURE sp_CreatePurchaseOrder (
    IN p_PO_Number INT,
    IN p_Supplier_ID INT,
    IN p_Buyer_ID INT,
    IN p_Order_Date DATE
)
BEGIN
    INSERT INTO PurchaseOrders (
        PO_Number,
        Supplier_ID,
        Buyer_ID,
        Order_Date,
        TotalAmount,
        Status
    )
    VALUES (
        p_PO_Number,
        p_Supplier_ID,
        p_Buyer_ID,
        p_Order_Date,
        0,
        'Pending'
    );
END$$

DELIMITER ;
