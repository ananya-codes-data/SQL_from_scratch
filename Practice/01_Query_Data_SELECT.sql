/* SELECT Query

Contents:
1. SELECT ALL COLUMNS
2. SELECT SPECIFIC COLUMNS
3. FROM
4. WHERE
5. GROUP BY
6. HAVING
7. ORDER BY
8. LIMIT
9. DISTINCT
10. OFFSET
11. TOP
12. Executing ALL Clause
13. Executing Multiple Queries
14. Using Static Data */

-- SELECT & FROM Clause (All)

-- Retrieve All Customer Data
SELECT *
FROM customers;

-- Retrieve All Order Data
SELECT *
FROM orders;


-- SELECT & FROM Clause (Few)

-- Retrieve each customer's name, country, and score
SELECT 
	first_name,
	country,
	score
FROM customers;


-- WHERE Clause

-- Retrieve customers with a score not equal to 0
SELECT *
FROM customers
WHERE score != 0;

-- Retrieve customers from Germany
SELECT *
FROM customers
WHERE country = 'Germany';

-- Retrieve the name and country of customers from Germany
SELECT
	first_name,
	country
FROM customers
WHERE country = 'Germany';


-- ORDER BY Clause

/* Retrieve all customers and 
sort the results by the highest score first */
SELECT *
FROM customers
ORDER BY score DESC;
  
/* Retrieve all customers and 
sort the results by the lowest score first */
SELECT *
FROM customers
ORDER BY score ASC;
   
-- If not specified as such then the default is ascending
/* Retrieve all customers and 
sort the results by the country */
SELECT *
FROM customers
ORDER BY country ASC;
   

-- (Nested) ORDER BY

/* Retrieve all customers and 
sort the results by the country and then by the highest score */
SELECT *
FROM customers
ORDER BY country ASC, score DESC;
   
/* Retrieve the name, country, and score of customers 
whose score is not equal to 0
and sort the results by the highest score first */
SELECT
	first_name,
	country,
	score
FROM customers
WHERE score != 0
ORDER BY score DESC;


-- GROUP BY Clause

-- Find the total score for each country
SELECT   
	country,
	SUM(score) AS total_score
FROM customers
GROUP BY country;

-- Find the total score and total number of customers for each country
SELECT
	country,
	SUM(score) AS total_score,
    COUNT(id) AS total_customers
FROM customers
GROUP BY country;


-- HAVING Clause

/* Find the average score for each country
   and return only those countries with an average score greater than 430 */
SELECT
	country,
    AVG(score) AS average_score
FROM customers
GROUP BY country
HAVING AVG(score) > 430;

/* Find the average score for each country
   considering only customers with a score not equal to 0
   and return only those countries with an average score greater than 430 */
SELECT
	country,
    AVG(score) AS avg_score
FROM customers
WHERE score != 0
GROUP BY country
HAVING AVG(score) > 430;


-- DISTINCT Clause

-- Return Unique list of all countries
SELECT DISTINCT country
FROM customers;


-- LIMIT Clause

-- Retrieve only 3 Customers
SELECT *
FROM customers
LIMIT 3;

-- Retrieve the Top 3 Customers with the Highest Scores
SELECT *
FROM customers
ORDER BY score DESC
LIMIT 3;

-- Retrieve the Lowest 2 Customers based on the score
SELECT *
FROM customers
ORDER BY score ASC
LIMIT 2;

-- Get the Two Most Recent Orders
SELECT *
FROM orders
ORDER BY order_date DESC
LIMIT 2;


-- All Together

/* Calculate the average score for each country 
   considering only customers with a score not equal to 0
   and return only those countries with an average score greater than 430
   and sort the results by the highest average score first */
SELECT
	country,
    AVG(score) AS avg_score
FROM customers
WHERE score != 0
GROUP BY country
HAVING AVG(score) > 430
ORDER BY AVG(score) DESC;

-- Always remember to put a ; after each query gets over

-- Execute multiple queries at once
SELECT *
FROM customers;

SELECT *
FROM orders;


-- Selecting Static Data

-- Select a static or constant value without accessing any table
SELECT 2122 AS twin_bday;

SELECT 'Ananya' AS my_name;

-- Assign a constant value to a column in a query
SELECT
	id,
    first_name,
    'New Customer' AS Customer_type
FROM customers;

-- If we highlight a part of the query and then execute it then the result will be different
SELECT *
FROM customers
WHERE country = 'Germany';

SELECT *
FROM orders;