# Experiment 05: Database Views, View Updatability, and Recursive Common Table Expressions (CTEs)

**Author:** ASHMIT TIWARI  
**Environment:** MySQL 8.0+ / MySQL Workbench  

---

## 1. Original Aim

To create SQL views for department salary summary and employee hierarchy, test the updatability of views, and implement a recursive CTE to display reporting chains.

---

## 2. Problem Statement

Modern database architectures rely on abstraction layers to isolate applications from underlying relational complexities, secure sensitive fields, and encapsulate precomputed aggregations. Furthermore, real-world corporate data frequently contains recursive graph-like relationships (such as organizational management hierarchies) that cannot be cleanly traversed using static joins.

This experiment tackles these challenges by:
- Defining aggregate views (`Department_Salary_Summary`) for departmental payroll indicators.
- Altering the relational schema to introduce self-referential foreign keys (`Manager_ID`).
- Creating joined projection views (`Employee_Hierarchy`) to resolve manager designations.
- Analyzing the SQL standards and engine rules governing view updatability.
- Formulating a recursive Common Table Expression (`WITH RECURSIVE`) to systematically traverse employee reporting trees and compute hierarchy levels.

---

## 3. Concepts Demonstrated

- **Virtual Tables (Views):** Encapsulation of complex queries via `CREATE VIEW`.
- **Aggregate Summary Views:** Combining `LEFT JOIN`, `GROUP BY`, and aggregate functions within a persisted view definition.
- **Self-Referential Integrity:** Adding a nullable foreign key column (`Manager_ID`) pointing back to the same table's primary key (`Emp_ID`).
- **View Updatability Constraints:**
  - *Updatable views:* Simple 1-to-1 table projections without groupings.
  - *Non-updatable views:* Views involving `GROUP BY`, aggregate functions (`AVG`, `SUM`, `COUNT`), `UNION`, or `DISTINCT`.
- **Recursive CTEs:** Designing recursive graph queries composed of an **Anchor Member** (root elements where `Manager_ID IS NULL`) and a **Recursive Member** (`INNER JOIN` resolving successive hierarchical levels).

---

## 4. Database Requirements

- **Database Engine:** MySQL Server 8.0+ (MySQL 8.0 is strictly required for `WITH RECURSIVE` CTE support).
- **SQL Dialect:** MySQL 8.0 SQL.

---

## 5. SQL File Descriptions

| File Name | Purpose |
| :--- | :--- |
| [`sql/schema.sql`](file:///e:/dbms%20files/Experiment-05/sql/schema.sql) | DDL script creating base `Department` and `Employee` tables. |
| [`sql/insert_data.sql`](file:///e:/dbms%20files/Experiment-05/sql/insert_data.sql) | DML script inserting 5 departments and 30 benchmark employee records. |
| [`sql/views.sql`](file:///e:/dbms%20files/Experiment-05/sql/views.sql) | Script creating and querying the `Department_Salary_Summary` view. |
| [`sql/hierarchy_and_cte.sql`](file:///e:/dbms%20files/Experiment-05/sql/hierarchy_and_cte.sql) | Script adding `Manager_ID`, setting hierarchy, creating `Employee_Hierarchy` view, testing updatability, and executing recursive CTE. |

---

## 6. Execution Order

Run the scripts in the following exact sequence:

1. `sql/schema.sql` (Creates base schema)
2. `sql/insert_data.sql` (Populates seed data)
3. `sql/views.sql` (Creates and queries summary view)
4. `sql/hierarchy_and_cte.sql` (Alters schema, builds hierarchy view, and runs recursive CTE)

---

## 7. Setup & Execution Instructions

### Using MySQL Command Line Client:

```sql
CREATE DATABASE IF NOT EXISTS dbms_exp05;
USE dbms_exp05;

SOURCE sql/schema.sql;
SOURCE sql/insert_data.sql;
SOURCE sql/views.sql;
SOURCE sql/hierarchy_and_cte.sql;
```

---

## 8. Important Queries & Explanations

### 1. Department Salary Summary View
```sql
CREATE VIEW Department_Salary_Summary AS
SELECT
    D.Dept_ID,
    D.Dept_Name,
    COUNT(E.Emp_ID) AS Total_Employees,
    AVG(E.Salary) AS Average_Salary,
    MAX(E.Salary) AS Maximum_Salary,
    MIN(E.Salary) AS Minimum_Salary
FROM Department D
LEFT JOIN Employee E
    ON D.Dept_ID = E.Dept_ID
GROUP BY D.Dept_ID, D.Dept_Name;
```
*Purpose:* Provides instant access to departmental metrics without requiring callers to rewrite multi-table joins and aggregation clauses.

### 2. Self-Referential Hierarchy View
```sql
CREATE VIEW Employee_Hierarchy AS
SELECT
    E.Emp_ID,
    E.Emp_Name,
    E.Job_Title,
    E.Salary,
    E.Manager_ID,
    M.Emp_Name AS Manager_Name
FROM Employee E
LEFT JOIN Employee M
    ON E.Manager_ID = M.Emp_ID;
```
*Purpose:* Resolves the human-readable manager name `M.Emp_Name` alongside employee attributes through an intra-table self-join.

### 3. Recursive CTE for Organizational Reporting Chains
```sql
WITH RECURSIVE Employee_Chain AS (
    -- Anchor Member: Find top managers
    SELECT Emp_ID, Emp_Name, Manager_ID, 1 AS Level
    FROM Employee
    WHERE Manager_ID IS NULL

    UNION ALL

    -- Recursive Member: Find subordinates iteratively
    SELECT E.Emp_ID, E.Emp_Name, E.Manager_ID, EC.Level + 1
    FROM Employee E
    INNER JOIN Employee_Chain EC
        ON E.Manager_ID = EC.Emp_ID
)
SELECT Emp_ID, Emp_Name, Manager_ID, Level
FROM Employee_Chain
ORDER BY Level ASC, Emp_ID ASC;
```
*Purpose:* Programmatically climbs down the reporting tree, initializing top-tier executives at Level 1 and incrementing the depth for each child tier.

---

## 9. Verified Expected Results

### View Output: `Department_Salary_Summary`
| Dept_ID | Dept_Name | Total_Employees | Average_Salary | Maximum_Salary | Minimum_Salary |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | Engineering | 6 | 64166.67 | 85000.00 | 58000.00 |
| 2 | Sales | 6 | 57166.67 | 78000.00 | 51000.00 |
| 3 | Human Resources | 6 | 61666.67 | 80000.00 | 56000.00 |
| 4 | Finance | 6 | 68833.33 | 88000.00 | 63000.00 |
| 5 | Operations | 6 | 59333.33 | 82000.00 | 52000.00 |

### Recursive CTE Output: Organizational Hierarchy
- **Level 1 (Top Department Managers, `Manager_ID IS NULL`):**
  - Noah Smith (Emp_ID: 4, Engineering Manager)
  - Amelia Miller (Emp_ID: 9, Sales Manager)
  - Daniel White (Emp_ID: 16, HR Manager)
  - Emily Hall (Emp_ID: 21, Finance Manager)
  - Chloe Green (Emp_ID: 27, Operations Manager)
- **Level 2 (Direct Reports, 25 records):**
  - All respective specialists, analysts, and representatives assigned to their departmental manager.

---

## 10. View Updatability Summary

| View | Updatable? | Reason / SQL Constraint |
| :--- | :--- | :--- |
| `Department_Salary_Summary` | **No** | Contains `GROUP BY` and aggregate functions (`COUNT`, `AVG`, `MAX`, `MIN`). Modifying aggregated rows cannot map back to individual base table rows. |
| `Employee_Hierarchy` | **Partial / Restricted** | Contains multi-table joins. In MySQL, updates through multi-table views are restricted to columns from only one base table at a time, provided key preservation rules hold. |

---

## 11. Learning Outcomes

1. Designed reusable virtual tables for reporting abstraction.
2. Altered live relational schemas to implement self-referencing foreign keys.
3. Mastered SQL standards regarding view updatability vs read-only aggregates.
4. Implemented recursive Common Table Expressions (`WITH RECURSIVE`) to model hierarchical organizational trees.

