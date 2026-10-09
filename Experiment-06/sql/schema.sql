-- =====================================================================
-- EXPERIMENT 06: Database Schema Creation
-- Author: Ashmit Tiwari
-- Database: MySQL 8.0+
-- Description: DDL script creating Department, Employee, and
--              Salary_Audit tables for procedural logic and triggers.
-- =====================================================================

DROP TABLE IF EXISTS Salary_Audit;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Department;

-- 1. Department Table
CREATE TABLE Department (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(100) NOT NULL
);

-- 2. Employee Table
CREATE TABLE Employee (
    Emp_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(100) NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL,
    Dept_ID INT,
    FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- 3. Salary Audit Table
-- Purpose: Records historical salary alterations triggered by UPDATE events.
CREATE TABLE Salary_Audit (
    Audit_ID INT AUTO_INCREMENT PRIMARY KEY,
    Emp_ID INT NOT NULL,
    Old_Salary DECIMAL(10, 2) NOT NULL,
    New_Salary DECIMAL(10, 2) NOT NULL,
    Changed_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

