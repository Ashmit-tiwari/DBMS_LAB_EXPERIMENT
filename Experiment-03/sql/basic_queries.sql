SELECT emp_id, emp_name, dept_id, project_id, salary, city
FROM Employee
WHERE city = 'Delhi';

SELECT emp_name, salary
FROM Employee;

SELECT emp_name, dept_id, salary
FROM Employee
ORDER BY salary DESC;
