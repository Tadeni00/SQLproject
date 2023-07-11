-- 1.	Analysis of sales by branch:

SELECT Branch, City, Total, Quantity, AVG(Rating) as AverageRating
FROM superMarketSales
GROUP BY Branch, City, Total, Quantity 

--In some database systems, you cannot reference an alias defined in the 
--SELECT clause within the same SELECT clause. In such cases, you would need to repeat the expression used to 
--calculate the average rating in the GROUP BY clause.

--2.	Customer segmentation:

SELECT [Customer type], Gender, City, [Product line], Payment, Total, Quantity, [gross income] 'Profit by Sales', Rating
FROM superMarketSales
GROUP BY [Customer type], Gender, Quantity, Total, Payment, [Product line], City, [gross income],Rating
ORDER BY [Profit by Sales] DESC, Total DESC, Quantity DESC

-- Customers by Payment Type

SELECT Payment, COUNT(Payment) 'Number by Payment Type'
FROM superMarketSales
GROUP BY Payment
ORDER BY 2 DESC

-- Customers by Product Line

SELECT DISTINCT([Product line]), COUNT([Product line]) 'Number by Product Line'
FROM superMarketSales
GROUP BY [Product line]
ORDER BY 2 DESC

-- Customers by City
SELECT DISTINCT(City), COUNT(City) 'Number by City'
FROM superMarketSales
GROUP BY City
ORDER BY 2 DESC

--3.	Understanding sales patterns by city:

SELECT City, SUM([gross income]) 'Profit Made', SUM(Total) 'Total on Sales', SUM(Quantity) 'Number of Sales', 
		 AVG(Rating) As 'Average Rating'
FROM superMarketSales
GROUP BY City
ORDER BY 2 DESC, 3 DESC, 4 DESC

--4.	Gender-based analysis: 

SELECT 
    Gender,
	SUM([gross income]) AS 'Profit on Sales',
	SUM(Total) AS 'Total on Sales',
	100.0 * SUM([gross income]) / (SELECT SUM([gross income]) FROM superMarketSales) AS 'Percentage Profit',
    SUM(Quantity) AS 'Number of sales', 
    AVG(Rating) AS 'Average Rating'   
FROM superMarketSales
GROUP BY Gender
ORDER BY 2 DESC, 3 DESC, 4 DESC



SELECT 
    CASE WHEN GROUPING(Gender) = 1 THEN 'Grand Total' ELSE Gender END AS Gender, 
    SUM([gross income]) AS 'Profit on Sales', 
    SUM(Total) AS 'Total on Sales', 
    SUM(Quantity) AS 'Number of sales', 
    AVG(Rating) AS 'Average Rating',
    CASE WHEN GROUPING(Gender) = 1 THEN 100.0 ELSE 100.0 * SUM([gross income]) / (SELECT SUM([gross income]) FROM superMarketSales) END AS 'Percentage Profit'
FROM superMarketSales
GROUP BY GROUPING SETS ((Gender), ())

--5.	Product line performance:
SELECT
	CASE WHEN GROUPING([Product line]) = 1 THEN 'Grand Total' ELSE [Product line] END AS Product, 
    SUM([gross income]) AS 'Profit on Sales', 
    SUM(Total) AS 'Total on Sales', 
    SUM(Quantity) AS 'Number of sales', 
    AVG(Rating) AS 'Average Rating',
    CASE WHEN GROUPING([Product line]) = 1 THEN 100.0 ELSE 100.0 * SUM([gross income]) / (SELECT SUM([gross income]) FROM superMarketSales) END AS 'Percentage Profit'
FROM superMarketSales
GROUP BY GROUPING SETS (([Product line]), ())
ORDER BY 2 DESC;


--6.	Time-based analysis: The "Date" and "Time" columns allow for analyzing sales trends over time, identifying peak sales hours,
--or understanding any temporal patterns in customer behavior.


--ALTER TABLE superMarketSales
--ADD SalesDate Date;

--UPDATE superMarketSales
--SET SalesDate = CONVERT(Date, Date);


--Alter Table superMarketSales
--Add SalesTime Time;

--UPDATE superMarketSales
--SET SalesTime = CONVERT(Time, Time);


--1. Which branch has the best results in the loyalty program?

SELECT TOP 1 Branch, AVG(Rating) as AverageRating,
	COUNT(Branch)OVER (PARTITION BY Branch) TotalBranches
FROM superMarketSales
GROUP BY Branch
ORDER BY Branch DESC;

--2.	Does the membership depend on customer rating?

SELECT [Customer type], AVG(Rating)
FROM superMarketSales
GROUP BY [Customer type]


--3.	Does gross income depend on the proportion of customers in the loyalty program? On payment method?

SELECT [Customer type], SUM([gross income]) [Average Income], AVG(Rating) AS AverageRating, Payment, COUNT([Customer type]) AS [Total by Customer Type]
FROM superMarketSales
GROUP BY [Customer type], Payment
ORDER BY 2 DESC;


--4.	Are there any differences in indicators between men and women?

SELECT 
    CASE WHEN GROUPING(Gender) = 1 THEN 'Grand Total' ELSE Gender END AS Gender, 
    SUM([gross income]) AS 'Profit on Sales', 
    SUM(Total) AS 'Total on Sales', 
    SUM(Quantity) AS 'Number of sales', 
    AVG(Rating) AS 'Average Rating',
    CASE WHEN GROUPING(Gender) = 1 THEN 100.0 ELSE 100.0 * SUM([gross income]) / (SELECT SUM([gross income]) FROM superMarketSales) END AS 'Percentage Profit'
FROM superMarketSales
GROUP BY GROUPING SETS ((Gender), ())


--5.	Which product category generates the highest income?

SELECT
	CASE WHEN GROUPING([Product line]) = 1 THEN 'Grand Total' ELSE [Product line] END AS Product, 
    SUM([gross income]) AS 'Profit on Sales', 
    SUM(Total) AS 'Total on Sales', 
    SUM(Quantity) AS 'Number of sales', 
    AVG(Rating) AS 'Average Rating',
    CASE WHEN GROUPING([Product line]) = 1 THEN 100.0 ELSE 100.0 * SUM([gross income]) / (SELECT SUM([gross income]) FROM superMarketSales) END AS 'Percentage Profit'
FROM superMarketSales
GROUP BY GROUPING SETS (([Product line]), ())
ORDER BY 2 DESC;