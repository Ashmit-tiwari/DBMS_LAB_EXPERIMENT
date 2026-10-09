-- =====================================================================
-- EXPERIMENT 06: Stored Procedure with Validation and Exception Handling
-- Author: Ashmit Tiwari
-- Database: MySQL 8.0+
-- Description: Defines transfer_employee procedure with custom error
--              handling using SIGNAL SQLSTATE '45000'.
-- =====================================================================

DROP PROCEDURE IF EXISTS transfer_employee;

DELIMITER $$

CREATE PROCEDURE transfer_employee(
    IN p_emp_id INT,
    IN p_new_dept_id INT
)
BEGIN
    DECLARE emp_count INT DEFAULT 0;
    DECLARE dept_count INT DEFAULT 0;

    -- Validate employee existence
    SELECT COUNT(*)
    INTO emp_count
    FROM Employee
    WHERE Emp_ID = p_emp_id;

    -- Validate target department existence
    SELECT COUNT(*)
    INTO dept_count
    FROM Department
    WHERE Dept_ID = p_new_dept_id;

    -- Conditional error handling
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

