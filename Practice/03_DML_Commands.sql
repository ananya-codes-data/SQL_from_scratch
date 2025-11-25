/* DML Commands
Data Manipulation Language

Contents:
1. INSERT
2. UPDATE
3. DELETE
4. TRUNCATE */

-- INSERT

# 1 Method: Manual INSERT using VALUES

-- Insert new records into the customers table
INSERT INTO customers (id, first_name, country, score)
VALUES
	(6, 'Anna', 'USA', NULL),
    (7, 'Sam', NULL, 100);


-- Incorrect column order 
INSERT INTO customers (id, first_name, country, score)
VALUES
	(8, 'USA', 'Max', NULL);
    
/* The above query is not in the correct order still it is accepted because both col.2 and col.3 have string values
and both of the columns have the same data type and that is VARCHAR, so database donsn't have any problem with the
contents of the column as long as the values follow the condition of the data type */

/* If you have executed the above query, you can execute the below queries in order to fetch the individual column values
and then delete the particular values for the given column

SELECT *
FROM customers
WHERE 
    id = 8;

DELETE
FROM customers
WHERE 
    id =8; */


-- Incorrect data type in values
INSERT INTO customers (id, first_name, country, score)
VALUES 
	('Max', 9, 'Max', NULL);

/* The above query won't execute and show an error because the values does not match the data type and constraint
that is given to the respective column */


-- Insert a new record with full column values
INSERT INTO customers (id, first_name, country, score)
VALUES
	(8, 'Max', 'USA', 368);
    

-- Insert a new record without specifying column names (not recommended)
INSERT INTO customers 
VALUES 
    (9, 'Andreas', 'Germany', NULL);

    
-- Insert a record with only id and first_name (other columns will be NULL or default values)
INSERT INTO customers (id, first_name)
VALUES 
    (10, 'Sahra');

SELECT *
FROM customers;

INSERT INTO customers (id, country)
VALUES
	(11, 'India');
    
SELECT *
FROM customers
WHERE 
    id = 11;

DELETE
FROM customers
WHERE 
    id = 11;
    
/* You can specify in which column you want to put the values but the primary key can never be null
orelse after execution the it will show an error so the primary key has to contain some value */


/* #2 Method: INSERT DATA USING SELECT - Moving Data From One Table to Another */

-- Copy data from the 'customers' table into 'persons'
/* persons - target table
customers - source table */
INSERT INTO persons (id, person_name, birth_date, phone)
SELECT
	id,
    first_name,
    NULL,
    'Unknown'
FROM customers;

SELECT *
FROM persons;


-- UPDATE
-- Change the score of customer with ID 6 to 0
UPDATE customers
SET score = 0
WHERE 
    id = 6;

/* You should run this query to avoid updating wrong data
SELECT *
FROM customers
WHERE 
    id = 6; */

-- Change the score of customer with ID 10 to 0 and update the country to 'UK'
UPDATE customers
SET
	score = 0,
    country = 'UK'
WHERE 
    id = 10;

/* SELECT *
FROM customers
WHERE 
    id = 10; */

-- Update all customers with a NULL score by setting their score to 0
UPDATE customers
SET 
    score = 0
WHERE 
    score IS NULL;

/* During update it is wise to use the primary key with the where condition
and in the above query the column mentioned is not the primary key which is why
MySQL will not execute this query and show an error code 1175 in the output area,
this happens because of a safe mode that is in MySQL. In order to run this query
I need to deactivate the safe mode and then execute the query.
I will deactivate the safe mode temporarily using the below query

SET SQL_SAFE_UPDATES = 0;

Once I run this above query the safe mode will be deactivated and I can run my
UPDATE query with ease. Now if I want to activate the safe mode again so I will 
be using the below query for this.

SET SQL_SAFE_UPDATES = 1;

After the above query gets executed the safe mode is activated again and again if
I try to run the same UPDATE query then the error code 1175 will be showing again */

-- Verify the update
SELECT *
FROM customers
WHERE 
    score IS NULL;


-- DELETE

-- Select customers with an ID greater than 5 before deleting
SELECT *
FROM customers
WHERE 
    id > 5;

-- Delete all customers with an ID greater than 5
DELETE
FROM customers
WHERE 
    id > 5;

-- Delete all data from the persons table
DELETE
FROM persons;

-- Faster method to delete all rows, especially useful for large tables
TRUNCATE TABLE persons;