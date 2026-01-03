/* SQL Window Aggregate Functions

Contents:
    1. COUNT
    2. SUM
    3. AVG
    4. MAX / MIN
    5. ROLLING SUM & AVERAGE Use Case */

-- SQL WINDOW AGGREGATION | COUNT

/* TASK 1:
   Find the Total Number of Orders and the Total Number of Orders for Each Customer */
SELECT
	orderid,
	orderdate,
	customerid,
	COUNT(*) OVER() AS total_orders,
	COUNT(*) OVER(
		PARTITION BY
			customerid
	) AS orders_by_customers
FROM orders;

/* TASK 2:
   - Find the Total Number of Customers
   - Find the Total Number of Scores for Customers
   - Find the Total Number of Countries */
SELECT
	*,
	COUNT(*) OVER() AS total_customers,
	COUNT(score) OVER() AS total_scores,
	COUNT(country) OVER() AS total_countries
FROM customers;

/* TASK 3:
   Check whether the table 'OrdersArchive' contains any duplicate rows */
SELECT
*
FROM (
	SELECT
		orderid,
		COUNT(*) OVER(
			PARTITION BY
				orderid     -- Divides the data by the primary key
		) AS check_pk
	FROM ordersarchive
) AS t
WHERE 
	check_pk > 1


-- SQL WINDOW AGGREGATION | SUM

/* TASK 4:
   - Find the Total Sales Across All Orders 
   - Find the Total Sales for Each Product */
SELECT
	orderid,
	orderdate,
	productid,
	sales,
	SUM(sales) OVER(
		PARTITION BY
			productid
	) AS sales_by_product,
	SUM(sales) OVER() AS total_sales
FROM orders;

/* TASK 5:
   Find the Percentage Contribution of Each Product's Sales to the Total Sales */
SELECT
	orderid,
	productid,
	sales,
	SUM(sales) OVER() AS total_sales,
	ROUND(
		CAST(sales AS numeric) / SUM(sales) OVER() * 100,
		2
	) AS percentage_of_total
FROM orders;


-- SQL WINDOW AGGREGATION | AVG

/* TASK 6:
   - Find the Average Sales Across All Orders 
   - Find the Average Sales for Each Product */
SELECT
	orderid,
	orderdate,
	sales,
	ROUND(
		AVG(sales) OVER(),
		2
	) AS avg_sales,
	ROUND(
		AVG(sales) OVER(
			PARTITION BY
			productid
		),
		2
	) AS avg_by_product
FROM orders;

/* TASK 7:
   Find the Average Scores of Customers */
SELECT
	customerid,
	score,
	ROUND(
		AVG(score) OVER(),
		2
	) AS avg_score
FROM customers;

/* TASK 8:
   Find all orders where Sales exceed the average Sales across all orders */



-- SQL WINDOW AGGREGATION | MAX / MIN


/* TASK 9:
   Find the Highest and Lowest Sales across all orders */


/* TASK 10:
   Find the Lowest Sales across all orders and by Product */


/* TASK 11:
   Show the employees who have the highest salaries */


/* TASK 12:
   Find the deviation of each Sale from the minimum and maximum Sales */



-- Use Case | ROLLING SUM & AVERAGE


/* TASK 13:
   Calculate the moving average of Sales for each Product over time */


/* TASK 14:
   Calculate the moving average of Sales for each Product over time,
   including only the next order */
