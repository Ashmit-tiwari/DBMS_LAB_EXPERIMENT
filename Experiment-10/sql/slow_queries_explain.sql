SELECT COUNT(*) AS Total_Records 
FROM Sales;

SELECT * 
FROM Sales;

EXPLAIN 
SELECT * 
FROM Sales 
WHERE Customer_ID = 150;

SELECT * 
FROM Sales 
WHERE Customer_ID = 150;

EXPLAIN 
SELECT * 
FROM Sales 
WHERE Category = 'Electronics';

SELECT * 
FROM Sales 
WHERE Category = 'Electronics';

EXPLAIN 
SELECT * 
FROM Sales 
WHERE Sale_Date BETWEEN '2026-03-01' AND '2026-06-30';

SELECT * 
FROM Sales 
WHERE Sale_Date BETWEEN '2026-03-01' AND '2026-06-30';

EXPLAIN 
SELECT City, SUM(Total_Amount) AS Total_Sales 
FROM Sales 
GROUP BY City;

SELECT City, SUM(Total_Amount) AS Total_Sales 
FROM Sales 
GROUP BY City;

EXPLAIN 
SELECT * 
FROM Sales 
WHERE Customer_ID = 150 
AND Category = 'Electronics' 
AND Sale_Date >= '2026-03-01';

SELECT * 
FROM Sales 
WHERE Customer_ID = 150 
AND Category = 'Electronics' 
AND Sale_Date >= '2026-03-01';
