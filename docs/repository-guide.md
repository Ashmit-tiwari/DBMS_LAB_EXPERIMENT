# Repository Structure & Maintenance Guide

**Author:** ASHMIT TIWARI  
**Scope:** Repository Governance & Extension Guidelines  

This document outlines the directory structure of the repository, explains the organization of experiment files, and provides step-by-step instructions for extending the project with additional experiments.

---

## 1. Repository Directory Structure

```text
DBMS-Lab-Experiments/
│
├── README.md                          # Root repository documentation
├── .gitignore                         # Git tracking exclusions
│
├── Experiment-03/                     # Experiment 03 folder
│   ├── README.md                      # Experiment documentation & verified outputs
│   └── sql/                           # Modular SQL files
│       ├── schema.sql
│       ├── insert_data.sql
│       ├── basic_queries.sql
│       ├── aggregate_queries.sql
│       ├── case_queries.sql
│       └── advanced_queries.sql
│
├── Experiment-04/                     # Experiment 04 folder
│   ├── README.md
│   └── sql/
│       ├── schema.sql
│       ├── insert_data.sql
│       ├── joins.sql
│       ├── subqueries.sql
│       ├── set_operations.sql
│       └── explain_plans.sql
│
├── Experiment-05/                     # Experiment 05 folder
│   ├── README.md
│   └── sql/
│       ├── schema.sql
│       ├── insert_data.sql
│       ├── views.sql
│       └── hierarchy_and_cte.sql
│
├── Experiment-06/                     # Experiment 06 folder
│   ├── README.md
│   └── sql/
│       ├── schema.sql
│       ├── insert_data.sql
│       ├── procedures.sql
│       ├── triggers.sql
│       └── test_cases.sql
│
├── Experiment-07/                     # Experiment 07 folder
│   ├── README.md
│   └── sql/
│       ├── unf_to_1nf.sql
│       ├── schema_normalized.sql
│       ├── insert_data.sql
│       └── verify_lossless_join.sql
│
├── Experiment-09/                     # Experiment 09 folder
│   ├── README.md
│   └── sql/
│       ├── schema.sql
│       ├── insert_data.sql
│       ├── queries_before_indexing.sql
│       ├── create_indexes.sql
│       └── queries_after_indexing.sql
│
├── Experiment-10/                     # Experiment 10 folder
│   ├── README.md
│   └── sql/
│       ├── schema.sql
│       ├── insert_data.sql
│       ├── slow_queries_explain.sql
│       ├── create_indexes.sql
│       └── optimized_queries.sql
│
└── docs/                              # Shared documentation
    ├── setup-guide.md                 # Database setup and execution instructions
    ├── sql-conventions.md             # Code style guide and formatting rules
    └── repository-guide.md            # Maintenance and contribution guidelines
```

---

## 2. Organization Principles

1. **Separation of Concerns:** Each experiment is an isolated module containing its own dedicated Markdown documentation (`README.md`) and a `sql/` directory.
2. **Modular SQL Scripts:** SQL scripts are decomposed by lifecycle phase (`schema.sql`, `insert_data.sql`) and query purpose (`create_indexes.sql`, `optimized_queries.sql`, etc.) rather than monolithic multi-hundred-line dumps.
3. **No-Images Policy:** The repository relies exclusively on lightweight text-based documentation, markdown tables, and inline code formatting. No image assets, screenshots, or graphics are admitted.
4. **Independent Reproducibility:** Each experiment directory contains sufficient DDL and DML scripts to run self-contained without cross-folder file dependencies.

---

## 3. How to Add a New Experiment (e.g., Experiment-11)

When expanding the repository with subsequent laboratory work, follow these standardized steps:

### Step 1: Create the Directory Tree
```bash
mkdir -p Experiment-11/sql
```

### Step 2: Implement SQL Scripts
Inside `Experiment-11/sql/`, create modular scripts adhering to [docs/sql-conventions.md](sql-conventions.md):
- `schema.sql`: Table definitions and integrity constraints.
- `insert_data.sql`: Seed dataset.
- Feature-specific query files.

### Step 3: Author the Experiment README
Create `Experiment-11/README.md` following the standardized structure:
1. Experiment number and descriptive title
2. Author: ASHMIT TIWARI
3. Original aim and academic problem statement
4. Concepts demonstrated
5. Database prerequisites
6. SQL file index table
7. Step-by-step execution order
8. Detailed query explanations with code blocks
9. Verified expected outputs
10. Learning outcomes

### Step 4: Update Root Documentation
1. Edit the root [README.md](../README.md) to add an entry in the **Repository Contents** table.
2. Include relative links pointing directly to `Experiment-11/README.md`.
3. Update the folder structure diagram to reflect the new directory.
