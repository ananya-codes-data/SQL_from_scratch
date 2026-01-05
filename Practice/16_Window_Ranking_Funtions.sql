/* SQL Window Ranking Functions

Contents:
     1. ROW_NUMBER
     2. RANK
     3. DENSE_RANK
     4. NTILE
     5. CUME_DIST */

-- SQL WINDOW RANKING | ROW_NUMBER, RANK, DENSE_RANK

/* TASK 1:
   Rank Orders Based on Sales from Highest to Lowest */
SELECT
	orderid,
	productid,
	sales,
	ROW_NUMBER() OVER (
		ORDER BY
			sales DESC
	) AS sales_rank_row,
	RANK() OVER (
		ORDER BY
			sales DESC
	) AS sales_rank_rank,
	DENSE_RANK() OVER (
		ORDER BY
			sales DESC
	) AS sales_rank_dense_rank
FROM orders;

/* TASK 2:
   Use Case | Top-N Analysis: Find the Highest Sale for Each Product */
SELECT
*
FROM (
	SELECT
		orderid,
		productid,
		sales,
		ROW_NUMBER() OVER (
			PARTITION BY
				productid
			ORDER BY
				sales DESC
		) AS rank_by_product
	FROM orders
) AS t
WHERE
	rank_by_product = 1;

/* TASK 3:
   Use Case | Bottom-N Analysis: Find the Lowest 2 Customers Based on Their Total Sales */
SELECT
*
FROM (
	SELECT
		customerid,
		SUM(sales) AS total_sales,
		ROW_NUMBER() OVER (
			ORDER BY
				SUM(sales) ASC
		) AS rank_customers
	FROM orders
	GROUP BY
		customerid
) AS t
WHERE
	rank_customers <= 2;

/* TASK 4:
   Use Case | Assign Unique IDs to the Rows of the 'Order Archive' */
SELECT
	ROW_NUMBER() OVER (
		ORDER BY
			orderid,
			orderdate
	) AS unique_id,
	*
FROM ordersarchive;

/* TASK 5:
   Use Case | Identify Duplicates:
   Identify Duplicate Rows in 'Order Archive' and return a clean result without any duplicates */
SELECT
*
FROM (
	SELECT
		ROW_NUMBER() OVER (
			PARTITION BY
				orderid
			ORDER BY
				creationtime DESC
		) AS rn,
		*
	FROM ordersarchive
) AS t
WHERE
	rn = 1
/* WHERE
	rn != 1
WHERE
	rn > 1 */;


-- SQL WINDOW RANKING | NTILE

/* TASK 6:
   Divide Orders into Groups Based on Sales */
SELECT
	orderid,
	sales,
	NTILE(4) OVER (
		ORDER BY
			sales DESC
	) AS four_bucket,
	NTILE(3) OVER (
		ORDER BY
			sales DESC
	) AS three_bucket,
	NTILE(2) OVER (
		ORDER BY
			sales DESC
	) AS two_bucket,
	NTILE(1) OVER (
		ORDER BY
			sales DESC
	) AS one_bucket
FROM orders;

/* TASK 7:
   Segment all Orders into 3 Categories: High, Medium, and Low Sales. */
SELECT
	*,
	CASE
		WHEN buckets = 1 THEN 'High'
		WHEN buckets = 2 THEN 'Medium'
		WHEN buckets = 3 THEN 'Low'
	END AS sales_segmentations
FROM (
	SELECT
		orderid,
		sales,
		NTILE(3) OVER (
			ORDER BY
				sales DESC
		) AS buckets
	FROM orders
) AS t;

/* TASK 8:
   Divide Orders into Groups for Processing */
SELECT
	NTILE(2) OVER (
		ORDER BY
			orderid
	) AS buckets,
	*
FROM orders;


-- SQL WINDOW RANKING | CUME_DIST

/* TASK 9:
   Find Products that Fall Within the Highest 40% of the Prices */
SELECT
	*,
	CONCAT(dist_rank * 100, '%') AS dist_rank_per
FROM (
	SELECT
		product,
		price,
		CUME_DIST() OVER (
			ORDER BY
				price DESC
		) AS dist_rank
	FROM products
) AS t
WHERE
	dist_rank <= 0.4;