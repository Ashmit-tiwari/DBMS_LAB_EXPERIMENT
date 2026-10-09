SELECT emp_name
FROM Employee
WHERE emp_id IN (
    SELECT emp_id
    FROM Employee
    WHERE city = 'Delhi'
)
AND emp_id IN (
    SELECT emp_id
    FROM Employee
    WHERE salary > 60000
);

SELECT emp_name
FROM Employee
WHERE emp_id NOT IN (
    SELECT emp_id
    FROM Employee
    WHERE city = 'Delhi'
);
