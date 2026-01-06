/* SQL String Functions

Contents:
     1. Manipulations
        - CONCAT
        - LOWER
        - UPPER
	- TRIM
	- REPLACE
     2. Calculation
        - LEN
     3. Substring Extraction
        - LEFT
        - RIGHT
        - SUBSTRING */

-- CONCAT() - String Concatenation

-- Concatenate first name and country into one column
SELECT
	first_name,
    country,
    CONCAT(first_name, '_', country) AS name_country
FROM customers;


-- LOWER() & UPPER() - Case Transformation

-- Convert the first name to lowercase
SELECT
	LOWER(first_name) AS first_name
FROM customers;

-- Convert the first name to uppercase
SELECT
	UPPER(first_name) AS FIRST_NAME
FROM customers;


-- TRIM() - Remove White Spaces

-- Find customers whose first name contains leading or trailing spaces
SELECT
	first_name,
    TRIM(first_name)
FROM customers;

SELECT
	first_name,
    LENGTH(first_name) AS length_name,
    LENGTH(
		TRIM(first_name)
	) AS trimmed_length_name,
    LENGTH(first_name) - LENGTH(TRIM(first_name)) AS diff
FROM customers
WHERE 
	LENGTH(first_name) != LENGTH(TRIM(first_name));
/* WHERE 
	first_name != TRIM(first_name) */


-- REPLACE() - Replace or Remove old value with new one

-- Remove dashes (-) from a phone number
SELECT 
	'123-456-7890' AS phone_no,
    REPLACE('123-456-7890', '-', '' ) AS clean_phn_no;

SELECT 
	'123-456-7890' AS phone_no,
    REPLACE('123-456-7890', '-', '/' ) AS clean_phn_no;

-- Replace File Extence from txt to csv
SELECT
	'report.txt' AS old_filename,
    REPLACE('report.txt', '.txt', '.csv') AS new_filename;


-- LEN() - String Length & Trimming

-- Calculate the length of each customer's first name
SELECT
	first_name,
    LENGTH(first_name)
FROM customers;


-- LEFT() & RIGHT() - Substring Extraction

-- Retrieve the first two characters of each first name
SELECT
	first_name,
    LEFT(
		TRIM(first_name),
		2
	) AS first_2_char
FROM customers;

-- Retrieve the last two characters of each first name
SELECT
	first_name,
    RIGHT(first_name, 2) AS last_2_char
FROM customers;


-- SUBSTRING() - Extracting Substrings

-- Retrieve a list of customers' first names after removing the first character
SELECT
	first_name,
    SUBSTRING(
		TRIM(first_name), 
		2, 
		LENGTH(first_name)
	) AS sub_name
FROM customers;


-- NESTING FUNCTIONS

-- Nesting
SELECT
	first_name,
    SUBSTRING(
		TRIM(first_name),
		2, 
		LENGTH(first_name)
	) AS sub_name
FROM customers;

-- We call it nesting when we use more than one function together to get the result that we need