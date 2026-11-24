# Experiment 07: Relational Database Normalization (UNF to 3NF & BCNF) and Lossless Join Verification

**Author:** ASHMIT TIWARI  
**Environment:** MySQL 8.0+ / MySQL Workbench  

---

## 1. Original Aim

To normalize a denormalized Sales table from UNF to 3NF and BCNF, and to verify lossless join and dependency preservation.

---

## 2. Problem Statement

Denormalized relational tables suffer from redundancy, update anomalies, insertion anomalies, and deletion anomalies. In an unnormalized sales record, customer, salesperson, and product details repeat across transactions, risking data inconsistency if customer locations or salesperson names change.

This experiment demonstrates the systematic decomposition of a denormalized `Sales_UNF` relation:
- Establishing First Normal Form (1NF) with atomic attributes and an identified candidate key `(Sale_ID, Product_ID)`.
- Eliminating partial dependencies to attain Second Normal Form (2NF).
- Eliminating transitive dependencies to achieve Third Normal Form (3NF) and Boyce-Codd Normal Form (BCNF).
- Verifying that the relational decomposition preserves all functional dependencies and supports a lossless join reconstruction without spurious tuples.

---

## 3. Concepts Demonstrated

- **Unnormalized Form (UNF):** Flat table representation containing composite multi-entity attributes.
- **First Normal Form (1NF):** Ensuring all column values are atomic and establishing a primary key `(Sale_ID, Product_ID)`.
- **Functional Dependencies (FDs):**
  - `Sale_ID -> Customer_ID, Salesperson_ID`
  - `Customer_ID -> Customer_Name, Customer_City`
  - `Product_ID -> Product_Name`
  - `Salesperson_ID -> Salesperson_Name`
  - `(Sale_ID, Product_ID) -> Quantity`
- **Second Normal Form (2NF):** Removing partial dependencies where non-prime attributes (`Product_Name`) depend on a subset of the composite candidate key (`Product_ID`).
- **Third Normal Form (3NF) & BCNF:** Eliminating transitive dependencies (`Sale_ID -> Customer_ID -> Customer_Name, Customer_City` and `Sale_ID -> Salesperson_ID -> Salesperson_Name`) into independent entity tables where every determinant is a superkey.
- **Lossless Join Decomposition:** Demonstrating that natural joins (`JOIN ... ON`) across foreign key relationships reconstruct the exact original dataset without tuple loss or phantom generation.
- **Dependency Preservation:** Ensuring all functional dependencies can be enforced using primary and foreign key constraints without requiring cross-table joins.

---

## 4. Database Requirements

- **Database Engine:** MySQL Server 8.0+ (or MariaDB 10.5+)
- **SQL Dialect:** MySQL 8.0 ANSI SQL compliant
- **Execution Interface:** MySQL Command Line Client (`mysql`) or MySQL Workbench 8.0 CE

---

## 5. SQL File Descriptions

| File Name | Purpose |
| :--- | :--- |
| [`sql/unf_to_1nf.sql`](sql/unf_to_1nf.sql) | DDL & DML script creating `Sales_UNF`, inserting benchmark transaction records, and creating `Sales_1NF` with a composite primary key. |
| [`sql/schema_normalized.sql`](sql/schema_normalized.sql) | DDL script defining decomposed normalized entities: `Customer`, `Product`, `Salesperson`, `Sales`, and `Sale_Details` with PK and FK constraints. |
| [`sql/insert_data.sql`](sql/insert_data.sql) | DML script migrating distinct records from `Sales_1NF` into normalized tables. |
| [`sql/verify_lossless_join.sql`](sql/verify_lossless_join.sql) | Analytical queries performing multi-table joins to prove lossless reconstruction and verify referential integrity. |

---

## 6. Execution Order

Run the SQL scripts in the following exact sequence:

1. `sql/unf_to_1nf.sql` (Creates UNF and 1NF tables and seeds baseline data)
2. `sql/schema_normalized.sql` (Creates normalized 3NF/BCNF relational schema)
3. `sql/insert_data.sql` (Populates normalized tables via SELECT DISTINCT from 1NF)
4. `sql/verify_lossless_join.sql` (Reconstructs original view and verifies lossless join integrity)

---

## 7. Setup & Execution Instructions

### Using MySQL Command Line Client:

```sql
CREATE DATABASE IF NOT EXISTS dbms_exp07;
USE dbms_exp07;

SOURCE sql/unf_to_1nf.sql;
SOURCE sql/schema_normalized.sql;
SOURCE sql/insert_data.sql;
SOURCE sql/verify_lossless_join.sql;
```

---

## 8. Decomposition Architecture

```text
Denormalized Table (Sales_UNF / Sales_1NF)
├── Sale_ID (PK Part 1)
├── Product_ID (PK Part 2)
├── Customer_ID, Customer_Name, Customer_City
├── Product_Name, Quantity
└── Salesperson_ID, Salesperson_Name

                  Decomposed into 3NF / BCNF
                  
   ┌───────────────┐         ┌────────────────┐         ┌─────────────────┐
   │   Customer    │         │  Salesperson   │         │     Product     │
   ├───────────────┤         ├────────────────┤         ├─────────────────┤
   │ Customer_ID*  │         │ Salesperson_ID*│         │ Product_ID*     │
   │ Customer_Name │         │ Salesperson_Name│        │ Product_Name    │
   │ Customer_City │         └───────┬────────┘         └────────┬────────┘
   └───────┬───────┘                 │                           │
           │                         │                           │
           └───────────┐ ┌───────────┘                           │
                       ▼ ▼                                       │
                 ┌──────────────┐                                │
                 │    Sales     │                                │
                 ├──────────────┤                                │
                 │ Sale_ID*     │◄───────────┐                   │
                 │ Customer_ID  │            │                   │
                 │Salesperson_ID│            │                   │
                 └──────────────┘            │                   │
                                             ▼                   ▼
                                     ┌─────────────────────────────┐
                                     │        Sale_Details         │
                                     ├─────────────────────────────┤
                                     │ Sale_ID* (FK to Sales)      │
                                     │ Product_ID* (FK to Product) │
                                     │ Quantity                    │
                                     └─────────────────────────────┘
```

---

## 9. Verified Expected Results

### Normalized Table: Customer
| Customer_ID | Customer_Name | Customer_City |
| :--- | :--- | :--- |
| 101 | Rahul Sharma | Lucknow |
| 102 | Priya Singh | Kanpur |
| 103 | Arjun Verma | Delhi |
| 104 | Sneha Gupta | Lucknow |
| 105 | Vivek Sharma | Kanpur |

### Normalized Table: Product
| Product_ID | Product_Name |
| :--- | :--- |
| 201 | Laptop |
| 202 | Mouse |
| 203 | Keyboard |
| 204 | Monitor |
| 205 | Printer |

### Normalized Table: Salesperson
| Salesperson_ID | Salesperson_Name |
| :--- | :--- |
| 301 | Amit Kumar |
| 302 | Neha Gupta |
| 303 | Rohit Singh |

### Normalized Table: Sales
| Sale_ID | Customer_ID | Salesperson_ID |
| :--- | :--- | :--- |
| 1 | 101 | 301 |
| 2 | 102 | 302 |
| 3 | 103 | 303 |
| 4 | 104 | 301 |
| 5 | 105 | 302 |

### Normalized Table: Sale_Details
| Sale_ID | Product_ID | Quantity |
| :--- | :--- | :--- |
| 1 | 201 | 2 |
| 2 | 202 | 3 |
| 3 | 203 | 1 |
| 4 | 204 | 2 |
| 5 | 205 | 1 |

### Lossless Join Reconstruction Query Output
Executing the 5-table join reproduces the exact original UNF tuple set without spurious records:

| Sale_ID | Customer_Name | Customer_City | Product_Name | Quantity | Salesperson_Name |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | Rahul Sharma | Lucknow | Laptop | 2 | Amit Kumar |
| 2 | Priya Singh | Kanpur | Mouse | 3 | Neha Gupta |
| 3 | Arjun Verma | Delhi | Keyboard | 1 | Rohit Singh |
| 4 | Sneha Gupta | Lucknow | Monitor | 2 | Amit Kumar |
| 5 | Vivek Sharma | Kanpur | Printer | 1 | Neha Gupta |

---

## 10. Learning Outcomes

1. Analyzed functional dependencies to diagnose update, insert, and delete anomalies in flat relational schemas.
2. Formulated lossless-join decomposition from UNF to 1NF, 2NF, 3NF, and BCNF.
3. Designed child transaction junction entities (`Sale_Details`) with composite foreign keys.
4. Programmatically validated lossless join reconstruction and dependency preservation using relational join algebra.
