PRINT 'Question 1:
Matching States
-------------
This week we focus on subqueries.
To start, write a subquery to find vendors'' names, and other info
    whose state matches the state of a vendor named ''Newbrige Book Clubs''.
Format the name and address to 23 characters each.
Use the AP database.

Vendor ID   State Vendor Name             Address
----------- ----- ----------------------- -----------------------
5           NJ    Newbrige Book Clubs     3000 Cindel Drive
27          NJ    Rich Advertising        12 Daniel Road
32          NJ    RR Bowker               PO Box 31
76          NJ    Simon Direct Inc        4 Cornwall Dr Ste 102
' + CHAR(10)

GO

--
USE AP
SELECT  CONVERT(char(23), VendorID) AS "Vendor ID",
        CONVERT(char(23), VendorState) AS "State",
        CONVERT(char(23), VendorName) AS "Vendor Name",
        CONVERT(char(23), VendorAddress1) AS "Address"
From    Vendors
WHERE   VendorState = (
    SELECT  VendorState
    FROM    Vendors
    WHERE   VendorName = 'Newbrige Book Clubs'
    );



--

GO


PRINT 'Question 2:
Run Time Minutes
---------
Write a SQL subquery to find the primary titles of the records whose
    runtime minutes are more than the average runtime minutes.
Return Primary Title and Runtime Minutes.
Use only subqueries and no joins. Do not hard-code any strings from the results.
You will be using IMDB database.
There will be 537,945 rows if you eliminate duplicate titles.
    Note that there is more than one way to eliminate duplicates.
	See the sample code in lesson 4 for two techniques.
Format the output with proper names. Truncate Primary Title to 90 characters.
The correct answer will be sorted and look like this:

Primary Title                                                                              Run Time Minutes
------------------------------------------------------------------------------------------ ----------------
----                                                                                       80
'' AV muri'' Fukada Nana 107 cmK kappu gingakei saikyo oppai muchakucha damashi momi         120
'' Horse Trials ''                                                                           120
!Women Art Revolution                                                                      83
"All in the Family" Retrospective                                                          90
"Are They All Yours?" Live Q & A                                                           72
"Bort g� de, stumma skrida de..."                                                          49
...
ZZ Top: Live at Montreux 2013                                                              81
ZZ Top: Live from Texas                                                                    122
Zzim                                                                                       101
ZZonk!! Splatt!!- the World of Children''s Comics                                           50
ZZZZZ                                                                                      51
' + CHAR(10)

--
USE IMDB
SELECT DISTINCT CONVERT(char(90), primaryTitle) AS "Primary Title",
                runtimeMinutes AS "Run Time Minutes"
FROM            title_basics
WHERE           runtimeMinutes >
                    (SELECT AVG(runtimeMinutes)
                    FROM    title_basics)
ORDER BY        "Primary Title", runtimeMinutes;




--

GO

PRINT 'Question 3:
MIN Price
----------
Use a subquery and no joins to find for each order which products
   had the lowest quantity.
Use the MyGuitarShop database.
Format the columns with proper columns names.
Correct answers will have 45 rows and will look like this:

Order#      Product ID  Quantity
----------- ----------- -----------
1           2           1
2           8           1
3           1           1
3           9           1
4           2           2
...
40          6           1
41          6           1
41          8           1
' + CHAR(10)

GO

--
USE MyGuitarShop
SELECT      OrderID AS "Order#",
            ProductID AS "Product ID",
            Quantity AS "Quantity"
FROM        OrderItems AS i
WHERE       Quantity = (
                SELECT MIN(Quantity)
                FROM OrderItems AS v
                WHERE v.OrderID = i.OrderID)
ORDER BY    OrderID, ProductID;






GO

PRINT 'Question 4:
Customers
----------
Write a SQL subquery and no joins to find those customers whose ID is not in orders 310-700.
The database is ProductOrders.
Format columns with appropriate names.
There will be 11 rows. Return the fields that are in the output below.

Customer ID Last Name       First Name      City
----------- --------------- --------------- --------------------
8           Damien          Deborah         Fresno
10          Nickalus        Kurt            Valencia
11          Eulalia         Kelsey          Sacramento
...
24          Carson          Julian          San Francisco
25          Story           Kirsten         Washington
' + CHAR(10)

GO

--
USE ProductOrders
SELECT  CustID AS "Customer ID",
        CustLastName AS "Last Name",
        CustFirstName AS "First Name",
        CustCity AS "City"
FROM    Customers
WHERE   CustID NOT IN (
    SELECT  CustID
    From    Orders
    WHERE   OrderID BETWEEN 310 AND 700);

--

GO




GO
PRINT 'Question 5:
High Prices
-----------
Your manager who is Italian wants you to find all products whose
   list price is more than half the average list price. That is,
   if the average was $1000, show all those with prices over $500.
Use MyGuitarShop.
Write a subquery to produce the following output, using Italian date format.
There should be 8 rows.
Hint: Remember Dates_CONVERT from module 2.

Product Name                             List Price      Category ID Date Added
---------------------------------------- --------------- ----------- ------------
Fender Stratocaster                      $699.00         1           30-10-2015
Gibson Les Paul                          $1,199.00       1           05-12-2015
Gibson SG                                $2,517.00       1           04-02-2016
...
Tama 5-Piece Drum Set with Cymbals       $799.99         3           30-07-2016
' + CHAR(10)

--
USE MyGuitarShop
SELECT  ProductName AS "Product Name",
        FORMAT(ListPrice, '$#,#.00') AS "List Price",
        CategoryID AS "Category ID",
        CONVERT(char(12), DateAdded, 105) AS "Date Added"
FROM    Products
WHERE   ListPrice > (
            SELECT  AVG(ListPrice)/2
            FROM    Products);
--


GO

PRINT 'Question 6:
Young Writers
-------------
Review the following subquery:'
USE IMDB
SELECT	TOP 10	CAST(primaryName AS CHAR(20)) AS primaryName,
			birthYear AS DOB,
			(SELECT		COUNT(*) AS "Nbr Written"
			FROM		title_writers AS TD
			WHERE		nconst = NB.nconst
			) AS WRITTEN
FROM		name_basics AS NB
WHERE		birthYear > 2000
ORDER BY	WRITTEN DESC;
PRINT '
1- In a paragraph, explain the purpose of the above query. What does it do?
2- Revise the query to produce the following result.
Do not use any joins.
Make AGE be correct no matter when it is executed.
Note that this shows it in the order of the highest number directed.

NAME                 DOB         AGE         WRITTEN     DIRECTED
-------------------- ----------- ----------- ----------- -----------
Chase Ramos          2001        25          118         128
Eric Martinez        2001        25          74          92
...
Miranda Laird        2004        22          8           14
Kacey Fifield        2005        21          0           11
' + CHAR(10)

-- Purpose of the query
--The purpose of the query is that it selects top 10 names from IMDB database
--who's birthyear is after 2000 to see the number of things they have written
--
--
USE IMDB
SELECT	TOP 10	CAST(primaryName AS CHAR(20)) AS NAME,
			birthYear AS DOB,
			(2026 - birthYear) AS AGE,
			(SELECT		COUNT(*) AS "Nbr Written"
			FROM		title_writers AS TD
			WHERE		nconst = NB.nconst
			) AS WRITTEN,
            (SELECT		COUNT(*) AS "Nbr Directed"
			FROM		title_directors AS TDT
			WHERE		nconst = NB.nconst
			) AS DIRECTED
FROM		name_basics AS NB
WHERE		birthYear > 2000
ORDER BY	DIRECTED DESC;
--

GO

PRINT 'Question 7:
Only One Item
-------------
Display the orders that only have one product.
	This does not mean a quantity of 1.
The database name is MyGuitarShop.
Use subqueries, not joins to find the result.
Format your output by proper column names.

Order ID    Item ID     Product ID  Quantity
----------- ----------- ----------- -----------
1           1           2           1
2           2           8           1
4           5           2           2
...
37          42          1           1
38          43          2           2
39          44          6           1
40          45          6           1
' + CHAR(10)

GO

--
USE MyGuitarShop
SELECT  OrderID AS "Order ID",
        ItemID AS "Item ID",
        ProductID AS "Product ID",
        Quantity AS "Quantity"
FROM    OrderItems
WHERE   OrderID IN (
    SELECT      OrderID
    FROM        OrderItems
    GROUP BY    OrderID
    HAVING      COUNT(ProductID) = 1
    );

--

GO


PRINT 'Question 8:
Write a subquery to display the sales reps whose total sales exceeded 800,000
    in the years after 2014 in highest Total Sales order.
The database name is Examples.

Rep ID      Total Sales     Sales Year
----------- --------------- ----------
3           $1,132,744.56   2015
2           $974,853.81     2015
1           $923,746.85     2015
2           $887,695.75     2016
' + CHAR(10)

GO



--
USE Examples
SELECT      RepID AS "Rep ID",
            FORMAT(SalesTotal, '$#,#.00') AS "Total Sales",
            SalesYear AS "Sales Year"
FROM        SalesTotals
WHERE       SalesTotal IN (
    SELECT  SalesTotal
    FROM    SalesTotals
    WHERE   SalesTotal > 800000 AND SalesYear > 2014
    )
ORDER BY    SalesTotal DESC;


--

GO

PRINT 'Question 9:
Discussion posts
--------------------
Alan Turing has posted a few messages about the Discussions.
Show only the first 55 characters of these messages.
Use only subqueries, no joins.
Do not hard code Alan''s user ID.
You will be using the Discussions database.
I did some editing because of several apostrophes which were part of the results:

Title                     Alan''s Content
------------------------- -------------------------------------------------------
Lesson 6 Discussion       <p>Yes Lee, what''s REALLY exensive is human labor. That
Discussion                <p>"Some people are just better than others at certain
Lesson#4 Discussion       <p>I don''t necessarily disagree with you, but that rais
Lesson#4 Discussion       <p>Your Uncle has probably not picked up a book on Algo
Lession 9 Discussion      <p>I think it''s a great example of Selection, Melissa :
' + CHAR(10)

GO

--
USE Discussions
SELECT  Title AS "Title",
        CONVERT(char(55), Content) AS "Alan''s Content"
FROM    Posts
WHERE   Title LIKE '%Discussion%' AND FK_UserID = (
            SELECT UserID
            FROM Profiles
            WHERE FirstName = 'Alan' AND LastName = 'Turing');

--

GO

PRINT 'Question 10:
Sales Reps
---------------------
Use subqueries to show the top 4 sales reps who had the highest total sales.
Do not use join or hard code sales reps ID or names.
You will be using the Examples database.
The correct results will look like this:

Rep ID      Rep Last Name   Total Sales
----------- --------------- ---------------------
2           Martinez        2841015.55
1           Thomas          2697771.96
3           Markasian       2165620.04
4           Winters         728230.29

' + CHAR(10)

GO

--
USE Examples
SELECT      TOP 4 RepID AS "Rep ID",
            (SELECT RepLastName
            FROM SalesReps
            WHERE SalesReps.RepID = SalesTotals.RepID) AS "Rep Last Name",
            CAST(SUM(SalesTotal) AS DECIMAL(18,2)) AS "Total Sales"
FROM        SalesTotals
GROUP BY    RepID
ORDER BY    "Total Sales" DESC;



--
