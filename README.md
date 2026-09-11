# Lab 3: Data Aggregation and Summary Queries

---

## Overview

This lab covers data aggregation and summary reporting in Transact-SQL (T-SQL). Key concepts demonstrated across these queries include multi-table relational joins, column aggregation functions (`SUM`, `COUNT`, `AVG`, `MIN`, `MAX`), filtering grouped results with `HAVING`, hierarchical super-aggregates using `ROLLUP`, and explicit currency data formatting via `CAST` and `MONEY` conversion.

---

## Lab Problems & Implementation Details

### Question 1: Customer Counts by State

* **Database:** `Examples`
* **Objective:** Group customer records by state to determine geographic distribution across 17 distinct regions.
* **Key T-SQL Construct:** `GROUP BY CustState` with `COUNT(*)`.

### Question 2: Vendor Invoice Financial Summary

* **Database:** `AP`
* **Objective:** Calculate per-vendor invoice counts, average invoice amounts, gross totals, a 10% calculated discount, and net post-discount balances across 34 vendors.
* **Key T-SQL Construct:** Aggregations (`AVG`, `SUM`), mathematical calculations on totals, and scalar formatting (`CAST(... AS MONEY)`).

### Question 3: High-Volume Sales Vendor Filter

* **Database:** `AP`
* **Objective:** Filter vendors in the ID range `110` through `140` who have cumulative invoice totals exceeding **$1,000**, ordered by highest invoice volume.
* **Key T-SQL Construct:** `WHERE` clause for primary filtering, `GROUP BY`, `HAVING SUM(InvoiceTotal) > 1000`, and `ORDER BY` descending.

### Question 4: Vendor Payment Ranges

* **Database:** `AP`
* **Objective:** Identify the aggregate payment boundaries (`MIN` and `MAX`) alongside invoice counts per vendor, returning the top 5 records.
* **Key T-SQL Construct:** `TOP 5`, `MIN(PaymentTotal)`, `MAX(PaymentTotal)`.

### Question 5: Annual Sales Representative Report

* **Database:** `Examples`
* **Objective:** Produce a sales performance report for 2015 displaying representative IDs, last names, and total sales ordered alphabetically.
* **Key T-SQL Construct:** `JOIN` between `SalesReps` and `SalesTotals` on `RepID`, filtered by `SalesYear = '2015'`.

### Question 6: Net Order Revenue per Product

* **Database:** `MyGuitarShop`
* **Objective:** Compute total revenue generated per product after adjusting for unit discounts:
$$\text{Total} = \sum (\text{ItemPrice} - \text{DiscountAmount}) \times \text{Quantity}$$


* **Key T-SQL Construct:** Mathematical expression evaluation inside `SUM()` with explicit operator precedence.

### Question 7: Product Sales Summary with Grand Total

* **Database:** `MyGuitarShop`
* **Objective:** Extend Question 6 to append a summary grand total row across all product lines.
* **Key T-SQL Construct:** `GROUP BY ROLLUP(ProductID)`.

### Question 8: Dated Vendor Invoice Rollup

* **Database:** `AP`
* **Objective:** Produce a chronological daily invoice breakdown for Vendor `123` with a summary total row at the bottom.
* **Key T-SQL Construct:** `GROUP BY ROLLUP(InvoiceDate)` with `CONVERT(varchar, InvoiceDate, 23)` for ISO date formatting (`YYYY-MM-DD`).

### Question 9: Multi-Item Customer Orders

* **Database:** `MyGuitarShop`
* **Objective:** Identify customer orders that contain **2 or more** distinct line items.
* **Key T-SQL Construct:** Three-table `JOIN` (`Customers`, `Orders`, `OrderItems`) with `GROUP BY` and `HAVING COUNT(Quantity) >= 2`.

### Question 10: Overall Enterprise Revenue

* **Database:** `Examples`
* **Objective:** Compute the total cumulative sales revenue recorded across all sales regions and years.
* **Key T-SQL Construct:** Scalar table-wide aggregation `SUM(SalesTotal)`.

---

## Technical Highlights

* **Grouping & Aggregation:** Heavy utilization of `GROUP BY` paired with `HAVING` filters to isolate summary-level records without altering base table rows.
* **Super-aggregates:** Usage of `ROLLUP` to generate automatic subtotal and grand total rows for reporting contexts.
* **Currency Formatting Pattern:** Standardized dollar string conversion pattern across queries:
```sql
'$' + CAST(CAST(SUM(ColumnName) AS MONEY) AS VARCHAR)

```
