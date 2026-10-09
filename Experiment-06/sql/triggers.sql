-- =====================================================================
-- EXPERIMENT 06: Database Triggers (Validation and Audit Logging)
-- Author: Ashmit Tiwari
-- Database: MySQL 8.0+
-- Description: Defines BEFORE UPDATE trigger to prevent negative salaries
--              and AFTER UPDATE trigger to maintain Salary_Audit trail.
-- =====================================================================

DROP TRIGGER IF EXISTS before_employee_salary_update;
DROP TRIGGER IF EXISTS after_employee_salary_update;

-- 1. Validation Trigger: Prevent negative salary updates
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


-- 2. Audit Logging Trigger: Record salary change events
DELIMITER $$

CREATE TRIGGER after_employee_salary_update
AFTER UPDATE ON Employee
FOR EACH ROW
BEGIN
    IF OLD.Salary <> NEW.Salary THEN
        INSERT INTO Salary_Audit (
            Emp_ID,
            Old_Salary,
            New_Salary
        )
        VALUES (
            OLD.Emp_ID,
            OLD.Salary,
            NEW.Salary
        );
    END IF;
END $$

DELIMITER ;

