PRINT 'Question 1:
Vendor-Customer City
--------------------
Write a query to find customers and vendors who are located in the same city.
You will be using the Examples database
Consider the following requirements:
1-Use ORDER BY to order the result by the customer''s city, last name and vendor''s name
2 Use CONVERT to format the columns with proper spacing
3-Make sure all columns have appropriate names (using AS where needed)
4-You must use JOIN

The Correct results will have 7 rows, and should look like this:
Customer Name  Customer City        Vendor Name                    Vendor City
-------------- -------------------- ------------------------------ --------------------
Lebihan        Chicago              Mcgraw Hill Companies          Chicago
Lebihan        Chicago              Quality Education Data         Chicago
Chelan         Dallas               Ingram                         Dallas
Yorres         San Francisco        Computerworld                  San Francisco
Yorres         San Francisco        IBM                            San Francisco
Yorres         San Francisco        Kent H Landsberg Co            San Francisco
Yorres         San Francisco        Pacific Gas & Electric         San Francisco
' + CHAR(10)


GO

--
USE Examples
SELECT      CONVERT(char(25), CustomerLast) AS "CustomerName",
            CONVERT(char(25), CustCity) AS "Customer City",
            CONVERT(char(25), VendorName) AS "Vendor Name",
            CONVERT(char(25), VendorCity) AS "Vendor City"
FROM        Customers
JOIN        Vendors ON Vendors.VendorCity = Customers.CustCity
ORDER BY    CustCity, CustomerLast, VendorName

--


GO

PRINT 'Question 2:
Vendor State
-----------
Similar to the above query, this time, find customers and vendors who are located in the same state.
You will be using the Examples database.
Consider the following requirements:
1-Exclude vendors who reside in IL and MA
2-You must use JOIN and IN
3-Order results by the Vendor''s state and name

The correct result will have 79 rows and will look like this:

Customer Name  Customer State Vendor Name                        Vendor State
-------------- -------------- ---------------------------------- ------------
Yorres         CA             Abbey Office Furnishings           CA
Yorres         CA             American Express                   CA
Yorres         CA             ASC Signs                          CA
Yorres         CA             Aztek Label                        CA
Yorres         CA             Bertelsmann Industry Svcs. Inc     CA
...
Berglund       IA             Open Horizons Publishing           IA
Chelan         TX             Ingram                             TX
' + CHAR(10)

GO

--
USE Examples
SELECT      Customers.CustomerLast, Customers.CustState, Vendors.VendorName, Vendors.VendorState
FROM        Customers
JOIN        Vendors ON Vendors.VendorState = Customers.CustState
WHERE       VendorState NOT IN ('IL', 'MA')
ORDER BY    VendorState, VendorName


--


GO




------------------
PRINT 'Question 3:
Extract
------------------
Write a SELECT to find transactions that Tim Brown has made on 2002-04-16.
Consider the following:
1- You will be using CISDB database (F_EMPLOYEE and F_INVOICE tables)
2- You will be using INNER JOIN
3- Name columns appropriately
4- Insert $ using any method
Note: There are ways to do this that don''t require an INNER JOIN, but use an INNER
JOIN anyway.

The desired output should look like the following

Invoice #   Date         Employee ID Employee Name        Employee Title       Total Price
----------- ------------ ----------- -------------------- -------------------- ------------
225         2002-04-16   5           Tim Brown            Sales Associate      $75.00
' + CHAR(10)



--
USE CISDB
Select      CONVERT(char(10), InvoiceNbr) AS "Invoice #",
            CONVERT(char(10), InvoiceDt, 23) AS "Date",
            CONVERT(char(10), EmpID) AS "Employee ID",
            Name AS "Employee Name",
            Title AS "Employee Title",
            ('$' + CONVERT(varchar(10), TotalPrice)) AS "Total Price"
From        F_INVOICE
INNER JOIN  F_EMPLOYEE ON F_EMPLOYEE.EmpID = F_INVOICE.FK_EmpID
WHERE       Name = 'Tim Brown' AND InvoiceDt = '2002-04-16'

--


GO


PRINT 'Question 4:
UNION
------------------
Review the following UNION query. Correct the error to produce the following
   result while still using UNION:

USE Examples
SELECT  InvoiceID AS "Invoice ID",
        InvoiceNumber AS "Invoice Number",
		InvoiceTotal AS "Invoice Total"
FROM    Invoices
WHERE   InvoiceTotal > 70
   UNION
SELECT  InvoiceID  AS "Invoice ID",
        InvoiceNumber AS "Invoice Number",
		InvoiceTotal AS "Invoice Total"
FROM    PaidInvoices
WHERE   InvoiceTotal < 10
ORDER BY "Invoice Total";

Invoice ID  Invoice Number  Invoice Total
----------- --------------- ---------------------
14          25022117        6.00
20          24863706        6.00
70          24780512        6.00
16          21-4748363      9.95
23          21-4923721      9.95
2           3662            100.00
4           4553            250.00
'+ CHAR(10)

GO

--

USE Examples
SELECT  CONVERT(char(10), InvoiceID) AS "Invoice ID",
        CONVERT(char(10), InvoiceNumber) AS "Invoice Number",
		CONVERT(char(6), InvoiceTotal)  AS "Invoice Total"
FROM    Invoices
WHERE   InvoiceTotal > 70
UNION
SELECT  CONVERT(char(10), InvoiceID) AS "Invoice ID",
        CONVERT(char(10), InvoiceNumber) AS "Invoice Number",
		CONVERT(char(6), InvoiceTotal)  AS "Invoice Total"
FROM    PaidInvoices
WHERE   InvoiceTotal < 10
ORDER BY "Invoice Total";






--
GO


PRINT 'Question 5:
Look at the following tables in the IMDB database:
  title_basics
  title_episode
  title_ratings
Consider the following:
1-Using JOIN write a query to display the Primary Title, Season Number, and Number of Votes
2-The Primary Title should include the word "Wicked" in it
3-The number of votes should be between 4 and 7
4-Sort by the Title
5-There are 9 records

Here is how the result will look like:
Primary Title                                      Season# Number of Votes
-------------------------------------------------- ------- ---------------
Mr. Winkle''s Monkey/Wicked Wendy                   1       7
Someone Wicked This Way Comes                      1       6
Something Wicked                                   1       7
Something Wicked in the Woods                      3       6
The Wicked Queen                                   2       5
The Wicked Witch of Georgia                        2       5
The Wicked Witch of the West                       1       5
Titanic Violin, Wicked Fungus and the Greatest Bar 12      5
Wicked Witness                                     4       5
'+ CHAR(10)
GO

--
USE IMDB
Select      primaryTitle AS "Primary Title",
            CONVERT(char(10), seasonNumber) AS "Season#",
            CONVERT(char(10), numVotes) AS "Number of Votes"
FROM        title_basics
JOIN        title_episode ON title_basics.tconst = title_episode.tconst
JOIN        title_ratings ON title_episode.tconst = title_ratings.tconst
WHERE       (numVotes BETWEEN 4 AND 7) AND (primaryTitle LIKE '%Wicked%')
ORDER BY    primaryTitle;
--
GO


GO

PRINT 'Question 6:
Akira Kurosawa
-----------------
For the following query, use the IMDB database to find
    all the Drama "Movies" that Akira Kurosawa has directed.
Look at the ERD and consider the following:
1-You must use JOIN
2-Format your report accordingly
3-Order the result by Year
4-The result includes 31 records

Hint: title_directors has information about which people directed which shows.
      title_genre has information about what genres a particular show belongs to.
	  title_principals should not be used.
Title                          Type         Year        Primary Name         Genre
------------------------------ ------------ ----------- -------------------- ----------
Uma                            movie        1941        Akira Kurosawa       Drama
Sanshiro Sugata                movie        1943        Akira Kurosawa       Drama
Ichiban utsukushiku            movie        1944        Akira Kurosawa       Drama
The Men Who Tread on the Tiger movie        1945        Akira Kurosawa       Drama
...
Ran                            movie        1985        Akira Kurosawa       Drama
Dreams                         movie        1990        Akira Kurosawa       Drama
Rhapsody in August             movie        1991        Akira Kurosawa       Drama
Maadadayo                      movie        1993        Akira Kurosawa       Drama
' + CHAR(10)


GO

--
USE IMDB
SELECT      CONVERT(char(20), primaryTitle) AS "Title",
            CONVERT(char(20), titleType) AS "Type",
            CONVERT(char(20), startYear) AS "Year",
            CONVERT(char(15), primaryName) AS "Primary Name",
            CONVERT(char(15), genre) AS "Genre"
FROM        title_directors
JOIN        title_basics ON title_basics.tconst = title_directors.tconst
JOIN        title_genre ON title_genre.tconst = title_basics.tconst
JOIN        name_basics ON name_basics.nconst = title_directors.nconst
WHERE       primaryName = 'Akira Kurosawa' AND genre = 'Drama' AND titleType = 'movie'
ORDER BY    "Year"
--


GO

PRINT 'Question 7:
Al Pacino
-----------------
Consider the following:
1.Write a query to show the movies where Al Pacino was both the director and writer.
2-Use IMDB database.
3-Produce the title, type, year, and Run Time.
4-Format Title as 20 characters wide and Director/Writer as 15 characters wide.
5-Order by Year.
6-You must use JOIN.

Correct results will have 2 rows formatted as:
Title                Type         Run Time    Year        Director/Writer
-------------------- ------------ ----------- ----------- ---------------
Looking for Richard  movie        112         1996        Al Pacino
Wilde Salom�         movie        95          2011        Al Pacino
' + CHAR(10)

GO

--
USE IMDB
Select      CONVERT(char(20), primaryTitle) AS "Title",
            CONVERT(char(20), titleType) AS "Type",
            CONVERT(char(20), runtimeMinutes) AS "Run Time",
            CONVERT(char(20), startYear) AS "Year",
            CONVERT(char(15), primaryName) AS "Director/Writer"
FROM        title_writers
JOIN        title_basics ON title_basics.tconst = title_writers.tconst
JOIN        title_directors ON title_directors.tconst = title_writers.tconst
JOIN        name_basics ON name_basics.nconst = title_writers.nconst
WHERE       primaryName = 'Al Pacino'
ORDER BY    "Year";
--


GO

PRINT 'Question 8:
Wes Craven''s TVSeries
---------------------------------------------------------
Still in the IMDB database, look at the ERD and consider the following:
1-Wes Craven has written many movies and TV series
2-Create a list of only his TV series in descending order by rating
3-Format the title as 30 characters wide
4-You must use JOIN
5-Your results should appear as below (I escaped the apostrophe in one result)
6-Title_ratings contains the number of votes and the average rating for each show
7-These 3 records are produced by this query

Primary Name         Series Name                    Type         Rating Year
-------------------- ------------------------------ ------------ ------ -----------
Wes Craven           Nightmare Cafe                 tvSeries     7.4    1992
Wes Craven           The People Next Door           tvSeries     7.1    1989
Wes Craven           Freddy''s Nightmares            tvSeries     6.5    1988
' + CHAR(10)

GO

--
USE IMDB
Select      CONVERT(char(30), primaryName) AS "Primary Name",
            CONVERT(char(30), primaryTitle) AS "Series Name",
            CONVERT(char(30), titleType) AS "Type",
            CONVERT(char(30), averageRating) AS "Rating",
            CONVERT(char(30), startYear) AS "Year"
FROM        title_writers
JOIN        title_basics ON title_basics.tconst = title_writers.tconst
JOIN        title_ratings ON title_ratings.tconst = title_basics.tconst
JOIN        name_basics ON name_basics.nconst = title_writers.nconst
WHERE       primaryName = 'Wes Craven' AND titleType = 'tvSeries'
ORDER BY    averageRating DESC;

--


GO


PRINT 'Question 9:
Top 10 Unit Price
----------------
Now use the MyGuitarShop database
Consider the following:
1-Find the 10 most highly priced items that have been ordered
2-Use JOIN with two related tables to produce the list
3-Order by Item Price in descending order
4-Format all fields accordingly

OrderID     Item Price   Order Date
----------- ------------ --------------------
3           2517.00      Mar 29 2016  9:44AM
12          2517.00      Apr  4 2016  8:15AM
22          2517.00      Apr 12 2016 12:26PM
27          2517.00      Apr 20 2016  9:17AM
31          2517.00      Apr 29 2016  6:47AM
32          2517.00      May  1 2016  1:23AM
37          2517.00      May  6 2016  2:15PM
38          1199.00      May  8 2016 11:41AM
34          1199.00      May  2 2016 11:36AM
25          1199.00      Apr 20 2016  8:23AM
' + CHAR(10)

GO

--

USE MyGuitarShop
SELECT      TOP 10
            CONVERT(char(10), OrderItems.OrderID) AS "OrderID ",
            CONVERT(char(10), ItemPrice) AS "Item Price",
            CONVERT(char(20), OrderDate, 100) AS "Order Date"
FROM        OrderItems
JOIN        Orders ON OrderItems.OrderID = Orders.OrderID
ORDER BY    ItemPrice DESC;




--
GO


GO
PRINT 'Question 10:
Write a simple problem statement similar to the ones you have seen above
then write a simple query, which uses INTERSECT to produce the result for the problem statement you wrote.
Use two tables from the TV or AP databases, such as Vendors and invoice tables.
Use the WHERE clause to set conditions, such as selected vendor numbers.

For an example, see near the end of the "UNION/INTERSECT/EXCEPT" video in
"Tutorial Videos on JOINs and on UNION/INTERSECT/EXCEPT".
' + CHAR(10)

GO

--Problem Statement
/*Display Invoice table ID's columns that exist in Vendors table ID's columns
----------------
Considered the following:
1-Use the AP database
2-Use INTERSECT with two related tables to display VendorID and InvoiceID
3-Use Where Clause

VendorID     InvoiceID
123          3           */

--
USE AP
SELECT  CONVERT(char(10), VendorID) AS "Vendor ID",
        CONVERT(char(10), InvoiceID) AS "Invoice ID"
FROM    Invoices
INTERSECT
SELECT CONVERT(char(10), VendorID),
       CONVERT(char(10), DefaultTermsID)
FROM    Vendors
WHERE   VendorID > 100;



--
