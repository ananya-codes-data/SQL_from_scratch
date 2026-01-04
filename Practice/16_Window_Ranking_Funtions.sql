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
	ROW_NUMBER() OVER(
		ORDER BY
			sales DESC
	) AS sales_rank_row,
	RANK() OVER(
		ORDER BY
			sales DESC
	) AS sales_rank_rank
FROM orders;

/* TASK 2:
   Use Case | Top-N Analysis: Find the Highest Sale for Each Product */


/* TASK 3:
   Use Case | Bottom-N Analysis: Find the Lowest 2 Customers Based on Their Total Sales */


/* TASK 4:
   Use Case | Assign Unique IDs to the Rows of the 'Order Archive' */


/* TASK 5:
   Use Case | Identify Duplicates:
   Identify Duplicate Rows in 'Order Archive' and return a clean result without any duplicates */



-- SQL WINDOW RANKING | NTILE

/* TASK 6:
   Divide Orders into Groups Based on Sales */


/* TASK 7:
   Segment all Orders into 3 Categories: High, Medium, and Low Sales. */


/* TASK 8:
   Divide Orders into Groups for Processing */



-- SQL WINDOW RANKING | CUME_DIST

/* TASK 9:
   Find Products that Fall Within the Highest 40% of the Prices */
