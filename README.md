# Lab 4: Subquery Constructs and Scalar Expressions

---

## Overview

This lab focuses on writing subqueries in Transact-SQL (T-SQL) without relying on explicit `JOIN` clauses. Key query patterns include single-value scalar subqueries, multi-value set subqueries (`IN`, `NOT IN`), correlated subqueries, calculated projection subqueries, and scalar data formatting (`FORMAT`, `CONVERT`, `CAST`, `LIKE`).

---

## Lab Problems & Implementation Details

### Question 1: Vendor State Matching Subquery

* **Database:** `AP`
* **Objective:** Retrieve vendors located in the same state as **'Newbrige Book Clubs'** using a single-value equality subquery (`WHERE VendorState = (...)`).
* **Formatting:** Converted fields to fixed length (`char(23)`).

### Question 2: Above-Average Runtime Query

* **Database:** `IMDB`
* **Objective:** Find titles in `title_basics` whose `runtimeMinutes` exceed the global dataset average using `WHERE runtimeMinutes > (SELECT AVG(...) FROM ...)`.
* **Formatting:** Applied `DISTINCT` and truncated `primaryTitle` to `char(90)`.

### Question 3: Minimum Quantity Correlated Subquery

* **Database:** `MyGuitarShop`
* **Objective:** For every order in `OrderItems`, identify items matching the lowest quantity within that specific order (`WHERE Quantity = (SELECT MIN(...) WHERE v.OrderID = i.OrderID)`).

### Question 4: Customer Exclusion via Set Subquery

* **Database:** `ProductOrders`
* **Objective:** Find customers who have **not** placed orders in the order range `310` to `700` using `WHERE CustID NOT IN (SELECT CustID WHERE OrderID BETWEEN 310 AND 700)`.

### Question 5: Threshold Filtering with Date Formatting

* **Database:** `MyGuitarShop`
* **Objective:** Query products priced higher than half the average list price (`WHERE ListPrice > (SELECT AVG(ListPrice)/2)`).
* **Formatting:** Formatted dates using Italian style 105 (`DD-MM-YYYY`) and currency output via `FORMAT()`.

### Question 6: Correlated Subqueries in Projection & Dynamic Age

* **Database:** `IMDB`
* **Objective:** Analyze creators born after 2000. Extended projection with subqueries counting records from `title_writers` and `title_directors`. Calculated age dynamically relative to the runtime environment year.

### Question 7: Single-Item Order Identification

* **Database:** `MyGuitarShop`
* **Objective:** Identify orders consisting of exactly one distinct item using `WHERE OrderID IN (SELECT OrderID ... GROUP BY OrderID HAVING COUNT(ProductID) = 1)`.

### Question 8: High-Value Sales Rep Filtering

* **Database:** `Examples`
* **Objective:** Filter sales totals over **$800,000** for sales years after **2014** using a subquery filter and `FORMAT()` currency styling.

### Question 9: User Profile Lookup Subquery

* **Database:** `Discussions`
* **Objective:** Extract forum posts by **'Alan Turing'** without using `JOIN` by retrieving the `UserID` dynamically via an inner subquery on `Profiles`.
* **Formatting:** Truncated content output using `CONVERT(char(55), Content)`.

### Question 10: Aggregated Top Sales Performance

* **Database:** `Examples`
* **Objective:** Retrieve the top 4 sales representatives based on cumulative sales across all recorded years. Looked up `RepLastName` using a correlated select subquery and grouped results by `RepID`.

---

## Technical Highlights

* **Subquery Patterns:** Scalar evaluation, set inclusion/exclusion (`IN` / `NOT IN`), correlated subqueries, inline projection subqueries.
* **Scalar Operations:** Standardized string conversions via `CONVERT()` and `CAST()`, currency formatting via `FORMAT()`, string pattern matching via `LIKE`.
