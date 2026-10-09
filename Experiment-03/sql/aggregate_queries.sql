-- =====================================================================
-- EXPERIMENT 03: Aggregate Queries (GROUP BY, HAVING, Statistical Functions)
-- Author: Ashmit Tiwari
-- Database: MySQL 8.0+
-- Description: Demonstrates aggregate calculations (COUNT, AVG, SUM,
--              MIN, MAX) grouped by department with condition filtering.
-- =====================================================================

-- 1. Department-wise Average Salary
-- Purpose: Calculate average compensation per department using GROUP BY.
SELECT dept_id, AVG(salary) AS avg_salary
FROM Employee
GROUP BY dept_id;

-- 2. Departments with more than 5 employees
-- Purpose: Filter aggregated groups using the HAVING clause.
SELECT dept_id, COUNT(*) AS num_employees
FROM Employee
GROUP BY dept_id
HAVING COUNT(*) > 5;

-- 3. Comprehensive Department-wise Salary Statistics
-- Purpose: Combine multiple aggregate functions (COUNT, SUM, AVG, MIN, MAX).
SELECT
    dept_id,
    COUNT(*) AS total_employees,
    SUM(salary) AS total_payroll,
    AVG(salary) AS average_salary,
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary
FROM Employee
GROUP BY dept_id
ORDER BY dept_id ASC;

