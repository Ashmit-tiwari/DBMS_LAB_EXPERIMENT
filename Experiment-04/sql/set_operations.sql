-- =====================================================================
-- EXPERIMENT 04: Simulated and ANSI Set Operations
-- Author: Ashmit Tiwari
-- Database: MySQL 8.0+
-- Description: Demonstrates set intersection and set difference.
--              Presents both simulated subquery patterns (backward-compatible)
--              and native ANSI SQL set operators.
-- =====================================================================

-- 1. Simulated INTERSECT: Employees in Delhi earning > 60,000
-- Method: Nested subqueries with compound 'IN' predicates simulating set intersection.
SELECT emp_name
FROM Employee
WHERE emp_id IN (
    SELECT emp_id
    FROM Employee
    WHERE city = 'Delhi'
)
AND emp_id IN (
    SELECT emp_id
    FROM Employee
    WHERE salary > 60000
);

-- Alternative Native MySQL 8.0.31+ INTERSECT:
-- SELECT emp_name FROM Employee WHERE city = 'Delhi'
-- INTERSECT
-- SELECT emp_name FROM Employee WHERE salary > 60000;


-- 2. Simulated EXCEPT (Set Difference): Employees NOT located in Delhi
-- Method: Subquery with 'NOT IN' predicate simulating set difference (All - Delhi).
SELECT emp_name
FROM Employee
WHERE emp_id NOT IN (
    SELECT emp_id
    FROM Employee
    WHERE city = 'Delhi'
);

-- Alternative Native MySQL 8.0.31+ EXCEPT:
-- SELECT emp_name FROM Employee
-- EXCEPT
-- SELECT emp_name FROM Employee WHERE city = 'Delhi';

