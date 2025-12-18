/* SQL NULL Functions

Contents:
	1. Handle NULL - Data Aggregation
	2. Handle NULL - Mathematical Operators
	3. Handle NULL - Sorting Data
	4. NULLIF - Division by Zero
	5. IS NULL - IS NOT NULL
	6. LEFT ANTI JOIN
	7. NULLs vs Empty String vs Blank Spaces */

-- HANDLE NULL - DATA AGGREGATION

/* TASK 1: 
   Find the average scores of the customers.
   Uses COALESCE to replace NULL Score with 0. */
SELECT
	customerid,
	score,
	COALESCE(score, 0) AS score_2,
	ROUND(AVG(score) OVER(), 0) AS avg_scores,
	ROUND(AVG(COALESCE(score, 0)) OVER ()) AS avg_score_2
FROM customers;


-- HANDLE NULL - MATHEMATICAL OPERATORS

/* TASK 2: 
   Display the full name of customers in a single field by merging their
   first and last names, and add 10 bonus points to each customer's score. */
SELECT
	customerid,
	firstname,
	lastname,
	firstname || ' ' || COALESCE(lastname, '') AS full_name,
	COALESCE(score, 0) + 10 AS score_withbonus
FROM customers;


-- HANDLE NULL - SORTING DATA

/* TASK 3: 
   Sort the customers from lowest to highest scores,
   with NULL values appearing last. */
SELECT
	customerid,
	score
FROM customers
ORDER BY
	score ASC;

/* In postgres NULL is considered as the highest value
unlike SQL server where NULL is considered as the lowest value */


-- NULLIF - DIVISION BY ZERO

/* TASK 4: 
   Find the sales price for each order by dividing sales by quantity.
   Uses NULLIF to avoid division by zero. */
SELECT
	orderid,
	sales,
	quantity,
	sales / NULLIF(quantity, 0) AS sales_price
FROM orders;


-- IS NULL - IS NOT NULL

/* TASK 5: 
   Identify the customers who have no scores */
SELECT
	customerid,
	score
FROM customers
WHERE
	score IS NULL;

/* TASK 6: 
   Identify the customers who have scores */
SELECT
	customerid,
	score
FROM customers
WHERE
	score IS NOT NULL;


-- LEFT ANTI JOIN

/* TASK 7: 
   List all details for customers who have not placed any orders */
SELECT
	c.*,
	o.orderid
FROM customers AS c
LEFT JOIN orders AS o
	ON c.customerid = o.customerid
WHERE
	o.customerid IS NULL;


-- NULLs vs EMPTY STRING vs BLANK SPACES

/* TASK 8: 
   Demonstrate differences between NULL, empty strings, and blank spaces */
WITH orders AS (
    SELECT 1 AS id, 'A' AS category
	UNION
    SELECT 2, NULL
	UNION
    SELECT 3, ''
	UNION
    SELECT 4, '  '
)
SELECT
	*,
	LENGTH(category) AS category_length,
	TRIM(category) AS data_policy1,
	NULLIF(TRIM(category), '') AS data_policy2,
	COALESCE(NULLIF(TRIM(category), ''), 'unknown') AS data_policy3
FROM orders;