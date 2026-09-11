PRINT 'Question 1:
Customer in each state
-----------------------------------
For this query, count the customers in each state.
Use the Examples database.

Correct results will have 17 rows and look like this:

States          # of Customers
--------------- ---------------
AK				1
AR				1
CA				1
GA				1
...
NM				1
OR				3
RI				1
TX				1
WA				4
WY				1
' + CHAR(10)
GO

USE Examples
SELECT CustState AS "States",
       COUNT(*) AS "# of Customers"
FROM Customers
GROUP BY CustState;




GO

PRINT 'Question 2:
Discount
-------
Your manager wants you to extract/calculate the following data in the AP database:
Number of invoices submitted by a vendor.
Average invoice amount.
Total Invoice calculated for all invoices.
Calculating a 10% discount on Total Invoice.
The balance after applying discounts.
Format columns with names and formats as below.

The correct output should have 34 rows

Vendor ID   # Invoices  Avg Invoice Amnt Total Invoice 10% Discount Balance
----------- ----------- ---------------- ------------- ------------ ----------
34          2           $600.06          $1,200.12     $120.01      $1,080.11
37          3           $188.00          $564.00       $56.40       $507.60
48          1           $856.92          $856.92       $85.69       $771.23
72          2           $10,963.66       $21,927.31    $2,192.73    $19,734.58
...
122         9           $2,575.33        $23,177.96    $2,317.80    $20,860.16
123         47          $93.15           $4,378.02     $437.80      $3,940.22
' + CHAR(10)
GO
--
USE AP
SELECT  VendorID AS "Vendor ID",
        COUNT(InvoiceNumber) AS "# Invoices",
        ('$' + CAST(CAST(AVG(InvoiceTotal) AS MONEY) AS VARCHAR)) AS "Avg Invoice Amnt",
        ('$' + CAST(CAST(SUM(InvoiceTotal) AS MONEY) AS VARCHAR)) AS "Total Invoices",
        ('$' + CAST(CAST(SUM(InvoiceTotal * 0.10) AS MONEY) AS VARCHAR)) AS "10% Discount",
        ('$' + CAST(CAST(SUM(InvoiceTotal - (InvoiceTotal * 0.10)) AS MONEY) AS VARCHAR)) AS "Balance"
FROM Invoices
GROUP BY VendorID;

--

GO

PRINT 'Question 3:
Selecting Vendors
--------------
Your manager wants to know the number of invoices that vendors submitted. 
They want to see the vendors whose vendor ID is between 110 to 140 
   and whose total sales are greater than $1000.
Show the largest numbers first.
You need to use AP database.

Correct results will look like this:

Vendor ID   Number of Invoices
----------- ------------------
123         47
122         9
121         8
110         5
113         1
119         1
' + CHAR(10)
GO


USE AP
SELECT  VendorID AS "Vendor ID",
        COUNT(InvoiceNumber) AS "# Invoices"
FROM Invoices
WHERE (VendorID BETWEEN 110 AND 140)
GROUP BY VendorID
HAVING SUM(InvoiceTotal) > 1000
ORDER BY "# Invoices" DESC;



GO

PRINT 'Question 4:
MIN & MAX
---------
Use AP database for this query.
Calculate the number of invoices each vendor has submitted. 
Calculate the first 5 lowest and highest payment amounts by vendor.
Format the columns with proper names. Insert a dollar sign.

Vendor ID   # Invoices  Min Payment Max Payment
----------- ----------- ----------- -----------
34          2           $116.54     $1083.58
37          3           $0.00       $224.00
48          1           $856.92     $856.92
72          2           $0.00       $21842.00
80          2           $0.00       $175.00
' + CHAR(10)

GO

--
USE AP
SELECT  TOP 5
        VendorID AS "Vendor ID",
        COUNT(InvoiceNumber) AS "# Invoices",
        ('$' + CAST(CAST(MIN(PaymentTotal) AS MONEY) AS VARCHAR)) AS "Min Payment",
        ('$' + CAST(CAST(MAX(PaymentTotal) AS MONEY) AS VARCHAR)) AS "Max Payment"
FROM Invoices
GROUP BY VendorID;
--

GO



PRINT 'Question 5:
Sales Report
------------
Produce a report showing sales reps'' ID, their last names, and the amount of sales for 2015.
Display them in last name order.
You need to use JOIN for this problem.
Use Examples database for this query.
Correct results will look like this:

Rep ID      Rep Last Name Year Total Sales
----------- ------------- ---- ---------------
5           Kramer        2015 $422,847.86
3           Markasian     2015 $1,132,744.56
2           Martinez      2015 $974,853.81
1           Thomas        2015 $923,746.85
4           Winters       2015 $655,786.92
' + CHAR(10)

GO


--
USE Examples
SELECT SalesReps.RepID AS "Rep ID",
       RepLastName AS "Rep Last Name",
       SalesYear AS "Year",
       ('$' + CAST(CAST(SalesTotal AS MONEY) AS VARCHAR)) AS "Total Sales"
FROM SalesReps
JOIN SalesTotals ON SalesTotals.RepID = SalesReps.RepID
WHERE SalesTotals.SalesYear = '2015'
ORDER BY RepLastName;

--

GO

PRINT 'Question 6:
Price of items ordered
----------------------
Calculate the sum of the price of all items ordered for each product.
Use the OrderItems table in the MyGuitarShop database.
Make sure you subtract the price of the item by the discount amount, 
  and then multiply that by the quantity of the items. Make sure your 
  order of operations is correct in this calculation because it will matter!
Format your report as below.

Product ID  Item Price Total
----------- ----------------
1           $8,457.12      
2           $10,071.60     
3           $5,039.91      
4           $2,039.97      
5           $979.98        
6           $7,339.50      
7           $749.98        
8           $911.37        
9           $506.30        
10          $1,793.00   
' + CHAR(10)
GO

USE MyGuitarShop
SELECT ProductID,
       ('$' + CAST(CAST(SUM((ItemPrice - DiscountAmount) * Quantity) AS MONEY) AS VARCHAR)) AS "Item Price Total"
FROM OrderItems
GROUP BY ProductID;

--


GO

PRINT 'Question 7:
Total Price Using Rollup
------------------------
Modify problem 6 to also show the total for all products combined.
Use the ROLLUP Operator (Murach page 172 (2019) or 149 (2022)) to do so.
Correct results will be like this:

Product ID  Item Price Total
----------- --------------------
1           $8,457.12
2           $10,071.60
3           $5,039.91
4           $2,039.97
5           $979.98
6           $7,339.50
7           $749.98
8           $911.37
9           $506.30
10          $1,793.00
NULL        $37,888.73
' + CHAR(10)
GO


--
USE MyGuitarShop
SELECT ProductID,
       ('$' + CAST(CAST(SUM((ItemPrice - DiscountAmount) * Quantity) AS MONEY) AS VARCHAR)) AS "Item Price Total"
FROM OrderItems
GROUP BY ROLLUP(ProductID);




--
GO


PRINT 'Question 8:
Total Using ROLLUP
------------------------------
Calculate the complete total per date for vendor 123 using the ROLLUP 
  Operator (Page 172 or 149 Murach).
Use AP database for this query.
There will be 39 records.
Format your report as below. A label for the bottom total is optional.

Invoice Date Invoice Total
------------ --------------------
2015-12-10   $40.20              
2015-12-13   $138.75             
2015-12-16   $202.95     
. . .
2016-03-30   $22.57              
2016-04-02   $127.75 
TOTAL        $4,378.02  
' + CHAR(10)

GO

--
USE AP
SELECT CONVERT(varchar, InvoiceDate, 23) AS "Invoice Date",
       ('$' + CAST(CAST(SUM(InvoiceTotal)AS MONEY) AS VARCHAR)) AS "Invoice Total"
FROM Invoices
WHERE VendorID = '123'
GROUP BY ROLLUP(InvoiceDate);

--

GO

PRINT 'Question 9:
Customer Orders
--------------------
Using JOIN find customers who have placed orders that have 2 or more different items in them.
Format your report with approriate spacing and column numbers. 
You will be using the MyGuitarShop database.
Correct results will have 5 rows that look like this:

CustomerID  Customer Last Name Order ID    Items in Order
----------- ------------------ ----------- --------------
1           Sherwood           3           2
6           Wilson             7           3
14          Morasca            16          2
27          Whobrey            31          2
35          Caudy              41          2

' + CHAR(10)



GO


--COME BACK TO THIS ONE
USE MyGuitarShop
SELECT Orders.CustomerID, LastName, Orders.OrderID, COUNT(Quantity)
FROM Orders
JOIN Customers ON Customers.CustomerID = Orders.CustomerID
JOIN OrderItems ON OrderItems.OrderID = Orders.OrderID
GROUP BY  Orders.CustomerID, LastName, Orders.OrderID
HAVING COUNT(Quantity) >= 2;

--


GO

PRINT 'Question 10:
Finally, an easy one:-)
---------------------
Calculate the total sales for the SalesTotal.
Use Examples database.

Total Sales
--------------------
$8,900,668.14     
' + CHAR(10)

GO

--
USE Examples
SELECT ('$' + CAST(CAST(SUM(SalesTotal) AS MONEY) AS VARCHAR)) AS "Total Sales"
FROM SalesTotals;



--
