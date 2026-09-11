PRINT 'Question 1:
What are the order numbers?
---------------------
Create a query that returns all order numbers that have an order amount
     between $1000 and $1700.
You will be using the Invoices table.
The name of the database is AP.
You need to use the following:
- WHERE
- AND
- BETWEEN
Display only the VendorID and InvoiceTotal columns.
Hint: correct results will look like this.

VendorID    InvoiceTotal
----------- ---------------------
107         1600.00
83          1575.00
34          1083.58
103         1367.50
121         1000.46
' + CHAR(10)

GO

USE AP;
SELECT  VendorID,
        InvoiceTotal
FROM    Invoices
WHERE   InvoiceTotal BETWEEN 1000 AND 1700;

--

GO

PRINT 'Question 2:
Write a SELECT statement that finds all vendors whose state name starts with N.
You will be using the Vendors table. The name of the database is AP.
You need to use the following:
   - WHERE
   - LIKE
   - Wildcard

Display Vendor''s Name and Vendor''s State.
This time, use CONVERT to make the name 25 characters wide and state 5 characters wide.
Note that some characters of the name will be chopped off.
Use AS to rename the columns. Always use double quotes with AS to make your code portable.
Display results in ascending order by VendorName.
You should get 10 records.

Hint: Correct results will look like this:

Vendor Name               State
------------------------- -----
American Booksellers Asso NY
Baker & Taylor Books      NC
Cahners Publishing Compan NV
Newbrige Book Clubs       NJ
Rich Advertising          NJ
RR Bowker                 NJ
Simon Direct Inc          NJ
The Mailers Guide Co      NY
United Parcel Service     NV
Venture Communications In NY
' + CHAR(10)

GO

USE AP;
SELECT      CONVERT(char(25), VendorName, 1) AS "Vendor Name",
            CONVERT(char(5), VendorState, 1) AS "State"
FROM        Vendors
WHERE       VendorState LIKE 'N%'
ORDER BY    VendorName ASC;

--


GO

PRINT 'Question 3:
Excluding Vendors?
--------------------
Create a list of distinct Vendors based on the following:
- Inlcude only vendors that end with ''Inc''
- Ignore all vendors who reside in Massachusetts or Virginia
- Sort the result in alphabetical order by Vendor name
- Use LIKE operator
- Use DISTINCT keyword
You will be using Vendors table, which is within the AP database.
Display the vendor''s name, state, city and phone
   with the vendor name no more than 30 characters wide and the others 15.
Make sure all your columns are named as shown below.
Hint: Correct results will have 11 rows and will look like this:

Vendor Name                    Vendor State    Vendor City     Vendor Phone
------------------------------ --------------- --------------- ---------------
Bertelsmann Industry Svcs. Inc CA              Valencia        (805) 555-0584
Bill Marvin Electric Inc       CA              Fresno          (559) 555-5106
Boucher Communications Inc     PA              Fort Washington (215) 555-8000
. . .
Roadway Package System, Inc    CA              Pasadena        NULL
Simon Direct Inc               NJ              East Brunswick  (908) 555-7222

' + CHAR(10)

GO

USE AP;
SELECT DISTINCT LEFT(VendorName,30) AS "Vendor Name",
                LEFT(VendorState,15) AS "Vendor Sate",
                LEFT(VendorCity,15) AS "Vendor City",
                LEFT(VendorPhone,15) AS "Vendor Phone"
FROM            Vendors
WHERE           VendorName LIKE '%Inc' AND NOT (VendorState = 'MA' OR VendorState = 'VA');

GO


GO

PRINT 'Question 4:
The favorite States?
--------------------
Find the last names of customers who reside in the following states:
OR
WA
Your query should include:
- Using IN and LIKE operators
- Only list customers whose zipcode contains the number 2 in it
- Give all columns relevant names
- The result should be ordered in ASC by the customer name
- USE Customers table from the Examples database

Produce the following columns: Customer Last Name, Customer States, and Customer Zip Codes.

Hint: Correct results will have 4 rows and will look like this:
Customer Last Name State Zip Code
------------------ ----- ----------
Jablonski          WA    98128
Latimer            OR    97827
Steel              WA    99362
Wilson             OR    97219
' + CHAR(10)

GO

USE Examples;
SELECT      CustomerLast AS "Customer Last Name",
            CustState AS "State",
            CustZip AS "Zip Code"
FROM        Customers
WHERE       CustState IN ('OR', 'WA') AND (CustZip LIKE '%[2]%')
ORDER BY    CustomerLast ASC;

--
GO


GO

PRINT 'Question 5:
PO BOX Address2
----------------
Find all Vendors whose address2 is a P.O. Box.
Here are the conditions:
- You must use Like and OR Operators
- Some P.O. Box addresses do not include a period so be sure to include them also
- The Vendors table within the Examples database will be used
- There are 9 records
- Do not forget to rename columns
- The output should look like the following (note the spacing and sort)

P.O. Box Address     Vendor Name
-------------------- ----------------------------------------
PO Box 944230        Bill Jones
PO Box 61000         Computerworld
P.O. Box 1952        Fresno Photoengraving Company
PO Box 61000         Kent H Landsberg Co
PO Box 1124          Malloy Lithographing Inc
PO Box 205           Open Horizons Publishing
PO Box 826276        State of California
PO Box 7005          US Postal Service
P.O. Box 29479       Wells Fargo Bank
' + CHAR(10)

GO

USE AP;
SELECT      VendorAddress2 AS "P.O. Box Address",
            VendorName AS "Vendor Name"
FROM        Vendors
WHERE       VendorAddress2 LIKE 'PO%' OR VendorAddress2 LIKE 'P.O.%'
ORDER BY    VendorName;

--
GO


PRINT 'Question 6:
--Returns
---------
Vendors sometimes return the items they have purchased.
Management wants to know which vendors have returned items they purchased.
Make sure you consider the following:
-Use the vendors table from the Examples database
-Format Vendor ID 9 characters wide, Vendor Name 20 characters, and Returns 10 characters.
-Add a dollar sign to the dollar values. Use any of the methods mentioned in Lecture 2, Sample Code.
-As always, since you do not know the results before you write your code, do not use
   any of the values (98, American Express, $556.19) in your code.
-Correct results will have 1 row and will look like this:

Vendor ID Vendor Name          Return Amount
--------- -------------------- -------------
98        American Express     $556.19
' + CHAR(10)
GO


USE Examples;
SELECT      CONVERT(char(9), VendorID, 1) AS "Vendor ID",
            CONVERT(char(20), VendorName, 1) AS "Vendor Name",
            ('$' + CONVERT(varchar(10), YTDReturns)) AS "Return Amount"
FROM        Vendors
WHERE       YTDReturns NOT LIKE '0.00';



--
GO


GO

PRINT 'Question 7:
Purchase ranges?
---------------
The management wants to see a list of vendors whose YTDPurchase is between 1100 and 4000
and have made the purchases between 2015-03-01 and 2015-10-30.
-
Consider the following:
-Use the Vendors table from the Examples database
-Display results ordered by VendorName
-Show ONLY the Vendor Name, Transaction Date, and Purchases
-Use CAST or CONVERT to format columns
-See Dates_CONVERT.sql for format to use for the date
-Add a dollar sign to the YTDPurchase
-Make sure all columns have appropriate names (using AS where needed)
-Order result by vendors''name in ASC order
-Correct results will have 8 rows, and should look like this:

Vendor Name                    Transaction Date YTD Purchases
------------------------------ ---------------- -------------
Cardinal Business Media, Inc.  23 Oct 2015      $2905.00
Frank E Wilber Co              12 Sep 2015      $1934.70
Fresno Credit Bureau           12 Sep 2015      $2663.26
Retirement Plan Consultants    09 Oct 2015      $1660.00
Springhouse Corp               29 Jul 2015      $1942.25
State Board Of Equalization    09 Oct 2015      $2433.00
The Presort Center             09 Oct 2015      $2377.43
The Windows Deck               29 Jul 2015      $2975.00
' + CHAR(10)

GO

--
USE Examples;
SELECT      VendorName AS 'Vendor Name',
            CONVERT(CHAR(12),LastTranDate,106) AS 'Transaction Date',
            ('$' + CONVERT(varchar(7), YTDPurchases)) AS "YTD Purchases"
FROM        Vendors
WHERE       (LastTranDate BETWEEN '2015-03-01' AND '2015-10-30') AND (YTDPurchases BETWEEN '1100' AND '4000')
ORDER By    VendorName ASC;



--
GO


GO

PRINT 'Question 8:
No Purchase Report
--------------
Management would like to have a report to show the names of vendors who have not purchased anything.
-Consider the following:
-Use Vendors table from the Examples database
-Insert a $ sign using any method
-The result will have 28 rows
-Format columns with proper spacing and column names

Correct results will look like this:

Vendor Name                         Year To Date Purchases
----------------------------------- ----------------------
ASC Signs							$0.00
BFI Industries						$0.00
Bill Marvin Electric Inc			$0.00
Blanchard & Johnson Associates		$0.00
...
Yale Industrial Trucks-Fresno		$0.00
Zee Medical Service Co				$0.00
' + CHAR(10)

GO

--
USE Examples;
SELECT      VendorName AS 'Vendor Name',
            ('$' + CONVERT(varchar(4), YTDPurchases)) AS 'Year To Date Purchases'
FROM        Vendors
WHERE       YTDPurchases = '0.0000'
ORDER By    VendorName ASC;

--



GO


PRINT 'Question 9:
10 buyers
------------------------
Produce a list of the vendors who have made the top 10 purchases.
-Consider the following:
-Use vendors table from the Examples database
-Exclude NULL and Zero values and limit columns to no more than 20 characters wide.
-Order output YTDPurchases in DESC order
-Insert a $ sign
-The result will have 10 rows
-Format your results to look like this:

Purchases Year To Date Vendor
---------------------- --------------------
$213,039.65            Malloy Lithographing
$93,601.99             United Parcel Servic
$48,690.51             Yesmed, Inc
$44,995.75             Valprint
$39,420.56             Bertelsmann Industry
$30,486.44             Zylka Design
$29,742.98             Federal Express Corp
$29,522.50             Dean Witter Reynolds
$28,740.10             American Express
$27,462.56             Courier Companies, I
' + CHAR(10)

GO

--

USE Examples;
SELECT TOP 10
            ('$' + CONVERT(varchar(20), CAST(YTDPurchases AS money),1)) AS 'Purchases Year To Date',
            CONVERT(char(20), VendorName) AS 'Vendor'
FROM        Vendors
WHERE       YTDPurchases IS NOT NULL AND YTDPurchases <> '0'
ORDER BY    YTDPurchases DESC;



--
GO


GO

PRINT 'Question 10:
Names that sound like Mary
-----------------
The metaphone for "Mary" is "MR". Find all other names that have the same metaphone.
-Consider the following:
-The database name is NAMES
-Format the columns with proper names and widths
-Order the results in name sequence
-There are 148 rows

Name            Metaphone
--------------- ---------
Maari           MR
Maaria          MR
Mahra           MR
Mahri           MR
Mahria          MR
Mahriah         MR
...
Mary            MR
Mauer           MR
...
' + CHAR(10)

GO

USE NAMES;
SELECT      Name,
            Metaphone
FROM        names
WHERE       Metaphone = 'MR'
ORDER BY    Name ASC;
--
