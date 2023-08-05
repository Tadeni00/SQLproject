-- Sales Performance Analysis

		-- Question 1
--Show product demand by country – List highest and lowest orders per product

SELECT Brands, countries, MAX(quantity) AS 'Highest Order', MIN(quantity) AS 'Lowest Order' 
FROM International_Breweries
GROUP BY countries, brands
ORDER BY countries;

		--Queastion 2
--Monthly average sales per product over the 3-year period

SELECT DISTINCT Months, Brands, AVG(Quantity) AS 'Average Sales'
FROM International_Breweries
GROUP BY Months, Brands
ORDER BY Months, Brands ASC;

		--Question 3
--Where can we find the highest sales quarterly?

SELECT DISTINCT Brands,Years, DATEPART(QUARTER, Years) AS Quarters, MAX(Profit) AS 'Highest Sales'
FROM International_Breweries
GROUP BY Years, Brands
ORDER BY Years, Brands ASC;

		--Question 4
-- Show quarterly volume of sales by Sales Reps.

SELECT DISTINCT Sales_Rep, Years, DATEPART(QUARTER, Years) AS Quarters, SUM(Quantity) AS 'Quarterly Sales Volume'
FROM International_Breweries
GROUP BY Sales_rep, Years
ORDER BY Years, Sales_rep ASC;

		-- Question 5
--Which Sales rep made the highest profit in this period? (A candidate for bonus)

SELECT TOP 1 Sales_Rep, SUM(profit) AS 'Highest Profit'
FROM International_Breweries
GROUP BY profit, Sales_rep
ORDER BY profit DESC;

