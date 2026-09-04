# **Global Supply Chain & Procurement Tracker**  
*A relational database system for supplier management, procurement operations, logistics tracking, and analytical reporting.*

---

## **Overview**
The **Global Supply Chain & Procurement Tracker** is an end‑to‑end relational database designed to support procurement, logistics, and quality assurance workflows for large-scale manufacturing and distribution environments. The system provides visibility from initial supplier engagement to final warehouse delivery, enabling organizations to monitor vendor performance, track shipments, manage inventory thresholds, and analyze operational trends.

This project was completed as part of **MIS 380 — Data Management Systems** at San Diego State University and demonstrates real-world database design, SQL development, cloud deployment, and analytical reporting.

---

## **Key Features**
- 15+ fully normalized entities  
- Supertypes/subtypes for product and employee specialization  
- Referential integrity enforced through PK/FK constraints  
- Automated business logic via triggers and stored procedures  
- Cloud deployment on **AWS RDS (MySQL)**  
- Role‑based access control using IAM  
- Analytical SQL for procurement insights  
- Python dashboard visualizing spend, demand, and buyer activity  

---

## **Business Rules**
- Each supplier must have a unique ID and verified tax number.  
- Products belong to defined categories (Raw Material, Component, Finished Good).  
- Purchase orders must be authorized by a procurement buyer.  
- Shipments must be assigned to a single carrier and warehouse.  
- Raw materials require mandatory quality inspections.  
- Inventory levels update automatically upon shipment arrival.  
- Reorder points are tracked per product to support demand planning.

---

## **Use Cases**
- **Manufacturing (e.g., Tesla)** — JIT production, supplier risk monitoring  
- **Retail & Distribution (e.g., Amazon)** — warehouse utilization, carrier performance  
- **Quality Assurance** — inspection tracking, supplier compliance  

---

# *Database Architecture**

## **Entities & Relationships**
The database contains 15+ entities including:

- Suppliers, Products, Categories  
- RawMaterials, Components (subtypes of Products)  
- Employees, ProcurementBuyers, QualityInspectors (subtypes of Employees)  
- PurchaseOrders, OrderDetails  
- Warehouses, Carriers, Shipments  
- QualityInspections  

---

## **Relational Model**
All tables include:

- Primary keys  
- Foreign keys  
- NOT NULL constraints  
- UNIQUE constraints  
- CHECK constraints  

---

# SQL Implementation

## **Index**
```sql
CREATE INDEX idx_purchaseorders_supplier
ON PurchaseOrders (Supplier_ID);
```

## **View**
```sql
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
```

## **Trigger**
```sql
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
```

## **Stored Procedure**
```sql
DELIMITER $$
CREATE PROCEDURE sp_CreatePurchaseOrder (
    IN p_PO_Number INT,
    IN p_Supplier_ID INT,
    IN p_Buyer_ID INT,
    IN p_Order_Date DATE
)
BEGIN
    INSERT INTO PurchaseOrders (
        PO_Number, Supplier_ID, Buyer_ID, Order_Date, TotalAmount, Status
    )
    VALUES (p_PO_Number, p_Supplier_ID, p_Buyer_ID, p_Order_Date, 0, 'Pending');
END$$
DELIMITER ;
```

---

# **Cloud Deployment (AWS RDS)**

### **IAM Roles**
**mis380-database-admin**  
- Full RDS + VPC permissions  
- Used by DBAs and infrastructure leads  

**mis380-database-read**  
- Read-only access  
- Ideal for analysts and auditors  

**mis380-final-group**  
- Shared read-only group  
- Safe collaboration without schema modification  

---

# **Analytical Questions & Insights**

### **1. Supplier Spend Analysis**
Identifies strategic suppliers and concentration risk.

### **2. Buyer Workload & Approval Utilization**
Shows average PO value per buyer.

### **3. Product Demand Forecasting**
Highlights most frequently ordered products.

### **4. Supplier Quality Failure Rates**
Evaluates inspection performance.

### **5. Warehouse Utilization**
Monitors capacity usage.

### **6. Lead Time Analysis**
Measures responsiveness from PO to delivery.

### **7. Carrier Dependency**
Shows shipment distribution across carriers.

### **8. Category-Level Spend**
Identifies cost drivers across product categories.

---

# **Dashboard & Visualizations**

### **Buyer Activity**
- Noah: **22.4%** of average PO value  
- Ethan: **21.5%**

### **Product Demand**
- Bolt Packs: **368 units**  
- Micro Sensor: **65 units**

### **Supplier Spend**
- Allied Metals: **7,250.00**  
- Precision Parts Ltd: **7,000.00**

---

# **Repository Structure**
```
/procurement-tracker
│
├── sql/
│   ├── ddl_tables.sql
│   ├── views.sql
│   ├── triggers.sql
│   ├── stored_procedures.sql
│
├── data/
│   ├── sample_data.csv
│
├── dashboard/
│   ├── dashboard.ipynb
│
├── diagrams/
│   ├── erd.png
│
└── README.md
```

---

# **How to Run**
1. Deploy MySQL instance (local or AWS RDS).  
2. Run DDL scripts in `/sql`.  
3. Load sample data.  
4. Execute analytical queries.  
5. Run Python dashboard notebook.

---

# **Key Takeaways**
- Fully normalized relational database with real procurement logic  
- Automated workflows via triggers & stored procedures  
- Cloud deployment with secure IAM roles  
- Actionable analytics for spend, demand, quality, and logistics  
- Professional documentation suitable for industry portfolios  

---
