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

/* TASK 7: 
   Calculate Total Sales by Order Status for current and next two orders */


/* TASK 8: 
   Calculate Total Sales by Order Status for current and previous two orders */


/* TASK 9: 
   Calculate Total Sales by Order Status from previous two orders only */


/* TASK 10: 
   Calculate cumulative Total Sales by Order Status up to the current order */


/* TASK 11: 
   Calculate cumulative Total Sales by Order Status from the start to the current row */



-- SQL WINDOW FUNCTIONS | RULES

/* RULE 1: 
   Window functions can only be used in SELECT or ORDER BY clauses */


-- Invalid: window function in WHERE clause

/* RULE 2: 
   Window functions cannot be nested */

-- Invalid nesting


-- SQL WINDOW FUNCTIONS | GROUP BY

/* TASK 12: 
   Rank customers by their total sales */
