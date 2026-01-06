/* SQL CASE Statement
Contents:
	1. Categorize Data
	2. Mapping
	3. Quick Form of Case Statement
	4. Handling Nulls
	5. Conditional Aggregation */

-- USE CASE: CATEGORIZE DATA

/* TASK 1: 
   Create a report showing total sales for each category:
	   - High: Sales over 50
	   - Medium: Sales between 20 and 50
	   - Low: Sales 20 or less
   The results are sorted from highest to lowest total sales. */
SELECT
	category,
	SUM(sales) AS total_sales
FROM (
	SELECT
		orderid,
		sales,
		CASE
			WHEN sales > 50 THEN 'High'
			WHEN sales > 20 THEN 'Medium'
			ELSE 'Low'
		END AS category
	FROM orders
) AS t
GROUP BY
	category
ORDER BY
	total_sales DESC;

-- USE CASE: MAPPING

-- Retrieve employee details with gender displayed as full text
SELECT
	employeeid,
	firstname,
	lastname,
	gender,
	CASE
		WHEN gender = 'F' THEN 'Female'
		WHEN gender = 'M' THEN 'Male'
		ELSE 'Not Available'
	END AS gender_fulltext
FROM employees;

/* TASK 2: 
   Retrieve customer details with abbreviated country codes */
SELECT
	customerid,
	firstname,
	lastname,
	country,
	CASE
		WHEN country = 'Germany' THEN 'DE'
		WHEN country = 'USA' THEN 'US'
		ELSE 'n/a'
	END AS country_abbr
FROM customers;

SELECT DISTINCT
	country
FROM customers;

-- QUICK FORM SYNTAX

/* TASK 3: 
   Retrieve customer details with abbreviated country codes using quick form */
SELECT
	customerid,
	firstname,
	lastname,
	country,
	CASE country
		WHEN 'USA' THEN 'US'
		WHEN 'Germany' THEN 'DE'
		ELSE 'n/a'
	END AS country_abbr
FROM customers;

SELECT DISTINCT
	country
FROM customers;


-- HANDLING NULLS

/* TASK 4: 
   Calculate the average score of customers, treating NULL as 0,
   and provide CustomerID and LastName details. */
SELECT
	customerid,
	lastname,
	score,
	CASE
		WHEN score IS NULL THEN 0
		ELSE score
	END AS clean_score,
	ROUND(
		AVG(
			CASE
				WHEN score IS NULL THEN 0
				ELSE score
			END
		) OVER (),
		0
	) AS avg_clean,
	ROUND(
		AVG(score) OVER (), 
		0
	) AS avg_customer
FROM customers;

-- CONDITIONAL AGGREGATION

/* TASK 5: 
   Count how many orders each customer made with sales greater than 30 */
SELECT
	customerid,
	SUM(
		CASE
			WHEN sales > 30 THEN 1
			ELSE 0
		END
	) AS total_orders_highsales,
	COUNT(*) AS total_orders
FROM orders
GROUP BY
	customerid;