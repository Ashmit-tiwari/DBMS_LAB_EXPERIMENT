CALL transfer_employee(1, 2);

SELECT Emp_ID, Emp_Name, Salary, Dept_ID
FROM Employee
WHERE Emp_ID = 1;

UPDATE Employee
SET Salary = 65000.00
WHERE Emp_ID = 1;

SELECT Emp_ID, Emp_Name, Salary, Dept_ID
FROM Employee
WHERE Emp_ID = 1;

SELECT Audit_ID, Emp_ID, Old_Salary, New_Salary, Changed_At
FROM Salary_Audit;
