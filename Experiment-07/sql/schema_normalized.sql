DROP TABLE IF EXISTS Sale_Details;
DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Salesperson;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Customer;

CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(50),
    Customer_City VARCHAR(50)
);

CREATE TABLE Product (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(50)
);

CREATE TABLE Salesperson (
    Salesperson_ID INT PRIMARY KEY,
    Salesperson_Name VARCHAR(50)
);

CREATE TABLE Sales (
    Sale_ID INT PRIMARY KEY,
    Customer_ID INT,
    Salesperson_ID INT,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Salesperson_ID) REFERENCES Salesperson(Salesperson_ID)
);

CREATE TABLE Sale_Details (
    Sale_ID INT,
    Product_ID INT,
    Quantity INT,
    PRIMARY KEY (Sale_ID, Product_ID),
    FOREIGN KEY (Sale_ID) REFERENCES Sales(Sale_ID),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);
