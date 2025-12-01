-- SQL SET Operations

/* Contents:
	1. SQL Operation Rules
	2. UNION
	3. UNION ALL
	4. EXCEPT
	5. INTERSECT */

-- RULES OF SET OPERATIONS

/* # 1: RULE: SQL Clauses:
   - Set operator can be used almost in all clauses
   WHERE
   JOIN
   GROUP BY
   HAVING
   - ORDER BY is allowed only at once at the end of query
   Example:
   SELECT
   FROM
   JOIN
   WHERE
   GROUP BY
   HAVING
   
   UNION
   
   SELECT
   FROM
   JOIN
   WHERE
   GROUP BY
   HAVING
   
   ORDER BY */


/* # 2: RULE: Number of columns:
   The number of columns in each query must be the same
   Example
   SELECT
		col.1,
        col.2
   FROM database.table_name
   
   UNION
   
   SELECT
		col.1,
        col.2
   FROM database.table_name; 
   
   The number of columns should be equal orelse there will be error */


/* # 3: RULE: Data Types:
   Data types of columns in each query must be compatible
   Example
   SELECT
		col.1, - INT
        col.2 - VARCHAR
   FROM database.table_name
   
   UNION
   
   SELECT
		col.1, - INT
        col.2 - VARCHAR
   FROM database.table_name
   
   The data type in the columns should match
   
   SELECT
		col.1, - VARCHAR
		col.2 - INT
   FROM database.table_name
   
   UNION
   
   SELECT
		col.1, - INT
        col.2 - VARCHAR
   FROM database.table_name
   
   The above query is invalid as the data type does not match the columns of the query
   In a query carrying set operator, the first query is the primary query and the result would be according
   to the columns in the first query.
   In the above query, the first query has a VARCHAR type in col.1 and INTEGER type in col.2,
   where as in the second query the col.1 has an INTEGER type while in col.2 it's a VARCHAR type
   
   In MySQL you would get a result for the above query as it does not follow strict SQL standards
   but in postgreSQL and SQL Server it would clearly show an error because they collow strict SQL standards */


/* # 4: RULE: Column Order:
   The order of the columns in each query must be the same
   Example
   SELECT
		col.1, - INT
        col.2 - VARCHAR
   FROM database.table_name
   
   UNION
   
   SELECT
		col.1, - INT
        col.2 - VARCHAR
   FROM database.table_name
   
   The above query would work properly but if we change the order of the column like:
   SELECT
		col.2, - VARCHAR
		col.1 - INT
   FROM database.table_name
   
   UNION
   
   SELECT
		col.1, - INT
        col.2 - VARCHAR
   FROM database.table_name
   
   The above query would show an error as SQL maps the column of the first query with the first column of the second query
   and maps the second column of the first query with the second column of the second query 
   and the data types of columns of the queries are not same and SQL cannot identify the columns
   so the columns need to be in order */


/* # 5: RULE: Column Aliases:
   The column names in the result set are determined by the column names
   specified in the first SELECT statement
   
   The 1st query controls the naming of the columns in the output
   So if you want to put AS do it in the 1st query and it will reflect in the output 
   If I apply AS in the 2nd query it will not reflect in the output as the 1st query is the primary query 
   The 1st query also controls the DATA types */


/* # 6: RULE: Correct Columns:
   Ensure that the correct columns are used to maintain data consistency
   
   - Even if all rules are met and SQL shows no errors, the result may be incorrect
   - Incorrect column selection leads to inaccurate results 
   Example
   SELECT
		col.1, - VARCHAR
        col.2 - VARCHAR
   FROM database.table_name
   
   UNION
   
   SELECT
		col.1, - VARCHAR
        col.2 - VARCHAR
   FROM database.table_name
   
   This query would be correct but if 
   SELECT
		col.1, - VARCHAR
        col.2 - VARCHAR
   FROM database.table_name
   
   UNION
   
   SELECT
		col.2, - VARCHAR
		col.1 - VARCHAR
   FROM database.table_name
   
   The above query would yield an output even if we change the column which would give us inaccurate results
   but SQL won't understand it as we are following all other rules */



/* SETS:
UNION,
UNION ALL,
EXCEPT,
INTERSECT */

/* TASK 1: 
   Combine the data from Employees and Customers into one table using UNION */
SELECT
	firstname,
    lastname
FROM salesdb.employees

UNION

SELECT
	firstname,
    lastname
FROM salesdb.customers;


/* TASK 2: 
   Combine the data from Employees and Customers into one table, including duplicates, using UNION ALL */
SELECT
	firstname,
    lastname
FROM salesdb.employees

UNION ALL

SELECT
	firstname,
    lastname
FROM salesdb.customers;


/* TASK 3: 
   Find employees who are NOT customers using EXCEPT */
SELECT
	firstname,
    lastname
FROM salesdb.employees

EXCEPT

SELECT
	firstname,
    lastname
FROM salesdb.customers;

/* In the above query if it shows error that is because MySQL does not support EXCEPT
but postgreSQL and SQL Server supports it */


/* TASK 4: 
   Find employees who are also customers using INTERSECT */
SELECT
	firstname,
    lastname
FROM salesdb.employees

INTERSECT

SELECT
	firstname,
    lastname
FROM salesdb.customers;

/* In the above query if it shows error that is because MySQL does not support INTERSECT
but postgreSQL and SQL Server supports it */


/* TASK 5: 
   Combine order data from Orders and OrdersArchive into one report without duplicates */
SELECT
    'Orders' AS SourceTable,
    orderid,
    productid,
    customerid,
    salespersonid,
    orderdate,
    shipdate,
    orderstatus,
    shipaddress,
    billaddress,
    quantity,
    sales,
    creationtime
FROM salesdb.orders

UNION

SELECT
    'OrdersArchive' AS SourceTable,
    orderid,
    productid,
    customerid,
    salespersonid,
    orderdate,
    shipdate,
    orderstatus,
    shipaddress,
    billaddress,
    quantity,
    sales,
    creationtime
FROM salesdb.orders_archive
ORDER BY orderid;