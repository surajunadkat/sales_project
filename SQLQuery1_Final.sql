# Inspecting the dataset
SELECT * FROM [dbo].[sales_data_sample]

#Split the ORDERDATE column into two separate columns - date and time
SELECT ORDERDATE,
	CONVERT(date, ORDERDATE) AS DATE,
	CONVERT(time, ORDERDATE) AS TIME
FROM [dbo].[sales_data_sample]

# Delete the ADDRESSLINE2 column as it is not important now, since all times are at 12 midnight
ALTER TABLE [dbo].[sales_data_sample]
DROP COLUMN ADDRESSLINE2

# Checking unique values
SELECT DISTINCT YEAR_ID FROM [dbo].[sales_data_sample] -> 3 years from 2003-2005
SELECT DISTINCT ORDERNUMBER FROM [dbo].[sales_data_sample]-> 307 order numbers
SELECT DISTINCT STATUS FROM [dbo].[sales_data_sample] -> 6 types of statuses
SELECT DISTINCT PRODUCTLINE FROM [dbo].[sales_data_sample] -> 7 types of product lines
SELECT DISTINCT COUNTRY FROM [dbo].[sales_data_sample] -> 19 countries
SELECT DISTINCT TERRITORY FROM [dbo].[sales_data_sample] -> 4 territories
SELECT DISTINCT DEALSIZE FROM [dbo].[sales_data_sample] -> 3 types of deal sizes

# Find total sales by product line using the Group By function, and round off to 2 decimals
SELECT PRODUCTLINE, ROUND(sum(SALES),2) AS Total_Sales FROM [dbo].[sales_data_sample]
GROUP BY PRODUCTLINE

# Find total sales by year id using the Group By function, and round off to 2 decimals
SELECT YEAR_ID, ROUND(sum(SALES),2) AS Total_Sales FROM [dbo].[sales_data_sample]
GROUP BY YEAR_ID

# Find total sales by deal size using the Group By function, and round off to 2 decimals
SELECT DEALSIZE, ROUND(sum(SALES),2) AS Total_Sales FROM [dbo].[sales_data_sample]
GROUP BY DEALSIZE

# Find the best month for sales in 2003 and 2004. 2005 has data only for 5 months
SELECT MONTH_ID, ROUND(sum(SALES),2) AS Total_Sales, COUNT(ORDERNUMBER) AS Frequency
FROM [dbo].[sales_data_sample]
WHERE YEAR_ID=2003
GROUP BY MONTH_ID
ORDER BY FREQUENCY DESC

SELECT MONTH_ID, ROUND(sum(SALES),2) AS Total_Sales, COUNT(ORDERNUMBER) AS Frequency
FROM [dbo].[sales_data_sample]
WHERE YEAR_ID=2004
GROUP BY MONTH_ID
ORDER BY FREQUENCY DESC

# Sales bifurcation as per geographic region
SELECT COUNTRY, TERRITORY, ROUND(sum(SALES),2) AS Total_Sales
FROM [dbo].[sales_data_sample]
GROUP BY TERRITORY,COUNTRY 
ORDER BY Total_Sales DESC

# Which product line sells the most in November and other months?
SELECT MONTH_ID, PRODUCTLINE, ROUND(sum(SALES),2) AS Total_Sales, COUNT(ORDERNUMBER) AS Frequency
FROM [dbo].[sales_data_sample]
WHERE YEAR_ID=2003 AND MONTH_ID=11
GROUP BY MONTH_ID, PRODUCTLINE
ORDER BY Total_Sales DESC

SELECT MONTH_ID, PRODUCTLINE, ROUND(sum(SALES),2) AS Total_Sales, COUNT(ORDERNUMBER) AS Frequency
FROM [dbo].[sales_data_sample]
WHERE YEAR_ID=2004 AND MONTH_ID=11
GROUP BY MONTH_ID, PRODUCTLINE
ORDER BY Total_Sales DESC

# Best customer in terms of average sales and total sales
SELECT DISTINCT CUSTOMERNAME, ROUND(sum(SALES),2) AS Total_Sales, ROUND(avg(SALES),2) AS Avg_Sales, COUNT(ORDERNUMBER) AS Frequency 
FROM [dbo].[sales_data_sample]
GROUP BY CUSTOMERNAME
ORDER BY Total_Sales DESC

# To find largest order size in terms of number of items
SELECT ORDERNUMBER, COUNT(PRODUCTLINE) AS Total_Items
FROM [dbo].[sales_data_sample]
WHERE STATUS='Shipped' 
GROUP BY ORDERNUMBER
ORDER BY Total_Items DESC


