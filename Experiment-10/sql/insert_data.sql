SET SESSION cte_max_recursion_depth = 10000;

INSERT INTO Sales 
(Sale_ID, Customer_ID, Customer_Name, Product_ID, 
 Product_Name, Category, Quantity, Price, Total_Amount, 
 Sale_Date, City, Payment_Mode) 
WITH RECURSIVE Numbers AS ( 
    SELECT 1 AS n 
    UNION ALL 
    SELECT n + 1 
    FROM Numbers 
    WHERE n < 10000 
) 
SELECT 
    n, 
    100 + (n % 500), 
    CONCAT('Customer_', n % 500), 
    1000 + (n % 100), 
    CONCAT('Product_', n % 100), 
    CASE 
        WHEN n % 4 = 0 THEN 'Electronics' 
        WHEN n % 4 = 1 THEN 'Clothing' 
        WHEN n % 4 = 2 THEN 'Furniture' 
        ELSE 'Grocery' 
    END, 
    (n % 10) + 1, 
    100 + (n % 900), 
    ((n % 10) + 1) * (100 + (n % 900)), 
    DATE_ADD('2026-01-01', INTERVAL (n % 365) DAY), 
    CASE 
        WHEN n % 4 = 0 THEN 'Lucknow' 
        WHEN n % 4 = 1 THEN 'Delhi' 
        WHEN n % 4 = 2 THEN 'Kanpur' 
        ELSE 'Mumbai' 
    END, 
    CASE 
        WHEN n % 3 = 0 THEN 'UPI' 
        WHEN n % 3 = 1 THEN 'Cash' 
        ELSE 'Card' 
    END 
FROM Numbers;
