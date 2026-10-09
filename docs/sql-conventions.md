# SQL Style Guide & Coding Conventions

**Author:** ASHMIT TIWARI  
**Scope:** DBMS Laboratory Experiments & Portfolio Work  

This document defines the architectural and stylistic standards implemented across all SQL scripts in this repository. Consistent SQL styling improves maintainability, simplifies peer review, and adheres to enterprise engineering practices.

---

## 1. Keyword Capitalization

All SQL keywords, built-in functions, clauses, and constraints must be written in **UPPERCASE**:

```sql
-- Correct
SELECT emp_name, AVG(salary) AS avg_salary
FROM Employee
WHERE salary > 50000
GROUP BY emp_name
ORDER BY avg_salary DESC;

-- Incorrect
select emp_name, avg(salary) as avg_salary
from Employee
where salary > 50000
group by emp_name
order by avg_salary desc;
```

Common uppercase elements include:
- Clauses: `SELECT`, `FROM`, `WHERE`, `GROUP BY`, `HAVING`, `ORDER BY`, `LIMIT`
- Joins: `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `CROSS JOIN`, `ON`
- DDL: `CREATE TABLE`, `ALTER TABLE`, `DROP TABLE`, `PRIMARY KEY`, `FOREIGN KEY`
- Procedural: `DELIMITER`, `CREATE PROCEDURE`, `CREATE TRIGGER`, `BEGIN`, `END`, `SIGNAL`
- Functions: `COUNT()`, `SUM()`, `AVG()`, `MIN()`, `MAX()`, `COALESCE()`

---

## 2. Indentation & Formatting

- Use **4 spaces** for indentation. Avoid hard tabs.
- Place major clauses (`SELECT`, `FROM`, `WHERE`, `GROUP BY`, `ORDER BY`) on dedicated lines aligned to the left.
- Align projected column lists on new lines when selecting more than two attributes:

```sql
SELECT
    E.emp_id,
    E.emp_name,
    D.dept_name,
    E.salary
FROM Employee E
INNER JOIN Department D
    ON E.dept_id = D.dept_id
WHERE E.salary >= 50000.00;
```

---

## 3. Table and Column Naming

- **Table Names:** Written in **PascalCase** (`Department`, `Employee`, `Project`, `Salary_Audit`).
- **Column Names:** Written consistently across a schema.
  - Standard identifiers: `emp_id`, `emp_name`, `dept_id`, `salary`, `city`.
  - Hierarchical identifiers: `Dept_ID`, `Emp_ID`, `Job_Title`, `Manager_ID`.
- Avoid reserved keywords for column names (e.g. use `dept_name` instead of `name`, `emp_status` instead of `status`).

---

## 4. Key Constraints & Referential Integrity

- Primary keys must be declared explicitly during table creation.
- Foreign keys must include corresponding referential actions (`ON UPDATE CASCADE`, `ON DELETE RESTRICT` or `ON DELETE SET NULL`):

```sql
CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    dept_id INT NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);
```

---

## 5. Commenting & Documentation Standards

- **Clean Script Files:** SQL script files are maintained as clean, comment-free executable code blocks to optimize database batch execution and script portability.
- **External Documentation:** All query explanations, execution orders, expected outputs, and technical rationales are fully documented in the respective experiment `README.md` files rather than embedded directly inside executable scripts.
- **Header Standards:** Where author attribution is required, scripts are attributed strictly to **ASHMIT TIWARI**.

---

## 6. SQL File Naming Conventions

All SQL files must follow **lowercase snake_case** naming that clearly describes their operational role:

- `schema.sql`: Table and constraint definitions.
- `insert_data.sql`: Seed data statements.
- `basic_queries.sql`: Selection, projection, and sorting.
- `aggregate_queries.sql`: Grouping, statistical summaries, and `HAVING` filters.
- `case_queries.sql`: Conditional branching expressions.
- `joins.sql`: Relational joins.
- `subqueries.sql`: Nested and correlated subqueries.
- `procedures.sql`: Stored procedure compilation scripts.
- `triggers.sql`: Event triggers.
- `test_cases.sql`: Automated test runs and edge-case validations.

