-- =====================================================================
-- EXPERIMENT 05: Data Insertion
-- Author: Ashmit Tiwari
-- Database: MySQL 8.0+
-- Description: DML script inserting 5 departments and 30 employees
--              with job titles and baseline salary values.
-- =====================================================================

-- 1. Insert Departments (5 Departments)
INSERT INTO Department (Dept_ID, Dept_Name) VALUES
(1, 'Engineering'),
(2, 'Sales'),
(3, 'Human Resources'),
(4, 'Finance'),
(5, 'Operations');

-- 2. Insert Employees (30 Employees)
INSERT INTO Employee (Emp_ID, Emp_Name, Job_Title, Salary, Dept_ID) VALUES
(1, 'Ava Patel', 'Developer', 60000.00, 1),
(2, 'Liam Chen', 'Developer', 62000.00, 1),
(3, 'Mia Garcia', 'Analyst', 58000.00, 1),
(4, 'Noah Smith', 'Engineering Manager', 85000.00, 1),
(5, 'Olivia Jones', 'Developer', 61000.00, 1),
(6, 'Ethan Brown', 'Analyst', 59000.00, 1),
(7, 'Sophia Wilson', 'Sales Representative', 52000.00, 2),
(8, 'Lucas Davis', 'Sales Representative', 54000.00, 2),
(9, 'Amelia Miller', 'Sales Manager', 78000.00, 2),
(10, 'James Taylor', 'Sales Representative', 51000.00, 2),
(11, 'Isabella Anderson', 'Sales Representative', 53000.00, 2),
(12, 'Benjamin Thomas', 'Sales Representative', 55000.00, 2),
(13, 'Charlotte Moore', 'HR Specialist', 57000.00, 3),
(14, 'Elijah Martin', 'HR Specialist', 56000.00, 3),
(15, 'Harper Lee', 'Recruiter', 59000.00, 3),
(16, 'Daniel White', 'HR Manager', 80000.00, 3),
(17, 'Evelyn Harris', 'HR Specialist', 58000.00, 3),
(18, 'Henry Clark', 'Recruiter', 60000.00, 3),
(19, 'Abigail Lewis', 'Accountant', 63000.00, 4),
(20, 'Sebastian Walker', 'Accountant', 64000.00, 4),
(21, 'Emily Hall', 'Finance Manager', 88000.00, 4),
(22, 'Jack Allen', 'Accountant', 65000.00, 4),
(23, 'Ella Young', 'Financial Analyst', 67000.00, 4),
(24, 'Owen King', 'Financial Analyst', 66000.00, 4),
(25, 'Grace Wright', 'Operations Specialist', 55000.00, 5),
(26, 'Matthew Scott', 'Operations Specialist', 56000.00, 5),
(27, 'Chloe Green', 'Operations Manager', 82000.00, 5),
(28, 'Wyatt Baker', 'Operations Specialist', 57000.00, 5),
(29, 'Lily Adams', 'Coordinator', 52000.00, 5),
(30, 'Gabriel Nelson', 'Coordinator', 54000.00, 5);

