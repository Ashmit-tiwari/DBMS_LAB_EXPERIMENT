-- =====================================================================
-- EXPERIMENT 05: Database Views (Department Salary Summary)
-- Author: Ashmit Tiwari
-- Database: MySQL 8.0+
-- Description: Creates and queries the Department_Salary_Summary view
--              to encapsulate department-level compensation analytics.
-- =====================================================================

-- Drop view if exists
DROP VIEW IF EXISTS Department_Salary_Summary;

-- 1. Create View: Department_Salary_Summary
-- Purpose: Aggregates employee compensation metrics grouped by department.
-- Note: Views containing aggregation functions (COUNT, AVG, MIN, MAX) or GROUP BY
--       are non-updatable views in MySQL according to SQL standards.
CREATE VIEW Department_Salary_Summary AS
SELECT
    D.Dept_ID,
    D.Dept_Name,
    COUNT(E.Emp_ID) AS Total_Employees,
    AVG(E.Salary) AS Average_Salary,
    MAX(E.Salary) AS Maximum_Salary,
    MIN(E.Salary) AS Minimum_Salary
FROM Department D
LEFT JOIN Employee E
    ON D.Dept_ID = E.Dept_ID
GROUP BY D.Dept_ID, D.Dept_Name;

-- 2. Query the Summary View
SELECT
    Dept_ID,
    Dept_Name,
    Total_Employees,
    Average_Salary,
    Maximum_Salary,
    Minimum_Salary
FROM Department_Salary_Summary;

