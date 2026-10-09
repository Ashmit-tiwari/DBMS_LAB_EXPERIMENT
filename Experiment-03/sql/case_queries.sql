SELECT
    emp_name,
    salary,
    CASE
        WHEN salary < 50000 THEN 'Low'
        WHEN salary BETWEEN 50000 AND 60000 THEN 'Medium'
        ELSE 'High'
    END AS salary_category
FROM Employee;

SELECT
    CASE
        WHEN salary < 50000 THEN 'Low'
        WHEN salary BETWEEN 50000 AND 60000 THEN 'Medium'
        ELSE 'High'
    END AS salary_category,
    COUNT(*) AS total_employees,
    AVG(salary) AS avg_bracket_salary
FROM Employee
GROUP BY salary_category
ORDER BY avg_bracket_salary ASC;
