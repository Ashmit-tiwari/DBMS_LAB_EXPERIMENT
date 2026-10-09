-- =====================================================================
-- EXPERIMENT 04: Relational Joins (INNER, LEFT, Self, and 3-Way Joins)
-- Author: Ashmit Tiwari
-- Database: MySQL 8.0+
-- Description: Demonstrates joining relational tables using diverse
--              join predicates across primary and foreign key boundaries.
-- =====================================================================

-- 1. INNER JOIN: Employee and Department
-- Purpose: Match each employee with their corresponding department name.
SELECT
    E.emp_id,
    E.emp_name,
    D.dept_name
FROM Employee E
INNER JOIN Department D
    ON E.dept_id = D.dept_id;

-- 2. LEFT JOIN: Department and Employee
-- Purpose: Preserve all departments even if no employees are assigned.
SELECT
    D.dept_id,
    D.dept_name,
    E.emp_name
FROM Department D
LEFT JOIN Employee E
    ON D.dept_id = E.dept_id;

-- 3. Self-Join: Co-workers within the same department
-- Purpose: Match distinct pairs of employees sharing the same department.
-- Note: 'E1.emp_id < E2.emp_id' prevents reflexive pairing and duplicate reversed pairs.
SELECT
    E1.emp_name AS Employee1,
    E2.emp_name AS Employee2,
    E1.dept_id
FROM Employee E1
INNER JOIN Employee E2
    ON E1.dept_id = E2.dept_id
    AND E1.emp_id < E2.emp_id;

-- 4. 3-Way Join: Employee, Project, and Department
-- Purpose: Combine employee records with both assigned project and governing department.
SELECT
    E.emp_name,
    P.project_name,
    D.dept_name
FROM Employee E
INNER JOIN Project P
    ON E.project_id = P.project_id
INNER JOIN Department D
    ON E.dept_id = D.dept_id;

