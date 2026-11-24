DROP TABLE IF EXISTS Sales;

CREATE TABLE Sales (
    Sale_ID INT PRIMARY KEY,
    Customer_ID INT,
    Customer_Name VARCHAR(50),
    Product_ID INT,
    Product_Name VARCHAR(50),
    Category VARCHAR(30),
    Quantity INT,
    Price DECIMAL(10,2),
    Total_Amount DECIMAL(12,2),
    Sale_Date DATE,
    City VARCHAR(50),
    Payment_Mode VARCHAR(20)
);
