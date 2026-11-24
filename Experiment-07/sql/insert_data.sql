INSERT INTO Customer
SELECT DISTINCT
    Customer_ID,
    Customer_Name,
    Customer_City
FROM Sales_1NF;

INSERT INTO Product
SELECT DISTINCT
    Product_ID,
    Product_Name
FROM Sales_1NF;

INSERT INTO Salesperson
SELECT DISTINCT
    Salesperson_ID,
    Salesperson_Name
FROM Sales_1NF;

INSERT INTO Sales
SELECT DISTINCT
    Sale_ID,
    Customer_ID,
    Salesperson_ID
FROM Sales_1NF;

INSERT INTO Sale_Details
SELECT
    Sale_ID,
    Product_ID,
    Quantity
FROM Sales_1NF;

SELECT * FROM Customer;
SELECT * FROM Product;
SELECT * FROM Salesperson;
SELECT * FROM Sales;
SELECT * FROM Sale_Details;
