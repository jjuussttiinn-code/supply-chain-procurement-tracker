-- Disable FK checks for smooth inserts
SET FOREIGN_KEY_CHECKS = 0;

-- =========================================
-- SUPPLIERS 
-- =========================================
INSERT INTO Suppliers (Supplier_ID, Supplier_Name, Country, Tax_ID, Contact_Email) VALUES
(5, 'Allied Metals', 'Canada', 'TAX-005', 'contact@allied.com'),
(6, 'Precision Parts Ltd', 'Germany', 'TAX-006', 'sales@precision.com'),
(7, 'Bulk Materials Inc', 'USA', 'TAX-007', 'bulk@email.com'),
(8, 'Asia Components', 'Japan', 'TAX-008', 'asia@comp.com'),
(9, 'Nordic Logistics', 'Sweden', 'TAX-009', 'supply@nordic.se'),
(10, 'Euro-Circuit', 'France', 'TAX-010', 'info@eurocircuit.fr');

-- =========================================
-- EMPLOYEES + ROLES 
-- =========================================
INSERT INTO Employees (Employee_ID, First_Name, Last_Name, Email, Job_Title) VALUES
(30, 'Liam', 'Patel', 'liam@email.com', 'Buyer'),
(31, 'Emma', 'Wilson', 'emma.w@email.com', 'Buyer'),
(32, 'Noah', 'Garcia', 'noah.g@email.com', 'Buyer'),
(33, 'Ava', 'Martinez', 'ava.m@email.com', 'Buyer'),
(34, 'Lucas', 'Kim', 'lucas.k@email.com', 'Buyer'),
(40, 'Sofia', 'Nguyen', 'sofia@email.com', 'Inspector'),
(41, 'Oliver', 'Smith', 'oliver.s@email.com', 'Inspector'),
(42, 'Isabella', 'Brown', 'isabella.b@email.com', 'Inspector'),
(43, 'Mia', 'Davis', 'mia.d@email.com', 'Inspector'),
(44, 'Ethan', 'Miller', 'ethan.m@email.com', 'Inspector'),
(50, 'Ethan', 'Ross', 'ethan@email.com', 'Buyer');

-- Specialization Linkage
INSERT INTO ProcurementBuyers (Employee_ID, Approval_Limit) VALUES
(30, 8000.00), (31, 15000.00), (32, 5000.00), (33, 25000.00), (34, 12000.00), (50, 10000.00);

INSERT INTO QualityInspectors (Employee_ID, Inspection_Specialty) VALUES
(40, 'Electronics'), (41, 'Raw Materials'), (42, 'Packaging'), (43, 'Chemicals'), (44, 'Hardware');

-- =========================================
-- PRODUCTS 
-- =========================================
INSERT INTO Products (Product_ID, Product_Name, Category_ID, Description, Unit_Price, Reorder_Point) VALUES
(506, 'Aluminum Sheet', 1, 'Lightweight metal', 120.00, 15),
(507, 'Bolt Pack', 2, 'Steel bolts', 5.00, 200),
(508, 'Plastic Crate', 3, 'Reusable box', 15.00, 100),
(509, 'Micro Sensor', 2, 'Precision sensor', 45.00, 75),
(510, 'Steel Rod', 1, 'Heavy duty rod', 150.00, 25),
(511, 'Gear Assembly', 2, 'Machine gear', 60.00, 40),
(512, 'Copper Wire', 1, 'Industrial grade', 85.00, 60),
(513, 'LCD Display', 2, '4-inch panel', 210.00, 30);

INSERT INTO RawMaterials (Product_ID, Material_Grade) VALUES
(506, 'A2'), (510, 'A1'), (512, 'C3');

INSERT INTO Components (Product_ID, Part_Number) VALUES
(507, 'BOLT-22'), (509, 'SENSOR-X'), (511, 'GEAR-77'), (513, 'DISP-99');

-- =========================================
-- WAREHOUSES + CARRIERS
-- =========================================
INSERT INTO Warehouses (Warehouse_ID, Warehouse_Name, Location, Capacity) VALUES
(2, 'LA Hub', 'Los Angeles', 2000),
(3, 'TX Hub', 'Dallas', 1500),
(4, 'NY Hub', 'New York', 1800),
(5, 'CHI Hub', 'Chicago', 2500);

INSERT INTO Carriers (Carrier_ID, Carrier_Name, Service_Type, Contact_Num) VALUES
(2, 'Air Express', 'Air', '555-0202'),
(3, 'Ocean Freight', 'Sea', '555-0303'),
(4, 'QuickShip', 'Ground', '555-0404'),
(5, 'Global Cargo', 'Multimodal', '555-0505');

-- =========================================
-- PURCHASE ORDERS (High Volume for Analytics)
-- =========================================
INSERT INTO PurchaseOrders (PO_Number, Supplier_ID, Buyer_ID, Order_Date, TotalAmount, Status) VALUES
(803, 5, 30, '2026-03-15', 2400.00, 'Arrived'),
(804, 6, 31, '2026-03-20', 1800.00, 'Arrived'),
(805, 7, 32, '2026-04-01', 950.00, 'Pending'),
(806, 9, 33, '2026-04-10', 3000.00, 'Arrived'),
(807, 10, 34, '2026-04-15', 1200.00, 'Shipped'),
(808, 5, 30, '2026-04-18', 2200.00, 'In Transit'),
(809, 8, 50, '2026-04-20', 4000.00, 'Arrived'),
(810, 5, 31, '2026-04-22', 1750.00, 'Pending'),
(811, 6, 32, '2026-04-25', 5200.00, 'Pending'),
(812, 10, 33, '2026-04-28', 840.00, 'Arrived');

-- =========================================
-- ORDER DETAILS (Connecting everything)
-- =========================================
INSERT INTO OrderDetails (PO_Number, Product_ID, Quantity, Unit_Price) VALUES
(803, 506, 20, 120.00), (803, 507, 200, 5.00),
(804, 509, 40, 45.00),
(805, 511, 15, 60.00),
(806, 510, 20, 150.00),
(807, 512, 14, 85.00),
(808, 513, 10, 210.00),
(809, 511, 30, 60.00), (809, 509, 25, 45.00),
(812, 507, 168, 5.00);

-- =========================================
-- SHIPMENTS
-- =========================================
INSERT INTO Shipments (Shipment_ID, PO_Number, Carrier_ID, Warehouse_ID, Tracking_Num, Status) VALUES
(903, 803, 2, 2, 'TRK-111', 'Delivered'),
(904, 804, 4, 3, 'TRK-222', 'Delivered'),
(905, 806, 3, 5, 'TRK-333', 'Delivered'),
(906, 807, 5, 4, 'TRK-444', 'Shipped'),
(907, 808, 2, 2, 'TRK-555', 'In Transit'),
(908, 809, 4, 4, 'TRK-666', 'Delivered'),
(909, 812, 3, 3, 'TRK-888', 'Delivered');

-- =========================================
-- QUALITY INSPECTIONS
-- =========================================
INSERT INTO QualityInspections (Inspection_ID, Shipment_ID, Inspector_ID, Inspection_Date, Result) VALUES
(3, 903, 41, '2026-03-16', 'Pass'),
(4, 904, 40, '2026-03-21', 'Pass'),
(5, 905, 41, '2026-04-11', 'Fail'),
(6, 905, 44, '2026-04-12', 'Pass'),
(7, 908, 40, '2026-04-21', 'Pass'),
(8, 909, 42, '2026-04-30', 'Pass');

-- Re-enable FK checks
SET FOREIGN_KEY_CHECKS = 1;

(805, 504, 300, 2.00),
(806, 501, 15, 100.00),
(806, 507, 100, 5.00),
(807, 502, 500, 0.50),
(808, 506, 10, 120.00),
(808, 505, 10, 85.00),
(809, 511, 30, 60.00),
(809, 509, 25, 45.00),
(810, 510, 10, 150.00);
-- =========================================
-- SHIPMENTS
-- =========================================
INSERT INTO Shipments (Shipment_ID, PO_Number, Carrier_ID, Warehouse_ID, Tracking_Num, Status) VALUES
(903, 803, 2, 2, 'TRK-111', 'Delivered'),
(904, 804, 1, 1, 'TRK-222', 'Delivered'),
(905, 806, 3, 3, 'TRK-333', 'Delivered'),
(906, 807, 1, 2, 'TRK-444', 'Shipped'),
(907, 808, 2, 1, 'TRK-555', 'In Transit'),
(908, 809, 4, 4, 'TRK-666', 'Delivered'),
(909, 810, 2, 2, 'TRK-777', 'Pending');
-- =========================================
-- QUALITY INSPECTIONS
-- =========================================
INSERT INTO QualityInspections (Inspection_ID, Shipment_ID, Inspector_ID, Inspection_Date, Result) VALUES
(3, 903, 40, '2026-03-16', 'Pass'),
(4, 904, 20, '2026-03-21', 'Pass'),
(5, 905, 40, '2026-04-11', 'Fail'),
(6, 905, 20, '2026-04-12', 'Pass'),
(7, 908, 40, '2026-04-21', 'Pass'),
(8, 908, 20, '2026-04-22', 'Fail');
-- Re-enable FK checks
SET FOREIGN_KEY_CHECKS = 1;
