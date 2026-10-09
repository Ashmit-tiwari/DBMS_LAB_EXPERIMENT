-- =====================================================================
-- EXPERIMENT 06: Test Cases and Edge-Case Demonstrations
-- Author: Ashmit Tiwari
-- Database: MySQL 8.0+
-- Description: Test suite verifying procedure transfer execution,
--              error signal triggers, and audit logging.
-- =====================================================================

-- ---------------------------------------------------------------------
-- TEST 1: Valid Employee Department Transfer
-- Expected: Alex's Dept_ID changes from 1 (Sales) to 2 (Engineering).
-- ---------------------------------------------------------------------
CALL transfer_employee(1, 2);

-- Verify transfer
SELECT Emp_ID, Emp_Name, Salary, Dept_ID
FROM Employee
WHERE Emp_ID = 1;


-- ---------------------------------------------------------------------
-- TEST 2: Edge Case - Transfer Non-Existent Employee
-- Expected Error: 1644 (45000): Employee does not exist
-- (Uncomment to execute and observe engine exception)
-- ---------------------------------------------------------------------
-- CALL transfer_employee(999, 2);


-- ---------------------------------------------------------------------
-- TEST 3: Edge Case - Transfer to Non-Existent Department
-- Expected Error: 1644 (45000): Department does not exist
-- (Uncomment to execute and observe engine exception)
-- ---------------------------------------------------------------------
-- CALL transfer_employee(1, 999);


-- ---------------------------------------------------------------------
-- TEST 4: Edge Case - Validation Trigger Blocking Negative Salary
-- Expected Error: 1644 (45000): Salary cannot be negative
-- (Uncomment to execute and observe engine exception)
-- ---------------------------------------------------------------------
-- UPDATE Employee SET Salary = -5000.00 WHERE Emp_ID = 1;


-- ---------------------------------------------------------------------
-- TEST 5: Valid Salary Update & Audit Logging
-- Expected:
--   1. Employee table updates Alex's salary to 65000.00.
--   2. after_employee_salary_update trigger logs Old_Salary=60000.00,
--      New_Salary=65000.00 to Salary_Audit table.
-- ---------------------------------------------------------------------
UPDATE Employee
SET Salary = 65000.00
WHERE Emp_ID = 1;

-- Verify Employee Record
SELECT Emp_ID, Emp_Name, Salary, Dept_ID
FROM Employee
WHERE Emp_ID = 1;

-- Verify Audit Trail
SELECT Audit_ID, Emp_ID, Old_Salary, New_Salary, Changed_At
FROM Salary_Audit;

