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



