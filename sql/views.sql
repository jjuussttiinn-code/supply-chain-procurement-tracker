CREATE VIEW vw_PurchaseOrderSummary AS
SELECT 
    po.PO_Number,
    s.Supplier_Name,
    e.First_Name,
    e.Last_Name,
    po.Order_Date,
    po.TotalAmount,
    po.Status
FROM PurchaseOrders po
JOIN Suppliers s ON po.Supplier_ID = s.Supplier_ID
JOIN ProcurementBuyers pb ON po.Buyer_ID = pb.Employee_ID
JOIN Employees e ON pb.Employee_ID = e.Employee_ID;
