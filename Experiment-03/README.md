# Experiment 03: Employee–Department–Project Database Schema and Basic/Aggregate Queries

**Author:** Ashmit Tiwari  
**Environment:** MySQL 8.0+ / MySQL Workbench  

---

## 1. Original Aim

Create an Employee–Department–Project schema. Insert at least 30 employees across 5 departments and 8 projects. Write SQL queries demonstrating selection, projection, aggregates, `GROUP BY`, `HAVING`, `CASE` expressions, and `ORDER BY`.

---

## 2. Problem Statement

An enterprise requires a structured relational model to track internal organizational units, projects, and workforce members. The data model must maintain referential integrity among departments, projects, and employees. Once populated with benchmark organizational data (at least 30 employee records across 5 distinct departments and 8 functional projects), the system must answer core operational and analytical questions:
- Locate staff by geographic location (Selection).
- Extract specific attribute subsets (Projection).
- Sort workforce records by compensation (Sorting).
- Compute statistical department payroll figures and filter departmental groups by threshold headcount (`GROUP BY`, `HAVING`).
- Segment employee compensation into qualitative tiers using conditional logic (`CASE`).

---

## 3. Concepts Demonstrated

- **Data Definition Language (DDL):** Normalized 3-table relational schema with `PRIMARY KEY` and `FOREIGN KEY` constraints.
- **Data Manipulation Language (DML):** Batch insertion preserving referential integrity.
- **Relational Selection:** Horizontal filtering using `WHERE`.
- **Relational Projection:** Attribute filtering using specific `SELECT` lists.
- **Aggregate Functions:** `COUNT()`, `SUM()`, `AVG()`, `MIN()`, and `MAX()`.
- **Group Aggregation:** Partitioning results with `GROUP BY` and group-level filtering with `HAVING`.
- **Conditional Expressions:** Dynamic categorization with `CASE ... WHEN ... THEN ... ELSE ... END`.
- **Result Ordering:** Ordering records ascending and descending with `ORDER BY`.

---

## 4. Database Requirements

- **Database Engine:** MySQL Server 8.0+ (or MariaDB 10.5+)
- **SQL Dialect:** MySQL 8.0 ANSI SQL compliant
- **Execution Interface:** MySQL Command Line Client (`mysql`) or MySQL Workbench 8.0 CE

---

## 5. SQL File Descriptions

| File Name | Purpose |
| :--- | :--- |
| [`sql/schema.sql`](file:///e:/dbms%20files/Experiment-03/sql/schema.sql) | DDL script to create `Department`, `Project`, and `Employee` tables with referential constraints. |
| [`sql/insert_data.sql`](file:///e:/dbms%20files/Experiment-03/sql/insert_data.sql) | DML script inserting 5 departments, 8 projects, and 30 employees. |
| [`sql/basic_queries.sql`](file:///e:/dbms%20files/Experiment-03/sql/basic_queries.sql) | Core selection, projection, and sorting operations. |
| [`sql/aggregate_queries.sql`](file:///e:/dbms%20files/Experiment-03/sql/aggregate_queries.sql) | Department-level `AVG()`, `COUNT()`, `GROUP BY`, and `HAVING` filters. |
| [`sql/case_queries.sql`](file:///e:/dbms%20files/Experiment-03/sql/case_queries.sql) | Salary band categorization using `CASE` expressions. |
| [`sql/advanced_queries.sql`](file:///e:/dbms%20files/Experiment-03/sql/advanced_queries.sql) | Optional analytical extensions (joins, subqueries, department payroll). |

---

## 6. Execution Order

Run the SQL scripts in the following exact sequence:

1. `sql/schema.sql` (Creates database structure)
2. `sql/insert_data.sql` (Populates seed data)
3. `sql/basic_queries.sql` (Executes foundational queries)
4. `sql/aggregate_queries.sql` (Executes aggregation analysis)
5. `sql/case_queries.sql` (Executes conditional expressions)
6. `sql/advanced_queries.sql` (Executes optional analytical extensions)

---

## 7. Setup & Execution Instructions

### Using MySQL Command Line Client:

```bash
# 1. Connect to MySQL and create/use a dedicated database
mysql -u root -p
```

```sql
CREATE DATABASE IF NOT EXISTS dbms_exp03;
USE dbms_exp03;

-- Execute scripts in sequence
SOURCE sql/schema.sql;
SOURCE sql/insert_data.sql;
SOURCE sql/basic_queries.sql;
SOURCE sql/aggregate_queries.sql;
SOURCE sql/case_queries.sql;
SOURCE sql/advanced_queries.sql;
```

### Using MySQL Workbench:
1. Open MySQL Workbench and connect to your local MySQL instance.
2. Open a new SQL Query tab, execute `CREATE DATABASE dbms_exp03; USE dbms_exp03;`.
3. Open each SQL script from the `sql/` folder sequentially and run via `Execute (Ctrl+Shift+Enter)`.

---

## 8. Important Queries & Explanations

### 1. Selection: Filtering by Location
```sql
SELECT emp_id, emp_name, dept_id, project_id, salary, city
FROM Employee
WHERE city = 'Delhi';
```
*Purpose:* Filters employee tuples horizontally where the geographic attribute `city` matches `'Delhi'`.

### 2. Department Average Salary
```sql
SELECT dept_id, AVG(salary) AS avg_salary
FROM Employee
GROUP BY dept_id;
```
*Purpose:* Groups employee rows by their foreign key `dept_id` and calculates the arithmetic mean salary for each department.

### 3. Group Filtering with HAVING
```sql
SELECT dept_id, COUNT(*) AS num_employees
FROM Employee
GROUP BY dept_id
HAVING COUNT(*) > 5;
```
*Purpose:* Partitions records by department and retains only departmental groups whose member count exceeds 5.

### 4. Conditional Classification with CASE
```sql
SELECT
    emp_name,
    salary,
    CASE
        WHEN salary < 50000 THEN 'Low'
        WHEN salary BETWEEN 50000 AND 60000 THEN 'Medium'
        ELSE 'High'
    END AS salary_category
FROM Employee;
```
*Purpose:* Evaluates each employee's compensation against predefined business brackets and assigns a qualitative descriptor without altering table storage.

---

## 9. Verified Expected Results

The following outputs have been verified against the dataset:

### Query: City = 'Delhi' (9 rows)
| emp_id | emp_name | salary | city |
| :--- | :--- | :--- | :--- |
| 1 | Alice | 45000.00 | Delhi |
| 4 | David | 55000.00 | Delhi |
| 9 | Ian | 72000.00 | Delhi |
| 12 | Leo | 48000.00 | Delhi |
| 15 | Oscar | 53000.00 | Delhi |
| 18 | Rita | 59000.00 | Delhi |
| 22 | Victor | 53000.00 | Delhi |
| 26 | Zane | 49000.00 | Delhi |
| 30 | Devika | 58000.00 | Delhi |

### Query: Department-wise Average Salary
| dept_id | avg_salary |
| :--- | :--- |
| 1 | 44600.00 |
| 2 | 54800.00 |
| 3 | 68000.00 |
| 4 | 50500.00 |
| 5 | 59000.00 |

### Query: Departments with Headcount > 5
| dept_id | num_employees |
| :--- | :--- |
| 3 | 7 |
| 4 | 6 |
| 5 | 7 |

---

## 10. Learning Outcomes

1. Designed and enforced foreign-key constraints between related business entities.
2. Mastered `WHERE` clause selection predicates vs `HAVING` clause group filters.
3. Implemented standard ANSI aggregation functions to produce statistical summaries.
4. Utilized inline `CASE` statements to construct custom classification dimensions.

