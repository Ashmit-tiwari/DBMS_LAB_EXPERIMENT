# DBMS Lab Experiments

**Author:** ASHMIT TIWARI  
**Repository Name:** DBMS-Lab-Experiments  
**Purpose:** Academic DBMS practical work, SQL learning, and database concept demonstration  
**Database System:** MySQL Community Server 8.0+  

---

## About

This repository provides production-quality SQL scripts and modular technical documentation for Database Management Systems (DBMS) Laboratory Experiments 3 through 6. 

The project demonstrates relational database modeling, data definition and manipulation, advanced querying (aggregations, joins, subqueries, and set operations), view abstractions, recursive Common Table Expressions (CTEs), and server-side procedural programming (stored procedures and triggers).

---

## Repository Contents

| Experiment | Original Title | Concepts Covered | Documentation |
| :--- | :--- | :--- | :--- |
| **Experiment 03** | Employee–Department–Project Database Schema and Basic/Aggregate Queries | DDL, DML, Selection, Projection, Aggregates (`AVG`, `COUNT`), `GROUP BY`, `HAVING`, `CASE` Expressions, `ORDER BY` | [Experiment-03/README.md](Experiment-03/README.md) |
| **Experiment 04** | Advanced Joins, Subqueries, Set Operations, and Execution Plan Analysis | `INNER JOIN`, `LEFT JOIN`, Self-Join, 3-Way Join, Correlated Subqueries, `EXISTS`, Simulated `INTERSECT` & `EXCEPT`, `EXPLAIN` Plans | [Experiment-04/README.md](Experiment-04/README.md) |
| **Experiment 05** | Database Views, View Updatability, and Recursive Common Table Expressions | `CREATE VIEW`, Aggregate Summaries, Self-Referential Foreign Keys, View Updatability, Recursive CTEs (`WITH RECURSIVE`) | [Experiment-05/README.md](Experiment-05/README.md) |
| **Experiment 06** | Stored Procedures with Error Handling and Triggers for Audit Logging | Stored Procedures, `DELIMITER`, Defensive Parameter Validation, Custom Exceptions (`SIGNAL SQLSTATE '45000'`), `BEFORE UPDATE` Validation Triggers, `AFTER UPDATE` Audit Logging | [Experiment-06/README.md](Experiment-06/README.md) |

---

## Repository Structure

```text
DBMS-Lab-Experiments/
│
├── README.md                          # Root project documentation
├── .gitignore                         # Git tracking exclusions
│
├── Experiment-03/                     # Basic & Aggregate Queries
│   ├── README.md                      # Experiment documentation & verified outputs
│   └── sql/
│       ├── schema.sql
│       ├── insert_data.sql
│       ├── basic_queries.sql
│       ├── aggregate_queries.sql
│       ├── case_queries.sql
│       └── advanced_queries.sql
│
├── Experiment-04/                     # Joins, Subqueries & Query Plans
│   ├── README.md
│   └── sql/
│       ├── schema.sql
│       ├── insert_data.sql
│       ├── joins.sql
│       ├── subqueries.sql
│       ├── set_operations.sql
│       └── explain_plans.sql
│
├── Experiment-05/                     # Views & Recursive CTEs
│   ├── README.md
│   └── sql/
│       ├── schema.sql
│       ├── insert_data.sql
│       ├── views.sql
│       └── hierarchy_and_cte.sql
│
├── Experiment-06/                     # Stored Procedures & Triggers
│   ├── README.md
│   └── sql/
│       ├── schema.sql
│       ├── insert_data.sql
│       ├── procedures.sql
│       ├── triggers.sql
│       └── test_cases.sql
│
└── docs/                              # Shared documentation
    ├── setup-guide.md                 # Environment setup and execution instructions
    ├── sql-conventions.md             # SQL style guide and standards
    └── repository-guide.md            # Repository governance and contribution guide
```

---

## Prerequisites & Database Setup

- **Database Engine:** MySQL Server 8.0 or higher (or MariaDB 10.5+)
- **Interface:** MySQL Command Line Client (`mysql`) or MySQL Workbench 8.0 CE
- **OS Support:** Windows, Linux, or macOS

For detailed environment installation steps, service management, and client setup, refer to the [Setup Guide](docs/setup-guide.md).

---

## How to Execute the SQL Scripts

Scripts must be executed in order (DDL schema -> DML data insertion -> Queries / Routines).

### Quickstart via MySQL Command Line Client:

```sql
-- 1. Create and select a target database
CREATE DATABASE IF NOT EXISTS dbms_lab;
USE dbms_lab;

-- 2. Execute any experiment by sourcing its files in sequence
-- Example: Executing Experiment 03
SOURCE Experiment-03/sql/schema.sql;
SOURCE Experiment-03/sql/insert_data.sql;
SOURCE Experiment-03/sql/basic_queries.sql;
SOURCE Experiment-03/sql/aggregate_queries.sql;
SOURCE Experiment-03/sql/case_queries.sql;
SOURCE Experiment-03/sql/advanced_queries.sql;
```

---

## SQL Formatting Conventions

All SQL code in this repository adheres to consistent standards:
- **Keywords:** UPPERCASE (`SELECT`, `FROM`, `WHERE`, `JOIN`, `GROUP BY`, `ORDER BY`, `CREATE TABLE`).
- **Indentation:** 4 spaces per indentation level.
- **Identifiers:** PascalCase for tables (`Employee`, `Department`), clear snake_case or PascalCase for attributes (`emp_id`, `salary`).
- **Safety:** Schema scripts drop tables in reverse foreign-key dependency order.

Read the complete [SQL Style Guide](docs/sql-conventions.md) for further details.

---

## Learning Objectives

1. Design and normalize relational database schemas with primary and foreign key constraints.
2. Formulate complex queries with multi-table joins, self-joins, and correlated subqueries.
3. Diagnose and compare execution plans using `EXPLAIN` to understand query performance.
4. Construct database views and traverse recursive organizational hierarchies with Common Table Expressions (CTEs).
5. Build robust, defensive server-side database logic using stored procedures, custom exception signaling (`SIGNAL`), and automated auditing triggers.

---

## Author Information

- **Author:** ASHMIT TIWARI
- **Repository:** DBMS-Lab-Experiments
- **Purpose:** Academic DBMS practical evaluations and developer portfolio showcase
