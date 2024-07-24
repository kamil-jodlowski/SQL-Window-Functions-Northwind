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

-- 8)Calculate running total of sales per month: First calculating total summary for all of the months and 
-- then as a next step calculating the running total 

WITH qwerty AS (SELECT DATE_TRUNC('month', order_date) :: DATE AS Month,
SUM(quantity*unit_price*(1-discount)) AS Total_sum 
FROM orders
JOIN order_details ON orders.order_id = order_details.order_id
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY DATE_TRUNC('month', order_date) ASC)

SELECT Month, 
       SUM(Total_sum) OVER (ORDER BY Month) AS Running_Total
FROM qwerty
ORDER BY Month;

-- 9) Calculate the month-over-month sales growth rate

WITH sum_for_month AS (SELECT DATE_TRUNC('month', order_date) :: DATE AS Month, 
SUM(quantity * unit_price * (1-discount)) AS Total_sum 
FROM Orders
JOIN Order_details ON (Orders.order_id = Order_details.order_id)
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY DATE_TRUNC('month', order_date) ASC),

num_of_month AS (SELECT sum_for_month.month , Extract(month FROM sum_for_month.month) As month_num , sum_for_month.total_sum
FROM sum_for_month),

sales_growth AS (
    SELECT 
        month,
        total_sum,
        LAG(total_sum, 1) OVER (ORDER BY Month) AS Previous_Sales
    FROM num_of_month),

sales_chan AS (SELECT month,
        total_sum, CASE WHEN total_sum IS NOT NULL THEN total_sum - LAG(total_sum, 1) OVER (ORDER BY month ) ELSE NULL END AS Sales_Change
FROM sales_growth)

SELECT month , sales_change / LAG(total_sum, 1) OVER (ORDER BY month ) * 100 AS Growth_rate
FROM sales_chan


--10) Identify customers with above-average order values

WITH order_totals AS (
    SELECT order_id,
           SUM(unit_price * quantity * (1 - discount)) AS order_value
    FROM order_details
    GROUP BY order_id),
	
average_order_value AS (
    SELECT AVG(order_value) AS avg_value
    FROM order_totals
),

crossik AS (SELECT order_totals.order_id,
       order_totals.order_value,
       average_order_value.avg_value
FROM order_totals
CROSS JOIN average_order_value)

SELECT order_id , order_value , avg_value, 
CASE WHEN order_value > avg_value THEN 'Above Average' ELSE 'Below Average' END AS Value_Category
FROM crossik 
ORDER BY order_id ASC


--Calculate the percentage of total sales for each product category

WITH total_cost_cal AS (SELECT product_id, 
SUM(quantity*unit_price*(1-discount)) AS total_cost
FROM order_details
GROUP BY product_id), 

ov_cost AS (SELECT SUM(total_cost) AS overall_cost 
FROM total_cost_cal), 

marge AS (SELECT total_cost_cal.product_id , total_cost_cal.total_cost , ov_cost.overall_cost
FROM total_cost_cal
CROSS JOIN ov_cost ), 

marge_category AS (SELECT marge.product_id, products.category_id, marge.total_cost ,marge.overall_cost
FROM marge
JOIN products ON marge.product_id = products.product_id),

smth AS (SELECT marge_category.category_id , categories.category_name,  SUM(marge_category.total_cost) AS ok , marge_category.overall_cost
FROM marge_category
JOIN categories ON categories.category_id = marge_category.category_id
GROUP BY marge_category.category_id , categories.category_name, marge_category.overall_cost
ORDER BY marge_category.category_id ASC),

final_tab AS (SELECT smth.category_id , smth.category_name, (smth.ok *1.00 / smth.overall_cost *1.00) * 100.00 AS "Sales Percentage" 
FROM smth
ORDER BY smth.category_id ASC
)
SELECT * FROM final_tab






