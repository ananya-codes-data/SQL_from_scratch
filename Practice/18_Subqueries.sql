/* SQL Subquery Functions
   
Contents:
	1. SUBQUERY - RESULT TYPES
	2. SUBQUERY - FROM CLAUSE
	3. SUBQUERY - SELECT
	4. SUBQUERY - JOIN CLAUSE
	5. SUBQUERY - COMPARISON OPERATORS 
	6. SUBQUERY - IN OPERATOR
	7. SUBQUERY - ANY OPERATOR
	8. SUBQUERY - CORRELATED 
	9. SUBQUERY - EXISTS OPERATOR */


-- SUBQUERY | RESULT TYPES

--  Scalar Query
SELECT
	ROUND(
		AVG(sales),
		0
	) AS sales_avg
FROM orders;

-- Row Query 
SELECT
	customerid
FROM orders;

-- Table Query
SELECT
	orderid,
	orderdate
FROM orders;


-- SUBQUERY | FROM CLAUSE

/* TASK 1:
   Find the products that have a price higher than the average price of all products */

-- Main Query
SELECT
*
FROM (
-- Subquery
	SELECT
		productid,
		price,
		ROUND(
			AVG(price) OVER (),
			0
			) AS avg_price
	FROM products
) AS t
WHERE
	price > avg_price;

/* TASK 2:
   Rank Customers based on their total amount of sales */
-- Main Query
SELECT
	*,
	RANK() OVER(
		ORDER BY
			total_sales DESC
	) AS customer_rank
FROM (
-- Subquery
	SELECT
		customerid,
		SUM(sales) AS total_sales
	FROM orders
	GROUP BY
		customerid
) AS t;


-- SUBQUERY | SELECT

/* TASK 3:
   Show the product IDs, product names, prices, and the total number of orders */
-- Main Query
SELECT
	productid,
	product,
	price,
	-- Subquery
	(
	SELECT
		COUNT(*)
	FROM orders
	) AS total_orders
FROM products;


-- SUBQUERY | JOIN CLAUSE

/* TASK 4:
   Show customer details along with their total sales */
-- Main Query
SELECT
	c.*,
	o.total_sales
FROM customers AS c
INNER JOIN (
-- Subquery
	SELECT
		customerid,
		SUM(sales) AS total_sales
	FROM orders
	GROUP BY
		customerid
) AS o
	ON c.customerid = o.customerid;

/* TASK 5:
   Show all customer details and the total orders of each customer */
-- Main Query
SELECT
	c.*,
	o.total_orders
FROM customers AS c
LEFT JOIN (
-- Subquery
	SELECT
		customerid,
		COUNT(*) AS total_orders
	FROM orders
	GROUP BY
		customerid
) AS o
	ON c.customerid = o.customerid;


-- SUBQUERY | COMPARISON OPERATORS

/* TASK 6:
   Find the products that have a price higher than the average price of all products */
-- Main Query
SELECT
	productid,
	price,
-- Subquery
	(
	SELECT
		ROUND(
			AVG(price),
			0
		)
	FROM products
	) AS avg_price
FROM products
WHERE
	price > (
-- Subquery
	SELECT
		ROUND(
			AVG(price),
			0
		)
	FROM products
);
 
-- SUBQUERY | IN OPERATOR

/* TASK 7:
   Show the details of orders made by customers in Germany */
-- Main Query
SELECT
*
FROM orders
WHERE
	customerid IN (
		SELECT
			customerid
		FROM customers
		WHERE
			country = 'Germany'
);

/* TASK 8:
   Show the details of orders made by customers not in Germany */
-- Main Query
SELECT
*
FROM orders
WHERE
	customerid IN (
	SELECT
		customerid
	FROM customers
	WHERE
		country != 'Germany'
);

--OR

-- Main Query
SELECT
*
FROM orders
WHERE
	customerid NOT IN (
	SELECT
		customerid
	FROM customers
	WHERE
		country = 'Germany'
);

 
-- SUBQUERY | ANY OPERATOR

/* TASK 9:
   Find female employees whose salaries are greater than the salaries of any male employees */
-- Main Query
SELECT
	employeeid,
	firstname,
	salary
FROM employees
WHERE
	gender = 'F'
	AND
	salary > ANY (
		SELECT
			salary
		FROM employees
		WHERE
			gender = 'M'
);


-- CORRELATED SUBQUERY

/* TASK 10:
   Show all customer details and the total orders for each customer using a correlated subquery */
--Main Query
SELECT
	*,
	(
	SELECT
		COUNT(*)
	FROM orders AS o
	WHERE
		o.customerid = c.customerid
	) AS total_sales
FROM customers AS c;

SELECT
	COUNT(*)
FROM orders;


-- SUBQUERY | EXISTS OPERATOR

/* TASK 11:
   Show the details of orders made by customers in Germany */
-- Main Query
SELECT
*
FROM orders AS o
WHERE
	EXISTS (
		SELECT
		1
		FROM customers AS c
		WHERE
			country = 'Germany'
			AND
			o.customerid = c.customerid
);

/* TASK 12:
   Show the details of orders made by customers not in Germany */
-- Main Query
SELECT
*
FROM orders AS o
WHERE
	NOT EXISTS (
		SELECT
		1
		FROM customers AS c
		WHERE
			country = 'Germany'
			AND
			o.customerid = c.customerid
);