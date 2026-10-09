-- =====================================================================
-- EXPERIMENT 03: Basic SQL Queries (Selection, Projection, Sorting)
-- Author: Ashmit Tiwari
-- Database: MySQL 8.0+
-- Description: Demonstrates basic relational querying using SELECT,
--              WHERE filtering, and ORDER BY clauses.
-- =====================================================================

-- 1. Selection: Retrieve all employees located in 'Delhi'
-- Purpose: Demonstrates horizontal filtering using the WHERE clause.
SELECT emp_id, emp_name, dept_id, project_id, salary, city
FROM Employee
WHERE city = 'Delhi';

-- 2. Projection: Retrieve only employee names and their salaries
-- Purpose: Demonstrates vertical subsetting (projection) of attributes.
SELECT emp_name, salary
FROM Employee;

-- 3. Sorting: Retrieve employee name, department ID, and salary ordered by salary descending
-- Purpose: Demonstrates ordering results using ORDER BY with DESC keyword.
SELECT emp_name, dept_id, salary
FROM Employee
ORDER BY salary DESC;

