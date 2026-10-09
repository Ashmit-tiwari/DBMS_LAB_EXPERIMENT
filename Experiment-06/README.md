# Experiment 06: Stored Procedures with Error Handling and Triggers for Audit Logging

**Author:** Ashmit Tiwari  
**Environment:** MySQL 8.0+ / MySQL Workbench  

---

## 1. Original Aim

To create a stored procedure `transfer_employee(emp_id, new_dept_id)` with validation and error handling, and to implement triggers for salary validation and audit logging, including testing of edge cases.

---

## 2. Problem Statement

Enterprise database management systems must preserve data consistency and enforce business invariants at the database layer rather than relying exclusively on application code. When performing business transactions (such as transferring an employee to a new department or updating employee remuneration), the system must:
- Validate input entity keys before issuing mutations.
- Reject invalid operations with descriptive exception signals (`SQLSTATE '45000'`).
- Validate incoming field invariants (e.g. non-negative salary bounds) via pre-operation hooks (`BEFORE UPDATE`).
- Maintain an immutable, automated audit trail capturing state modifications with timestamps (`AFTER UPDATE`).

---

## 3. Concepts Demonstrated

- **Stored Procedures:** Encapsulating multi-statement business logic on the database server using `CREATE PROCEDURE`.
- **Delimiters in MySQL:** Switching execution statement terminators (`DELIMITER $$`) to define multi-statement routine bodies.
- **Defensive Input Validation:** Pre-querying entity counts (`emp_count`, `dept_count`) to verify foreign references before data modification.
- **Exception Raising via SIGNAL:** Generating user-defined runtime errors via `SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '...'`.
- **BEFORE Triggers:** Intercepting data mutations prior to disk writes to validate business invariants.
- **AFTER Triggers & Audit Logging:** Accessing virtual pseudo-records (`OLD` and `NEW`) upon successful row mutation to populate historical audit tables.

---

## 4. Database Requirements

- **Database Engine:** MySQL Server 8.0+ (or MariaDB 10.5+)
- **SQL Dialect:** MySQL Procedural SQL (Stored Procedures & Triggers)

---

## 5. SQL File Descriptions

| File Name | Purpose |
| :--- | :--- |
| [`sql/schema.sql`](file:///e:/dbms%20files/Experiment-06/sql/schema.sql) | DDL script creating `Department`, `Employee`, and `Salary_Audit` tables. |
| [`sql/insert_data.sql`](file:///e:/dbms%20files/Experiment-06/sql/insert_data.sql) | DML script inserting baseline departments (Sales, Engineering) and test employee. |
| [`sql/procedures.sql`](file:///e:/dbms%20files/Experiment-06/sql/procedures.sql) | Script creating `transfer_employee` stored procedure with defensive error handling. |
| [`sql/triggers.sql`](file:///e:/dbms%20files/Experiment-06/sql/triggers.sql) | Script creating `before_employee_salary_update` and `after_employee_salary_update` triggers. |
| [`sql/test_cases.sql`](file:///e:/dbms%20files/Experiment-06/sql/test_cases.sql) | Comprehensive test suite covering successful runs and commented error edge cases. |

---

## 6. Execution Order

Run the scripts in the following exact sequence:

1. `sql/schema.sql` (Initializes database structure)
2. `sql/insert_data.sql` (Populates seed data)
3. `sql/procedures.sql` (Compiles stored procedure)
4. `sql/triggers.sql` (Compiles validation and audit triggers)
5. `sql/test_cases.sql` (Executes functional and edge-case verifications)

---

## 7. Setup & Execution Instructions

### Using MySQL Command Line Client:

```sql
CREATE DATABASE IF NOT EXISTS dbms_exp06;
USE dbms_exp06;

SOURCE sql/schema.sql;
SOURCE sql/insert_data.sql;
SOURCE sql/procedures.sql;
SOURCE sql/triggers.sql;
SOURCE sql/test_cases.sql;
```

---

## 8. Important Routines & Explanations

### 1. `transfer_employee` Stored Procedure
```sql
DELIMITER $$
CREATE PROCEDURE transfer_employee(
    IN p_emp_id INT,
    IN p_new_dept_id INT
)
BEGIN
    DECLARE emp_count INT DEFAULT 0;
    DECLARE dept_count INT DEFAULT 0;

    SELECT COUNT(*) INTO emp_count FROM Employee WHERE Emp_ID = p_emp_id;
    SELECT COUNT(*) INTO dept_count FROM Department WHERE Dept_ID = p_new_dept_id;

    IF emp_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Employee does not exist';
    ELSEIF dept_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Department does not exist';
    ELSE
        UPDATE Employee
        SET Dept_ID = p_new_dept_id
        WHERE Emp_ID = p_emp_id;
    END IF;
END $$
DELIMITER ;
```
*Purpose:* Safely reassigns an employee to a new department. If either the employee or target department ID does not exist, it aborts execution and raises a descriptive custom exception.

### 2. Validation Trigger (`BEFORE UPDATE`)
```sql
DELIMITER $$
CREATE TRIGGER before_employee_salary_update
BEFORE UPDATE ON Employee
FOR EACH ROW
BEGIN
    IF NEW.Salary < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary cannot be negative';
    END IF;
END $$
DELIMITER ;
```
*Purpose:* Intercepts any salary update statement. If the new value is less than zero, the trigger aborts the operation, preventing invalid data entry.

### 3. Audit Trigger (`AFTER UPDATE`)
```sql
DELIMITER $$
CREATE TRIGGER after_employee_salary_update
AFTER UPDATE ON Employee
FOR EACH ROW
BEGIN
    IF OLD.Salary <> NEW.Salary THEN
        INSERT INTO Salary_Audit (Emp_ID, Old_Salary, New_Salary)
        VALUES (OLD.Emp_ID, OLD.Salary, NEW.Salary);
    END IF;
END $$
DELIMITER ;
```
*Purpose:* Fires automatically after a successful salary modification. If the salary changed, it archives the before-and-after values into `Salary_Audit` along with an automated timestamp.

---

## 9. Expected Test Results & Edge Cases

### Test 1: Department Transfer
- Action: `CALL transfer_employee(1, 2);`
- Result:
  | Emp_ID | Emp_Name | Salary | Dept_ID |
  | :--- | :--- | :--- | :--- |
  | 1 | Alex | 60000.00 | 2 |

### Test 2: Transfer Non-Existent Employee (Edge Case)
- Action: `CALL transfer_employee(999, 2);`
- Output: `ERROR 1644 (45000): Employee does not exist`

### Test 3: Transfer to Non-Existent Department (Edge Case)
- Action: `CALL transfer_employee(1, 999);`
- Output: `ERROR 1644 (45000): Department does not exist`

### Test 4: Negative Salary Update (Edge Case)
- Action: `UPDATE Employee SET Salary = -5000.00 WHERE Emp_ID = 1;`
- Output: `ERROR 1644 (45000): Salary cannot be negative`

### Test 5: Salary Audit Logging
- Action: `UPDATE Employee SET Salary = 65000.00 WHERE Emp_ID = 1;`
- Audit Table Output (`Salary_Audit`):
  | Audit_ID | Emp_ID | Old_Salary | New_Salary | Changed_At |
  | :--- | :--- | :--- | :--- | :--- |
  | 1 | 1 | 60000.00 | 65000.00 | `<Current Timestamp>` |

---

## 10. Learning Outcomes

1. Authored structured procedural routines inside MySQL using custom delimiters and control blocks.
2. Implemented active error interception using `SIGNAL SQLSTATE '45000'`.
3. Designed event-driven validation rules utilizing `BEFORE UPDATE` triggers.
4. Created automated compliance and historical audit mechanisms utilizing `AFTER UPDATE` triggers.

