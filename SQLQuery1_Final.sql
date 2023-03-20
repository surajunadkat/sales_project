# Inspecting the dataset
SELECT * FROM [dbo].[sales_data_sample]

#Split the ORDERDATE column into two separate columns - date and time
SELECT ORDERDATE,
	CONVERT(date, ORDERDATE) AS DATE,
	CONVERT(time, ORDERDATE) AS TIME
FROM [dbo].[sales_data_sample]

# Deleted the ADDRESSLINE2 column as it is not important now, since all times are at 12 midnight
ALTER TABLE [dbo].[sales_data_sample]
DROP COLUMN ADDRESSLINE2

# Checked for unique values and commented on observations 
SELECT DISTINCT YEAR_ID FROM [dbo].[sales_data_sample] -> 3 years from 2003-2005
SELECT DISTINCT ORDERNUMBER FROM [dbo].[sales_data_sample]-> 307 order numbers
SELECT DISTINCT STATUS FROM [dbo].[sales_data_sample] -> 6 types of statuses
SELECT DISTINCT PRODUCTLINE FROM [dbo].[sales_data_sample] -> 7 types of product lines
SELECT DISTINCT COUNTRY FROM [dbo].[sales_data_sample] -> 19 countries
SELECT DISTINCT TERRITORY FROM [dbo].[sales_data_sample] -> 4 territories
SELECT DISTINCT DEALSIZE FROM [dbo].[sales_data_sample] -> 3 types of deal sizes

# Found total sales by product line using the Group By function, and rounded off to 2 decimals
SELECT PRODUCTLINE, ROUND(sum(SALES),2) AS Total_Sales FROM [dbo].[sales_data_sample]
GROUP BY PRODUCTLINE 
-- Sales from Classic Cars were the highest  

# Found total sales by year id using the Group By function, and rounded off to 2 decimals
SELECT YEAR_ID, ROUND(sum(SALES),2) AS Total_Sales FROM [dbo].[sales_data_sample]
GROUP BY YEAR_ID
--Sales in 2004 were higher than 2003 and 2005

# Found total sales by deal size using the Group By function, and rounded off to 2 decimals
SELECT DEALSIZE, ROUND(sum(SALES),2) AS Total_Sales FROM [dbo].[sales_data_sample]
GROUP BY DEALSIZE
--Large deals comprised of 60% of total sales

# Found the best month for sales in 2003 and 2004. 2005 has data only for 5 months
SELECT MONTH_ID, ROUND(sum(SALES),2) AS Total_Sales, COUNT(ORDERNUMBER) AS Frequency
FROM [dbo].[sales_data_sample]
WHERE YEAR_ID=2003
GROUP BY MONTH_ID
ORDER BY FREQUENCY DESC
--November has the highest sales, while January has the lowest.

SELECT MONTH_ID, ROUND(sum(SALES),2) AS Total_Sales, COUNT(ORDERNUMBER) AS Frequency
FROM [dbo].[sales_data_sample]
WHERE YEAR_ID=2004
GROUP BY MONTH_ID
ORDER BY FREQUENCY DESC
--November has the highest sales, while March has the lowest.

# Sales bifurcation as per geographic region
SELECT COUNTRY, TERRITORY, ROUND(sum(SALES),2) AS Total_Sales
FROM [dbo].[sales_data_sample]
GROUP BY TERRITORY,COUNTRY 
ORDER BY Total_Sales DESC
-- USA, Spain, France are the top regions country-wise.

# Which product line sells the most in November and other months?
SELECT MONTH_ID, PRODUCTLINE, ROUND(sum(SALES),2) AS Total_Sales, COUNT(ORDERNUMBER) AS Frequency
FROM [dbo].[sales_data_sample]
WHERE YEAR_ID=2003 AND MONTH_ID=11
GROUP BY MONTH_ID, PRODUCTLINE
ORDER BY Total_Sales DESC
-- Classic cars were the most sold in November 2003 having highest frequency. Trucks and buses rank second although their frequency is less than vintage cars.

SELECT MONTH_ID, PRODUCTLINE, ROUND(sum(SALES),2) AS Total_Sales, COUNT(ORDERNUMBER) AS Frequency
FROM [dbo].[sales_data_sample]
WHERE YEAR_ID=2004 AND MONTH_ID=11
GROUP BY MONTH_ID, PRODUCTLINE
ORDER BY Total_Sales DESC
-- Classic cars were the most sold in November 2004 having highest frequency. 

# Best customer in terms of average sales and total sales
SELECT DISTINCT CUSTOMERNAME, ROUND(sum(SALES),2) AS Total_Sales, ROUND(avg(SALES),2) AS Avg_Sales, COUNT(ORDERNUMBER) AS Frequency 
FROM [dbo].[sales_data_sample]
GROUP BY CUSTOMERNAME
ORDER BY Total_Sales DESC
--Euro Shopping Channel was the best customer in terms of total sales.

# To find largest order size in terms of number of items
SELECT ORDERNUMBER, COUNT(PRODUCTLINE) AS Total_Items
FROM [dbo].[sales_data_sample]
WHERE STATUS='Shipped' 
GROUP BY ORDERNUMBER
ORDER BY Total_Items DESC

--None of the orders contained more than 18 items.
