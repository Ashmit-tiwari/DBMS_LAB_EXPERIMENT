DROP VIEW IF EXISTS Department_Salary_Summary;

CREATE VIEW Department_Salary_Summary AS
SELECT
    D.Dept_ID,
    D.Dept_Name,
    COUNT(E.Emp_ID) AS Total_Employees,
    AVG(E.Salary) AS Average_Salary,
    MAX(E.Salary) AS Maximum_Salary,
    MIN(E.Salary) AS Minimum_Salary
FROM Department D
LEFT JOIN Employee E
    ON D.Dept_ID = E.Dept_ID
GROUP BY D.Dept_ID, D.Dept_Name;

SELECT
    Dept_ID,
    Dept_Name,
    Total_Employees,
    Average_Salary,
    Maximum_Salary,
    Minimum_Salary
FROM Department_Salary_Summary;
