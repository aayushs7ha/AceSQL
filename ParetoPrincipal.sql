-- Pareto Principal 
-- For instance -  80% of the sales comes from 20 % of the employees

/*

CREATE TABLE SuperStore
(
    Row_ID INT PRIMARY KEY,
    Order_ID VARCHAR(20),
    Order_Date DATE,
    Ship_Date DATE,
    Ship_Mode VARCHAR(50),
    Customer_ID VARCHAR(20),
    Customer_Name VARCHAR(100),
    Segment VARCHAR(50),
    Country_Region VARCHAR(100),
    City VARCHAR(100),
    State VARCHAR(100),
    Postal_Code VARCHAR(20),
    Region VARCHAR(50),
    Product_ID VARCHAR(20),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Product_Name VARCHAR(200),
    Sales DECIMAL(10,2),
    Quantity INT,
    Discount DECIMAL(4,2),
    Profit DECIMAL(10,2)
);
*/


-- Find those 20 % of Product which are doing 80% of sales 
-- TOTAL SALES 



--SELECT COUNT(*) tc
--from (
SELECT Product_Name, SUM(Sales)TotalSales 
FROM SuperStore 
GROUP BY Product_Name
ORDER BY TotalSales DESC 
--)s
-- 1849 Total Products 
-- 80 % OF TOTALSALES
SELECT 0.80 * SUM(Sales)Total_Sales_80P
FROM SuperStore ss 
-- 1,837,760.528 

-- 

SELECT Product_Name, TotalSales, RunningSales, CumulativePct
FROM (
    SELECT 
        Product_Name,
        TotalSales,
        SUM(TotalSales) OVER (ORDER BY TotalSales DESC) AS RunningSales,
        SUM(TotalSales) OVER () AS GrandTotalSales,
        SUM(TotalSales) OVER (ORDER BY TotalSales DESC) * 1.0 
            / SUM(TotalSales) OVER () AS CumulativePct
    FROM (
        SELECT 
            Product_Name, 
            SUM(Sales) AS TotalSales
        FROM SuperStore
        GROUP BY Product_Name
    ) AS ProductSales
) AS RankedProducts
WHERE CumulativePct <= 0.80;

--

WITH ProductSales AS (
SELECT Product_Name, SUM(Sales)TotalSales 
FROM SuperStore 
GROUP BY Product_Name
--ORDER BY TotalSales DESC
),
RunningSales AS (
SELECT 
	Product_Name,
	TotalSales,
	SUM(TotalSales) OVER (ORDER BY TotalSales DESC) RunningSales,
	SUM(TotalSales) OVER () GrandSales
FROM ProductSales
),
FinalSelction AS  (
SELECT *,
	RunningSales/GrandSales as Cumulative_percentage
FROM RunningSales
)
SELECT 
	Product_Name,
	TotalSales,
	Cumulative_percentage
FROM FinalSelction
WHERE Cumulative_percentage <= 0.80
