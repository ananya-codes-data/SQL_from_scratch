/* SQL Date & Time Functions

Contents:
     1. NOW | Date Values
     2. Date Part Extractions (DATE_TRUNC, TO_CHAR, DATE_PART, EXTRACT(YEAR, MONTH, DAY))
     3. DATE_TRUNC
     4. EOMONTH
     5. Date Parts
     6. TO_CHAR
     7. Conversion - TO_CHAR, CAST
     8. CAST
     9. Date additions and subtractions
	10. Methods to find difference in dates - AGE(), EXTRACT(), ED - SD 
    11. Creating function for IS_DATE and running IS_DATE */

-- NOW() | DATE VALUES

/* TASK 1:
   Display OrderID, CreationTime, a hard-coded date, and the current system date */
SELECT
	orderid,
    creationtime,
    '2025-06-26' AS hard_coded,
    NOW() AS today
FROM orders;


/* DATE PART EXTRACTIONS
   (DATETRUNC, DATENAME, DATEPART, YEAR, MONTH, DAY) */

/* TASK 2:
   Extract various parts of CreationTime using DATETRUNC, DATENAME, DATEPART,
   YEAR, MONTH, and DAY */

SELECT
	orderid,
	creationtime,
-- DATE_TRUNC Example
	DATE_TRUNC('year', creationtime) AS year_dt,
	DATE_TRUNC('month', creationtime) AS month_dt,
	DATE_TRUNC('day', creationtime) AS day_dt,
	DATE_TRUNC('hour', creationtime) AS hour_dt,
	DATE_TRUNC('minute', creationtime) AS minute_dt,
-- TO_CHAR Example
	TO_CHAR(creationtime, 'Day') AS Day_tc,
	TO_CHAR(creationtime, 'Mon') AS Mon_tc,
	TO_CHAR(creationtime, 'Month') AS Month_tc,
--- DATE_PART Example
	DATE_PART('HOUR', creationtime) AS hour_dp,
	DATE_PART('DAY', creationtime) AS day_dp,
	DATE_PART('DOW', creationtime) AS weekday_dp,
	DATE_PART('WEEK', creationtime) AS week_dp,
	DATE_PART('MONTH', creationtime) AS month_dp,
	DATE_PART('QUARTER', creationtime) AS quarter_dp,
	DATE_PART('YEAR', creationtime) AS year_dp,
    EXTRACT(DAY FROM creationtime) AS day_ex,
	EXTRACT(MONTH FROM creationtime) AS month_ex,
	EXTRACT(YEAR FROM creationtime) AS year_ex
FROM orders;


-- DATETRUNC() DATA AGGREGATION

/* TASK 3:
   Aggregate orders by year using DATETRUNC on CreationTime */
SELECT
	DATE_TRUNC('year', creationtime),
	COUNT(*)
FROM orders
GROUP BY
	DATE_TRUNC('year', creationtime);


-- EOMONTH

/* TASK 4:
   Display OrderID, CreationTime, and the end-of-month date for CreationTime */
SELECT
	orderid,
	creationtime,
	CAST(DATE_TRUNC('month', creationtime) + interval '1 month - 1 day' AS DATE) AS EOMONTH
FROM orders;

/* DATE_TRUNC('month', creationtime) - this gives the first day of the month
+ interval '1 month - 1 day' - this jumps to the last day
+ interval '1 month' - If we are just going for this then it will show the next month 
CAST is for turning the truncation data to a date */


-- DATE PARTS | USE CASES

/* TASK 5:
   How many orders were placed each year? */
SELECT
	DATE_PART('year',orderdate),
	COUNT(*) AS no_of_orders
FROM orders
GROUP BY
	DATE_PART('year',orderdate);

/* TASK 6:
   How many orders were placed each month? */
SELECT
	DATE_PART('month',orderdate),
	COUNT(*) AS no_of_orders
FROM orders
GROUP BY
	DATE_PART('month',orderdate);

/* TASK 7:
   How many orders were placed each month (using friendly month names)? */
SELECT
	TO_CHAR(orderdate, 'month'),
	COUNT(*) AS no_of_orders
FROM orders
GROUP BY
	TO_CHAR(orderdate, 'month');

/* TASK 8:
   Show all orders that were placed during the month of February */
SELECT *
FROM orders
WHERE
	DATE_PART('month', orderdate) = 2;


-- For Formatting - TO_CHAR()

/* TASK 9:
   Format CreationTime into various string representations */

SELECT
	orderid,
	creationtime,
	TO_CHAR(creationtime, 'MM-dd-YYYY') AS USA_Format,
	TO_CHAR(creationtime, 'dd-MM-YYYY') AS EURO_Format,
	TO_CHAR(creationtime, 'dd') AS dd,
	TO_CHAR(creationtime, 'dy') AS day_ddd,
	TO_CHAR(creationtime, 'day') AS day_day,
	TO_CHAR(creationtime, 'MM') AS MM,
	TO_CHAR(creationtime, 'Mon') AS Mon,
	TO_CHAR(creationtime, 'Month') AS Month_MM
FROM orders;

/* TASK 10:
   Display CreationTime using a custom format:
   Example: Day Wed Jan Q1 2025 12:34:56 PM */
SELECT
	orderid,
	creationtime,
	'Day ' ||
	TO_CHAR(creationtime, 'Dy Mon') ||
	' Q' ||
	TO_CHAR(creationtime, 'Q') ||
	' ' ||
	TO_CHAR(creationtime, 'YYYY hh12:mi:ss PM') AS Custom_Format
FROM orders;

/* TASK 11:
   How many orders were placed each year, formatted by month and year (e.g., "Jan 25")? */
SELECT
	TO_CHAR(orderdate, 'Mon YY') AS order_date,
	COUNT(*)
FROM orders
GROUP BY
	TO_CHAR(orderdate, 'Mon YY');


/* Convert
For Formatting - TO_CHAR
Data Type conversion - CAST, :: */

/* TASK 12:
   Demonstrate conversion using CAST & TO_CHAR */
   
SELECT
	/*'123' :: INT AS "String to Int CAST",
	CAST('2025-08-20' AS DATE) AS "String to Date CAST",*/
	creationtime,
	CAST(creationtime AS DATE) AS "Datetime to Date CAST",
	/* CAST(TO_CHAR(creationtime, 'YYYY/MM/DD') AS VARCHAR)
	: For better understanding but not needed because TO_CHAR formats the timestamp
	and the output of TO_CHAR is VARCHAR so there is no need of CAST for conversion */
	TO_CHAR(creationtime, 'MM-DD-YYYY')
	AS "Datetime to String conversion-USA standard format",
	TO_CHAR(creationtime, 'DD-MM-YYYY')
	AS "Datetime to String conversion-European standard format"
FROM orders;


-- CAST(), ::type

/* TASK 13:
   Convert data types using CAST */
SELECT
	CAST('123' AS INT) AS "String to Int",
	123 :: VARCHAR AS "Int to String",
	'2025-08-20' :: DATE AS "String to Date",
	'2025-08-20' :: TIMESTAMP AS "String to Datetime",
	-- In Postgre TIMESTAMP is used in the place of DATETIME
	creationtime,
	creationtime :: DATE AS "Datetime to Date"
FROM orders;


-- Add interval / Difference

/* TASK 14:
   Perform date arithmetic on OrderDaten */
SELECT
	orderid,
	orderdate,
	CAST(orderdate - interval '10 days' AS DATE) AS ten_days_before,
	CAST(orderdate + interval '3 months' AS DATE) AS three_months_later,
	CAST(orderdate + interval '2 years' AS DATE) AS two_years_later
FROM orders;

/* Added CAST because the output I got for the date add was in timestamp,
with CAST I converted that to date */

/* When nesting CAST with other syntax, make sure to use the name aliases
in the last and the CAST aliases in the first */

/* TASK 15:
   Calculate the age of employees */
SELECT
	employeeid,
	birthdate,
	AGE(NOW(), birthdate) AS employees_age
FROM employees;

/* TASK 16:
   Find the average shipping duration in days for each month */
SELECT
	DATE_PART('month', orderdate) AS order_date,
	ROUND(AVG(shipdate - orderdate),0) AS avg_shipping_duration
FROM orders
GROUP BY
	DATE_PART('month', orderdate);

/* TASK 17:
   Time Gap Analysis: Find the number of days between each order and the previous order */
SELECT
	orderid,
	orderdate AS current_order_date,
	LAG(orderdate) OVER (ORDER BY orderdate) AS previous_order_date,
	ABS(LAG(orderdate) OVER (ORDER BY orderdate) - orderdate) AS no_of_days
FROM orders;

/* Used ABS(absolute) in the above query so that
the number of days don't show up as negative integers */


-- ISDATE()

/* TASK 18:
   Validate OrderDate using ISDATE and convert valid dates */

CREATE OR REPLACE FUNCTION IS_DATE(p_value text)
RETURNS boolean AS $$
BEGIN
	-- Year-only input YYYY
	IF p_value ~ '^\d{4}$' THEN
		RETURN TRUE;
	END IF;

	-- Try full date casting
	PERFORM p_value::DATE;
	RETURN TRUE;
	
EXCEPTION
	WHEN others THEN
		RETURN false;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

/* The above query needs to be run before using IS_DATE function because
postgreSQL doesn't support IS_DATE so in the above query we create a function
which replicates IS_DATE. Run the query once and IS_DATE function will be activated
then we can go ahead and check dates with the IS_DATE function */

SELECT
	IS_DATE('123') AS date_check_1,
	IS_DATE('2025-08-20') AS date_check_2,
	IS_DATE('20-08-2025') AS date_check_3,
	/* SQL won't understand because this is not the standard format
	SQL will think it as a string value, SQL will only understand
	if we write the date in the standard format */
	IS_DATE('2025') AS date_check_4,
	IS_DATE('08') AS date_check_5;

SELECT
	--CAST(orderdate AS DATE) AS order_date,
	orderdate,
	IS_DATE(orderdate),
	CASE
		WHEN IS_DATE(orderdate) = true THEN CAST(orderdate AS DATE)
		ELSE '9999-01-01'
	END AS neworderdate
FROM
(
	SELECT
		'2025-08-20' AS orderdate
	UNION
	SELECT
		'2025-08-21'
	UNION
	SELECT
		'2025-08-23'
	UNION
	SELECT
		'2025-08'
)t;
/* WHERE 
	IS_DATE(orderdate) = false; */