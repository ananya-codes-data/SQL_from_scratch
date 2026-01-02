/* SQL Window Functions

Contents:
	1.SQLWindowBasics
	2.SQLWindowOVERClause
	3.SQLWindowPARTITIONClause
	4.SQLWindowORDERClause
	5.SQLWindowFRAMEClause
	6.SQLWindowRules
	7.SQLWindowwithGROUPBY */

-- SQL WINDOW FUNCTIONS | BASICS

/* TASK 1: 
   Calculate the Total Sales Across All Orders  */
SELECT
	SUM(sales) AS total_sales
FROM orders;

/* TASK 2: 
   Calculate the Total Sales for Each Product */
SELECT
	productid,
	SUM(sales) AS total_sales
FROM orders
GROUP BY
	productid;


-- SQL WINDOW FUNCTIONS | OVER CLAUSE

/* TASK 3: 
   Find the total sales across all orders,
   additionally providing details such as OrderID and OrderDate */
SELECT
	orderid,
	orderdate,
	SUM(sales) OVER() AS total_sales
FROM orders;


-- SQL WINDOW FUNCTIONS | PARTITION CLAUSE

/* TASK 4: 
   Find the total sales across all orders and for each product,
   additionally providing details such as OrderID and OrderDate */
SELECT
	orderid,
	orderdate,
	productid,
	SUM(sales) OVER(
		PARTITION BY
			productid
	) AS total_sales_by_product
FROM orders;

/* TASK 5: 
   Find the total sales across all orders, for each product,
   and for each combination of product and order status,
   additionally providing details such as OrderID and OrderDate */
SELECT
	orderid,
	orderdate,
	productid,
	orderstatus,
	sales,
	SUM(sales) OVER() AS total_sales,
	SUM(sales) OVER(
		PARTITION BY
			productid
	) AS sales_by_product,
	SUM(sales) OVER(
		PARTITION BY
			productid,
			orderstatus
	) AS sales_by_product_and_orderstatus
FROM orders;


-- SQL WINDOW FUNCTIONS | ORDER CLAUSE

/* TASK 6: 
   Rank each order by Sales from highest to lowest */
SELECT
	orderid,
	orderdate,
	sales,
	RANK() OVER(ORDER BY sales DESC) AS rank_sales
FROM orders;


-- SQL WINDOW FUNCTIONS | FRAME CLAUSE

SELECT
	orderid,
	orderdate,
	orderstatus,
	sales,
	SUM(sales) OVER(
		PARTITION BY 
			orderstatus
		ORDER BY
			orderdate
		ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING
	) AS total_sales
FROM orders;

SELECT
	orderid,
	orderdate,
	orderstatus,
	sales,
	SUM(sales) OVER(
		PARTITION BY 
			orderstatus
		ORDER BY
			orderdate
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW /* DEFAULT FRAME
		, only works with the ORDER BY
		, can be executed without it to get the exact result */
		-- ROWS UNBOUNDED PRECEDING -- DEFAULT FRAME SHORT FORM
		-- ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
		-- ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		-- ROWS 2 PRECEDING
		-- ROWS UNBOUNDED PRECEDING
	) AS total_sales
FROM orders;

/* TASK 7: 
   Calculate Total Sales by Order Status for current and next two orders */
SELECT
	orderid,
	orderdate,
	orderstatus,
	sales,
	SUM(sales) OVER(
		PARTITION BY
			orderstatus
		ORDER BY
			orderdate
		ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING
	) AS total_sales
FROM orders;

/* TASK 8: 
   Calculate Total Sales by Order Status for current and previous two orders */
SELECT
	orderid,
	orderdate,
	orderstatus,
	sales,
	SUM(sales) OVER(
		PARTITION BY
			orderstatus
		ORDER BY
			orderdate
		ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
	) AS total_sales
FROM orders;

/* TASK 9: 
   Calculate Total Sales by Order Status from previous two orders only */
SELECT
	orderid,
	orderdate,
	orderstatus,
	sales,
	SUM(sales) OVER(
		PARTITION BY
			orderstatus
		ORDER BY
			orderdate
		ROWS 2 PRECEDING
	) AS total_sales
FROM orders;

/* TASK 10: 
   Calculate cumulative Total Sales by Order Status up to the current order */
SELECT
	orderid,
	orderdate,
	orderstatus,
	sales,
	SUM(sales) OVER(
		PARTITION BY
			orderstatus
		ORDER BY
			orderdate
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
	) AS total_sales
FROM orders;

/* TASK 11: 
   Calculate cumulative Total Sales by Order Status from the start to the current row */
SELECT
	orderid,
	orderdate,
	orderstatus,
	sales,
	SUM(sales) OVER(
		PARTITION BY
			orderstatus
		ORDER BY
			orderdate
		ROWS UNBOUNDED PRECEDING
	) AS total_sales
FROM orders;


-- SQL WINDOW FUNCTIONS | RULES

/* RULE 1: 
   Window functions can only be used in SELECT or ORDER BY clauses */
SELECT
	orderid,
	orderdate,
	orderstatus,
	sales,
	SUM(sales) OVER(
		PARTITION BY
			orderstatus
	) AS total_sales
FROM orders
ORDER BY
	SUM(sales) OVER(
		PARTITION BY
			orderstatus
	) DESC;

/* Invalid: window functions are not allowed in WHERE clause as well as in GROUP BY clause
window functions can't be used to filter data or group data */

/* RULE 2: 
   Window functions cannot be nested */
SELECT
	orderid,
	orderdate,
	orderstatus,
	sales,
	SUM(SUM(sales) OVER(
		PARTITION BY
			orderstatus
	)) OVER(
		PARTITION BY
			orderstatus
	) AS total_sales
FROM orders

-- Error: window fuction cannot be nested

/* Find the total sales for each order status,
only for two products 101 and 102 */

SELECT
	orderid,
	orderdate,
	orderstatus,
	productid,
	sales,
	SUM(sales) OVER(
		PARTITION BY
			orderstatus
	) AS total_sales
FROM orders
WHERE
	productid IN(101, 102);

-- first filtering and then aggregation

-- SQL WINDOW FUNCTIONS | GROUP BY

/* TASK 12: 
   Rank customers by their total sales */
SELECT
	customerid,
	SUM(sales) AS total_sales,
	RANK() OVER(
		ORDER BY
			SUM(sales) DESC
	) AS rank_customers
FROM orders
GROUP BY
	customerid;

/* We can use both GROUP BY and WINDOW Functions together but the only rule is,
the columns that are to be used inside WINDOW functions needs to be in the GROUP BY too */