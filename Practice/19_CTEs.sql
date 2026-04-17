/* SQL Common Table Expressions (CTEs)
Contents:
	1. NON-RECURSIVE CTE
	2. RECURSIVE CTE | GENERATE SEQUENCE
	3. RECURSIVE CTE | BUILD HIERARCHY */

 
-- NON-RECURSIVE CTE


-- Step1: Find the total Sales Per Customer (Standalone CTE)

WITH CTE_Total_Sales AS
(
SELECT
	customerid,
	SUM(sales) AS total_sales
FROM Orders
GROUP BY
	customerid
)

-- Step2: Find the last order date for each customer (Standalone CTE)

, CTE_Last_Order AS
(
SELECT
	customerid,
	MAX(orderdate) AS last_order
FROM orders
GROUP BY
	customerid
)

-- Step3: Rank Customers based on Total Sales Per Customer (Nested CTE)

, CTE_customer_rank AS
(
SELECT
	customerid,
	total_sales,
	RANK() OVER (
		ORDER BY
			total_sales DESC
	) AS customer_rank
FROM CTE_Total_Sales
)

-- Step4: segment customers based on their total sales (Nested CTE)

, CTE_customer_segments AS
(
SELECT
	customerid,
	total_sales,
	CASE
		WHEN total_sales > 100 THEN 'High'
		WHEN total_sales > 80 THEN 'Medium'
		ELSE 'Low'
	END AS customer_segments
FROM CTE_Total_Sales
)

-- Main Query

SELECT
	c.customerid,
	c.firstname,
	c.lastname,
	cts.total_sales,
	clo.last_order,
	ccr.customer_rank,
	ccs.customer_segments
FROM customers AS c
LEFT JOIN CTE_Total_Sales AS cts
ON c.customerid = cts.customerid
LEFT JOIN CTE_Last_Order AS clo
ON c.customerid = clo.customerid
LEFT JOIN CTE_customer_rank AS ccr
ON c.customerid = ccr.customerid
LEFT JOIN CTE_customer_segments AS ccs
ON c.customerid = ccs.customerid;

 
-- RECURSIVE CTE | GENERATE SEQUENCE

/* TASK 2:
   Generate a sequence of numbers from 1 to 20 */
WITH RECURSIVE series AS (
	-- Anchor Query
	SELECT 1 AS my_number
	UNION ALL
	-- Recursive Query
	SELECT
	my_number + 1
	FROM series
	WHERE my_number < 20
)

-- Main Query
SELECT *
FROM series;

/* TASK 3:
   Generate a sequence of numbers from 1 to 1000 */
WITH RECURSIVE series_2 AS
(
    -- Anchor Query
    SELECT 1 AS my_number
	UNION ALL
    -- Recursive Query
    SELECT
	my_number + 1
	FROM series_2
	WHERE my_number < 1000
)
-- Main Query
SELECT *
FROM series_2;

 
-- RECURSIVE CTE | BUILD HIERARCHY

/* TASK 4:
   Build the employee hierarchy by displaying each employee's level within the organization
   - Anchor Query: Select employees with no manager
   - Recursive Query: Select subordinates and increment the level */

WITH RECURSIVE CTE_emp_hierarchy AS
(
    -- Anchor Query: Top-level employees (no manager)
    SELECT
		employeeid,
		firstname,
		managerid,
		1 AS level
	FROM employees
	WHERE managerid IS NULL
	UNION ALL

    -- Recursive Query: Get subordinate employees and increment level
    SELECT
		e.employeeid,
		e.firstname,
		e.managerid,
		level + 1
	FROM employees AS e
	INNER JOIN CTE_emp_hierarchy AS ceh
	ON e.managerid = ceh.employeeid
)
-- Main Query
SELECT *
FROM CTE_emp_hierarchy;