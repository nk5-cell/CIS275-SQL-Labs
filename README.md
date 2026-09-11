# Lab 2: Relational Joins, Set Operators, and Data Formatting

---

## Overview

This lab focuses on core relational operations in Transact-SQL (T-SQL), including multi-table inner joins, set operators (`UNION`, `INTERSECT`), conditional pattern matching (`LIKE`, `BETWEEN`), and explicit column output alignment using `CONVERT`.

---

## Lab Problems & Implementation Details

### Question 1: Vendor-Customer City Matching

* **Database:** `Examples`
* **Objective:** Perform an inner join on `Customers` and `Vendors` matching on `CustCity = VendorCity`.
* **Key T-SQL Construct:** `JOIN Vendors ON Vendors.VendorCity = Customers.CustCity`, fixed-width alignment using `CONVERT(char(25), ...)`, and sorting by city, customer last name, and vendor name.

### Question 2: Vendor-Customer State Exclusion

* **Database:** `Examples`
* **Objective:** Pair customers and vendors located in the same state while explicitly excluding vendors in Illinois (`IL`) and Massachusetts (`MA`).
* **Key T-SQL Construct:** `JOIN ... ON VendorState = CustState` combined with `WHERE VendorState NOT IN ('IL', 'MA')`.

### Question 3: Employee Invoice Lookup

* **Database:** `CISDB`
* **Objective:** Extract invoice records processed by employee Tim Brown on `2002-04-16`.
* **Key T-SQL Construct:** `INNER JOIN F_EMPLOYEE ON F_EMPLOYEE.EmpID = F_INVOICE.FK_EmpID`, style 23 ISO date formatting (`YYYY-MM-DD`), and string-concatenated currency symbols.

### Question 4: Multi-Table Set Union

* **Database:** `Examples`
* **Objective:** Combine high-value active invoices (`InvoiceTotal > 70`) with low-value paid invoices (`InvoiceTotal < 10`) into a unified result set using set operations.
* **Key T-SQL Construct:** `UNION` set operator, consistent column data type casting via `CONVERT`, and global ordering on the unified result set (`ORDER BY "Invoice Total"`).

### Question 5: Episode Rating Pattern Matching

* **Database:** `IMDB`
* **Objective:** Identify episode titles containing the substring "Wicked" that fall within a low-to-moderate vote count range (4 to 7 votes).
* **Key T-SQL Construct:** Three-table `JOIN` (`title_basics`, `title_episode`, `title_ratings`), `primaryTitle LIKE '%Wicked%'`, and `numVotes BETWEEN 4 AND 7`.

### Question 6: Filmography Filtering (Akira Kurosawa)

* **Database:** `IMDB`
* **Objective:** Retrieve all feature-length Drama movies directed by Akira Kurosawa, sorted chronologically.
* **Key T-SQL Construct:** Multi-table relational chain (`title_directors`, `title_basics`, `title_genre`, `name_basics`), filtering on `primaryName`, `genre = 'Drama'`, and `titleType = 'movie'`.

### Question 7: Dual-Role Feature Lookup (Al Pacino)

* **Database:** `IMDB`
* **Objective:** Isolate feature films where Al Pacino served as both director and writer.
* **Key T-SQL Construct:** Multi-table join interconnecting `title_writers`, `title_directors`, `title_basics`, and `name_basics` on shared `tconst` and `nconst` keys.

### Question 8: TV Series Director Rankings (Wes Craven)

* **Database:** `IMDB`
* **Objective:** List television series written by Wes Craven, ordered by average viewer rating in descending order.
* **Key T-SQL Construct:** `titleType = 'tvSeries'` filter, joined with `title_ratings` to order by `averageRating DESC`.

### Question 9: High-Value Order Identification

* **Database:** `MyGuitarShop`
* **Objective:** Retrieve the 10 highest unit-priced items ordered along with their respective order dates.
* **Key T-SQL Construct:** `TOP 10` with `ORDER BY ItemPrice DESC`, joining `OrderItems` to `Orders`, formatted using date style 100 (`mon dd yyyy hh:mmAM/PM`).

### Question 10: Set Intersection Problem Statement

* **Database:** `AP`
* **Objective:** Identify common key pairs present across `Invoices` and `Vendors` using set evaluation.
* **Key T-SQL Construct:** `INTERSECT` operator comparing `(VendorID, InvoiceID)` from `Invoices` against `(VendorID, DefaultTermsID)` from `Vendors`.

---

## Technical Highlights

* **Relational Joins:** Clean multi-table joins across normalized entity-relationship diagrams (ERDs) using primary/foreign key pairs.
* **Set Operations:** Unified dataset creation using `UNION` and set evaluation via `INTERSECT`.
* **String Alignment & Formatting:** Standardized column alignment across terminal outputs using explicit `CONVERT(char(N), ...)` casting.
