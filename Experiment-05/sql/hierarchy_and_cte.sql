ALTER TABLE Employee
ADD Manager_ID INT NULL;

ALTER TABLE Employee
ADD CONSTRAINT FK_Employee_Manager
FOREIGN KEY (Manager_ID) REFERENCES Employee(Emp_ID)
ON UPDATE CASCADE
ON DELETE SET NULL;

UPDATE Employee SET Manager_ID = 4 WHERE Emp_ID IN (1, 2, 3, 5, 6);

UPDATE Employee SET Manager_ID = 9 WHERE Emp_ID IN (7, 8, 10, 11, 12);

UPDATE Employee SET Manager_ID = 16 WHERE Emp_ID IN (13, 14, 15, 17, 18);

UPDATE Employee SET Manager_ID = 21 WHERE Emp_ID IN (19, 20, 22, 23, 24);

UPDATE Employee SET Manager_ID = 27 WHERE Emp_ID IN (25, 26, 28, 29, 30);

DROP VIEW IF EXISTS Employee_Hierarchy;

CREATE VIEW Employee_Hierarchy AS
SELECT
    E.Emp_ID,
    E.Emp_Name,
    E.Job_Title,
    E.Salary,
    E.Manager_ID,
    M.Emp_Name AS Manager_Name
FROM Employee E
LEFT JOIN Employee M
    ON E.Manager_ID = M.Emp_ID;

SELECT * FROM Employee_Hierarchy;

UPDATE Employee
SET Salary = 63000.00
WHERE Emp_ID = 1;

SELECT Emp_ID, Emp_Name, Salary
FROM Employee
WHERE Emp_ID = 1;

SELECT *
FROM Employee_Hierarchy
WHERE Emp_ID = 1;

WITH RECURSIVE Employee_Chain AS (
    SELECT
        Emp_ID,
        Emp_Name,
        Manager_ID,
        1 AS Level
    FROM Employee
    WHERE Manager_ID IS NULL

    UNION ALL

    SELECT
        E.Emp_ID,
        E.Emp_Name,
        E.Manager_ID,
        EC.Level + 1
    FROM Employee E
    INNER JOIN Employee_Chain EC
        ON E.Manager_ID = EC.Emp_ID
)
SELECT
    Emp_ID,
    Emp_Name,
    Manager_ID,
    Level
FROM Employee_Chain
ORDER BY Level ASC, Emp_ID ASC;
