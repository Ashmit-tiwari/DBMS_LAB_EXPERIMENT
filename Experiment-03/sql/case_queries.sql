-- =====================================================================
-- EXPERIMENT 03: Conditional Expressions (CASE Queries)
-- Author: Ashmit Tiwari
-- Database: MySQL 8.0+
-- Description: Demonstrates conditional attribute evaluation using
--              CASE expressions to categorize employee salaries.
-- =====================================================================

-- 1. Employee Salary Categorization
-- Purpose: Categorize each employee's salary into 'Low', 'Medium', or 'High'.
-- Thresholds:
--   - Low: < 50,000
--   - Medium: 50,000 to 60,000
--   - High: > 60,000
SELECT
    emp_name,
    salary,
    CASE
        WHEN salary < 50000 THEN 'Low'
        WHEN salary BETWEEN 50000 AND 60000 THEN 'Medium'
        ELSE 'High'
    END AS salary_category
FROM Employee;

-- 2. Distribution Summary of Salary Categories
-- Purpose: Group employees by their evaluated CASE category to assess payroll brackets.
SELECT
    CASE
        WHEN salary < 50000 THEN 'Low'
        WHEN salary BETWEEN 50000 AND 60000 THEN 'Medium'
        ELSE 'High'
    END AS salary_category,
    COUNT(*) AS total_employees,
    AVG(salary) AS avg_bracket_salary
FROM Employee
GROUP BY salary_category
ORDER BY avg_bracket_salary ASC;

