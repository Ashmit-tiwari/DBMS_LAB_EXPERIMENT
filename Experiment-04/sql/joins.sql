SELECT
    E.emp_id,
    E.emp_name,
    D.dept_name
FROM Employee E
INNER JOIN Department D
    ON E.dept_id = D.dept_id;

SELECT
    D.dept_id,
    D.dept_name,
    E.emp_name
FROM Department D
LEFT JOIN Employee E
    ON D.dept_id = E.dept_id;

SELECT
    E1.emp_name AS Employee1,
    E2.emp_name AS Employee2,
    E1.dept_id
FROM Employee E1
INNER JOIN Employee E2
    ON E1.dept_id = E2.dept_id
    AND E1.emp_id < E2.emp_id;

SELECT
    E.emp_name,
    P.project_name,
    D.dept_name
FROM Employee E
INNER JOIN Project P
    ON E.project_id = P.project_id
INNER JOIN Department D
    ON E.dept_id = D.dept_id;
