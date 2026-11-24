DROP TABLE IF EXISTS Sales_1NF;
DROP TABLE IF EXISTS Sales_UNF;

CREATE TABLE Sales_UNF (
    Sale_ID INT,
    Customer_ID INT,
    Customer_Name VARCHAR(50),
    Customer_City VARCHAR(50),
    Product_ID INT,
    Product_Name VARCHAR(50),
    Quantity INT,
    Salesperson_ID INT,
    Salesperson_Name VARCHAR(50)
);

INSERT INTO Sales_UNF VALUES
(1, 101, 'Rahul Sharma', 'Lucknow', 201, 'Laptop', 2, 301, 'Amit Kumar'),
(2, 102, 'Priya Singh', 'Kanpur', 202, 'Mouse', 3, 302, 'Neha Gupta'),
(3, 103, 'Arjun Verma', 'Delhi', 203, 'Keyboard', 1, 303, 'Rohit Singh'),
(4, 104, 'Sneha Gupta', 'Lucknow', 204, 'Monitor', 2, 301, 'Amit Kumar'),
(5, 105, 'Vivek Sharma', 'Kanpur', 205, 'Printer', 1, 302, 'Neha Gupta');

SELECT * FROM Sales_UNF;

CREATE TABLE Sales_1NF (
    Sale_ID INT,
    Customer_ID INT,
    Customer_Name VARCHAR(50),
    Customer_City VARCHAR(50),
    Product_ID INT,
    Product_Name VARCHAR(50),
    Quantity INT,
    Salesperson_ID INT,
    Salesperson_Name VARCHAR(50),
    PRIMARY KEY (Sale_ID, Product_ID)
);

INSERT INTO Sales_1NF
SELECT *
FROM Sales_UNF;

SELECT * FROM Sales_1NF;
