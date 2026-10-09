EXPLAIN
SELECT E.emp_name, D.dept_name
FROM Employee E
INNER JOIN Department D
    ON E.dept_id = D.dept_id;

EXPLAIN
SELECT D.dept_name, E.emp_name
FROM Department D
LEFT JOIN Employee E
    ON D.dept_id = E.dept_id;

EXPLAIN
SELECT E.emp_name, E.salary
FROM Employee E
WHERE E.salary > (
    SELECT AVG(E2.salary)
    FROM Employee E2
    WHERE E2.dept_id = E.dept_id
);

EXPLAIN
SELECT E.emp_name
FROM Employee E
WHERE EXISTS (
    SELECT 1
    FROM Project P
    WHERE P.dept_id = E.dept_id
);
