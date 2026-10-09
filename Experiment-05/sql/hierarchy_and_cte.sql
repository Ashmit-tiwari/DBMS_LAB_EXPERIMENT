-- =====================================================================
-- EXPERIMENT 05: Organizational Hierarchy, View Updatability, & Recursive CTE
-- Author: Ashmit Tiwari
-- Database: MySQL 8.0+
-- Description: Alters schema to model self-referencing reporting lines,
--              creates an Employee_Hierarchy view, demonstrates view
--              updatability concepts, and executes a recursive CTE.
-- =====================================================================

-- 1. Schema Alteration: Add Self-Referencing Manager_ID Column & Foreign Key
ALTER TABLE Employee
ADD Manager_ID INT NULL;

ALTER TABLE Employee
ADD CONSTRAINT FK_Employee_Manager
FOREIGN KEY (Manager_ID) REFERENCES Employee(Emp_ID)
ON UPDATE CASCADE
ON DELETE SET NULL;

-- 2. Populate Manager Hierarchy Relationships
-- Engineering Manager: Noah Smith (Emp_ID: 4)
UPDATE Employee SET Manager_ID = 4 WHERE Emp_ID IN (1, 2, 3, 5, 6);

-- Sales Manager: Amelia Miller (Emp_ID: 9)
UPDATE Employee SET Manager_ID = 9 WHERE Emp_ID IN (7, 8, 10, 11, 12);

-- HR Manager: Daniel White (Emp_ID: 16)
UPDATE Employee SET Manager_ID = 16 WHERE Emp_ID IN (13, 14, 15, 17, 18);

-- Finance Manager: Emily Hall (Emp_ID: 21)
UPDATE Employee SET Manager_ID = 21 WHERE Emp_ID IN (19, 20, 22, 23, 24);

-- Operations Manager: Chloe Green (Emp_ID: 27)
UPDATE Employee SET Manager_ID = 27 WHERE Emp_ID IN (25, 26, 28, 29, 30);

-- 3. Create Hierarchical View: Employee_Hierarchy
DROP VIEW IF EXISTS Employee_Hierarchy;

CREATE VIEW Employee_Hierarchy AS
SELECT
    E.Emp_ID,
    E.Emp_Name,
    E.Job_Title,
    E.Salary,
    E.Manager_ID,
    M.Emp_Name AS Manager_Name
FROM Employee E
LEFT JOIN Employee M
    ON E.Manager_ID = M.Emp_ID;

-- Query the hierarchical view
SELECT * FROM Employee_Hierarchy;

-- 4. Testing View Updatability
-- Theoretical Rule:
--   - Simple views pointing to a single table without aggregates or GROUP BY are updatable.
--   - Aggregate views (like Department_Salary_Summary) are structurally read-only in MySQL.
-- Here we test modifying the underlying base table and observe automatic reflection in the view.
UPDATE Employee
SET Salary = 63000.00
WHERE Emp_ID = 1;

-- Verify updated value in base table and views
SELECT Emp_ID, Emp_Name, Salary
FROM Employee
WHERE Emp_ID = 1;

SELECT *
FROM Employee_Hierarchy
WHERE Emp_ID = 1;

-- 5. Recursive Common Table Expression (CTE): Organizational Reporting Chain
-- Computes the reporting depth (Level 1 for top managers, Level 2 for direct reports)
WITH RECURSIVE Employee_Chain AS (
    -- Anchor Member: Root managers having no superior (Manager_ID IS NULL)
    SELECT
        Emp_ID,
        Emp_Name,
        Manager_ID,
        1 AS Level
    FROM Employee
    WHERE Manager_ID IS NULL

    UNION ALL

    -- Recursive Member: Subordinates whose Manager_ID links to an already identified node
    SELECT
        E.Emp_ID,
        E.Emp_Name,
        E.Manager_ID,
        EC.Level + 1
    FROM Employee E
    INNER JOIN Employee_Chain EC
        ON E.Manager_ID = EC.Emp_ID
)
SELECT
    Emp_ID,
    Emp_Name,
    Manager_ID,
    Level
FROM Employee_Chain
ORDER BY Level ASC, Emp_ID ASC;

