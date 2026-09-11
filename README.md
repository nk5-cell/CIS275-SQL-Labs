# Lab 1: Basic Queries, Filtering, and Data Formatting

---

## Overview

This lab covers essential single-table SQL querying techniques in Transact-SQL (T-SQL). Key concepts include conditional filtering (`WHERE`, `BETWEEN`, `IN`, `LIKE`), string pattern matching with wildcards, fixed-width output formatting (`CONVERT`, `CAST`, `LEFT`), string concatenation for currency output, and dataset limiting (`TOP`).

---

## Lab Problems & Implementation Details

### Question 1: Invoices in Price Range

* **Database:** `AP`
* **Objective:** Extract invoice records with totals falling between $1,000 and $1,700.
* **Key T-SQL Construct:** `WHERE InvoiceTotal BETWEEN 1000 AND 1700` selecting `VendorID` and `InvoiceTotal`.

### Question 2: Vendor State Pattern Matching

* **Database:** `AP`
* **Objective:** Retrieve vendors located in states starting with the letter 'N', formatted to explicit column widths.
* **Key T-SQL Construct:** `WHERE VendorState LIKE 'N%'` combined with `CONVERT(char(25), VendorName)` and `CONVERT(char(5), VendorState)`.

### Question 3: Excluding Specific State Vendors

* **Database:** `AP`
* **Objective:** Generate a unique list of vendors ending in 'Inc' while excluding those in Massachusetts (`MA`) or Virginia (`VA`).
* **Key T-SQL Construct:** `DISTINCT` keyword, `LEFT()` string truncation for formatting, and boolean filtering: `WHERE VendorName LIKE '%Inc' AND NOT (VendorState = 'MA' OR VendorState = 'VA')`.

### Question 4: Pacific Northwest Zip Code Filter

* **Database:** `Examples`
* **Objective:** Find customers in Oregon (`OR`) or Washington (`WA`) whose zip code contains the digit `2`.
* **Key T-SQL Construct:** `CustState IN ('OR', 'WA')` paired with wildcard range matching `CustZip LIKE '%[2]%'`.

### Question 5: P.O. Box Address Identification

* **Database:** `AP`
* **Objective:** Locate vendors whose secondary address line represents a P.O. Box, accommodating variations with or without periods.
* **Key T-SQL Construct:** `WHERE VendorAddress2 LIKE 'PO%' OR VendorAddress2 LIKE 'P.O.%'`.

### Question 6: Vendor Return Formatting

* **Database:** `Examples`
* **Objective:** Identify vendors with non-zero Year-To-Date returns and prepend a dollar sign to the output.
* **Key T-SQL Construct:** String concatenation with type casting: `'$' + CONVERT(varchar(10), YTDReturns)`, filtering out zero values via `YTDReturns NOT LIKE '0.00'`.

### Question 7: Purchase Date and Amount Filtering

* **Database:** `Examples`
* **Objective:** Filter vendors with YTD purchases between $1,100 and $4,000 made between March 1, 2015, and October 30, 2015.
* **Key T-SQL Construct:** Double range filtering using `BETWEEN` on both date and numeric attributes, formatted using date style 106 (`DD Mon YYYY`).

### Question 8: Zero-Purchase Vendor Audit

* **Database:** `Examples`
* **Objective:** Pull all vendors with zero recorded YTD purchases and display formatted currency values.
* **Key T-SQL Construct:** Exact string matching on decimal storage `YTDPurchases = '0.0000'` formatted as `'$0.00'`.

### Question 9: Top 10 Purchasers

* **Database:** `Examples`
* **Objective:** Isolate the 10 vendors with the highest YTD purchases, formatted as standard currency with commas.
* **Key T-SQL Construct:** `SELECT TOP 10` combined with money-style formatting: `'$' + CONVERT(varchar(20), CAST(YTDPurchases AS money), 1)`, sorted in descending order (`ORDER BY YTDPurchases DESC`).

### Question 10: Metaphone Phonetic Search

* **Database:** `NAMES`
* **Objective:** Find all names in the database sharing the metaphone phonetic representation `'MR'` (sounding like "Mary").
* **Key T-SQL Construct:** Basic string equality filter `WHERE Metaphone = 'MR'` ordered alphabetically by `Name`.

---

## Technical Highlights

* **Data Type Conversions:** Utilizing `CONVERT()` and `CAST()` to force fixed-width tabular character alignment in script output windows.
* **Pattern & Wildcard Matching:** Using `%` for zero-or-more character matching and `[...]` for explicit character set inclusion.
* **Currency Formatting:** Constructing dynamic currency strings directly in T-SQL using SQL Server money conversion styles (`style 1`).
