/* SQL Window Value Functions
Contents:
	1. LEAD
    2. LAG
    3. FIRST_VALUE
    4. LAST_VALUE */

-- SQL WINDOW VALUE | LEAD, LAG

/* TASK 1:
   Analyze the Month-over-Month Performance by Finding the Percentage Change in Sales
   Between the Current and Previous Months */
SELECT
	*,
	current_month_sales - previous_month_sales AS mom_change,
	ROUND(
		CAST(
			(current_month_sales - previous_month_sales) 
			AS NUMERIC
		) / previous_month_sales * 100,
		1
	) AS mom_per
FROM (
	SELECT
		EXTRACT(month FROM orderdate) AS order_month,
		SUM(sales) AS current_month_sales,
		LAG(
			SUM(sales)
		) OVER (
			ORDER BY
				EXTRACT(month FROM orderdate)
		) AS previous_month_sales
	FROM orders
	GROUP BY
		EXTRACT(month FROM orderdate)
) AS t;

/* TASK 2:
   Customer Loyalty Analysis - Rank Customers Based on the Average Days Between Their Orders */
SELECT
	customerid,
	ROUND(
		AVG(days_until_next_order),
		1
	)AS avg_days,
	RANK() OVER (
		ORDER BY
			AVG(days_until_next_order) ASC
	) AS rank_avg
FROM (
	SELECT
		orderid,
		customerid,
		orderdate AS current_order,
		LEAD(orderdate) OVER (
			PARTITION BY
				customerid
			ORDER BY
				orderdate
		) AS next_order,
		LEAD(orderdate) OVER (
			PARTITION BY
				customerid
			ORDER BY
				orderdate
		) - orderdate
		AS days_until_next_order
	FROM orders
) AS t
GROUP BY
	customerid;


-- SQL WINDOW VALUE | FIRST & LAST VALUE

/* TASK 3:
   Find the Lowest and Highest Sales for Each Product,
   and determine the difference between the current Sales and the lowest Sales for each Product */
SELECT
	orderid,
	productid,
	sales,
	FIRST_VALUE(sales) OVER (
		PARTITION BY
			productid
		ORDER BY
			sales ASC
	) AS lowest_sales,
	LAST_VALUE(sales) OVER(
		PARTITION BY
			productid
		ORDER BY
			sales ASC
		ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
	) AS highest_sales,
	sales - FIRST_VALUE(sales) OVER (PARTITION BY productid ORDER BY sales ASC) AS sales_difference
	/* FIRST_VALUE(sales) OVER (
		PARTITION BY
			productid
		ORDER BY
			sales DESC
	) AS highest_sales2,
	MIN(sales) OVER (
		PARTITION BY
			productid
	) AS lowest_sales2,
	MAX(sales) OVER (
		PARTITION BY
			productid
	) AS highest_sales3 */
FROM orders;