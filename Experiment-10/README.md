# Experiment 10: Query Optimization, Indexing, and Query Rewriting on a 10,000-Record Sales Database

**Author:** ASHMIT TIWARI  
**Environment:** MySQL 8.0+ / MySQL Workbench  

---

## 1. Original Aim

To create a Sales database containing at least 10,000 records, identify slow SQL queries, analyze their execution plans using `EXPLAIN`, and optimize queries using indexing and query rewriting techniques.

---

## 2. Problem Statement

In enterprise e-commerce and retail analytics systems, tables quickly scale past tens of thousands of rows. Unoptimized relational operations cause high CPU utilization, memory pressure, and excessive disk I/O. Common anti-patterns include unindexed filter conditions, non-sargable date ranges, full wildcard projections (`SELECT *`), and unconstrained sorting.

This experiment demonstrates a comprehensive database performance tuning workflow:
- Generating a realistic 10,000-record sales ledger using a Recursive Common Table Expression (`WITH RECURSIVE`).
- Identifying inefficient slow queries and inspecting their query execution plans via `EXPLAIN`.
- Implementing targeted single-column indexes (`Customer_ID`, `Category`, `Sale_Date`, `City`) and a multi-column compound index `(Customer_ID, Category, Sale_Date)`.
- Applying query rewriting techniques: replacing full table scans with covering index projections, transforming date boundary filters into sargable half-open intervals, and optimizing top-N queries using `ORDER BY ... LIMIT`.

---

## 3. Concepts Demonstrated

- **Large-Scale Data Generation:** Synthesizing 10,000 complex sales rows with varied products, payment modes, customer IDs, and computed totals using a recursive CTE (`cte_max_recursion_depth = 10000`).
- **Query Performance Profiling (`EXPLAIN`):**
  - Tracking scan access types (`ALL` vs `ref` vs `range` vs `index`).
  - Analyzing index selection, key length, and row lookup estimates.
- **Index Architecture:**
  - Single-column B-tree indexes for high-frequency filter columns.
  - Multi-column composite index `idx_customer_category_date` matching compound equality and range criteria.
- **Query Rewriting Strategies:**
  - *Projection Pruning:* Eliminating `SELECT *` in favor of specific attributes, allowing index-only covering scans where possible.
  - *Sargable Range Filtering:* Converting inclusive `BETWEEN` operators to half-open interval checks (`>= '2026-03-01' AND < '2026-07-01'`).
  - *Top-N Optimization:* Using indexed sorting with `LIMIT 10` to avoid costly filesort operations.
- **Table Statistics Synchronization:** Running `ANALYZE TABLE Sales` to update InnoDB key distribution statistics.

---

## 4. Database Requirements

- **Database Engine:** MySQL Server 8.0+ (strictly required for recursive CTE execution up to 10,000 rows).
- **SQL Dialect:** MySQL 8.0 SQL.
- **Session Configuration:** `SET SESSION cte_max_recursion_depth = 10000;`.

---

## 5. SQL File Descriptions

| File Name | Purpose |
| :--- | :--- |
| [`sql/schema.sql`](sql/schema.sql) | DDL script defining the `Sales` schema. |
| [`sql/insert_data.sql`](sql/insert_data.sql) | DML script populating 10,000 synthetic transaction records via recursive CTE. |
| [`sql/slow_queries_explain.sql`](sql/slow_queries_explain.sql) | Baseline queries and unindexed `EXPLAIN` execution plan analysis. |
| [`sql/create_indexes.sql`](sql/create_indexes.sql) | DDL script constructing single-column and composite B-Tree indexes. |
| [`sql/optimized_queries.sql`](sql/optimized_queries.sql) | Post-indexing `EXPLAIN` comparisons, rewritten projection queries, top-N queries, and table statistics refresh. |

---

## 6. Execution Order

Run the SQL scripts in the following exact sequence:

1. `sql/schema.sql` (Initializes table structure)
2. `sql/insert_data.sql` (Generates 10,000 benchmark records)
3. `sql/slow_queries_explain.sql` (Profiles unindexed query execution plans)
4. `sql/create_indexes.sql` (Compiles secondary and composite indexes)
5. `sql/optimized_queries.sql` (Profiles indexed queries, tests rewritten queries, and refreshes statistics)

---

## 7. Setup & Execution Instructions

### Using MySQL Command Line Client:

```sql
CREATE DATABASE IF NOT EXISTS dbms_exp10;
USE dbms_exp10;

SOURCE sql/schema.sql;
SOURCE sql/insert_data.sql;
SOURCE sql/slow_queries_explain.sql;
SOURCE sql/create_indexes.sql;
SOURCE sql/optimized_queries.sql;
```

---

## 8. Query Optimization & EXPLAIN Comparison

| Query Pattern | Before Indexing (`type`) | Unindexed Rows Examined | After Indexing (`type`) | Key Utilized | Indexed Rows Examined |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `WHERE Customer_ID = 150` | `ALL` (Table Scan) | ~10,000 rows | `ref` (Index Scan) | `idx_customer` | ~20 rows |
| `WHERE Category = 'Electronics'` | `ALL` (Table Scan) | ~10,000 rows | `ref` (Index Scan) | `idx_category` | ~2,500 rows |
| `WHERE Sale_Date BETWEEN ...` | `ALL` (Table Scan) | ~10,000 rows | `range` (Index Scan) | `idx_sale_date` | ~3,300 rows |
| `GROUP BY City` | `ALL` (Table Scan) | ~10,000 rows | `index` (Index Scan) | `idx_city` | ~10,000 rows (avoids temporary table) |
| `WHERE Customer_ID = 150 AND Category = ...` | `ALL` (Table Scan) | ~10,000 rows | `range` (Compound Scan) | `idx_customer_category_date` | ~5 rows |

---

## 9. Query Rewriting Breakdown

### 1. Covering Column Projection
```sql
-- Unoptimized
SELECT * FROM Sales WHERE Customer_ID = 150;

-- Optimized (Selective Projection)
SELECT Sale_ID, Customer_ID, Total_Amount 
FROM Sales 
WHERE Customer_ID = 150;
```
*Impact:* Reduces memory footprint and network payload by reading only the required attributes.

### 2. Sargable Date Boundaries
```sql
-- Optimized Date Range Filtering
SELECT Sale_ID, Product_Name, Total_Amount 
FROM Sales 
WHERE Sale_Date >= '2026-03-01' 
AND Sale_Date < '2026-07-01';
```
*Impact:* Enables index boundary seeking without ambiguity across month-end dates.

### 3. Top-N Ranking with Early Termination
```sql
-- Top 10 Highest Value Transactions
SELECT Sale_ID, Customer_Name, Total_Amount 
FROM Sales 
ORDER BY Total_Amount DESC 
LIMIT 10;
```

---

## 10. Verified Sample Outputs

### Record Count
```sql
SELECT COUNT(*) AS Total_Records FROM Sales;
```
| Total_Records |
| :--- |
| 10000 |

### Category Sales Breakdown
| Category | Category_Sales |
| :--- | :--- |
| Electronics | ~14,200,000.00 |
| Clothing | ~14,150,000.00 |
| Furniture | ~14,300,000.00 |
| Grocery | ~14,250,000.00 |

### Top 10 Transactions
Returns the 10 transactions with the highest `Total_Amount`, terminating immediately once 10 rows are populated.

---

## 11. Learning Outcomes

1. Generated multi-thousand row transactional datasets using recursive SQL CTEs.
2. Evaluated query execution plans with `EXPLAIN` to isolate bottlenecks.
3. Designed compound multi-column indexes targeting complex multi-predicate queries.
4. Mastered query rewriting techniques including projection trimming, sargable range predicates, and indexed early-exit top-N retrieval.
