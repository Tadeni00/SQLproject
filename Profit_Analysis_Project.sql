											-- PROFIT ANALYSIS


-- Question 1
-- Within the space of the last three years, whats was the profit worth of the breweries, inclusive of the Anglophone and the farncophone territories?

SELECT SUM(profit) as 'Total Profit'
FROM International_Breweries;


-- Question 2
-- Compare the total profits between this two territories for the country manager, Mr. Stone.

ALTER TABLE International_Breweries
ADD Languages VARCHAR(50);

UPDATE International_Breweries
SET Languages =
CASE WHEN countries IN ('Senegal', 'Togo', 'Benin') THEN 'Francophone Countries'
	ELSE 'Anglophone Countries'
	END;
SELECT DISTINCT Languages, SUM(profit) AS 'Total Profit by Language'
FROM International_Breweries
GROUP BY Languages;

-- Question 3
-- Which country generated the highest profit in 2019?

SELECT TOP 1 Countries, SUM(profit) AS 'Total Profit'
FROM International_Breweries
WHERE years = 2019
GROUP BY countries
ORDER BY 'Total Profit' DESC;

-- Question 4
-- Help him find the year with the highest profit.

SELECT years, SUM(profit) AS 'Total Profit'
FROM International_Breweries
GROUP BY years
ORDER BY 'Total Profit' DESC;

-- Question 5
-- Which year in the three years was the least profit generated?

SELECT months, years, SUM(profit) AS 'Total Profit'
FROM International_Breweries
GROUP BY months, years
ORDER BY months, years ASC
