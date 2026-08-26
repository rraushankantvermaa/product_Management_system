SHOW DATABASES;
DROP DATABASE IF EXISTS product_management;
CREATE DATABASE product_management;
USE product_management;



CREATE TABLE categories(
category_id INT AUTO_INCREMENT,
category_name VARCHAR(100) NOT NULL,
description VARCHAR(255),
CONSTRAINT pk_categories PRIMARY KEY (category_id),
CONSTRAINT uq_category_name UNIQUE (category_name)
);

CREATE TABLE suppliers(
 supplier_id INT AUTO_INCREMENT, 
 supplier_name VARCHAR(100) NOT NULL,
 email VARCHAR(150) NOT NULL,
 phone VARCHAR(20),
 city VARCHAR(100),
 CONSTRAINT pk_suppliers PRIMARY KEY (supplier_id),
 CONSTRAINT uq_supplier_email UNIQUE (email));
 
CREATE TABLE products(
product_id INT AUTO_INCREMENT,
product_name VARCHAR(150) NOT NULL,
category_id INT NOT NULL, supplier_id INT NOT NULL,
price DECIMAL(10,2) NOT NULL, stock_quantity INT NOT NULL DEFAULT 0,
discount DECIMAL(5,2) DEFAULT 0, product_code VARCHAR(50) NOT NULL,
status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
created_date DATE NOT NULL,
CONSTRAINT pk_products PRIMARY KEY (product_id),
CONSTRAINT uq_product_code UNIQUE (product_code),
CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES categories(category_id),
CONSTRAINT fk_product_supplier FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
CONSTRAINT chk_product_price CHECK (price > 0), 
CONSTRAINT chk_stock_quantity CHECK (stock_quantity >= 0),
CONSTRAINT chk_discount CHECK (discount BETWEEN 0 AND 100),
CONSTRAINT chk_product_status CHECK (status IN ('ACTIVE', 'INACTIVE', 'DISCONTINUED')));
 
CREATE TABLE customers(
customer_id INT AUTO_INCREMENT,
customer_name VARCHAR(100) NOT NULL,
email VARCHAR(150) NOT NULL, phone VARCHAR(20),
city VARCHAR(100),
CONSTRAINT pk_customers PRIMARY KEY (customer_id),
CONSTRAINT uq_customer_email UNIQUE (email) ); 

CREATE TABLE orders(
order_id INT AUTO_INCREMENT,
customer_id INT NOT NULL,
order_date DATE NOT NULL,
order_status VARCHAR(20) NOT NULL DEFAULT 'PLACED',
CONSTRAINT pk_orders PRIMARY KEY (order_id),
CONSTRAINT fk_order_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
CONSTRAINT chk_order_status CHECK ( order_status IN ('PLACED', 'PROCESSING', 'SHIPPED', 'DELIVERED', 'CANCELLED'))); 

CREATE TABLE order_items(
order_item_id INT AUTO_INCREMENT,
order_id INT NOT NULL,
product_id INT NOT NULL,
quantity INT NOT NULL,
unit_price DECIMAL(10,2) NOT NULL,
CONSTRAINT pk_order_items PRIMARY KEY (order_item_id),
CONSTRAINT fk_orderitem_order FOREIGN KEY (order_id) REFERENCES orders(order_id),
CONSTRAINT fk_orderitem_product FOREIGN KEY (product_id) REFERENCES products(product_id),
CONSTRAINT chk_orderitem_quantity CHECK (quantity > 0),
CONSTRAINT chk_orderitem_price CHECK (unit_price > 0) );

SHOW TABLES;
DESC categories;
DESC suppliers;
DESC products;
DESC customers;
DESC orders;
DESC order_items;

SHOW CREATE TABLE products;

INSERT INTO categories (category_name, description) VALUES
('Electronics', 'Electronic products'),
('Mobiles', 'Smartphones and mobile devices'),
('Laptops', 'Laptop computers'),
('Accessories','Computer and mobile accessories'),
('Home Appliances','Home electrical appliances');
SELECT * FROM categories;

INSERT INTO suppliers(supplier_name, email, phone, city) VALUES
('Tech World', 'techworld@gmail.com', '9000000001', 'Kolkata'),
('Digital India', 'digitalindia@gmail.com', '9000000002', 'Delhi'),
('Global Electronics', 'global@gmail.com', '9000000003', 'Mumbai'),
('Smart Solutions', 'smart@gmail.com', '9000000004', 'Bangalore');
SELECT * from suppliers;

INSERT INTO products (product_name, category_id, supplier_id, price, stock_quantity, discount, product_code, status, created_date) VALUES
('iPhone 15', 2, 1, 70000, 25, 5, 'IPH15', 'ACTIVE', '2026-01-10'),
('Samsung Galaxy S25', 2, 2, 65000, 30, 8, 'SAM25', 'ACTIVE', '2026-01-15'),
('Dell Inspiron', 3, 3, 75000, 15, 10, 'DELLINS', 'ACTIVE', '2026-02-01'),
('HP Pavilion', 3, 3, 68000, 20, 7, 'HPPAV', 'ACTIVE', '2026-02-05'),
('Wireless Mouse', 4, 1, 1200, 100, 15, 'WM001', 'ACTIVE', '2026-02-10'),
('Mechanical Keyboard', 4, 1, 3500, 50, 10, 'KEY001', 'ACTIVE', '2026-02-12'),
('LG Refrigerator', 5, 4, 55000, 10, 5, 'LGREF', 'ACTIVE', '2026-03-01'),
('Sony TV', 1, 4, 85000, 8, 12, 'SONYTV', 'ACTIVE', '2026-03-05');

INSERT INTO customers (customer_name, email, phone, city) VALUES
('Rahul Sharma', 'rahul@gmail.com', '8000000001', 'Kolkata'),
('Priya Das', 'priya@gmail.com', '8000000002', 'Delhi'),
('Amit Roy', 'amit@gmail.com', '8000000003', 'Mumbai'),
('Sneha Singh', 'sneha@gmail.com', '8000000004', 'Bangalore'),
('Arjun Kumar', 'arjun@gmail.com', '8000000005', 'Kolkata');

INSERT INTO orders (customer_id, order_date, order_status) VALUES
(1, '2026-08-01', 'DELIVERED'),
(2, '2026-08-05', 'SHIPPED'),
(3, '2026-08-10', 'PROCESSING'),
(1, '2026-08-15', 'PLACED'),
(4, '2026-08-18', 'CANCELLED');

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 70000),
(1, 5, 2, 1200),
(2, 2, 1, 65000), 
(2, 6, 1, 3500),
(3, 3, 1, 75000),
(4, 4, 1, 68000),
(4, 5, 1, 1200),
(5, 8, 1, 85000);

SELECT * FROM products; 
SELECT product_id, product_name, price FROM products;
SELECT product_name AS Product, price AS Price, stock_quantity AS Stock FROM products;
SELECT * FROM products WHERE price > 50000; 
SELECT * FROM products WHERE price < 10000;
SELECT * FROM products WHERE stock_quantity > 20;
SELECT * FROM products WHERE price > 50000 AND stock_quantity > 10;
SELECT * FROM products WHERE price > 70000 OR stock_quantity > 50;
SELECT * FROM products WHERE NOT status = 'DISCONTINUED';
SELECT * FROM products WHERE price BETWEEN 30000 AND 80000;
SELECT * FROM products WHERE created_date BETWEEN '2026-01-01' AND '2026-03-31';
SELECT * FROM products WHERE status IN ('ACTIVE', 'INACTIVE');
SELECT * FROM products WHERE category_id IN (2, 3);

SELECT * FROM products WHERE product_name LIKE 'S%';
SELECT * FROM products WHERE product_name LIKE '%r';
SELECT * FROM products WHERE product_name LIKE '%Phone%';

SELECT * FROM products ORDER BY price ASC;
SELECT * FROM products ORDER BY price DESC;
SELECT * FROM products ORDER BY category_id, price DESC;

SELECT * FROM products ORDER BY price DESC LIMIT 3;
SELECT * FROM products ORDER BY price LIMIT 1;

SELECT DISTINCT city FROM customers;
SELECT DISTINCT status FROM products;

UPDATE products SET price = price + 1000 WHERE product_id = 5;
UPDATE products SET status = 'INACTIVE' WHERE product_id = 8;
UPDATE products SET discount = 20 WHERE product_id = 3;
UPDATE products SET price = price + 1000;

DELETE FROM categories WHERE category_id = 5;
DELETE FROM products WHERE product_id = 7;

SELECT COUNT(*) AS total_products FROM products;
SELECT SUM(stock_quantity) AS total_stock FROM products;
SELECT AVG(price) AS average_price FROM products;
SELECT MIN(price) AS minimum_price FROM products;
SELECT MAX(price) AS maximum_price FROM products; 
SELECT category_id, COUNT(*) AS product_count FROM products GROUP BY category_id;
SELECT category_id, AVG(price) AS average_price FROM products GROUP BY category_id;
SELECT category_id, AVG(price) AS average_price FROM products GROUP BY category_id;
SELECT category_id, MAX(price) AS maximum_price FROM products GROUP BY category_id;
SELECT category_id, COUNT(*) AS product_count FROM products GROUP BY category_id HAVING COUNT(*) > 1;
SELECT category_id, AVG(price) AS average_price FROM products GROUP BY category_id HAVING AVG(price) > 50000;

SELECT p.product_id, p.product_name, c.category_name FROM products p INNER JOIN categories c ON p.category_id = c.category_id;
SELECT p.product_name, p.price, s.supplier_name FROM products p INNER JOIN suppliers s ON p.supplier_id = s.supplier_id;
SELECT p.product_name, c.category_name, s.supplier_name, p.price FROM products p INNER JOIN categories c ON p.category_id = c.category_id INNER JOIN suppliers s ON p.supplier_id = s.supplier_id;
SELECT c.category_name, p.product_name FROM products p RIGHT JOIN categories c ON p.category_id = c.category_id;
SELECT c.category_name, p.product_name FROM categories c LEFT JOIN products p ON c.category_id = p.category_id UNION SELECT c.category_name, p.product_name FROM categories c RIGHT JOIN products p ON c.category_id = p.category_id;
SELECT o.order_id, c.customer_name, o.order_date, o.order_status FROM orders o INNER JOIN customers c ON o.customer_id = c.customer_id;
SELECT o.order_id, c.customer_name, p.product_name, oi.quantity, oi.unit_price, oi.quantity * oi.unit_price AS total_amount FROM orders o INNER JOIN customers c ON o.customer_id = c.customer_id INNER JOIN order_items oi ON o.order_id = oi.order_id INNER JOIN products p ON oi.product_id = p.product_id;
SELECT c.customer_id, c.customer_name, COUNT(DISTINCT o.order_id) AS total_orders, SUM(oi.quantity * oi.unit_price) AS total_purchase FROM customers c LEFT JOIN orders o ON c.customer_id = o.customer_id LEFT JOIN order_items oi ON o.order_id = oi.order_id GROUP BY c.customer_id, c.customer_name;
SELECT product_name, price, CASE WHEN price >= 70000 THEN 'Premium' WHEN price >= 30000 THEN 'Medium' ELSE 'Budget' END AS price_category FROM products;
SELECT product_name, stock_quantity, CASE WHEN stock_quantity = 0 THEN 'Out of Stock' WHEN stock_quantity <= 10 THEN 'Low Stock' WHEN stock_quantity <= 50 THEN 'Normal Stock' ELSE 'High Stock' END AS stock_status FROM products;
SELECT product_name, discount, CASE WHEN discount = 0 THEN 'No Discount' WHEN discount <= 10 THEN 'Low Discount' WHEN discount <= 20 THEN 'Good Discount' ELSE 'Heavy Discount' END AS discount_category FROM products;
SELECT p.product_name, p.price, p.discount, p.price - (p.price * p.discount / 100) AS selling_price, CASE WHEN p.discount >= 20 THEN 'Best Offer' WHEN p.discount >= 10 THEN 'Good Offer' ELSE 'Regular Offer' END AS offer_status FROM products p;
SELECT order_id, order_status, CASE WHEN order_status = 'PLACED' THEN 'Order Received' WHEN order_status = 'PROCESSING' THEN 'Being Prepared' WHEN order_status = 'SHIPPED' THEN 'On The Way' WHEN order_status = 'DELIVERED' THEN 'Completed' WHEN order_status = 'CANCELLED' THEN 'Cancelled' END AS status_description FROM orders;
SELECT * FROM products WHERE status IS NOT NULL;
SELECT * FROM products WHERE discount IS NULL;
SELECT product_name, COALESCE(discount, 0) AS discount FROM products;
SELECT c.customer_name, COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS total_purchase FROM customers c LEFT JOIN orders o ON c.customer_id = o.customer_id LEFT JOIN order_items oi ON o.order_id = oi.order_id GROUP BY c.customer_id, c.customer_name;

SELECT product_name, price FROM products WHERE price > (SELECT AVG(price) FROM products);
SELECT product_name, price FROM products WHERE price = (SELECT MAX(price) FROM products);
SELECT product_name, price FROM products WHERE price > ( SELECT price FROM products WHERE product_name = 'Dell Inspiron');
START TRANSACTION; UPDATE products SET stock_quantity = stock_quantity - 2 WHERE product_id = 1;
SELECT product_name, stock_quantity FROM products WHERE product_id = 1;
SELECT stock_quantity FROM products WHERE product_id = 1;
UPDATE products SET stock_quantity = stock_quantity - 5 WHERE product_id = 1;
SELECT stock_quantity FROM products WHERE product_id = 1;
SELECT stock_quantity FROM products WHERE product_id = 1;  