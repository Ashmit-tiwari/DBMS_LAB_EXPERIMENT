SELECT
    S.Sale_ID,
    C.Customer_Name,
    C.Customer_City,
    P.Product_Name,
    SD.Quantity,
    SP.Salesperson_Name
FROM Sales S
JOIN Customer C
    ON S.Customer_ID = C.Customer_ID
JOIN Salesperson SP
    ON S.Salesperson_ID = SP.Salesperson_ID
JOIN Sale_Details SD
    ON S.Sale_ID = SD.Sale_ID
JOIN Product P
    ON SD.Product_ID = P.Product_ID;

SELECT
    S.Sale_ID,
    S.Customer_ID,
    S.Salesperson_ID,
    SD.Product_ID,
    SD.Quantity
FROM Sales S
JOIN Sale_Details SD
    ON S.Sale_ID = SD.Sale_ID;

SELECT
    Sale_ID,
    Customer_ID,
    Salesperson_ID
FROM Sales
WHERE Customer_ID IS NOT NULL;

SELECT
    SD.Sale_ID,
    SD.Product_ID,
    SD.Quantity
FROM Sale_Details SD
WHERE SD.Product_ID IS NOT NULL;
