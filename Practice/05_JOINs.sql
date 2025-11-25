/* SQL Joins

Contents:
1. Basic Joins
	- INNER JOIN
	- LEFT JOIN
	- RIGHT JOIN
	- FULL JOIN
2. Advanced Joins
	- LEFT ANTI JOIN
	- RIGHT ANTI JOIN
	- ALTERNATIVE INNER JOIN
	- FULL ANTI JOIN
	- CROSS JOIN
3. Multiple Table Joins (4 Tables) */


-- BASIC JOINS

-- No Join
-- Retrieve all data from customers and orders as separate results
SELECT *
FROM customers;

SELECT *
FROM orders;


-- INNER JOIN

/* Get all customers along with their orders, 
   but only for customers who have placed an order */
SELECT
	c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM customers AS c
INNER JOIN orders AS o
	ON c.id = o.customer_id;


-- LEFT JOIN

/* Get all customers along with their orders, 
   including those without orders */
SELECT
	c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM customers AS c
LEFT JOIN orders AS o
	ON c.id = o.customer_id;


-- RIGHT JOIN
/* Get all customers along with their orders, 
   including orders without matching customers */
SELECT
	c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM customers AS c
RIGHT JOIN orders AS o
	ON c.id = o.customer_id;


-- Alternative to RIGHT JOIN using LEFT JOIN

/* Get all customers along with their orders, 
   including orders without matching customers */
SELECT
	c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM orders AS o
LEFT JOIN customers AS c
	ON o.customer_id = c.id;


-- FULL JOIN

/* Get all customers and all orders, even if there’s no match */
SELECT *
FROM customers AS c
LEFT JOIN orders AS o
	ON c.id = o.customer_id

UNION

SELECT *
FROM customers AS c
RIGHT JOIN orders AS o
	ON c.id = o.customer_id;

/* The above query is specific for MySQL because MySQL does not support FULL OUTER JOIN / FULL JOIN;
however PostgreSQL, Microsoft SQL Server support FULL OUTER JOIN / FULL JOIN */


-- ADVANCED JOINS

-- LEFT ANTI JOIN

/* Get all customers who haven't placed any order */
SELECT *
FROM customers AS c
LEFT JOIN orders AS o
	ON c.id = o.customer_id
WHERE
	o.customer_id IS NULL;


-- RIGHT ANTI JOIN

/* Get all orders without matching customers */
SELECT *
FROM customers AS c
RIGHT JOIN orders AS o
	ON c.id = o.customer_id
WHERE
	c.id IS NULL;


-- Alternative to RIGHT ANTI JOIN using LEFT JOIN

/* Get all orders without matching customers */
SELECT *
FROM orders AS o
LEFT JOIN customers AS c
	ON o.customer_id = c.id
WHERE 
	c.id IS NULL;


-- FULL ANTI JOIN

/* Find customers without orders and orders without customers */
SELECT *
FROM customers AS c
LEFT JOIN orders AS o
	ON c.id = o.customer_id
WHERE 
	o.customer_id IS NULL

UNION

SELECT *
FROM orders AS o
LEFT JOIN customers AS c
	ON o.customer_id = c.id
WHERE 
	c.id IS NULL;


# Challenge:
-- Alternative to INNER JOIN using LEFT JOIN

/* Get all customers along with their orders, 
   but only for customers who have placed an order */
SELECT *
FROM customers AS c
LEFT JOIN orders AS o
	ON c.id = o.customer_id
WHERE
	o.customer_id IS NOT NULL;
    

-- CROSS JOIN

/* Generate all possible combinations of customers and orders */
SELECT *
FROM customers
CROSS JOIN orders;


-- MULTIPLE TABLE JOINS (4 Tables)

/* Task: Using SalesDB, Retrieve a list of all orders, along with the related customer, product, 
   and employee details. For each order, display:
   - Order ID
   - Customer's name
   - Product name
   - Sales amount
   - Product price
   - Salesperson's name */
SELECT
	o.orderid,
    o.sales,
    c.firstname AS customer_firstname,
    c.lastname AS customer_lastname,
    p.product,
    p.price,
    e.firstname AS salesperson_firstname,
    e.lastname AS salesperson_lastname
FROM salesdb.orders AS o
LEFT JOIN salesdb.customers AS c
	ON o.customerid = c.customerid
LEFT JOIN salesdb.products AS p
	ON o.productid = p.productid
LEFT JOIN salesdb.employees AS e
	ON o.salespersonid = e.employeeid;
    
/* It's better to have a ER Diagram (Entity-Relationship Diagram) when working with multiple tables
as we may get confused about the primary keys and the foreign keys */