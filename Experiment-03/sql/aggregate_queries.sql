SELECT dept_id, AVG(salary) AS avg_salary
FROM Employee
GROUP BY dept_id;

SELECT dept_id, COUNT(*) AS num_employees
FROM Employee
GROUP BY dept_id
HAVING COUNT(*) > 5;

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
