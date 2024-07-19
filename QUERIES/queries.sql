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

--5) Examining the relationship between the order and employees table to see which employee is responsible for which orders.
SELECT e.first_name || ' ' || e.last_name AS employee_name, o.order_id , o.order_date
FROM orders o
JOIN employees e ON e.employee_id = o.employee_id 
LIMIT 10

--6) Examining the relationship between the orders and customers table to get more detailed information about each customer
SELECT o.order_id,
c.company_name,
c.contact_name,
o.order_date
FROM orders o 
JOIN customers c ON c.customer_id = o.customer_id
LIMIT 10

-- 7) Using CTE and window functions, we discovered which employee was associated with the highest number of sales.
WITH EmployeeSales AS (
    SELECT Employees.Employee_ID, Employees.First_Name, Employees.Last_Name,
           SUM(Unit_Price * Quantity * (1 - Discount)) AS Total_Sales
    FROM Orders 
    JOIN Order_Details ON Orders.Order_ID = Order_Details.Order_ID
    JOIN Employees ON Orders.Employee_ID = Employees.Employee_ID

    GROUP BY Employees.Employee_ID
)

SELECT employee_id , first_name , last_name, 
ROW_NUMBER () OVER (ORDER BY Total_Sales DESC) AS "Sales Rank"
FROM EmployeeSales
LIMIT 10 ;


