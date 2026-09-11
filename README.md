# Transact-SQL Database Development & Advanced Querying Lab Portfolio

**Course:** PCC CIS 275 

**Target Environment:** T-SQL / Microsoft SQL Server (`AP`, `Examples`, `CISDB`, `IMDB`, `MyGuitarShop`, `NAMES`, `ProductOrders`, `Discussions`, `CIS275Sandboxx`)

---

## Overview

This repository contains a comprehensive suite of six Transact-SQL (T-SQL) lab projects completed as part of CIS 275 (Database Development). The portfolio progresses from foundational single-table relational queries to complex multi-table joins, analytical aggregations, subquery patterns, set operations, Common Table Expressions (CTEs), and full database schema design using Data Definition Language (DDL) and Data Manipulation Language (DML).

---

## Portfolio Summary & Lab Breakdown

| Lab Module | Focus Area | Key T-SQL Concepts Covered | Target Databases |
| --- | --- | --- | --- |
| **Lab 1** | Basic Queries, Filtering & Formatting | `WHERE`, `BETWEEN`, `IN`, `LIKE`, `TOP`, `CONVERT`, `CAST`, Currency Formatting | `AP`, `Examples`, `NAMES` |
| **Lab 2** | Relational Joins & Set Operators | Multi-table `JOIN`, `UNION`, `INTERSECT`, Pattern Matching, Fixed-Width Alignment | `Examples`, `CISDB`, `IMDB`, `MyGuitarShop`, `AP` |
| **Lab 3** | Data Aggregation & Summary Reports | `GROUP BY`, `HAVING`, Aggregations (`SUM`, `COUNT`, `AVG`), `ROLLUP`, Math Operations | `Examples`, `AP`, `MyGuitarShop` |
| **Lab 4** | Subquery Constructs & Scalar Expressions | Scalar, Multi-value (`IN`/`NOT IN`), and Correlated Subqueries, `FORMAT()`, Date Functions | `AP`, `IMDB`, `MyGuitarShop`, `ProductOrders`, `Examples`, `Discussions` |
| **Lab 5** | Advanced Queries, CTEs & Functions | Common Table Expressions (`WITH`), `EXCEPT`, `CASE`, `DATENAME`, `DATEPART`, `DATEDIFF` | `ProductOrders`, `AP`, `MyGuitarShop`, `Examples` |
| **Lab 6** | Database Design, DDL & Multi-Table Views | Schema Creation (`CREATE`), FK Constraints, `ALTER TABLE`, Identity Columns, `VIEW`s | `CIS275Sandboxx` |

---

## Technical Highlights across Labs

### Lab 1: Basic Queries, Filtering, and Data Formatting

* **Conditional Filtering:** Applied targeted search conditions using `WHERE`, range evaluation with `BETWEEN`, set inclusion using `IN`, and phonetic substring searches via `Metaphone = 'MR'`.
* **String Pattern & Wildcard Matching:** Utilized `%` for arbitrary string match patterns and `[...]` for explicit character set matching (e.g., matching zip codes containing specific digits).
* **Terminal Data Alignment & Formatting:** Enforced fixed column display widths using `CONVERT(char(N), ...)` and `LEFT()` truncation. Standardized currency outputs via T-SQL money casting (`'$' + CONVERT(varchar(20), CAST(YTDPurchases AS money), 1)`).

### Lab 2: Relational Joins, Set Operators, and Data Formatting

* **Relational Multi-Table Joins:** Integrated primary-to-foreign key joins across complex normalized entities (e.g., interconnecting filmographies across `title_basics`, `title_directors`, `title_writers`, `title_ratings`, and `name_basics`).
* **Set Operations:** Unified distinct datasets using `UNION` while enforcing matching column data types, and isolated overlapping dataset keys using `INTERSECT`.
* **Chronological & Conditional Filtering:** Extracted records matching specific runtime parameters and rating boundaries (`numVotes BETWEEN 4 AND 7`).

### Lab 3: Data Aggregation and Summary Queries

* **Grouped Aggregations:** Aggregated enterprise metrics using `COUNT()`, `SUM()`, `AVG()`, `MIN()`, and `MAX()` grouped by geographic and entity attributes.
* **Group Level Filtering:** Applied post-aggregation conditional filters using `HAVING` clauses (e.g., isolating high-volume sales vendors with total cumulative invoices exceeding $1,000).
* **Hierarchical Super-Aggregates:** Generated multi-level summary sub-totals and grand totals using `GROUP BY ROLLUP()`.
* **Mathematical Expressions:** Evaluated dynamic line-item total formulas combining unit prices, discounts, and quantities directly within `SUM()` calls.

### Lab 4: Subquery Constructs and Scalar Expressions

* **Non-Join Subquery Operations:** Implemented scalar equality subqueries, multi-value set exclusion subqueries (`NOT IN`), and inline projection subqueries without resorting to explicit `JOIN` clauses.
* **Correlated Subqueries:** Constructed context-aware inner subqueries that dynamically evaluate criteria against outer query rows (e.g., identifying items matching the minimum quantity per order or counting creator credits).
* **Dynamic Time & Scalar Calculations:** Computed age and date metrics relative to runtime environment years, and applied locale-specific date formatting (e.g., Italian style 105 `DD-MM-YYYY`).

### Lab 5: Advanced SQL Queries, CTEs, and Built-In Functions

* **Modular Queries with CTEs:** Replaced complex nested subqueries with readable, maintainable Common Table Expressions (`WITH` block constructs).
* **Set Difference Logic:** Computed customer attrition and year-over-year retention metrics using the `EXCEPT` set operator.
* **Date & Time Operations:** Extracted calendar components (`DATEPART`), converted date representations to full descriptive strings (`DATENAME`), and calculated elapsed time ranges (`DATEDIFF`).
* **Conditional Logic Handling:** Handled missing/null attributes (e.g., unshipped order durations) gracefully using `CASE ... WHEN ... THEN` conditional structures.

### Lab 6: Database Design, DDL Operations, and Multi-Table Views

* **Relational Schema Modeling:** Designed and implemented a healthcare patient registration, billing, and referral tracking database schema from scratch using custom table prefixes (`NK_`).
* **Integrity Constraints & Foreign Keys:** Established primary keys with automatic identity incrementing (`IDENTITY`), enforced foreign key constraints, and handled circular entity dependencies via non-null `ALTER` adjustments and targeted `UPDATE` scripts.
* **Data Definition & Modification:** Executed full DDL/DML lifecycle commands including `CREATE TABLE`, `ALTER TABLE ... ADD/DROP COLUMN`, `SET IDENTITY_INSERT`, `DATEADD()`, and multi-table consolidated output `CREATE VIEW` abstractions using `LEFT JOIN`.

---

## How to Run

1. Open SQL Server Management Studio (SSMS), Azure Data Studio, or DataGrip.
2. Verify active connections and appropriate read/write user permissions for the target databases (`AP`, `Examples`, `CISDB`, `IMDB`, `MyGuitarShop`, `NAMES`, `ProductOrders`, `Discussions`, and `CIS275Sandboxx`).
3. Load the target script (e.g., `Lab1.sql` through `Lab6.sql`) and execute query batches sequentially.
