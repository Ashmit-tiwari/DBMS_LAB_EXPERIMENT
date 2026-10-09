# Database Setup and Execution Guide

**Author:** Ashmit Tiwari  
**Target Environment:** MySQL Server 8.0+ / MySQL Workbench 8.0 CE  

This guide provides instructions for setting up the local MySQL environment, configuring the command-line interface, executing laboratory experiment scripts in correct sequence, and troubleshooting common database engine issues.

---

## 1. Required Database Software

To replicate and execute the laboratory experiments contained in this repository, ensure the following software is installed:

- **MySQL Community Server 8.0+**: The core relational database engine supporting ANSI SQL, Window functions, Recursive Common Table Expressions (CTEs), Stored Procedures, and Triggers.
- **MySQL Workbench 8.0 CE** (Optional GUI): Visual database design, query construction, and administration tool.
- **MySQL Command Line Client (`mysql`)**: Official CLI utility for executing script files.

---

## 2. Environment Configuration on Windows

### Verifying MySQL Service
Ensure the MySQL Windows service is active:
```powershell
Get-Service *mysql*
```
If stopped, start the service using:
```powershell
Start-Service MySQL80
```

### Adding MySQL to System PATH
To execute `mysql` directly from PowerShell or Command Prompt, add the MySQL binary folder to your system environment variables:
```
C:\Program Files\MySQL\MySQL Server 8.0\bin
```
Verify the installation by running:
```bash
mysql --version
```

---

## 3. Database Creation & User Privileges

Open the MySQL command line client with administrative privileges:

```bash
mysql -u root -p
```
Enter your MySQL root password when prompted.

Create a sandbox database for each experiment or a unified laboratory workspace:
```sql
CREATE DATABASE IF NOT EXISTS dbms_lab CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE dbms_lab;
```

---

## 4. Script Execution Order

Always execute scripts in strict dependency order:

1. **Schema Definition (`schema.sql`):** Creates base tables with primary and foreign key constraints.
2. **Data Insertion (`insert_data.sql`):** Populates parental entities first (e.g. `Department`), followed by child entities (e.g. `Project`, `Employee`).
3. **Queries & Advanced Routines (`*.sql`):** Executes views, joins, procedures, triggers, and query analysis scripts.

### Execution via MySQL CLI (Recommended)

Navigate to the repository folder in your terminal and invoke `mysql` using the `SOURCE` command:

```sql
-- Example for Experiment 03:
USE dbms_lab;
SOURCE Experiment-03/sql/schema.sql;
SOURCE Experiment-03/sql/insert_data.sql;
SOURCE Experiment-03/sql/basic_queries.sql;
SOURCE Experiment-03/sql/aggregate_queries.sql;
SOURCE Experiment-03/sql/case_queries.sql;
SOURCE Experiment-03/sql/advanced_queries.sql;
```

Alternatively, pass scripts directly from PowerShell/Bash:
```powershell
Get-Content Experiment-03/sql/schema.sql | mysql -u root -p dbms_lab
```

### Execution via MySQL Workbench
1. Launch MySQL Workbench and connect to your local MySQL instance (`localhost:3306`).
2. Set the default schema by executing `USE dbms_lab;`.
3. Go to **File -> Open SQL Script...** and select the target script.
4. Execute via **Query -> Execute (All or Selection)** or press `Ctrl + Shift + Enter`.

---

## 5. Verifying Schema & Records

Verify table creation:
```sql
SHOW TABLES;
```

Inspect table definitions and data types:
```sql
DESCRIBE Department;
DESCRIBE Project;
DESCRIBE Employee;
```

Verify row counts after data insertion:
```sql
SELECT 'Department' AS Table_Name, COUNT(*) AS Record_Count FROM Department
UNION ALL
SELECT 'Project', COUNT(*) FROM Project
UNION ALL
SELECT 'Employee', COUNT(*) FROM Employee;
```

---

## 6. Common SQL Errors & Troubleshooting

| Error Code | Error Message | Root Cause & Resolution |
| :--- | :--- | :--- |
| **ERROR 1045 (28000)** | Access denied for user 'root'@'localhost' | Incorrect credentials. Verify password or check local authentication plugins. |
| **ERROR 1046 (3D000)** | No database selected | Attempted to run DDL/DML before selecting a database. Execute `USE <database_name>;` first. |
| **ERROR 1064 (42000)** | You have an error in your SQL syntax | Typically caused by omitting `DELIMITER $$` when compiling stored procedures or triggers in CLI. |
| **ERROR 1451 / 1452** | Cannot add or update a child row: a foreign key constraint fails | Referential integrity violation. Ensure parent rows (Department) exist before inserting referencing child rows (Employee). |
| **ERROR 1062 (23000)** | Duplicate entry '...' for key 'PRIMARY' | Primary key uniqueness violation. Verify that identifier keys do not collide. |
| **ERROR 1644 (45000)** | User-defined custom error message | Custom business rule exception raised intentionally by `SIGNAL SQLSTATE '45000'` in procedures/triggers (e.g. negative salary check). |

