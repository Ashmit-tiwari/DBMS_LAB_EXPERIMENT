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
