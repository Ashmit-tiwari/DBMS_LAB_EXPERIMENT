# Experiment 04: Advanced Joins, Subqueries, Set Operations, and Execution Plan Analysis

**Author:** Ashmit Tiwari  
**Environment:** MySQL 8.0+ / MySQL Workbench  

---

## 1. Original Aim

Using the Employee schema, write queries with `INNER JOIN`, `LEFT JOIN`, self-join, 3-way join, correlated subqueries, `EXISTS`, and simulated `INTERSECT` and `EXCEPT`. Compare execution plans using `EXPLAIN`.

---

## 2. Problem Statement

Complex enterprise reporting requires combining relational data across multiple tables, resolving recursive or peer relationships, evaluating correlated conditions per entity, and performing set-theoretic comparisons. Furthermore, as queries scale in complexity, database engineers must diagnose performance by examining how the query optimizer navigates tables, utilizes keys, and structures execution loops.

This experiment addresses these requirements through:
- Inter-table data assembly across two and three relational entities.
- Peer matching within organizational units (self-join).
- Dynamic benchmark filtering via correlated subqueries.
- Set-theoretical comparisons simulated via SQL subquery membership predicates.
- Profiling query optimizer decisions using MySQL's `EXPLAIN` diagnostic facility.

---

## 3. Concepts Demonstrated

- **Inner Join:** Returning only intersecting records matching join predicates.
- **Left Outer Join:** Preserving all primary records from the left table while bringing matched attributes from the right table.
- **Self-Join:** Joining a table to itself to relate intra-table entities (co-workers in the same department), with strict inequality predicates (`E1.emp_id < E2.emp_id`) to avoid redundant reflexive pairings.
- **3-Way Join:** Cascading joins across `Employee`, `Project`, and `Department`.
- **Correlated Subqueries:** Subqueries whose execution depends on values passed down from outer query rows.
- **`EXISTS` Semi-Join Predicate:** Early-exit Boolean evaluation testing for related child records without pulling full result sets.
- **Simulated Set Operations:** Emulating `INTERSECT` and `EXCEPT` via nested `IN` and `NOT IN` predicates for cross-version compatibility.
- **Query Plan Profiling:** Interpreting `EXPLAIN` diagnostic outputs (`select_type`, `type`, `key`, `rows`, `Extra`).

---

## 4. Database Requirements

- **Database Engine:** MySQL Server 8.0+ (or MariaDB 10.5+)
- **SQL Dialect:** MySQL 8.0 SQL
- **Prerequisite Data:** Employee, Department, and Project dataset from Experiment 03 (provided self-contained in this directory for independent execution).

---

## 5. SQL File Descriptions

| File Name | Purpose |
| :--- | :--- |
| [`sql/schema.sql`](file:///e:/dbms%20files/Experiment-04/sql/schema.sql) | DDL script defining `Department`, `Project`, and `Employee` tables. |
| [`sql/insert_data.sql`](file:///e:/dbms%20files/Experiment-04/sql/insert_data.sql) | DML script populating benchmark departments, projects, and employees. |
| [`sql/joins.sql`](file:///e:/dbms%20files/Experiment-04/sql/joins.sql) | Scripts for `INNER JOIN`, `LEFT JOIN`, self-join, and 3-way join. |
| [`sql/subqueries.sql`](file:///e:/dbms%20files/Experiment-04/sql/subqueries.sql) | Scripts for correlated subqueries and `EXISTS` conditions. |
| [`sql/set_operations.sql`](file:///e:/dbms%20files/Experiment-04/sql/set_operations.sql) | Simulated and native `INTERSECT` and `EXCEPT` implementations. |
| [`sql/explain_plans.sql`](file:///e:/dbms%20files/Experiment-04/sql/explain_plans.sql) | `EXPLAIN` execution plan analysis statements. |

---

## 6. Execution Order

Run the scripts in the following exact sequence:

1. `sql/schema.sql` (Creates schema if not already present)
2. `sql/insert_data.sql` (Inserts records if not already populated)
3. `sql/joins.sql` (Executes join operations)
4. `sql/subqueries.sql` (Executes correlated subqueries and EXISTS)
5. `sql/set_operations.sql` (Executes set-theoretic queries)
6. `sql/explain_plans.sql` (Executes execution plan analyses)

---

## 7. Setup & Execution Instructions

### Using MySQL Command Line Client:

```sql
CREATE DATABASE IF NOT EXISTS dbms_exp04;
USE dbms_exp04;

SOURCE sql/schema.sql;
SOURCE sql/insert_data.sql;
SOURCE sql/joins.sql;
SOURCE sql/subqueries.sql;
SOURCE sql/set_operations.sql;
SOURCE sql/explain_plans.sql;
```

---

## 8. Important Queries & Explanations

### 1. Self-Join for Co-workers
```sql
SELECT E1.emp_name AS Employee1, E2.emp_name AS Employee2, E1.dept_id
FROM Employee E1
INNER JOIN Employee E2
    ON E1.dept_id = E2.dept_id
    AND E1.emp_id < E2.emp_id;
```
*Purpose:* Finds pairs of employees working in the same department. The condition `E1.emp_id < E2.emp_id` eliminates self-matches (e.g. Alice matching Alice) and eliminates inverted duplicate pairs (e.g. pairing Alice-Bob once instead of both Alice-Bob and Bob-Alice).

### 2. Correlated Subquery: Earning Above Department Average
```sql
SELECT E.emp_name, E.dept_id, E.salary
FROM Employee E
WHERE E.salary > (
    SELECT AVG(E2.salary)
    FROM Employee E2
    WHERE E2.dept_id = E.dept_id
);
```
*Purpose:* Dynamically compares each employee's salary against their specific department's average salary rather than a global fixed number.

### 3. EXISTS Semi-Join
```sql
SELECT E.emp_id, E.emp_name, E.dept_id
FROM Employee E
WHERE EXISTS (
    SELECT 1
    FROM Project P
    WHERE P.dept_id = E.dept_id
);
```
*Purpose:* Efficiently verifies whether an employee's department has an assigned project in the `Project` table.

---

## 9. Verified Expected Results

### Query: Correlated Subquery (Employees Above Department Average)
| emp_name | dept_id | salary | Dept Average |
| :--- | :--- | :--- | :--- |
| Alice | 1 | 45000.00 | 44600.00 |
| Charlie | 1 | 47000.00 | 44600.00 |
| Bhavya | 1 | 46000.00 | 44600.00 |
| David | 2 | 55000.00 | 54800.00 |
| Eva | 2 | 60000.00 | 54800.00 |
| Grace | 3 | 70000.00 | 68000.00 |
| Ian | 3 | 72000.00 | 68000.00 |
| Xavier | 3 | 71000.00 | 68000.00 |
| Nina | 4 | 51000.00 | 50500.00 |
| Oscar | 4 | 53000.00 | 50500.00 |
| Aditi | 4 | 52000.00 | 50500.00 |
| Sam | 5 | 60000.00 | 59000.00 |
| Tina | 5 | 61000.00 | 59000.00 |
| Uma | 5 | 62000.00 | 59000.00 |

### Query: Simulated INTERSECT (City = 'Delhi' AND Salary > 60000)
| emp_name |
| :--- |
| Ian |

*Verification:* Among all employees in Delhi, only Ian (salary: 72,000.00) meets the > 60,000 threshold.

### Query: Simulated EXCEPT (Employees NOT in Delhi)
- Total Count: **21 employees** (30 total employees minus 9 in Delhi).

---

## 10. Query Plan (EXPLAIN) Analysis Breakdown

| Query Type | Primary Table Access | Secondary Access | Notes |
| :--- | :--- | :--- | :--- |
| **INNER JOIN** | Full table scan (`ALL`) on `Employee` | Key lookup (`eq_ref`) on `Department.PRIMARY` | Optimizer drives join from outer table to indexed PK. |
| **LEFT JOIN** | Full scan (`ALL`) on `Department` | Ref lookup (`ref`) on `Employee.dept_id` foreign key | Preserves all department tuples. |
| **Correlated Subquery** | Outer scan (`ALL`) on `Employee E` | Iterative scan (`ALL` / `ref`) on `Employee E2` tagged `DEPENDENT SUBQUERY` | Cost scales with outer row count; candidates for window function optimization. |
| **EXISTS** | Scan on `Employee E` | Semi-join lookup on `Project` | Optimizer halts inner lookup immediately upon finding the first match. |

---

## 11. Learning Outcomes

1. Formulated multi-table queries utilizing inner, outer, and self-joins.
2. Understood correlated subquery variable passing and performance implications.
3. Implemented set intersection and difference logic using standard ANSI subquery constructs.
4. Learned to interpret optimizer execution plans using `EXPLAIN` to diagnose index usage.

