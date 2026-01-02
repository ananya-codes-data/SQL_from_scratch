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
FROM customers;

/* TASK 3:
   Check whether the table 'OrdersArchive' contains any duplicate rows */



-- SQL WINDOW AGGREGATION | SUM


/* TASK 4:
   - Find the Total Sales Across All Orders 
   - Find the Total Sales for Each Product */


/* TASK 5:
   Find the Percentage Contribution of Each Product's Sales to the Total Sales */



-- SQL WINDOW AGGREGATION | AVG

/* TASK 6:
   - Find the Average Sales Across All Orders 
   - Find the Average Sales for Each Product */


/* TASK 7:
   Find the Average Scores of Customers */


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
