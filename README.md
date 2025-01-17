# SQL-Window-Functions-Northwind
A project using SQL Window Functions on a Northwind database

# SQL Window Functions for Northwind Traders

## Project Description

This project aims to use advanced SQL window functions to analyze data in the Northwind database. The Northwind database is a classic example used to demonstrate database applications.

## Installation and Configuration

### 1. Install Postgres.app

- Download and install [Postgres.app](https://postgresapp.com/).
- Open Postgres.app and ensure the PostgreSQL server is running.

### 2. Install pgAdmin

- Download and install [pgAdmin](https://www.pgadmin.org/download/pgadmin-4-macos/).
- Configure the connection to the local PostgreSQL server in pgAdmin.

### 3. Import the Northwind Database

- Download the `northwind.sql` file from [Northwind PostgreSQL](https://github.com/pthom/northwind_psql).
- Create a new database in pgAdmin, name it `northwind`.
- Import the `northwind.sql` file into the newly created database using the Query Tool in pgAdmin.

## Project Steps:

### 1. Getting to know the data

- Checking and understanding the data one by one
- Searching for dependencies between tables

### 2. Examining the relationship:

- between the order and employees table to see which employee is responsible for which orders.

- Examining the relationship between the orders and customers table to get more detailed information about each customer

### 3.  Rank employees by sales performance

- Using CTE and window functions, we discovered which employee was associated with the highest number of sales.
- Margeret Peacock is the top-selling employee and Steven Buchanan is the lowest-selling employee in this case.

### 4.  Calculate running total of sales per month

- Calculate the running total of sales per month: First, calculate the total sum for each month, and then, as the next step, calculate the running total.

### 5.  Calculate the month-over-month sales growth rate 

- Appropriate connection of tables Orders and Order_Details,
- month-over-month sales growth rate calculation

 ### 6) Identify customers with above-average order values
 
- Appropriate connection of tables Orders and Order_Details,
- above-average order values by cross joining the CTE table with order_details

### 7) Calculate the percentage of total sales for each product category

- Finding the total cost of products from order_details tab
- Joining order_details tab with products tab to see the product category for each product,
- Joining the category tab to see the name of each category,
- Calculating the percentage of each product,
- Beverages is the top category in terms of sales percentages, followed closely by Dairy Products. Produce and Grains/Cereals are the categories with the smallest sales percentage.

### 8) Find the top 3 products sold in each category

- Finding the total cost of products from order_details tab
- Joining order_details tab with products tab to see the product category for each product,
- Joining the category tab to see the name of each category
- Identify top 3 products by window function ROW_NUMBER,
- Select only top 3 products from the final tab 






