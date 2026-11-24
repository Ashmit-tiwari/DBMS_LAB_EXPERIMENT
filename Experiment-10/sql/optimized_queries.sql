EXPLAIN 
SELECT * 
FROM Sales 
WHERE Customer_ID = 150;

EXPLAIN 
SELECT * 
FROM Sales 
WHERE Category = 'Electronics';

EXPLAIN 
SELECT * 
FROM Sales 
WHERE Sale_Date BETWEEN '2026-03-01' AND '2026-06-30';

EXPLAIN 
SELECT City, SUM(Total_Amount) AS Total_Sales 
FROM Sales 
GROUP BY City;

EXPLAIN 
SELECT * 
FROM Sales 
WHERE Customer_ID = 150 
AND Category = 'Electronics' 
AND Sale_Date >= '2026-03-01';

SELECT Sale_ID, Customer_ID, Total_Amount 
FROM Sales 
WHERE Customer_ID = 150;

SELECT Category, SUM(Total_Amount) AS Category_Sales 
FROM Sales 
GROUP BY Category;

SELECT Sale_ID, Product_Name, Total_Amount 
FROM Sales 
WHERE Sale_Date >= '2026-03-01' 
AND Sale_Date < '2026-07-01';

SELECT Sale_ID, Customer_Name, Total_Amount 
FROM Sales 
ORDER BY Total_Amount DESC 
LIMIT 10;

SELECT SUM(Total_Amount) AS Total_Revenue 
FROM Sales;

SHOW INDEX FROM Sales;

ANALYZE TABLE Sales;
