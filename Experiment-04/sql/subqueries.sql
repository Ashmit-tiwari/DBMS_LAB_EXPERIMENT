-- =====================================================================
-- EXPERIMENT 04: Subqueries and EXISTS Operators
-- Author: Ashmit Tiwari
-- Database: MySQL 8.0+
-- Description: Demonstrates correlated subqueries and the EXISTS
--              predicate evaluated iteratively against outer tuples.
-- =====================================================================

-- 1. Correlated Subquery: Employees earning above departmental average salary
-- Purpose: For each outer employee row E, dynamically calculate the average
--          salary of their specific department in subquery E2 and compare.
SELECT
    E.emp_name,
    E.dept_id,
    E.salary
FROM Employee E
WHERE E.salary > (
    SELECT AVG(E2.salary)
    FROM Employee E2
    WHERE E2.dept_id = E.dept_id
);

-- 2. EXISTS Operator: Employees whose department has at least one associated project
-- Purpose: Evaluate existence of child rows in the Project table matching E.dept_id.
SELECT
    E.emp_id,
    E.emp_name,
    E.dept_id
FROM Employee E
WHERE EXISTS (
    SELECT 1
    FROM Project P
    WHERE P.dept_id = E.dept_id
);

