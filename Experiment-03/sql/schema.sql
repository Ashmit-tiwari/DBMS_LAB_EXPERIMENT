-- =====================================================================
-- EXPERIMENT 03: Database Schema Creation
-- Author: Ashmit Tiwari
-- Database: MySQL 8.0+
-- Description: DDL script creating Department, Project, and Employee
--              tables with primary and foreign key constraints.
-- =====================================================================

-- Drop existing tables in reverse dependency order to prevent FK errors
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Project;
DROP TABLE IF EXISTS Department;

-- 1. Department Table
CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

-- 2. Project Table
CREATE TABLE Project (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50) NOT NULL,
    dept_id INT NOT NULL,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- 3. Employee Table
CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    dept_id INT NOT NULL,
    project_id INT NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    city VARCHAR(50) NOT NULL,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (project_id) REFERENCES Project(project_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

