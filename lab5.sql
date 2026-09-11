PRINT 'Question 1:
Display the list of orders that only have one item.
Use the ProductOrders database.
Format your columns accordingly.
There should be 29 records.

OrderID     Item ID     Quantity
----------- ----------- --------
19          5           1
32          7           3
70          1           1
89          4           1
...
703         4           1
773         10          2
827         6           1
' + CHAR(10)
--
USE ProductOrders
SELECT      OrderID,
            ItemID AS "Item ID",
            Quantity
FROM        OrderDetails
WHERE       OrderID IN (
    SELECT      OrderID
    FROM        OrderDetails
    GROUP BY    OrderID
    HAVING      COUNT(ItemID) = 1
    )
ORDER BY    OrderID;



--

GO
PRINT 'Question 2:
Write a common table expression to identify Vendors who have some Total Credit.
Also display the total number of all their invoices.
The AP database will be used for this problem.

Vendor ID   Vendor Name                    Total Credit    NBR_Invoices
----------- ------------------------------ --------------- ------------
110         Malloy Lithographing Inc       $3,495.95       5
121         Zylka Design                   $200.00         8
'+ CHAR(10)

GO

--
USE AP
SELECT      Vendors.VendorID AS "Vendor ID",
            Vendors.VendorName AS "Vendor Name",
            FORMAT(SUM(Invoices.CreditTotal), '$#,#.00') AS "Total Credit",
            COUNT(Invoices.InvoiceID) AS "NBR_Invoices"
FROM        Vendors
JOIN        Invoices ON Invoices.VendorID = Vendors.VendorID
GROUP BY    Vendors.VendorID, Vendors.VendorName
HAVING      SUM(Invoices.CreditTotal) > 0
ORDER BY    "Vendor ID";

--


GO
PRINT 'Question 3:
Your manager wants you to provide the number of orders which were placed between
  Dec 1, 2015 and April 1, 2016 each day any orders were placed.
Show the complete names of each customer in date order.
Use the ProductOrders database.
Use the DATENAME Function (Ch 9 Murach) to format the dates.

Date                           Customer Name             # Orders
------------------------------ ------------------------- -----------
Monday, December 21, 2015      Dakota Baylee             1
Friday, December 25, 2015      Erick Kaleigh             1
Friday, December 25, 2015      Kaitlin Hostlery          1
Sunday, January 3, 2016        Samuel Jacobsen           3
Monday, January 4, 2016        Yash Randall              1
...
Saturday, March 19, 2016       Samuel Jacobsen           1
Monday, March 21, 2016         Kyle Marissa              1
Monday, March 21, 2016         Yash Randall              1
Friday, April 1, 2016          Korah Blanca              1
'+ CHAR(10)
--
USE ProductOrders
SELECT      (DATENAME(dw, o.OrderDate) + ', ' + DATENAME(mm, o.OrderDate) + ' ' + DATENAME(dd, o.OrderDate) + ', ' + DATENAME(yy, o.OrderDate)) AS "Date",
            CONCAT_WS(' ', c.CustFirstName, c.CustLastName) AS "Customer Name",
            COUNT(OrderID) AS "# Orders"
FROM        Customers c
JOIN        Orders o ON o.CustID = c.CustID
WHERE       CAST(CAST(o.OrderDate AS char(11)) AS datetime) BETWEEN '2015-12-01' AND '2016-04-01'
GROUP BY    o.OrderDate, c.CustFirstName, c.CustLastName;

--
GO


GO
PRINT 'Question 4:
Find all customers who placed orders in 2014 but did not place any in 2016.
There are several good ways to solve this. Choose one.
Use the ProductOrders database.

CustID      Customer First Name Customer Last Name City
----------- ------------------- ------------------ ---------------
3           Johnathon           Millerton          New York
8           Deborah             Damien             Fresno
10          Kurt                Nickalus           Valencia
11          Kelsey              Eulalia            Sacramento
14          Gonzalo             Keeton             Fairfield
22          Rashad              Holbrooke          Fresno
24          Julian              Carson             San Francisco
.' + CHAR(10)
--
USE ProductOrders
SELECT DISTINCT CustID AS "CustID",
                CustFirstName AS "Customer First Name",
                CustLastName AS "Customer Last Name",
                CustCity AS "City"
FROM            Customers
WHERE           CustID IN
    (SELECT CustID
    FROM    Orders
    WHERE   YEAR(OrderDate) = 2014 AND CustID NOT IN
        (SELECT CustID
        FROM    Orders
        WHERE   YEAR(OrderDate) = 2016))
ORDER BY CustID;

--
GO
PRINT 'Question 5:
Do the previous questions again using a different technique. It might be
   solved using joins, subqueries, CTEs, EXCEPT, a combination of these,
   or some other way.
Whichever you used in Q4, do not use that same way here.
   If Q4 had a subquery, no subquery here.
   If Q4 had a join, no join here.
   Etc.
Note that your results here should match your results in Q4.
' + CHAR(10)
--


USE ProductOrders;

WITH year2014s AS
(
    SELECT  DISTINCT CustID
    FROM    Orders
    WHERE   YEAR(OrderDate) = 2014
),
yearNot2016s AS
(
    SELECT  DISTINCT CustID
    FROM    Orders
    WHERE   YEAR(OrderDate) = 2016
),
combined AS
(
    SELECT CustID
    FROM year2014s
    EXCEPT
    SELECT CustID
    FROM yearNot2016s
)

SELECT DISTINCT c.CustID AS "CustID",
                c.CustFirstName AS "Customer First Name",
                c.CustLastName AS "Customer Last Name",
                c.CustCity AS "City"
FROM            Customers c
JOIN combined y ON y.CustID = c.CustID
ORDER BY "CustID";

--

GO

GO

PRINT 'Question 6:
In which quarters have customers placed orders in 2015?
Show the number of orders and the total quantity placed then.
Use the ProductOrders database and show them in customer and quarter order.
Hint: Use DATEPART Function (Ch 9 Murach).

Customer Name             Year        Quarter     # Orders    Total Quantity
------------------------- ----------- ----------- ----------- --------------
Ania Irvin                2015        1           1           1
Dakota Baylee             2015        4           2           3
Derek Chaddick            2015        3           1           1
Erick Kaleigh             2015        4           1           2
...
Trisha Anum               2015        1           1           2
Yash Randall              2015        2           1           1
Yash Randall              2015        4           1           1
'+ CHAR(10)
--
USE ProductOrders
SELECT      CONCAT_WS(' ', c.CustFirstName, c.CustLastName) AS "Customer Name",
            DATEPART(yy, OrderDate) AS "Year",
            DATEPART(qq, OrderDate) AS "Quarter",
            COUNT(DISTINCT od.OrderID) AS "# Orders",
            SUM(Quantity) AS "Total Quantity"
FROM        Customers c
JOIN        Orders o ON o.CustID = c.CustID
JOIN        OrderDetails od ON od.OrderID = o.OrderID
WHERE       DATEPART(yy, OrderDate) = 2015
GROUP BY    c.CustFirstName, c.CustLastName, DATEPART(yy, OrderDate), DATEPART(qq, OrderDate)
ORDER BY    "Customer Name", "Quarter";

--
GO


GO
PRINT 'Question 7:
Write a query to find the products whose list price is greater than or equal to the
  average list price of the products that are in category 3.
Sort by the list price.
Use database MyGuitarShop.

ProductID   Product Name                             List Price CategoryID
----------- ---------------------------------------- ---------- -----------
7           Fender Precision                         799.99     2
10          Tama 5-Piece Drum Set with Cymbals       799.99     3
2           Gibson Les Paul                          1199.00    1
3           Gibson SG                                2517.00    1
'+ CHAR(10)
--

USE MyGuitarShop
SELECT      ProductID AS "ProductID",
            ProductName AS "Product Name",
            FORMAT(ListPrice, '#.00') AS "List Price",
            CategoryID AS "CategoryID"
FROM        Products
WHERE       ListPrice >=
(
    SELECT  AVG(ListPrice)
    FROM    Products
    WHERE   CategoryID = 3
)
ORDER BY    ListPrice;


--
GO


GO
PRINT 'Question 8:
Display the difference between when the order was placed and when the order was shipped.
If it was never shipped, display 9999.
You need to use DATEDIFF and CASE (Ch 9 in Murach).
Display the TOP 10 days late only.
Use ProductOrders for this problem.
Display the results as follows.

OrderID     CustID      Date Ordered Date Shipped Days Late
----------- ----------- ------------ ------------ -----------
824         1           04-01-2016                9999
827         18          04-02-2016                9999
829         9           04-02-2016                9999
180         24          12-25-2014   01-30-2015   36
...
548         2           11-22-2015   12-18-2015   26
158         9           12-04-2014   12-20-2014   16
'+ CHAR(10)
--
USE ProductOrders
SELECT      TOP 10 OrderID AS "OrderID",
                   CustID AS "CustID",
                   CONVERT(char(12), OrderDate, 110) AS "Date Ordered",
                   ISNULL(CONVERT(char(12), ShippedDate, 110), ' ') AS "Date Shipped",
            CASE
                WHEN (DATEDIFF(day, OrderDate, ShippedDate)) IS NULL
                    THEN 9999
                ELSE DATEDIFF(day, OrderDate, ShippedDate)
            END AS "Days Late"
FROM        Orders
ORDER BY    "Days Late" DESC;

--
GO


GO
PRINT 'Question 9:
What orders were placed by each customer on their last order date?
For example, Customer ID 1 has placed one orders on�6/23/15, 9/30/15 and 4/01/16.
We want the order number for the one that was placed on 4/01/16.
Use subquery to produce the output.
Display the first 6 customers.
The ProductOrders database will be used for this problem.

CustID      OrderID     Date Ordered
----------- ----------- ------------
1           824         04/01/16
2           802         03/21/16
3           523         11/07/15
4           494         10/10/15
5           442         08/28/15
6           606         12/25/15
' + CHAR(10)
--
USE ProductOrders
SELECT TOP 6 CustID AS "CustID",
             MAX(OrderID) AS "OrderID",
             CONVERT(char(12), MAX(OrderDate), 1) AS "Date Ordered"
FROM         Orders
GROUP BY     CustID
ORDER BY     CustID;


--
GO



GO
PRINT 'Question 10:
Calculate the percent of total sales of each sales rep in 2014.
The calculation will show the percentage of the total sales for each
  rep compared to the company overall total sales for all years.
For example, if the overall sales for all years was $10,000 and
  rep''s total sales for 2014 was $1000, the percentage would be 10%.
Use both a subquery and JOIN.
Use the Examples database.
Sort the results by the highest sales.

Rep ID Last Name  2014 Totals   % of Company Sales
------ ---------- ------------- ------------------
1      Thomas     $1,274,856.38 14.32%
3      Markasian  $1,032,875.48 11.60%
2      Martinez   $978,465.99   10.99%
' + CHAR(10)
--

--Use both a subquery and JOIN.
USE Examples;
SELECT      r.RepID AS "Rep ID",
            r.RepLastName AS "Last Name",
            FORMAT(t.SalesTotal, '$#,#.00') AS "2014 Totals",
            FORMAT(t.SalesTotal /p.SalesTotal, 'P2') AS "% of Company Sales"
FROM        SalesReps r
JOIN        SalesTotals t ON t.RepID = r.RepID
CROSS JOIN (
    SELECT SUM(SalesTotal) AS "SalesTotal"
    FROM SalesTotals AS "Total"
) p
WHERE       t.SalesYear = 2014
ORDER BY    "% of Company Sales" DESC;
