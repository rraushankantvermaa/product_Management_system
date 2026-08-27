# 🛒 Product Management System | SQL Project

## 📌 Project Overview

This project is a **Product Management System** built using **MySQL**. The project demonstrates practical SQL skills by creating a relational database to manage products, categories, suppliers, customers, orders, and order items.

The project includes database creation, table relationships, constraints, sample data insertion, CRUD operations, filtering, sorting, aggregate functions, joins, conditional statements, subqueries, and transactions.

---

## 🛠️ Technologies Used

* MySQL
* MySQL Community Server 8.0
* SQL
* MySQL Shell / MySQL Workbench

---

## 🗂️ Database Name

```sql
product_management
```

---

# 📊 Database Schema

The database contains **6 tables**:

| Table Name    | Description                                              |
| ------------- | -------------------------------------------------------- |
| `categories`  | Stores product category information                      |
| `suppliers`   | Stores supplier details                                  |
| `products`    | Stores product information, prices, stock, and discounts |
| `customers`   | Stores customer information                              |
| `orders`      | Stores customer order details                            |
| `order_items` | Stores individual products included in each order        |

---

# 🔗 Database Relationships

```text
Categories
     │
     │ 1
     │
     └──────< Products >────── Suppliers
                  │
                  │
                  │
Orders >──────── Order_Items ───────< Products
   │
   │
Customers
```

### Relationships

* One **category** can contain multiple products.
* One **supplier** can supply multiple products.
* One **customer** can place multiple orders.
* One **order** can contain multiple products.
* The `order_items` table connects orders and products.

---

# 🏗️ Database Tables

## 1. Categories

Stores information about product categories.

**Columns:**

```text
category_id
category_name
description
```

---

## 2. Suppliers

Stores supplier information.

**Columns:**

```text
supplier_id
supplier_name
email
phone
city
```

---

## 3. Products

Stores detailed product information.

**Columns:**

```text
product_id
product_name
category_id
supplier_id
price
stock_quantity
discount
product_code
status
created_date
```

### Features

* Unique product code
* Product price validation
* Stock quantity validation
* Discount validation
* Product status validation
* Foreign key relationships with categories and suppliers

---

## 4. Customers

Stores customer information.

**Columns:**

```text
customer_id
customer_name
email
phone
city
```

---

## 5. Orders

Stores customer order information.

**Columns:**

```text
order_id
customer_id
order_date
order_status
```

### Order Status

```text
PLACED
PROCESSING
SHIPPED
DELIVERED
CANCELLED
```

---

## 6. Order Items

Stores products included in each order.

**Columns:**

```text
order_item_id
order_id
product_id
quantity
unit_price
```

---

# ✨ SQL Concepts Used

This project demonstrates the following SQL concepts:

## 🟢 Database Operations

```sql
CREATE DATABASE
DROP DATABASE
USE DATABASE
SHOW DATABASES
SHOW TABLES
```

---

## 🟢 Table Creation

The project uses:

```text
CREATE TABLE
PRIMARY KEY
FOREIGN KEY
UNIQUE
NOT NULL
DEFAULT
CHECK
AUTO_INCREMENT
```

---

## 🟢 CRUD Operations

### Create

```sql
INSERT INTO products (...)
VALUES (...);
```

### Read

```sql
SELECT * FROM products;
```

### Update

```sql
UPDATE products
SET price = price + 1000
WHERE product_id = 5;
```

### Delete

```sql
DELETE FROM products
WHERE product_id = 7;
```

---

# 🔍 Filtering and Searching

The project includes:

```sql
WHERE
AND
OR
NOT
BETWEEN
IN
LIKE
```

### Example

```sql
SELECT *
FROM products
WHERE price BETWEEN 30000 AND 80000;
```

---

# 📈 Sorting and Limiting Data

```sql
ORDER BY
LIMIT
DISTINCT
```

### Example

```sql
SELECT *
FROM products
ORDER BY price DESC
LIMIT 3;
```

---

# 📊 Aggregate Functions

The following aggregate functions are used:

```sql
COUNT()
SUM()
AVG()
MIN()
MAX()
```

### Example

```sql
SELECT AVG(price) AS average_price
FROM products;
```

---

# 📌 GROUP BY and HAVING

The project analyzes products based on categories.

```sql
SELECT category_id,
       COUNT(*) AS product_count
FROM products
GROUP BY category_id;
```

### HAVING Example

```sql
SELECT category_id,
       COUNT(*) AS product_count
FROM products
GROUP BY category_id
HAVING COUNT(*) > 1;
```

---

# 🔗 SQL Joins

The project demonstrates multiple joins.

### INNER JOIN

```sql
SELECT
    p.product_name,
    c.category_name
FROM products p
INNER JOIN categories c
ON p.category_id = c.category_id;
```

### LEFT JOIN

Used to identify categories even when no products are available.

### RIGHT JOIN

Used to retrieve all categories with matching products.

### FULL OUTER JOIN Alternative

Since MySQL does not directly support `FULL OUTER JOIN`, the project demonstrates it using:

```sql
LEFT JOIN
UNION
RIGHT JOIN
```

---

# 🧮 CASE Statements

CASE statements are used for business classification.

### Product Price Category

```sql
SELECT
    product_name,
    price,
    CASE
        WHEN price >= 70000 THEN 'Premium'
        WHEN price >= 30000 THEN 'Medium'
        ELSE 'Budget'
    END AS price_category
FROM products;
```

### Stock Status

Products are classified as:

```text
Out of Stock
Low Stock
Normal Stock
High Stock
```

### Discount Category

Products are classified based on discount percentage.

```text
No Discount
Low Discount
Good Discount
Heavy Discount
```

---

# 💰 Business Analysis Queries

The project performs several useful business analyses.

### Total Products

```sql
SELECT COUNT(*) AS total_products
FROM products;
```

### Total Stock

```sql
SELECT SUM(stock_quantity) AS total_stock
FROM products;
```

### Average Product Price

```sql
SELECT AVG(price) AS average_price
FROM products;
```

### Customer Purchase Analysis

```sql
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity * oi.unit_price) AS total_purchase
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
LEFT JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name;
```

---

# 🧩 NULL Handling

The project uses:

```sql
IS NULL
IS NOT NULL
COALESCE()
```

Example:

```sql
SELECT
    product_name,
    COALESCE(discount, 0) AS discount
FROM products;
```

---

# 🔎 Subqueries

Subqueries are used for advanced data analysis.

### Products Above Average Price

```sql
SELECT product_name, price
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);
```

### Most Expensive Product

```sql
SELECT product_name, price
FROM products
WHERE price = (
    SELECT MAX(price)
    FROM products
);
```

---

# 🔄 Transactions

The project also demonstrates transaction-related operations while updating product stock.

```sql
START TRANSACTION;

UPDATE products
SET stock_quantity = stock_quantity - 2
WHERE product_id = 1;
```

Transactions are useful for maintaining data consistency when performing multiple related operations.

---

# 📁 Project Structure

```text
Product-Management-System-SQL/
│
├── product_management.sql
│
├── README.md
│
└── screenshots/
    ├── database_creation.png
    ├── tables.png
    ├── joins.png
    └── analysis_queries.png
```

---

# 🚀 How to Run the Project

### Step 1: Clone the Repository

```bash
git clone https://github.com/your-username/Product-Management-System-SQL.git
```

### Step 2: Open MySQL

Open MySQL Workbench or MySQL Shell.

### Step 3: Run the SQL File

Execute:

```sql
SOURCE product_management.sql;
```

Or open the SQL file in MySQL Workbench and run the complete script.

### Step 4: Verify the Database

```sql
USE product_management;

SHOW TABLES;
```

---

# 📚 Key Skills Demonstrated

* Database Design
* Relational Database Management
* Primary Keys
* Foreign Keys
* Constraints
* Data Insertion
* Data Updates
* Data Deletion
* Data Filtering
* Sorting
* Aggregate Functions
* GROUP BY
* HAVING
* SQL Joins
* CASE Statements
* NULL Handling
* Subqueries
* Transactions
* Business Data Analysis

---

# 🎯 Learning Outcome

Through this project, I practiced how to design and manage a relational database using MySQL. I learned how different tables are connected using primary and foreign keys and how SQL queries can be used to extract meaningful business insights.

This project helped strengthen my understanding of:

* Database normalization and relationships
* Writing efficient SQL queries
* Performing CRUD operations
* Analyzing business data
* Working with joins and aggregate functions
* Using subqueries and conditional logic

---

# 🔮 Future Improvements

Possible future improvements include:

* Adding stored procedures
* Creating views
* Adding triggers
* Implementing indexes
* Creating advanced analytical queries
* Connecting the database with Power BI
* Building an interactive dashboard
* Adding more realistic data
* Implementing inventory alerts for low-stock products

---

## 👨‍💻 Author

**Raushan Kant Verma**

Aspiring Data Analyst | SQL | Excel | Power BI | Python

---

⭐ If you found this project useful, please consider giving the repository a star!
