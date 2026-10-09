-- =====================================================================
-- EXPERIMENT 06: Data Insertion
-- Author: Ashmit Tiwari
-- Database: MySQL 8.0+
-- Description: DML script populating benchmark department and employee
--              records for procedure and trigger execution testing.
-- =====================================================================

-- Insert Departments
INSERT INTO Department (Dept_ID, Dept_Name) VALUES
(1, 'Sales'),
(2, 'Engineering');

-- Insert Initial Employee Record
INSERT INTO Employee (Emp_ID, Emp_Name, Salary, Dept_ID) VALUES
(1, 'Alex', 60000.00, 1);

