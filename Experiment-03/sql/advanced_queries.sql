-- =====================================================================
-- EXPERIMENT 03: Optional Advanced Query Extensions
-- Author: Ashmit Tiwari
-- Database: MySQL 8.0+
-- Description: Advanced analytical queries extending core Experiment 3
--              requirements with joins, subqueries, and reporting aggregations.
-- =====================================================================

-- 1. INNER JOIN: Employee with Department
-- Purpose: Display employee details with resolved department names.
SELECT
    E.emp_id,
    E.emp_name,
    D.dept_name,
    E.salary,
    E.city
FROM Employee E
INNER JOIN Department D
    ON E.dept_id = D.dept_id
ORDER BY E.emp_id ASC;

-- 2. Department-wise Summary Report with LEFT JOIN
-- Purpose: Produce a comprehensive department head-count and payroll summary.
SELECT
    D.dept_id,
    D.dept_name,
    COUNT(E.emp_id) AS total_employees,
    COALESCE(AVG(E.salary), 0) AS average_salary,
    COALESCE(SUM(E.salary), 0) AS total_payroll
FROM Department D
LEFT JOIN Employee E
    ON D.dept_id = E.dept_id
GROUP BY D.dept_id, D.dept_name
ORDER BY D.dept_id ASC;

-- 3. Project-wise Employee Allocation Report
-- Purpose: Count how many employees are assigned to each project.
SELECT
    P.project_id,
    P.project_name,
    D.dept_name,
    COUNT(E.emp_id) AS assigned_employees
FROM Project P
INNER JOIN Department D
    ON P.dept_id = D.dept_id
LEFT JOIN Employee E
    ON P.project_id = E.project_id
GROUP BY P.project_id, P.project_name, D.dept_name
ORDER BY P.project_id ASC;

-- 4. Subquery: Employees Earning Above Department Average Salary
-- Purpose: Identify top earners relative to their peers in the same department.
SELECT
    E.emp_id,
    E.emp_name,
    E.dept_id,
    E.salary
FROM Employee E
WHERE E.salary > (
    SELECT AVG(E2.salary)
    FROM Employee E2
    WHERE E2.dept_id = E.dept_id
)
ORDER BY E.dept_id, E.salary DESC;

