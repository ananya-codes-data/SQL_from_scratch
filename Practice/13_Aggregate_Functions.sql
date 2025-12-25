/* SQL Aggregate Functions
Contents:
	1. Basic Aggregate Functions
		- COUNT
		- SUM
		- AVG
		- MAX
		- MIN
	2. Grouped Aggregations
		- GROUP BY
*/

-- BASIC AGGREGATE FUNCTIONS

-- Find the total number of customers
SELECT
	COUNT(*) AS total_noof_customers
FROM customers;

-- Find the total sales of all orders
SELECT
	SUM(sales) AS total_sales
FROM orders;

-- Find the average sales of all orders
SELECT
	ROUND(AVG(sales), 0) AS avg_sales
FROM orders;

-- Find the highest score among customers
SELECT
	MAX(score) AS highest_score
FROM customers;

-- Find the lowest score among customers
SELECT
	MIN(score) AS lowest_score
FROM customers;

-- GROUPED AGGREGATIONS - GROUP BY

-- Find the number of orders, total sales, average sales, highest sales, and lowest sales per customer
SELECT
	customerid,
	COUNT(*) AS noof_orders,
	SUM(sales) AS total_sales,
	ROUND(AVG(sales), 0) AS avg_sales,
	MAX(sales) AS highest_sales,
	MIN(sales) AS lowest_sales
FROM orders
GROUP BY
	customerid;