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
