# Experiment 09: Railway Booking Indexing and Execution Plan (EXPLAIN) Analysis

**Author:** ASHMIT TIWARI  
**Environment:** MySQL 8.0+ / MySQL Workbench  

---

## 1. Original Aim

To create a Railway Booking table containing at least 5,000 records, execute SQL queries before and after creating indexes, and compare query execution plans using the `EXPLAIN` command.

---

## 2. Problem Statement

High-volume transaction systems such as railway booking portals manage thousands of reservation entries across dates, routes, passenger cohorts, and fare tiers. Without database indexing, retrieval queries require exhaustive Full Table Scans (`type: ALL`), reading every data page from storage regardless of result selectivity.

This experiment demonstrates database indexing and performance optimization:
- Synthesizing an active transactional database of 5,000 reservation records using a Recursive Common Table Expression (`WITH RECURSIVE`).
- Profiling unindexed query latency and access types using MySQL's `EXPLAIN` facility.
- Designing single-column and composite B-tree secondary indexes for frequent predicate patterns (`Train_No`, `Passenger_Name`, `Booking_Status`, `Source_Station`, `Journey_Date`, `Fare`, and `(Train_No, Journey_Date)`).
- Re-evaluating execution plans post-indexing to demonstrate the transition from linear $O(N)$ full table scans to logarithmic $O(\log N)$ indexed lookups (`ref`, `range`).

---

## 3. Concepts Demonstrated

- **Recursive CTE Synthetic Data Generation:** Utilizing `WITH RECURSIVE` and `SET SESSION cte_max_recursion_depth = 5000` to generate deterministic benchmark records without external scripts.
- **Query Execution Plan Profiling (`EXPLAIN`):**
  - Evaluating join types: `ALL` (full table scan), `ref` (non-unique index lookup), `range` (index range scan).
  - Examining key utilization (`possible_keys` vs `key`).
  - Monitoring estimated row inspections (`rows`) and filter ratios (`filtered`).
- **Single-Column B-Tree Indexes:** Accelerating exact-match searches (`WHERE Passenger_Name = 'Passenger_100'`, `WHERE Train_No = 12005`).
- **Composite Indexes:** Building multi-column compound keys (`idx_train_date` on `(Train_No, Journey_Date)`) leveraging the leftmost prefix rule.
- **Index Statistics Optimization:** Invoking `ANALYZE TABLE Railway_Booking` to refresh cardinality statistics for the cost-based query optimizer.

---

## 4. Database Requirements

- **Database Engine:** MySQL Server 8.0+ (strictly required for `WITH RECURSIVE` CTE data generation).
- **SQL Dialect:** MySQL 8.0 SQL.
- **Session Configuration:** `SET SESSION cte_max_recursion_depth = 5000;`.

---

## 5. SQL File Descriptions

| File Name | Purpose |
| :--- | :--- |
| [`sql/schema.sql`](sql/schema.sql) | DDL script defining the `Railway_Booking` table. |
| [`sql/insert_data.sql`](sql/insert_data.sql) | DML script generating and inserting 5,000 synthetic booking records via a recursive CTE. |
| [`sql/queries_before_indexing.sql`](sql/queries_before_indexing.sql) | Baseline execution queries and unindexed `EXPLAIN` diagnostic statements. |
| [`sql/create_indexes.sql`](sql/create_indexes.sql) | DDL script constructing single-column and composite B-Tree indexes. |
| [`sql/queries_after_indexing.sql`](sql/queries_after_indexing.sql) | Post-indexing `EXPLAIN` queries, range filters, aggregations, index inspection, and table analysis. |

---

## 6. Execution Order

Run the SQL scripts in the following exact sequence:

1. `sql/schema.sql` (Creates table structure)
2. `sql/insert_data.sql` (Generates 5,000 benchmark records)
3. `sql/queries_before_indexing.sql` (Profiles unindexed queries and execution plans)
4. `sql/create_indexes.sql` (Creates secondary indexes)
5. `sql/queries_after_indexing.sql` (Profiles indexed queries, verifies index utilization, and refreshes statistics)

---

## 7. Setup & Execution Instructions

### Using MySQL Command Line Client:

```sql
CREATE DATABASE IF NOT EXISTS dbms_exp09;
USE dbms_exp09;

SOURCE sql/schema.sql;
SOURCE sql/insert_data.sql;
SOURCE sql/queries_before_indexing.sql;
SOURCE sql/create_indexes.sql;
SOURCE sql/queries_after_indexing.sql;
```

---

## 8. Query Optimization & EXPLAIN Comparison

| Query Pattern | Unindexed Access (`type`) | Unindexed Rows Examined | Indexed Access (`type`) | Indexed Key Used | Indexed Rows Examined |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `WHERE Train_No = 12005` | `ALL` (Table Scan) | ~5,000 rows | `ref` (Index Scan) | `idx_train_no` | ~250 rows |
| `WHERE Passenger_Name = 'Passenger_100'` | `ALL` (Table Scan) | ~5,000 rows | `ref` (Index Scan) | `idx_passenger_name` | 1 row |
| `WHERE Booking_Status = 'Confirmed'` | `ALL` (Table Scan) | ~5,000 rows | `ref` (Index Scan) | `idx_booking_status` | ~1,250 rows |
| `WHERE Train_No = 12005 AND Journey_Date BETWEEN ...` | `ALL` (Table Scan) | ~5,000 rows | `range` (Compound Scan) | `idx_train_date` | ~60 rows |

---

## 9. Verified Sample Outputs

### Record Count Verification
```sql
SELECT COUNT(*) AS Total_Bookings FROM Railway_Booking;
```
| Total_Bookings |
| :--- |
| 5000 |

### Top Revenue by Train
| Train_No | Total_Revenue |
| :--- | :--- |
| 12019 | 201250.00 |
| 12018 | 199750.00 |
| 12017 | 198250.00 |
| 12016 | 196750.00 |
| 12015 | 195250.00 |

### Status Distribution Aggregation
| Booking_Status | Total |
| :--- | :--- |
| Confirmed | 1250 |
| Waiting | 1250 |
| Cancelled | 1250 |
| RAC | 1250 |

---

## 10. Learning Outcomes

1. Synthesized large-scale test datasets natively in SQL using recursive common table expressions.
2. Diagnosed full table scan bottlenecks on multi-thousand row datasets using `EXPLAIN`.
3. Designed targeted B-tree indexes matching query predicates to minimize I/O footprint.
4. Demonstrated composite index usage following leftmost prefix rules for multi-predicate range queries.
