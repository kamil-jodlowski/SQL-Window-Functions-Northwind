-- Exploring the Northwind Database - Getting to Know the Data

--1) Exploring the whole data base: 
SELECT
    table_name as name,
    table_type as type
FROM information_schema.tables
WHERE table_schema = 'public' AND table_type IN ('BASE TABLE', 'VIEW');

--2) Exploring the "customers" tab
SELECT *
FROM customers
LIMIT 5;

--3) Exploring the "orders" tab
SELECT *
FROM orders
LIMIT 5;

--4) Exploring the "order_details" tab
SELECT *
FROM order_details
LIMIT 5;

--4) Exploring the "products" tab
SELECT *
FROM products
LIMIT 5;

--5) -- Examining the relationship between the order and employees table to see which employee is responsible for which orders.
SELECT e.first_name || ' ' || e.last_name AS employee_name, o.order_id , o.order_date
FROM orders o
JOIN employees e ON e.employee_id = o.employee_id 
LIMIT 10
