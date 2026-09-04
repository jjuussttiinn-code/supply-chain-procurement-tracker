CREATE TABLE Categories (
Category_ID INT PRIMARY KEY,
Category_Name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Suppliers (
Supplier_ID INT PRIMARY KEY,
Supplier_Name VARCHAR(100) NOT NULL,
Country VARCHAR(50) NOT NULL,
Tax_ID VARCHAR(20) NOT NULL UNIQUE,
Contact_Email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Products (
Product_ID INT PRIMARY KEY,
Product_Name VARCHAR(100) NOT NULL,
Category_ID INT NOT NULL,
Description TEXT,
Unit_Price DECIMAL(10, 2) NOT NULL,
Reorder_Point INT NOT NULL,
FOREIGN KEY (Category_ID) REFERENCES Categories(Category_ID)
);

CREATE TABLE RawMaterials (
Product_ID INT PRIMARY KEY,
Material_Grade VARCHAR(50) NOT NULL,
FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);

CREATE TABLE Components (
Product_ID INT PRIMARY KEY,
Part_Number VARCHAR(50) NOT NULL UNIQUE,
FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);

CREATE TABLE Employees (
Employee_ID INT PRIMARY KEY,
First_Name VARCHAR(50) NOT NULL,
Last_Name VARCHAR(50) NOT NULL,
Email VARCHAR(100) NOT NULL UNIQUE,
Job_Title VARCHAR(50) NOT NULL
);

CREATE TABLE ProcurementBuyers (
Employee_ID INT PRIMARY KEY,
Approval_Limit DECIMAL(15, 2) NOT NULL,
FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID)
);

CREATE TABLE QualityInspectors (
Employee_ID INT PRIMARY KEY,
Inspection_Specialty VARCHAR(100) NOT NULL,
FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID)
);

CREATE TABLE PurchaseOrders (
PO_Number INT PRIMARY KEY,
Supplier_ID INT NOT NULL,
Buyer_ID INT NOT NULL,
Order_Date DATE NOT NULL,
TotalAmount DECIMAL(15, 2) NOT NULL,
Status VARCHAR(20) DEFAULT 'Pending',
FOREIGN KEY (Supplier_ID) REFERENCES Suppliers(Supplier_ID),
FOREIGN KEY (Buyer_ID) REFERENCES ProcurementBuyers(Employee_ID)
);

CREATE TABLE OrderDetails (
OrderDetail_ID INT PRIMARY KEY AUTO_INCREMENT,
PO_Number INT NOT NULL,
Product_ID INT NOT NULL,
Quantity INT NOT NULL,
Unit_Price DECIMAL(10, 2) NOT NULL,
FOREIGN KEY (PO_Number) REFERENCES PurchaseOrders(PO_Number),
FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);

CREATE TABLE Warehouses (
Warehouse_ID INT PRIMARY KEY,
Warehouse_Name VARCHAR(100) NOT NULL UNIQUE,
Location VARCHAR(100) NOT NULL,
Capacity INT NOT NULL
);

CREATE TABLE Carriers (
Carrier_ID INT PRIMARY KEY,
Carrier_Name VARCHAR(100) NOT NULL UNIQUE,
Service_Type VARCHAR(50),
Contact_Num VARCHAR(20)
);

CREATE TABLE Shipments (
Shipment_ID INT PRIMARY KEY,
PO_Number INT NOT NULL,
Carrier_ID INT NOT NULL,
Warehouse_ID INT NOT NULL,
Tracking_Num VARCHAR(50) NOT NULL UNIQUE,
Status VARCHAR(20) NOT NULL,
FOREIGN KEY (PO_Number) REFERENCES PurchaseOrders(PO_Number),
FOREIGN KEY (Carrier_ID) REFERENCES Carriers(Carrier_ID),
FOREIGN KEY (Warehouse_ID) REFERENCES Warehouses(Warehouse_ID)
);

CREATE TABLE QualityInspections (
Inspection_ID INT PRIMARY KEY,
Shipment_ID INT NOT NULL,
Inspector_ID INT NOT NULL,
Inspection_Date DATE NOT NULL,
Result VARCHAR(10) CHECK (Result IN ('Pass', 'Fail')),
FOREIGN KEY (Shipment_ID) REFERENCES Shipments(Shipment_ID),
FOREIGN KEY (Inspector_ID) REFERENCES QualityInspectors(Employee_ID)
);
