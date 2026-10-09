-- =====================================================================
-- EXPERIMENT 04: Database Schema Creation
-- Author: Ashmit Tiwari
-- Database: MySQL 8.0+
-- Description: DDL script creating Department, Project, and Employee
--              tables for join and subquery analysis.
-- =====================================================================

DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Project;
DROP TABLE IF EXISTS Department;

CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

CREATE TABLE Project (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50) NOT NULL,
    dept_id INT NOT NULL,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

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

